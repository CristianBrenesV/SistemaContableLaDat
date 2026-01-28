using SistemaContableLaDat.Entities.Usuarios;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface ILoginService
    {   
        Task<UsuarioEntity?> VerificarCredencialAsync(string nombreUsuario);
    }
    
}
