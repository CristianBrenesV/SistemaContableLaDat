using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Service.Asientos;

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
        public AsientoEncabezadoEntity Asiento { get; set; }

        public async Task<IActionResult> OnGetAsync(int id)
        {
            Asiento = await _asientoService.ObtenerParaEdicionAsync(id);

            if (Asiento == null) return NotFound();

            if (Asiento.IdEstadoAsiento == 5)
                return RedirectToPage("./Index");

            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int id)
        {
            try
            {
                int idUsuario = int.Parse(User.FindFirst("IdUsuario")?.Value ?? "1");

                await _asientoService.AnularAsync(id, idUsuario);

                TempData["Mensaje"] = $"Asiento {id} anulado con éxito.";
                return RedirectToPage("./Index");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                // Recargar datos si hay error
                Asiento = await _asientoService.ObtenerParaEdicionAsync(id);
                return Page();
            }
        }
    }
}