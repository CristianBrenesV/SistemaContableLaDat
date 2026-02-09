using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Service.Periodos;
using System.Security.Claims;

namespace SistemaContableLaDat.Web.Pages.Asientos
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly AsientoService _asientoService;
        private readonly PeriodoService _periodoService;

        public List<AsientoListadoDto> Asientos { get; set; } = new();
        public List<PeriodoDto> ListaPeriodos { get; set; } = new();

        [BindProperty(SupportsGet = true)]
        public int? PeriodoId { get; set; }

        [BindProperty(SupportsGet = true)]
        public int? EstadoId { get; set; }

        public int PaginaActual { get; set; } = 1;
        public int TotalPaginas { get; set; }
        private const int PageSize = 10;

        public IndexModel(AsientoService asientoService, PeriodoService periodoService)
        {
            _asientoService = asientoService;
            _periodoService = periodoService;
        }

        public async Task<IActionResult> OnGetAsync(int page = 1)
        {
            PaginaActual = page;

            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim == null) return Challenge();

            int idUsuario = int.Parse(userIdClaim.Value);

            var periodosDb = await _periodoService.ListarParaFiltrosAsync();
            ListaPeriodos = periodosDb ?? new List<PeriodoDto>();

            if (PeriodoId == null || PeriodoId == 0)
            {
                PeriodoId = await _periodoService.ObtenerIdPeriodoActivoAsync();
                if (PeriodoId == null && ListaPeriodos.Any())
                {
                    PeriodoId = ListaPeriodos.First().IdPeriodo;
                }
            }
            var resultadoAsientos = await _asientoService.ListarPorPeriodoAsync(PeriodoId ?? 0, idUsuario, EstadoId);
            var todos = (resultadoAsientos ?? new List<AsientoListadoDto>()).ToList();

            TotalPaginas = (int)Math.Ceiling(todos.Count / (double)PageSize);
            if (TotalPaginas == 0) TotalPaginas = 1;

            Asientos = todos
                .Skip((PaginaActual - 1) * PageSize)
                .Take(PageSize)
                .ToList();

            return Page();
        }

        public async Task<IActionResult> OnGetDetalleAsync(int idAsiento)
        {
            var detalle = await _asientoService.ObtenerDetalleAsync(idAsiento);
            return new JsonResult(detalle ?? new object());
        }

        public async Task<IActionResult> OnPostAnularAsync(int id)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim != null)
            {
                int idUsuario = int.Parse(userIdClaim.Value);
                await _asientoService.AnularAsync(id, idUsuario);
            }

            return RedirectToPage(new
            {
                page = PaginaActual,
                PeriodoId = PeriodoId,
                EstadoId = EstadoId
            });
        }
    }
}