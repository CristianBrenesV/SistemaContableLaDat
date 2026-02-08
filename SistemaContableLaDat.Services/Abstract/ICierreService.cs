using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SistemaContableLaDat.Entities.Cierres;

namespace SistemaContableLaDat.Service.Abstract
{
    public interface ICierreService
    {
        Task<IEnumerable<PeriodoContableEntity>> ListarPeriodosAsync();
        Task<ResultadoCierreDto> CalcularCierreAsync(int idPeriodo);
        Task<bool> EjecutarCierreAsync(int idPeriodo, int idUsuario);
        Task<IEnumerable<SaldoCuentaDto>> ObtenerSaldosDetalladosAsync(int idPeriodo);
        Task<bool> ValidarPeriodosAnterioresCerradosAsync(int idPeriodo);
        Task<CierreContableEntity> ObtenerUltimoCierreAsync();
        Task<PeriodoContableEntity?> ObtenerPeriodoAsync(int idPeriodo);
    }
}