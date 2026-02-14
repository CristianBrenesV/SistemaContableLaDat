using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.PeriodosContables;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.Periodos
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly IPeriodosContablesService _periodosService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(
            IPeriodosContablesService periodosService,
            IBitacoraService bitacoraService)
        {
            _periodosService = periodosService;
            _bitacoraService = bitacoraService;
        }

        [BindProperty(SupportsGet = true)]
        public int? PeriodoId { get; set; }

        [BindProperty(SupportsGet = true)]
        public int? EstadoId { get; set; }

        public List<PeriodoContable> Periodos { get; set; } = new();

        public IEnumerable<SelectListItem> ListaEstados { get; set; }

        public int PaginaActual { get; set; }
        public int TotalPaginas { get; set; }

        private const int TamanoPagina = 10;

        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (int.TryParse(claim, out var idUsuario))
                return idUsuario;

            return null;
        }

        public async Task<IActionResult> OnGetAsync(int pagina = 1)
        {
            var query = await _periodosService.GetPaginadoAsync(pagina, TamanoPagina);

            if (PeriodoId.HasValue)
                query = query.Where(p => p.IdPeriodo == PeriodoId.Value).ToList();

            if (EstadoId.HasValue)
                query = query.Where(p => (int)p.Estado == EstadoId.Value).ToList();

            var total = query.Count();
            PaginaActual = pagina;
            TotalPaginas = (int)Math.Ceiling(total / (double)TamanoPagina);

            Periodos = query
                .Skip((pagina - 1) * TamanoPagina)
                .Take(TamanoPagina)
                .ToList();

            ListaEstados = Enum.GetValues(typeof(EstadoPeriodosContables))
                .Cast<EstadoPeriodosContables>()
                .Select(e => new SelectListItem
                {
                    Text = e.ToString(),
                    Value = ((int)e).ToString(),
                    Selected = EstadoId.HasValue && EstadoId.Value == (int)e
                });

            var idUsuario = ObtenerIdUsuarioLogueado();
            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta de periodos contables con filtros",
                    new { Pagina = pagina, PeriodoId, EstadoId, RegistrosMostrados = Periodos.Count }
                );
            }

            return Page();
        }

        public async Task<IActionResult> OnPostEliminarAsync(int idPeriodo)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();

            if (!idUsuario.HasValue)
            {
                TempData["Mensaje"] = "No se pudo obtener el usuario autenticado.";
                return RedirectToPage();
            }

            var resultado = await _periodosService.DeleteAsync(idPeriodo, idUsuario.Value);

            TempData["Mensaje"] = resultado == 1
                ? "Periodo eliminado correctamente."
                : "No se pudo eliminar el periodo.";

            return RedirectToPage();
        }

        public async Task<IActionResult> OnPostCerrarAsync(int idPeriodo)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();
            if (!idUsuario.HasValue) return RedirectToPage();

            await _periodosService.CerrarPeriodoAsync(idPeriodo, idUsuario.Value);
            TempData["Mensaje"] = "Periodo cerrado correctamente";
            return RedirectToPage();
        }

        public async Task<IActionResult> OnPostReabrirAsync(int idPeriodo)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();
            if (!idUsuario.HasValue) return RedirectToPage();

            await _periodosService.ReabrirPeriodoAsync(idPeriodo, idUsuario.Value);
            TempData["Mensaje"] = "Periodo reabierto correctamente";
            return RedirectToPage();
        }

    }
}