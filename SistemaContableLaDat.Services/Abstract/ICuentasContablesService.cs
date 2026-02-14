using SistemaContableLaDat.Entities.CuentasContables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface ICuentasContablesService
    {
        Task<IEnumerable<CuentaContable>> GetAllAsync();
        Task<CuentaContable?> GetByIdAsync(int idCuenta);
        Task<int> InsertAsync(CuentaContable cuenta, int idUsuario);
        Task<int> UpdateAsync(CuentaContable cuenta, int idUsuario);
        Task<int> DeleteAsync(int idCuenta, int idUsuario);
        Task<IEnumerable<CuentaContable>> GetPaginadoAsync(int pagina, int tamanoPagina);
        Task<int> CountAsync();
    }
}
