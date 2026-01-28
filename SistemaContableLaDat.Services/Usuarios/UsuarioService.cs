using Dapper;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Infrastructure;
using SistemaContableLaDat.Service.Abstract;
using System.Data;

namespace SistemaContableLaDat.Repository.Usuarios
{
    public class UsuarioService : IUsuarioService
    {

        private readonly UsuarioRepository _usuarioRepository;
        private readonly IBitacoraService _bitacoraService;

        public UsuarioService(UsuarioRepository usuarioRepository, IBitacoraService bitacoraService)
        {
            _usuarioRepository = usuarioRepository;
            _bitacoraService = bitacoraService;
        }

        public Task<IEnumerable<UsuarioEntity>> GetAllAsync()
        {
            return _usuarioRepository.GetAllAsync();
        }

        public Task<UsuarioEntity?> GetByIdAsync(string id_usuario)
        {
            return _usuarioRepository.GetByIdAsync(id_usuario);
        }

        public async Task<int> InsertAsync(UsuarioEntity usuario, string idUsuarioEjecutor)
        {
            try
            {
                var resultado = await _usuarioRepository.InsertAsync(usuario);
                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuarioEjecutor,
                        "Usuario creado",
                        new
                        {
                            usuario.IdUsuario,
                            usuario.NombreUsuario,
                            usuario.NombreCompleto,
                            usuario.CorreoElectronico,
                            Estado = usuario.Estado.ToString()
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuarioEjecutor, ex.ToString());
                throw;
            }
        }

        public async Task<int> UpdateAsync(UsuarioEntity usuario, string idUsuarioEjecutor)
        {
            try
            {
                var usuarioAnterior = await _usuarioRepository.GetByIdAsync(usuario.IdUsuario);
                var resultado = await _usuarioRepository.UpdateAsync(usuario);

                if (resultado == 1 && usuarioAnterior != null)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuarioEjecutor,
                        "Usuario actualizado",
                        new
                        {
                            Antes = usuarioAnterior,
                            Despues = usuario
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuarioEjecutor, ex.ToString());
                throw;
            }
        }


        public async Task<int> DeleteAsync(string id_usuario, string idUsuarioEjecutor)
        {
            try
            {
                // 1. Obtener los datos actuales del usuario antes de eliminar
                var usuarioExistente = await _usuarioRepository.GetByIdAsync(id_usuario);

                if (usuarioExistente == null)
                {
                    // Puedes registrar un intento de eliminación fallido si lo deseas
                    return 0; // No existe, no hay nada que eliminar
                }

                // 2. Eliminar
                var resultado = await _usuarioRepository.DeleteAsync(id_usuario);

                // 3. Registrar en bitácora solo si fue exitoso
                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuarioEjecutor,
                        "Usuario eliminado",
                        new
                        {
                            usuarioExistente.IdUsuario,
                            usuarioExistente.NombreUsuario,
                            usuarioExistente.NombreCompleto,
                            usuarioExistente.CorreoElectronico,
                            usuarioExistente.Estado
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuarioEjecutor, ex.ToString());
                throw;
            }
        }

        public Task<IEnumerable<UsuarioEntity>> GetUsuariosPaginadosAsync(int pagina, int tamanoPagina)
        {
            return _usuarioRepository.GetUsuariosPaginadosAsync(pagina, tamanoPagina);
        }

        public Task<int> CuentaUsuariosAsync()
        {
            return _usuarioRepository.CuentaUsuariosAsync();
        }

    }
}
