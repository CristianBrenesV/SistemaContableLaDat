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

        // ========== MÉTODOS PÚBLICOS ==========

        public async Task<IEnumerable<PeriodoContableEntity>> ListarPeriodosAsync()
        {
            using var cn = _connectionFactory.CreateConnection();
            return await cn.QueryAsync<PeriodoContableEntity>(
                "sp_periodos_listar",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<PeriodoContableEntity?> ObtenerPeriodoAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();
            return await cn.QueryFirstOrDefaultAsync<PeriodoContableEntity>(
                "sp_periodo_obtener_por_id",
                new { p_id_periodo = idPeriodo },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<SaldoCuentaDto>> CalcularSaldosPeriodoAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();

            // Obtener el periodo actual
            var periodoActual = await ObtenerPeriodoAsync(idPeriodo);
            if (periodoActual == null)
                throw new Exception("Periodo no encontrado");

            // Buscar periodo anterior cerrado usando SP
            var periodoAnterior = await cn.QueryFirstOrDefaultAsync<PeriodoContableEntity>(
                "sp_periodo_obtener_anterior_cerrado",
                new
                {
                    p_anio = periodoActual.Anio,
                    p_mes = periodoActual.Mes
                },
                commandType: CommandType.StoredProcedure
            );

            // Si no hay periodo anterior cerrado, usar NULL
            int? idPeriodoAnterior = periodoAnterior?.IdPeriodo;

            // Calcular saldos usando SP
            return await cn.QueryAsync<SaldoCuentaDto>(
                "sp_cierre_calcular_saldos_periodo",
                new
                {
                    p_id_periodo = idPeriodo,
                    p_id_periodo_anterior = idPeriodoAnterior
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<ResultadoCierreDto> CalcularBalanceAsync(int idPeriodo)
        {
            using var cn = _connectionFactory.CreateConnection();

            // Obtener saldos del periodo
            var saldos = await CalcularSaldosPeriodoAsync(idPeriodo);

            // Obtener información del periodo
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

            // Validar si puede cerrar usando SP
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

            // Obtener periodo actual
            var periodoActual = await ObtenerPeriodoAsync(idPeriodo);
            if (periodoActual == null)
                return false;

            // Validar usando SP
            var parameters = new DynamicParameters();
            parameters.Add("p_anio", periodoActual.Anio);
            parameters.Add("p_mes", periodoActual.Mes);
            parameters.Add("p_puede_cerrar", dbType: DbType.Boolean, direction: ParameterDirection.Output);

            await cn.ExecuteAsync(
                "sp_periodo_validar_anteriores_cerrados",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return parameters.Get<bool>("p_puede_cerrar");
        }

        public async Task<bool> EjecutarCierreAsync(int idPeriodo, int idUsuario)
        {
            using var cn = _connectionFactory.CreateConnection();

            try
            {
                // ABRIR CONEXIÓN para transacción
                cn.Open();

                // Iniciar transacción
                using var transaction = cn.BeginTransaction();

                try
                {
                    // 1. Validar que se pueda cerrar
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

                    // 4. Insertar saldos usando SP
                    foreach (var saldo in saldos)
                    {
                        await cn.ExecuteAsync(
                            "sp_saldos_insertar_por_periodo",
                            new
                            {
                                p_id_periodo = idPeriodo,
                                p_id_cuenta = saldo.IdCuenta,
                                p_saldo_anterior = saldo.SaldoAnterior,
                                p_debitos_mes = saldo.DebitosMes,
                                p_creditos_mes = saldo.CreditosMes,
                                p_saldo_actual = saldo.SaldoActual
                            },
                            transaction,
                            commandType: CommandType.StoredProcedure
                        );
                    }

                    // 5. Cerrar periodo usando SP
                    await cn.ExecuteAsync(
                        "sp_periodo_cerrar",
                        new
                        {
                            p_id_periodo = idPeriodo,
                            p_id_usuario = idUsuario
                        },
                        transaction,
                        commandType: CommandType.StoredProcedure
                    );

                    // 6. Registrar cierre usando SP
                    await cn.ExecuteAsync(
                        "sp_cierre_registrar",
                        new
                        {
                            p_id_periodo = idPeriodo,
                            p_id_usuario_cierre = idUsuario,
                            p_total_debe = totalDeudor,
                            p_total_haber = totalAcreedor,
                            p_estado = "COMPLETADO",
                            p_mensaje = (string?)null
                        },
                        transaction,
                        commandType: CommandType.StoredProcedure
                    );

                    // Commit de la transacción
                    transaction.Commit();
                    return true;
                }
                catch (Exception ex)
                {
                    // Rollback en caso de error
                    transaction.Rollback();

                    // Registrar error usando SP (con nueva conexión)
                    using var cnError = _connectionFactory.CreateConnection();
                    await cnError.ExecuteAsync(
                        "sp_cierre_registrar",
                        new
                        {
                            p_id_periodo = idPeriodo,
                            p_id_usuario_cierre = idUsuario,
                            p_total_debe = 0,
                            p_total_haber = 0,
                            p_estado = "ERROR",
                            p_mensaje = $"Error en el proceso de cierre: {ex.Message}"
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    throw new Exception($"Error en transacción de cierre: {ex.Message}", ex);
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Error ejecutando cierre: {ex.Message}", ex);
            }
        }

        public async Task<CierreContableEntity> ObtenerUltimoCierreAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            // Verificar si la tabla existe usando SP
            bool tablaExiste = await VerificarTablaExisteAsync("cierrescontables");

            if (!tablaExiste)
            {
                return new CierreContableEntity();
            }

            return await cn.QueryFirstOrDefaultAsync<CierreContableEntity>(
                "sp_cierre_obtener_ultimo",
                commandType: CommandType.StoredProcedure
            ) ?? new CierreContableEntity();
        }

        public async Task<IEnumerable<CierreContableEntity>> ListarCierresAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            // Verificar si la tabla existe usando SP
            bool tablaExiste = await VerificarTablaExisteAsync("cierrescontables");

            if (!tablaExiste)
            {
                return new List<CierreContableEntity>();
            }

            return await cn.QueryAsync<CierreContableEntity>(
                "sp_cierres_listar",
                commandType: CommandType.StoredProcedure
            );
        }

        // ========== MÉTODOS PRIVADOS ==========

        private async Task<bool> VerificarTablaExisteAsync(string nombreTabla)
        {
            using var cn = _connectionFactory.CreateConnection();

            var parameters = new DynamicParameters();
            parameters.Add("p_nombre_tabla", nombreTabla);
            parameters.Add("p_existe", dbType: DbType.Boolean, direction: ParameterDirection.Output);

            await cn.ExecuteAsync(
                "sp_tabla_existe",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return parameters.Get<bool>("p_existe");
        }


        public async Task<int> CorregirAsientosPeriodoIncorrectoAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            return 0;
        }
    }
}