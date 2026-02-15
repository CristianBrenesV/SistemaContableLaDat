using SistemaContableLaDat.Entities.EstadosAsientosContables;
using SistemaContableLaDat.Repository.EstadosAsientosContables;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.EstadosAsientosContables
{
    public class EstadosAsientosContablesService : IEstadosAsientosContablesService
    {
        private readonly EstadoAsientoContableRepository _repository;
        private readonly IBitacoraService _bitacoraService;

        public EstadosAsientosContablesService(
            EstadoAsientoContableRepository repository,
            IBitacoraService bitacoraService)
        {
            _repository = repository;
            _bitacoraService = bitacoraService;
        }

        public Task<IEnumerable<EstadosAsientoContable>> GetAllAsync()
        {
            return _repository.GetAllAsync();
        }

        public Task<EstadosAsientoContable?> GetByIdAsync(int idEstadoAsiento)
        {
            return _repository.GetByIdAsync(idEstadoAsiento);
        }

        public async Task<int> InsertAsync(EstadosAsientoContable estado, int idUsuario)
        {
            try
            {
                var resultado = await _repository.InsertAsync(estado);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Estado de asiento contable creado",
                        new
                        {
                            estado.Codigo,
                            estado.Nombre,
                            estado.Descripcion,
                            estado.Estado
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

        public async Task<int> UpdateAsync(EstadosAsientoContable estado, int idUsuario)
        {
            try
            {
                var estadoAnterior = await _repository.GetByIdAsync(estado.IdEstadoAsiento);

                var resultado = await _repository.UpdateAsync(estado);

                if (resultado == 1 && estadoAnterior != null)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Estado de asiento contable actualizado",
                        new
                        {
                            Antes = estadoAnterior,
                            Despues = estado
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

        public async Task<int> DeleteAsync(int idEstadoAsiento, int idUsuario)
        {
            try
            {
                var estadoExistente = await _repository.GetByIdAsync(idEstadoAsiento);

                if (estadoExistente == null)
                    return 0;

                var resultado = await _repository.DeleteAsync(idEstadoAsiento);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Estado de asiento contable eliminado",
                        new
                        {
                            estadoExistente.IdEstadoAsiento,
                            estadoExistente.Codigo,
                            estadoExistente.Nombre,
                            estadoExistente.Estado
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

        public Task<IEnumerable<EstadosAsientoContable>> GetPaginadoAsync(int pagina, int tamanoPagina)
        {
            return _repository.GetPaginadoAsync(pagina, tamanoPagina);
        }

        public Task<int> CountAsync(string? estado = null)
        {
            return _repository.CountAsync(estado);
        }
    }
}