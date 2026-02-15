using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Roles;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Roles
{
    public class RolService : IRolService
    {
        private readonly RolRepository _rolRepository;
        private readonly IBitacoraService _bitacoraService;

        public RolService(RolRepository rolRepository, IBitacoraService bitacoraService)
        {
            _rolRepository = rolRepository;
            _bitacoraService = bitacoraService;
        }

        public Task<IEnumerable<Rol>> GetAllAsync()
        {
            return _rolRepository.GetAllAsync();
        }

        public Task<Rol?> GetByIdAsync(string idRol)
        {
            return _rolRepository.GetByIdAsync(idRol);
        }
        public Task<IEnumerable<Rol>> GetRolesPaginadosAsync(int pagina, int tamanoPagina)
        {
            return _rolRepository.GetRolesPaginadosAsync(pagina, tamanoPagina);
        }
        public async Task<int> InsertAsync(Rol rol, int IdUsuario)
        {
            try
            {
                var resultado = await _rolRepository.InsertAsync(rol);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Rol creado",
                        new
                        {
                            rol.IdRol,
                            rol.NombreRol,
                            rol.Descripcion,
                            Estado = rol.Estado.ToString()
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> UpdateAsync(Rol rol, int IdUsuario)
        {
            try
            {
                var rolAnterior = await _rolRepository.GetByIdAsync(rol.IdRol);
                var resultado = await _rolRepository.UpdateAsync(rol);

                if (resultado == 1 && rolAnterior != null)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Rol actualizado",
                        new
                        {
                            Antes = rolAnterior,
                            Despues = rol
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> DeleteAsync(string idRol, int IdUsuario)
        {
            try
            {
                var rolExistente = await _rolRepository.GetByIdAsync(idRol);

                if (rolExistente == null)
                    return 0;

                var resultado = await _rolRepository.DeleteAsync(idRol);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Rol eliminado",
                        new
                        {
                            rolExistente.IdRol,
                            rolExistente.NombreRol,
                            rolExistente.Descripcion,
                            Estado = rolExistente.Estado.ToString()
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }
        public Task<int> CuentaRolesAsync()
        {
            return _rolRepository.CuentaRolesAsync();
        }
    }
}
