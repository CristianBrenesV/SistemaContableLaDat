using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Entities.Asientos;
using System.Security.Claims;

namespace SistemaContableLaDat.Web.Pages.Asientos
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly AsientoService _asientoService;

        public List<AsientoListadoDto> Asientos { get; set; } = new();

        public int PaginaActual { get; set; } = 1;
        public int TotalPaginas { get; set; }
        private const int PageSize = 10;

        public IndexModel(AsientoService asientoService)
        {
            _asientoService = asientoService;
        }

        public async Task<IActionResult> OnGetAsync(int page = 1)
        {
            PaginaActual = page;

            int idPeriodo = 1;
            int idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

            var todos = (await _asientoService
                .ListarPorPeriodoAsync(idPeriodo, idUsuario))
                .ToList();

            TotalPaginas = (int)Math.Ceiling(todos.Count / (double)PageSize);

            Asientos = todos
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToList();

            return Page();
        }

        public async Task<IActionResult> OnGetDetalleAsync(int idAsiento)
        {
            var detalle = await _asientoService.ObtenerDetalleAsync(idAsiento);
            return new JsonResult(detalle);
        }


        public async Task<IActionResult> OnPostAnularAsync(int id)
        {
            int idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

            await _asientoService.AnularAsync(id, idUsuario);

            return RedirectToPage(new { page = PaginaActual });
        }
    }
}
