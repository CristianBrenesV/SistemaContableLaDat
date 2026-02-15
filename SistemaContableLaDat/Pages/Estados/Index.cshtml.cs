using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.EstadosAsientosContables;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.Estados
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly IEstadosAsientosContablesService _estadosService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(
            IEstadosAsientosContablesService estadosService,
            IBitacoraService bitacoraService)
        {
            _estadosService = estadosService;
            _bitacoraService = bitacoraService;
        }

        public List<EstadosAsientoContable> Estados { get; set; } = new();

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
            var estadosEntidad = await _estadosService.GetPaginadoAsync(pagina, TamanoPagina);
            var total = await _estadosService.CountAsync();

            PaginaActual = pagina;
            TotalPaginas = (int)Math.Ceiling(total / (double)TamanoPagina);

            Estados = estadosEntidad.ToList();

            var idUsuario = ObtenerIdUsuarioLogueado();
            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta paginada de estados de asientos contables",
                    new { Pagina = pagina, RegistrosMostrados = Estados.Count }
                );
            }

            return Page();
        }

        public async Task<IActionResult> OnPostEliminarAsync(int idEstadoAsiento)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();

            if (!idUsuario.HasValue)
            {
                TempData["Mensaje"] = "No se pudo obtener el usuario autenticado.";
                return RedirectToPage();
            }

            var resultado = await _estadosService.DeleteAsync(idEstadoAsiento, idUsuario.Value);

            TempData["Mensaje"] = resultado == 1
                ? "Estado eliminado correctamente."
                : "No se pudo eliminar el estado.";

            return RedirectToPage();
        }
    }
}