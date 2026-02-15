using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Entities.RolesPantallas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IRolPantallaService
    {
        Task<IEnumerable<RolPantalla>> GetPantallasByRolAsync(string idRol);
        Task<IEnumerable<Pantalla>> GetPantallasDetalleByRolAsync(string idRol);
        Task<int> AsignarPantallaAsync(string idRol, int idPantalla, int idUsuarioEjecutor);
        Task<int> RemoverPantallaAsync(string idRol, int idPantalla, int idUsuarioEjecutor);
        Task<int> ActualizarPantallasAsync(string idRol, List<int> pantallas, int idUsuarioEjecutor);
        Task<IEnumerable<RolPantalla>> Listar10Async(int limite, int offset);
        Task<IEnumerable<RolPantalla>> ListarAsync();
        Task<int> ConteoAsync();
    }
}
