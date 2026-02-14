using SistemaContableLaDat.Entities.PeriodosContables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IPeriodosContablesService
    {
        Task<IEnumerable<PeriodoContable>> GetAllAsync();
        Task<PeriodoContable?> GetByIdAsync(int idPeriodo);
        Task<int> InsertAsync(PeriodoContable periodo, int idUsuario);
        Task<int> UpdateAsync(PeriodoContable periodo, int idUsuario);
        Task<int> DeleteAsync(int idPeriodo, int idUsuario);
        Task<IEnumerable<PeriodoContable>> GetPaginadoAsync(int pagina, int tamanoPagina);
        Task<int> CountAsync(string? estado = null);
    }
}
