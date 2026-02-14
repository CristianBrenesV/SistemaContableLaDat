using SistemaContableLaDat.Entities.EstadosAsientosContables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IEstadosAsientosContablesService
    {
        Task<IEnumerable<EstadosAsientoContable>> GetAllAsync();
        Task<EstadosAsientoContable?> GetByIdAsync(int idEstadoAsiento);
        Task<int> InsertAsync(EstadosAsientoContable estado, int idUsuario);
        Task<int> UpdateAsync(EstadosAsientoContable estado, int idUsuario);
        Task<int> DeleteAsync(int idEstadoAsiento, int idUsuario);
        Task<IEnumerable<EstadosAsientoContable>> GetPaginadoAsync(int pagina, int tamanoPagina);
        Task<int> CountAsync(string? estado = null);
    }
}
