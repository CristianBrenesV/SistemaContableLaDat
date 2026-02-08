using SistemaContableLaDat.Repository.Periodos;
using System.Linq;

namespace SistemaContableLaDat.Service.Periodos
{
    public class PeriodoService
    {
        private readonly PeriodoRepository _repository;

        public PeriodoService(PeriodoRepository repository)
        {
            _repository = repository;
        }

        public async Task<List<PeriodoDto>> ListarParaFiltrosAsync()
        {
            var periodos = await _repository.ObtenerTodosAsync();

            return periodos.Select(p => new PeriodoDto
            {
                IdPeriodo = p.IdPeriodo,
                Descripcion = $"{p.Mes:D2}/{p.Anio} - {p.Estado}",
                EstaAbierto = p.Estado == "Abierto"
            }).ToList();
        }

        public async Task<int> ObtenerIdPeriodoActivoAsync()
        {
            var activo = await _repository.ObtenerActivoAsync();
            return activo?.IdPeriodo ?? 0;
        }
    }
}