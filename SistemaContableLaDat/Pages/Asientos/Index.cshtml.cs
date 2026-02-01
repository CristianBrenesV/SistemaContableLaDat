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

        public IndexModel(AsientoService asientoService)
        {
            _asientoService = asientoService;
        }

        public async Task<IActionResult> OnGetAsync()
        {
            int idPeriodo = 1; // luego será el periodo activo
            int idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

            Asientos = (await _asientoService
                .ListarPorPeriodoAsync(idPeriodo, idUsuario))
                .ToList();

            return Page();
        }

        public async Task<IActionResult> OnPostAnularAsync(int id)
        {
            int idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

            await _asientoService.AnularAsync(id, idUsuario);

            return RedirectToPage();
        }
    }
}
