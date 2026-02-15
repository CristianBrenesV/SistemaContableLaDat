using SistemaContableLaDat.Entities.Pantallas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface IPantallaService
    {
        Task<IEnumerable<Pantalla>> GetAllAsync();
        Task<Pantalla?> GetByIdAsync(int IdPantalla);
        Task<int> InsertAsync(Pantalla pantalla, int IdUsuario);
        Task<int> UpdateAsync(Pantalla pantalla, int IdUsuario);
        Task<int> DeleteAsync(int IdPantalla, int IdUsuario);
        Task<IEnumerable<Pantalla>> GetPantallasPaginadosAsync(int pagina, int tamanoPagina);
        Task<int> CuentaPantallasAsync();
    }
}
