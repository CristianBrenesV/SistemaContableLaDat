using SistemaContableLaDat.Entities.Usuarios;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IUsuarioService
    {
        Task<IEnumerable<UsuarioEntity>> GetAllAsync();
        Task<UsuarioEntity?> GetByIdAsync(string id);
        Task<int> InsertAsync(UsuarioEntity usuario, string idUsuarioEjecutor);
        Task<int> UpdateAsync(UsuarioEntity usuario, string idUsuarioEjecutor);  
        Task<int> DeleteAsync(string id_usuario, string idUsuarioEjecutor);
        Task<IEnumerable<UsuarioEntity>> GetUsuariosPaginadosAsync(int pagina, int tamanoPagina);
        Task<int> CuentaUsuariosAsync();

    }
}
