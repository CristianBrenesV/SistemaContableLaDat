using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Entities.Usuarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IRolService
    {
        Task<IEnumerable<Rol>> GetAllAsync();
        Task<Rol?> GetByIdAsync(string IdRol);
        Task<int> InsertAsync(Rol rol, int IdUsuario);
        Task<int> UpdateAsync(Rol rol, int IdUsuario);
        Task<int> DeleteAsync(string idRol, int IdUsuario);
        Task<IEnumerable<Rol>> GetRolesPaginadosAsync(int pagina, int tamanoPagina);
        Task<int> CuentaRolesAsync();
    }
}
