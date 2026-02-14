using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.PeriodosContables;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Pages.Periodos
{
    [Authorize]
    public class CrearModel : PageModel
    {
        private readonly IPeriodosContablesService _periodoService;

        public CrearModel(IPeriodosContablesService periodoService)
        {
            _periodoService = periodoService;
        }

        [BindProperty]
        public NuevoPeriodoContableFormModel PeriodoForm { get; set; } = new();

        public void OnGet()
        {
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
                return Page();

            var idUsuario = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(idUsuario))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario.";
                return RedirectToPage("/Periodos/Index");
            }

            var nuevoPeriodo = new PeriodoContable
            {
                Anio = PeriodoForm.Anio,
                Mes = PeriodoForm.Mes,
                Estado = PeriodoForm.Estado
            };

            var resultado = await _periodoService.InsertAsync(nuevoPeriodo, int.Parse(idUsuario));

            TempData["Mensaje"] = resultado == 1
                ? "Periodo contable creado exitosamente."
                : "Error al crear el periodo contable.";

            return RedirectToPage("Index");
        }
    }
}
