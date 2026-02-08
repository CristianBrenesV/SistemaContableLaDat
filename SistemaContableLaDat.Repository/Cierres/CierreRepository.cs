using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using SistemaContableLaDat.Entities.Cierres;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

namespace SistemaContableLaDat.Repository.Cierres
{
    public class CierreRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public CierreRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<PeriodoContableEntity>> ListarPeriodosAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            return await cn.QueryAsync<PeriodoContableEntity>(
                @"SELECT 
                    IdPeriodo,
                    Anio,
                    Mes,
                    Estado,
                    IdUsuarioCierre,
                    FechaCierre
                  FROM periodocontable
                  ORDER BY Anio DESC, Mes DESC"
            );
        }

        public async Task<PeriodoContableEntity?> ObtenerPeriodoAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();

            return await cn.QueryFirstOrDefaultAsync<PeriodoContableEntity>(
                @"SELECT * FROM periodocontable 
                  WHERE IdPeriodo = @id",
                new { id = idPeriodo }
            );
        }

        public async Task<IEnumerable<SaldoCuentaDto>> CalcularSaldosPeriodoAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();

            // Obtener el periodo actual
            var periodoActual = await ObtenerPeriodoAsync(idPeriodo);
            if (periodoActual == null)
                throw new Exception("Periodo no encontrado");

            // Buscar el ÚLTIMO periodo CERRADO anterior a este
            var periodoAnterior = await cn.QueryFirstOrDefaultAsync<PeriodoContableEntity>(
                @"SELECT * FROM periodocontable 
          WHERE Estado = 'Cerrado'
            AND (Anio < @anio OR (Anio = @anio AND Mes < @mes))
          ORDER BY Anio DESC, Mes DESC
          LIMIT 1",
                new
                {
                    anio = periodoActual.Anio,
                    mes = periodoActual.Mes
                }
            );

            // Si no hay periodo anterior cerrado, usar saldos en 0
            int? idPeriodoAnterior = periodoAnterior?.IdPeriodo;

            var query = @"
        -- Saldos al periodo anterior (si existe y está cerrado)
        WITH SaldosAnteriores AS (
            SELECT 
                cc.IdCuenta,
                cc.CodigoCuenta,
                cc.Nombre,
                cc.Tipo,
                cc.TipoSaldo,
                COALESCE(
                    (SELECT SaldoActual 
                     FROM saldoscuentasperiodo 
                     WHERE IdCuenta = cc.IdCuenta 
                       AND IdPeriodo = @idPeriodoAnterior
                    ), 0) AS SaldoAnterior
            FROM cuentascontables cc
            WHERE cc.Estado = 'Activa'
        ),
        MovimientosPeriodo AS (
            SELECT 
                d.IdCuentaContable,
                SUM(CASE WHEN d.TipoMovimiento = 'D' THEN d.Monto ELSE 0 END) AS Debitos,
                SUM(CASE WHEN d.TipoMovimiento = 'C' THEN d.Monto ELSE 0 END) AS Creditos
            FROM asientocontabledetalle d
            INNER JOIN asientocontableencabezado e 
                ON e.IdAsiento = d.IdAsiento
            WHERE e.IdPeriodo = @idPeriodoActual
              AND e.IdEstadoAsiento = 3 -- Solo asientos APROBADOS
            GROUP BY d.IdCuentaContable
        )
        SELECT 
            sa.IdCuenta,
            sa.CodigoCuenta,
            sa.Nombre AS NombreCuenta,
            sa.Tipo AS TipoCuenta,
            sa.TipoSaldo,
            sa.SaldoAnterior,
            COALESCE(mp.Debitos, 0) AS DebitosMes,
            COALESCE(mp.Creditos, 0) AS CreditosMes,
            -- Calcular saldo actual según naturaleza de la cuenta
            CASE sa.TipoSaldo
                WHEN 'Deudor' THEN 
                    sa.SaldoAnterior + COALESCE(mp.Debitos, 0) - COALESCE(mp.Creditos, 0)
                WHEN 'Acreedor' THEN 
                    sa.SaldoAnterior + COALESCE(mp.Creditos, 0) - COALESCE(mp.Debitos, 0)
                ELSE sa.SaldoAnterior
            END AS SaldoActual,
            -- Determinar naturaleza para el balance
            CASE sa.Tipo
                WHEN 'Activo' THEN 'Deudora'
                WHEN 'Gasto' THEN 'Deudora'
                WHEN 'Pasivo' THEN 'Acreedora'
                WHEN 'Capital' THEN 'Acreedora'
                WHEN 'Ingreso' THEN 'Acreedora'
                ELSE 'Indeterminada'
            END AS Naturaleza
        FROM SaldosAnteriores sa
        LEFT JOIN MovimientosPeriodo mp ON mp.IdCuentaContable = sa.IdCuenta
        ORDER BY sa.CodigoCuenta";

            return await cn.QueryAsync<SaldoCuentaDto>(query, new
            {
                idPeriodoActual = idPeriodo,
                idPeriodoAnterior
            });
        }

        public async Task<ResultadoCierreDto> CalcularBalanceAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();

            var saldos = await CalcularSaldosPeriodoAsync(idPeriodo);
            var periodo = await ObtenerPeriodoAsync(idPeriodo);

            if (periodo == null)
                throw new Exception("Periodo no encontrado");

            // Calcular totales según naturaleza
            decimal totalDeudor = 0;
            decimal totalAcreedor = 0;

            foreach (var saldo in saldos)
            {
                if (saldo.Naturaleza == "Deudora")
                    totalDeudor += saldo.SaldoActual;
                else if (saldo.Naturaleza == "Acreedora")
                    totalAcreedor += saldo.SaldoActual;
            }

            // Verificar si puede cerrar (periodos anteriores cerrados)
            var puedeCerrar = await ValidarPeriodosAnterioresCerradosAsync(idPeriodo);

            var resultado = new ResultadoCierreDto
            {
                IdPeriodo = idPeriodo,
                Anio = periodo.Anio,
                Mes = periodo.Mes,
                MesNombre = periodo.NombreMes,
                TotalDebe = totalDeudor,
                TotalHaber = totalAcreedor,
                EstadoPeriodo = periodo.Estado,
                PuedeCerrar = puedeCerrar && periodo.Estado == "Abierto",
                MensajeValidacion = !puedeCerrar
                    ? "No se puede cerrar este periodo porque hay periodos anteriores abiertos."
                    : periodo.Estado == "Cerrado"
                        ? "El periodo ya está cerrado."
                        : "Listo para cerrar."
            };

            return resultado;
        }

        public async Task<bool> ValidarPeriodosAnterioresCerradosAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();

            var periodoActual = await ObtenerPeriodoAsync(idPeriodo);
            if (periodoActual == null)
                return false;

            // Verificar si hay periodos anteriores abiertos
            var periodosAbiertos = await cn.QueryFirstOrDefaultAsync<int>(
                @"SELECT COUNT(*) 
                  FROM periodocontable 
                  WHERE (Anio < @anio OR (Anio = @anio AND Mes < @mes))
                    AND Estado = 'Abierto'",
                new { anio = periodoActual.Anio, mes = periodoActual.Mes }
            );

            return periodosAbiertos == 0;
        }

        public async Task<bool> EjecutarCierreAsync(int idPeriodo, int idUsuario)
        {
            using var cn = _connectionFactory.CreateConnection();

            try
            {
                // ABRIR LA CONEXIÓN EXPLÍCITAMENTE
                cn.Open();

                // Iniciar transacción
                using var transaction = cn.BeginTransaction();

                try
                {
                    // 1. Verificar que se pueda cerrar
                    var puedeCerrar = await ValidarPeriodosAnterioresCerradosAsync(idPeriodo);
                    if (!puedeCerrar)
                        throw new Exception("No se puede cerrar: hay periodos anteriores abiertos");

                    // 2. Obtener saldos del periodo
                    var saldos = await CalcularSaldosPeriodoAsync(idPeriodo);

                    // 3. Verificar que esté balanceado
                    decimal totalDeudor = saldos.Where(s => s.Naturaleza == "Deudora").Sum(s => s.SaldoActual);
                    decimal totalAcreedor = saldos.Where(s => s.Naturaleza == "Acreedora").Sum(s => s.SaldoActual);

                    if (totalDeudor != totalAcreedor)
                        throw new Exception($"El periodo no está balanceado. Diferencia: {Math.Abs(totalDeudor - totalAcreedor):C}");

                    // 4. Insertar saldos del periodo en tabla de histórico
                    foreach (var saldo in saldos)
                    {
                        await cn.ExecuteAsync(
                            @"INSERT INTO saldoscuentasperiodo 
                      (IdPeriodo, IdCuenta, SaldoAnterior, DebitosPeriodo, 
                       CreditosPeriodo, SaldoActual, FechaRegistro)
                      VALUES (@IdPeriodo, @IdCuenta, @SaldoAnterior, @DebitosMes, 
                              @CreditosMes, @SaldoActual, NOW())",
                            new
                            {
                                IdPeriodo = idPeriodo,
                                IdCuenta = saldo.IdCuenta,
                                SaldoAnterior = saldo.SaldoAnterior,
                                DebitosMes = saldo.DebitosMes,
                                CreditosMes = saldo.CreditosMes,
                                SaldoActual = saldo.SaldoActual
                            },
                            transaction
                        );
                    }

                    // 5. Actualizar estado del periodo
                    await cn.ExecuteAsync(
                        @"UPDATE periodocontable 
                  SET Estado = 'Cerrado',
                      IdUsuarioCierre = @idUsuario,
                      FechaCierre = NOW()
                  WHERE IdPeriodo = @idPeriodo",
                        new { idPeriodo, idUsuario },
                        transaction
                    );

                    // 6. Registrar en tabla de cierres (histórico)
                    await cn.ExecuteAsync(
                        @"INSERT INTO cierrescontables 
                  (IdPeriodo, FechaCierre, IdUsuarioCierre, 
                   TotalDebe, TotalHaber, Estado, FechaRegistro)
                  VALUES (@IdPeriodo, NOW(), @IdUsuarioCierre,
                          @TotalDebe, @TotalHaber, 'COMPLETADO', NOW())",
                        new
                        {
                            IdPeriodo = idPeriodo,
                            IdUsuarioCierre = idUsuario,
                            TotalDebe = totalDeudor,
                            TotalHaber = totalAcreedor
                        },
                        transaction
                    );

                    // Commit de la transacción
                    transaction.Commit();
                    return true;
                }
                catch (Exception ex)
                {
                    // Rollback en caso de error
                    transaction.Rollback();

                    // Registrar el error en la tabla de cierres (con conexión nueva para evitar problemas)
                    using var cnError = _connectionFactory.CreateConnection();
                    await cnError.ExecuteAsync(
                        @"INSERT INTO cierrescontables 
                  (IdPeriodo, FechaCierre, IdUsuarioCierre, 
                   Estado, Mensaje, FechaRegistro)
                  VALUES (@IdPeriodo, NOW(), @IdUsuarioCierre,
                          'ERROR', @Mensaje, NOW())",
                        new
                        {
                            IdPeriodo = idPeriodo,
                            IdUsuarioCierre = idUsuario,
                            Mensaje = $"Error en el proceso de cierre: {ex.Message}"
                        }
                    );

                    throw new Exception($"Error en transacción de cierre: {ex.Message}", ex);
                }
            }
            catch (Exception ex)
            {
                // Re-lanzar la excepción para que el service la maneje
                throw new Exception($"Error ejecutando cierre: {ex.Message}", ex);
            }
        }

        public async Task<CierreContableEntity> ObtenerUltimoCierreAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            // Primero verificar si la tabla existe
            var tablaExiste = await cn.QueryFirstOrDefaultAsync<int?>(
                @"SELECT COUNT(*) 
                  FROM information_schema.tables 
                  WHERE table_schema = DATABASE() 
                    AND table_name = 'cierrescontables'"
            );

            if (tablaExiste == 0 || tablaExiste == null)
            {
                return new CierreContableEntity();
            }

            return await cn.QueryFirstOrDefaultAsync<CierreContableEntity>(
                @"SELECT 
                    c.*,
                    CONCAT(u.NombreUsuario, ' ', u.ApellidoUsuario) as NombreUsuario,
                    p.Anio,
                    p.Mes
                  FROM cierrescontables c
                  LEFT JOIN periodocontable p ON p.IdPeriodo = c.IdPeriodo
                  LEFT JOIN usuarios u ON u.IdUsuario = c.IdUsuarioCierre
                  WHERE c.Estado = 'COMPLETADO'
                  ORDER BY c.FechaCierre DESC
                  LIMIT 1"
            ) ?? new CierreContableEntity();
        }

        public async Task<IEnumerable<CierreContableEntity>> ListarCierresAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            // Verificar si la tabla existe
            var tablaExiste = await cn.QueryFirstOrDefaultAsync<int?>(
                @"SELECT COUNT(*) 
                  FROM information_schema.tables 
                  WHERE table_schema = DATABASE() 
                    AND table_name = 'cierrescontables'"
            );

            if (tablaExiste == 0 || tablaExiste == null)
            {
                return new List<CierreContableEntity>();
            }

            return await cn.QueryAsync<CierreContableEntity>(
                @"SELECT 
                    c.*,
                    CONCAT(u.NombreUsuario, ' ', u.ApellidoUsuario) as NombreUsuario,
                    p.Anio,
                    p.Mes
                  FROM cierrescontables c
                  INNER JOIN periodocontable p ON p.IdPeriodo = c.IdPeriodo
                  LEFT JOIN usuarios u ON u.IdUsuario = c.IdUsuarioCierre
                  ORDER BY c.FechaCierre DESC"
            );
        }
    }
}