using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.PeriodosContables;
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

        public List<PeriodoContable> Periodos { get; set; } = new();

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
            var periodosEntidad = await _periodosService.GetPaginadoAsync(pagina, TamanoPagina);
            var total = await _periodosService.CountAsync();

            PaginaActual = pagina;
            TotalPaginas = (int)Math.Ceiling(total / (double)TamanoPagina);

            Periodos = periodosEntidad.ToList();

            var idUsuario = ObtenerIdUsuarioLogueado();
            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta paginada de periodos contables",
                    new { Pagina = pagina, RegistrosMostrados = Periodos.Count }
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
    }
}