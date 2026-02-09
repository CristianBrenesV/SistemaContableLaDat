using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Service.Asientos;
using System.Security.Claims;

namespace SistemaContableLaDat.Web.Pages.Asientos
{
    public class AprobarModel : PageModel
    {
        private readonly AsientoService _asientoService;

        public List<AsientoListadoDto> Asientos { get; set; } = new();
        public Dictionary<int, string> Estados { get; set; } = new();
        public List<PeriodoComboDto> Periodos { get; set; } = new();
        public AsientoFiltroDto Filtro { get; set; } = new();
        public int TotalPaginas { get; set; }
        public int TotalRegistros { get; set; }

        [BindProperty(SupportsGet = true)]
        public int? PeriodoFiltro { get; set; }

        [BindProperty(SupportsGet = true)]
        public int? EstadoFiltro { get; set; }

        [BindProperty(SupportsGet = true)]
        public int PaginaActual { get; set; } = 1;

        public AprobarModel(AsientoService asientoService)
        {
            _asientoService = asientoService;
        }

        public async Task OnGetAsync()
        {
            await CargarEstados();
            await CargarPeriodos();

            Filtro.IdPeriodo = PeriodoFiltro; // allow null to propagate
            Filtro.IdEstado = EstadoFiltro;
            Filtro.Pagina = PaginaActual;
            Filtro.ItemsPorPagina = 10;

            int idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

            var resultado = await _asientoService.ListarConFiltroAsync(Filtro, idUsuario);
            Asientos = resultado.Asientos.ToList();
            TotalRegistros = resultado.Total;
            TotalPaginas = (int)Math.Ceiling(TotalRegistros / (double)Filtro.ItemsPorPagina);
        }

        public async Task<IActionResult> OnPostCambiarEstadoAsync(int idAsiento, int nuevoEstado)
        {
            try
            {
                int idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

                bool resultado = await _asientoService.CambiarEstadoAsync(idAsiento, nuevoEstado, idUsuario);

                if (resultado)
                {
                    TempData["SuccessMessage"] = "Estado del asiento actualizado correctamente.";
                }
                else
                {
                    TempData["ErrorMessage"] = "No se pudo cambiar el estado del asiento.";
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Error: {ex.Message}";
            }

            return RedirectToPage(new
            {
                PeriodoFiltro = PeriodoFiltro,
                EstadoFiltro = EstadoFiltro,
                PaginaActual = PaginaActual
            });
        }

        public async Task<IActionResult> OnGetAccionesPermitidasAsync(int idAsiento)
        {
            var acciones = await _asientoService.ObtenerEstadosPermitidosAsync(idAsiento);
            return new JsonResult(acciones);
        }

        private async Task CargarEstados()
        {
            Estados = new Dictionary<int, string>
            {
                { (int)EstadoAsiento.Borrador, "Borrador" },
                { (int)EstadoAsiento.PendienteAprobar, "Pendiente de Aprobación" },
                { (int)EstadoAsiento.Aprobado, "Aprobado" },
                { (int)EstadoAsiento.Rechazado, "Rechazado" },
                { (int)EstadoAsiento.Anulado, "Anulado" }
            };
        }

        private async Task CargarPeriodos()
        {
            var periodos = await _asientoService.ObtenerPeriodosParaComboAsync();
            Periodos = periodos.ToList();
        }
    }
}