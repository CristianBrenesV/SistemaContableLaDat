using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Cierres;
using SistemaContableLaDat.Service.Abstract;
using System.Security.Claims;
using System.Text.Json;

namespace SistemaContableLaDat.Web.Pages.Cierres
{
    public class IndexModel : PageModel
    {
        private readonly ICierreService _cierreService;

        public List<PeriodoContableEntity> Periodos { get; set; } = new();
        public List<CierreContableEntity> CierresEjecutados { get; set; } = new();
        public CierreContableEntity UltimoCierre { get; set; } = new();

        [TempData]
        public string SuccessMessage { get; set; } = string.Empty;

        [TempData]
        public string ErrorMessage { get; set; } = string.Empty;

        public IndexModel(ICierreService cierreService)
        {
            _cierreService = cierreService;
        }

        public async Task OnGetAsync()
        {
            try
            {
                Periodos = (await _cierreService.ListarPeriodosAsync()).ToList();
                UltimoCierre = await _cierreService.ObtenerUltimoCierreAsync();
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error al cargar periodos: {ex.Message}";
            }
        }

        public async Task<IActionResult> OnPostCalcularAsync(int idPeriodo)
        {
            try
            {
                var resultado = await _cierreService.CalcularCierreAsync(idPeriodo);

                // Guardar en sesión en lugar de TempData
                HttpContext.Session.SetString("ResultadoCierre",
                    JsonSerializer.Serialize(resultado));

                return RedirectToPage("Ejecutar", new { idPeriodo });
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error al calcular cierre: {ex.Message}";
                return RedirectToPage();
            }
        }
    }
}