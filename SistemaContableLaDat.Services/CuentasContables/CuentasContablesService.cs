using SistemaContableLaDat.Entities.CuentasContables;
using SistemaContableLaDat.Repository.CuentasContables;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.CuentasContables
{
    public class CuentasContablesService : ICuentasContablesService
    {
        private readonly CuentasContablesRepository _repository;
        private readonly IBitacoraService _bitacoraService;

        public CuentasContablesService(
            CuentasContablesRepository repository,
            IBitacoraService bitacoraService)
        {
            _repository = repository;
            _bitacoraService = bitacoraService;
        }

        public Task<IEnumerable<CuentaContable>> GetAllAsync()
        {
            return _repository.GetAllAsync();
        }

        public Task<CuentaContable?> GetByIdAsync(int idCuenta)
        {
            return _repository.GetByIdAsync(idCuenta);
        }

        public async Task<int> InsertAsync(CuentaContable cuenta, int idUsuario)
        {
            try
            {
                var resultado = await _repository.InsertAsync(cuenta);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Cuenta contable creada",
                        new
                        {
                            cuenta.IdCuenta,
                            cuenta.CodigoCuenta,
                            cuenta.Nombre,
                            cuenta.Tipo,
                            cuenta.CuentaPadre,
                            cuenta.TipoSaldo,
                            cuenta.AceptaMovimiento,
                            cuenta.Estado
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

        public async Task<int> UpdateAsync(CuentaContable cuenta, int idUsuario)
        {
            try
            {
                var cuentaAnterior = await _repository.GetByIdAsync(cuenta.IdCuenta);

                var resultado = await _repository.UpdateAsync(cuenta);

                if (resultado == 1 && cuentaAnterior != null)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Cuenta contable actualizada",
                        new
                        {
                            Antes = cuentaAnterior,
                            Despues = cuenta
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

        public async Task<int> DeleteAsync(int idCuenta, int idUsuario)
        {
            try
            {
                var cuentaExistente = await _repository.GetByIdAsync(idCuenta);

                if (cuentaExistente == null)
                    return 0;

                var resultado = await _repository.DeleteAsync(idCuenta);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Cuenta contable eliminada",
                        new
                        {
                            cuentaExistente.IdCuenta,
                            cuentaExistente.CodigoCuenta,
                            cuentaExistente.Nombre,
                            cuentaExistente.Tipo,
                            cuentaExistente.Estado
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

        public Task<IEnumerable<CuentaContable>> GetPaginadoAsync(int pagina, int tamanoPagina)
        {
            return _repository.GetPaginadoAsync(pagina, tamanoPagina);
        }

        public Task<int> CountAsync()
        {
            return _repository.CountAsync();
        }
    }
}