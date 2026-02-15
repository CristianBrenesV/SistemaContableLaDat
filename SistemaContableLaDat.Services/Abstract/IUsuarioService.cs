using SistemaContableLaDat.Entities.Usuarios;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IUsuarioService
    {
        Task<IEnumerable<UsuarioEntity>> GetAllAsync();
        Task<UsuarioEntity?> GetByIdAsync(int IdUsuario);
        Task<int> InsertAsync(UsuarioEntity usuario, List<string> roles, int IdUsuario);
        Task<int> UpdateAsync(UsuarioEntity usuario, List<string> roles, int IdUsuario);
        Task<int> DeleteAsync(int IdUsuario);
        Task<IEnumerable<UsuarioEntity>> GetUsuariosPaginadosAsync(int pagina, int tamanoPagina);
        Task<int> CuentaUsuariosAsync();
        Task<int> CambiarClaveAsync(int IdUsuario, string nuevaClave);
        Task<int> CambiarEstadoAsync(int idUsuario, string nuevoEstado);

    }
}
