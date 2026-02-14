using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.EstadosAsientosContables;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.Estados
{
    [Authorize]
    public class CrearModel : PageModel
    {
        private readonly IEstadosAsientosContablesService _estadoService;

        public CrearModel(IEstadosAsientosContablesService estadoService)
        {
            _estadoService = estadoService;
        }

        [BindProperty]
        public NuevoEstadoAsientoContableFormModel EstadoForm { get; set; } = new();

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
                return RedirectToPage("/Usuarios/Index");
            }

            // Mapeo del FormModel a la entidad
            var nuevoEstado = new EstadosAsientoContable
            {
                Codigo = EstadoForm.Codigo,
                Nombre = EstadoForm.Nombre,
                Descripcion = EstadoForm.Descripcion,
                Estado = EstadoForm.Estado
            };

            var resultado = await _estadoService.InsertAsync(nuevoEstado, int.Parse(idUsuario));

            TempData["Mensaje"] = resultado == 1
                ? "Estado de asiento creado exitosamente."
                : "Error al crear el estado de asiento.";

            return RedirectToPage("Index");
        }
    }
}
