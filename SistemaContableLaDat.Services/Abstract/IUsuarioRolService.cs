using SistemaContableLaDat.Entities.UsuariosRoles;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IUsuarioRolService
    {
        Task<IEnumerable<UsuarioRol>> GetRolesByUsuarioAsync(int idUsuario);
        Task<int> AsignarRolAsync(int idUsuario, string idRol);
        Task<int> RemoverRolAsync(int idUsuario, string idRol);
    }
}
