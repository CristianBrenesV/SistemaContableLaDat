using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SistemaContableLaDat.Entities.Cierres;
using SistemaContableLaDat.Repository.Cierres;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Bitacora;

namespace SistemaContableLaDat.Service.Cierres
{
    public class CierreService : ICierreService
    {
        private readonly CierreRepository _repository;
        private readonly IBitacoraService _bitacora;

        public CierreService(CierreRepository repository, IBitacoraService bitacora)
        {
            _repository = repository;
            _bitacora = bitacora;
        }

        public async Task<IEnumerable<PeriodoContableEntity>> ListarPeriodosAsync()
        {
            return await _repository.ListarPeriodosAsync();
        }

        public async Task<ResultadoCierreDto> CalcularCierreAsync(int idPeriodo)
        {
            try
            {
                var resultado = await _repository.CalcularBalanceAsync(idPeriodo);

                // Registrar en bitácora
                await _bitacora.RegistrarConsultaAsync(
                    "Sistema",
                    "Cálculo de cierre contable",
                    new { IdPeriodo = idPeriodo, Resultado = resultado }
                );

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacora.RegistrarErrorAsync(
                    "Sistema",
                    $"Error calculando cierre periodo {idPeriodo}: {ex.Message}"
                );
                throw;
            }
        }

        public async Task<bool> EjecutarCierreAsync(int idPeriodo, int idUsuario)
        {
            try
            {
                // Registrar inicio en bitácora
                await _bitacora.RegistrarCreacionAsync(
                    idUsuario.ToString(),
                    "Proceso de Cierre Contable",
                    new
                    {
                        IdPeriodo = idPeriodo,
                        FechaInicio = DateTime.Now,
                        Usuario = idUsuario
                    }
                );

                // Validar que se pueda cerrar
                var puedeCerrar = await _repository.ValidarPeriodosAnterioresCerradosAsync(idPeriodo);
                if (!puedeCerrar)
                {
                    throw new Exception("No se puede cerrar el periodo porque hay periodos anteriores abiertos.");
                }

                // Calcular balance para verificar
                var balance = await _repository.CalcularBalanceAsync(idPeriodo);
                if (!balance.Balanceado)
                {
                    throw new Exception($"El periodo no está balanceado. Diferencia: {balance.Diferencia:C}");
                }

                // Ejecutar cierre en base de datos
                var resultado = await _repository.EjecutarCierreAsync(idPeriodo, idUsuario);

                if (resultado)
                {
                    // Registrar éxito en bitácora
                    await _bitacora.RegistrarCreacionAsync(
                        idUsuario.ToString(),
                        "Cierre Contable Completado",
                        new
                        {
                            IdPeriodo = idPeriodo,
                            Anio = balance.Anio,
                            Mes = balance.Mes,
                            TotalDebe = balance.TotalDebe,
                            TotalHaber = balance.TotalHaber,
                            FechaCierre = DateTime.Now,
                            Balanceado = true
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                // Registrar error en bitácora
                await _bitacora.RegistrarErrorAsync(
                    idUsuario.ToString(),
                    $"Error en cierre contable periodo {idPeriodo}: {ex.Message}"
                );

                throw;
            }
        }

        public async Task<IEnumerable<SaldoCuentaDto>> ObtenerSaldosDetalladosAsync(int idPeriodo)
        {
            try
            {
                var saldos = await _repository.CalcularSaldosPeriodoAsync(idPeriodo);

                // Registrar consulta en bitácora
                await _bitacora.RegistrarConsultaAsync(
                    "Sistema",
                    "Saldos detallados para cierre",
                    new { IdPeriodo = idPeriodo, TotalCuentas = saldos.Count() }
                );

                return saldos;
            }
            catch (Exception ex)
            {
                await _bitacora.RegistrarErrorAsync(
                    "Sistema",
                    $"Error obteniendo saldos periodo {idPeriodo}: {ex.Message}"
                );
                throw;
            }
        }

        public async Task<bool> ValidarPeriodosAnterioresCerradosAsync(int idPeriodo)
        {
            return await _repository.ValidarPeriodosAnterioresCerradosAsync(idPeriodo);
        }

        public async Task<CierreContableEntity> ObtenerUltimoCierreAsync()
        {
            return await _repository.ObtenerUltimoCierreAsync();
        }

        public async Task<PeriodoContableEntity?> ObtenerPeriodoAsync(int idPeriodo)
        {
            return await _repository.ObtenerPeriodoAsync(idPeriodo);
        }
    }
}
