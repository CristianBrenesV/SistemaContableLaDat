using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Service.Asientos;
using System.Security.Claims;

namespace SistemaContableLaDat.Pages.Asientos
{
    public class AnularModel : PageModel
    {
        private readonly AsientoService _asientoService;

        public AnularModel(AsientoService asientoService)
        {
            _asientoService = asientoService;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Asiento { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int id)
        {
            var asiento = await _asientoService.ObtenerParaEdicionAsync(id);
            if (asiento == null) return NotFound();

            if (asiento.IdEstadoAsiento == 5)
            {
                TempData["Error"] = "Este asiento ya se encuentra anulado.";
                return RedirectToPage("/Asientos/Index");
            }

            Asiento = asiento;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int id)
        {
            try
            {
                var userIdClaim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier);
                int idUsuario = userIdClaim != null ? int.Parse(userIdClaim.Value) : 1;

                await _asientoService.AnularAsync(id, idUsuario);

                TempData["Success"] = $"Asiento #{id} anulado correctamente.";

                return LocalRedirect("/Asientos");

            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "Error: " + ex.Message);
                Asiento = await _asientoService.ObtenerParaEdicionAsync(id);
                return Page();
            }
        }
    }
}