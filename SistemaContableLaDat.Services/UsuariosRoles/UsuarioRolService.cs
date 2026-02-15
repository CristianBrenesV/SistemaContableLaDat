using SistemaContableLaDat.Entities.UsuariosRoles;
using SistemaContableLaDat.Repository.UsuariosRoles;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Service.UsuariosRoles
{
    public class UsuarioRolService : IUsuarioRolService
    {
        private readonly UsuarioRolRepository _usuarioRolRepository;
        private readonly IBitacoraService _bitacoraService;

        public UsuarioRolService(
            UsuarioRolRepository usuarioRolRepository,
            IBitacoraService bitacoraService)
        {
            _usuarioRolRepository = usuarioRolRepository;
            _bitacoraService = bitacoraService;
        }

        public Task<IEnumerable<UsuarioRol>> GetRolesByUsuarioAsync(int idUsuario)
        {
            return _usuarioRolRepository.GetRolesByUsuarioAsync(idUsuario);
        }

        public async Task<int> AsignarRolAsync(int idUsuario, string idRol)
        {
            try
            {
                var resultado = await _usuarioRolRepository.InsertAsync(idUsuario, idRol);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Rol asignado a usuario",
                        new { idUsuario, idRol }
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

        public async Task<int> RemoverRolAsync(int idUsuario, string idRol)
        {
            try
            {
                var resultado = await _usuarioRolRepository.DeleteAsync(idUsuario, idRol);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuario,
                        "Rol removido de usuario",
                        new { idUsuario, idRol }
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
    }
}
