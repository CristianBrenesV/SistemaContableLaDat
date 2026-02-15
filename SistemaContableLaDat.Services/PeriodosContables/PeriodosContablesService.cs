using SistemaContableLaDat.Repository.PeriodosContables;
using SistemaContableLaDat.Entities.PeriodosContables;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.PeriodosContables
{
    public class PeriodosContablesService : IPeriodosContablesService
    {
        private readonly PeriodoContableRepository _repository;
        private readonly IBitacoraService _bitacoraService;

        public PeriodosContablesService(
            PeriodoContableRepository repository,
            IBitacoraService bitacoraService)
        {
            _repository = repository;
            _bitacoraService = bitacoraService;
        }

        public Task<IEnumerable<PeriodoContable>> GetAllAsync()
        {
            return _repository.GetAllAsync();
        }

        public Task<PeriodoContable?> GetByIdAsync(int idPeriodo)
        {
            return _repository.GetByIdAsync(idPeriodo);
        }

        public Task<IEnumerable<PeriodoContable>> GetAnioMesAsync()
        {
            return _repository.GetAnioMesAsync();
        }

        public async Task<int> InsertAsync(PeriodoContable periodo, int idUsuario)
        {
            try
            {
                var resultado = await _repository.InsertAsync(periodo);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Periodo contable creado",
                        new
                        {
                            periodo.Anio,
                            periodo.Mes,
                            periodo.Estado,
                            periodo.IdUsuarioCierre,
                            periodo.FechaCierre
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> UpdateAsync(PeriodoContable periodo, int idUsuario)
        {
            try
            {
                var periodoAnterior = await _repository.GetByIdAsync(periodo.IdPeriodo);

                var resultado = await _repository.UpdateAsync(periodo);

                if (resultado == 1 && periodoAnterior != null)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Periodo contable actualizado",
                        new
                        {
                            Antes = periodoAnterior,
                            Despues = periodo
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> DeleteAsync(int idPeriodo, int idUsuario)
        {
            try
            {
                var periodoExistente = await _repository.GetByIdAsync(idPeriodo);

                if (periodoExistente == null)
                    return 0;

                var resultado = await _repository.DeleteAsync(idPeriodo);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Periodo contable eliminado",
                        new
                        {
                            periodoExistente.IdPeriodo,
                            periodoExistente.Anio,
                            periodoExistente.Mes,
                            periodoExistente.Estado
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuario, ex.ToString());
                throw;
            }
        }

        public Task<IEnumerable<PeriodoContable>> GetPaginadoAsync(int pagina, int tamanoPagina)
        {
            return _repository.GetPaginadoAsync(pagina, tamanoPagina);
        }

        public Task<int> CountAsync(string? estado = null)
        {
            return _repository.CountAsync(estado);
        }

        public async Task<int> CerrarPeriodoAsync(int idPeriodo, int idUsuario)
        {
            var resultado = await _repository.CerrarPeriodoAsync(idPeriodo, idUsuario);

            if (resultado == 1)
            {
                await _bitacoraService.RegistrarAccionAsync(
                    idUsuario,
                    "Cierre de periodo contable",
                    new { IdPeriodo = idPeriodo }
                );
            }

            return resultado;
        }

        public async Task<int> ReabrirPeriodoAsync(int idPeriodo, int idUsuario)
        {
            var resultado = await _repository.ReabrirPeriodoAsync(idPeriodo);

            if (resultado == 1)
            {
                await _bitacoraService.RegistrarAccionAsync(
                    idUsuario,
                    "Reapertura de periodo contable",
                    new { IdPeriodo = idPeriodo }
                );
            }

            return resultado;
        }
    }
}