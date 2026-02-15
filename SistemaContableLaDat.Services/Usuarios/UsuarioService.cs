using Dapper;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Infrastructure;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Encriptado;
using System.Data;
using System.Security.Cryptography;
using System.Text;

namespace SistemaContableLaDat.Repository.Usuarios
{
    public class UsuarioService : IUsuarioService
    {
        private readonly UsuarioRepository _usuarioRepository;
        private readonly IUsuarioRolService _usuarioRolService;
        private readonly IBitacoraService _bitacoraService;
        private readonly IEncriptadoService _encriptadoService;

        public UsuarioService(
            UsuarioRepository usuarioRepository,
            IUsuarioRolService usuarioRolService,
            IBitacoraService bitacoraService,
            IEncriptadoService encriptadoService)
        {
            _usuarioRepository = usuarioRepository;
            _usuarioRolService = usuarioRolService;
            _bitacoraService = bitacoraService;
            _encriptadoService = encriptadoService;
        }

        public Task<IEnumerable<UsuarioEntity>> GetAllAsync()
        {
            return _usuarioRepository.GetAllAsync();
        }

        public Task<UsuarioEntity?> GetByIdAsync(int IdUsuario)
        {
            return _usuarioRepository.GetByIdAsync(IdUsuario);
        }

        public async Task<int> InsertAsync(UsuarioEntity usuario, List<string> roles, int IdUsuario)
        {
            try
            {

                var resultado = await _usuarioRepository.InsertAsync(usuario);

                if (resultado == 1)
                {
                    foreach (var rolId in roles)
                    {
                        await _usuarioRolService.AsignarRolAsync(usuario.IdUsuario, rolId.ToString());
                    }

                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
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
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> UpdateAsync(UsuarioEntity usuario, List<string> roles, int IdUsuario)
        {
            try
            {
                var usuarioAnterior = await _usuarioRepository.GetByIdAsync(usuario.IdUsuario);
                var resultado = await _usuarioRepository.UpdateAsync(usuario);

                if (resultado == 1 && usuarioAnterior != null)
                {
                    var rolesActuales = await _usuarioRolService.GetRolesByUsuarioAsync(usuario.IdUsuario);

                    foreach (var rolActual in rolesActuales)
                    {
                        await _usuarioRolService.RemoverRolAsync(usuario.IdUsuario, rolActual.IdRol);
                    }

                    foreach (var rolNuevo in roles)
                    {
                        await _usuarioRolService.AsignarRolAsync(usuario.IdUsuario, rolNuevo.ToString());
                    }

                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Usuario actualizado",
                        new { Antes = usuarioAnterior, Despues = usuario }
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

        public async Task<int> DeleteAsync(int IdUsuario)
        {
            try
            {
                var usuarioExistente = await _usuarioRepository.GetByIdAsync(IdUsuario);

                if (usuarioExistente == null)
                    return 0;

                var resultado = await _usuarioRepository.DeleteAsync(IdUsuario);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
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
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
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

        public async Task<int> CambiarClaveAsync(int IdUsuario, string nuevaClave)
        {
            try
            {
                var usuarioExistente = await _usuarioRepository.GetByIdAsync(IdUsuario);

                if (usuarioExistente == null)
                    return 0;

                var plaintext = Encoding.UTF8.GetBytes(nuevaClave);
                var (ciphertext, tag, nonce) = _encriptadoService.Encriptar(plaintext);

                var resultado = await _usuarioRepository.CambiarClaveAsync(IdUsuario, ciphertext, tag, nonce);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Cambio de clave",
                        new
                        {
                            usuarioExistente.IdUsuario,
                            usuarioExistente.Usuario,
                            usuarioExistente.CorreoElectronico
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
        public async Task<int> CambiarEstadoAsync(int IdUsuario, string nuevoEstado)
        {
            try
            {
                var usuarioExistente = await _usuarioRepository.GetByIdAsync(IdUsuario);
                if (usuarioExistente == null)
                    return 0;

                var estadoAnterior = usuarioExistente.Estado;

                var resultado = await _usuarioRepository.CambiarEstadoAsync(IdUsuario, nuevoEstado);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario, 
                        "Cambio de estado de usuario",
                        new
                        {
                            IdUsuario = usuarioExistente.IdUsuario,
                            NombreUsuario = usuarioExistente.NombreUsuario,
                            ApellidoUsuario = usuarioExistente.ApellidoUsuario,
                            EstadoAnterior = estadoAnterior.ToString(),
                            EstadoNuevo = nuevoEstado
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


    }
}
