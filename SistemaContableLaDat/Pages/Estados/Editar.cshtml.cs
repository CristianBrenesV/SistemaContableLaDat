using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.EstadosAsientosContables;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.Estados
{
    [Authorize]
    public class EditarModel : PageModel
    {
        private readonly IEstadosAsientosContablesService _estadoService;

        public EditarModel(IEstadosAsientosContablesService estadoService)
        {
            _estadoService = estadoService;
        }

        [BindProperty]
        public EditarEstadoAsientoContableFormModel EstadoForm { get; set; } = new();

        public List<SelectListItem> ListaEstados { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int IdEstado)
        {
            var estadoEntidad = await _estadoService.GetByIdAsync(IdEstado);
            if (estadoEntidad == null)
                return RedirectToPage("Index");

            EstadoForm = new EditarEstadoAsientoContableFormModel
            {
                IdEstadoAsiento = estadoEntidad.IdEstadoAsiento,
                Codigo = estadoEntidad.Codigo,
                Nombre = estadoEntidad.Nombre,
                Descripcion = estadoEntidad.Descripcion,
                Estado = estadoEntidad.Estado
            };

            await CargarListaEstadosAsync(); 
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                await CargarListaEstadosAsync();
                return Page();
            }

            var idUsuario = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(idUsuario))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario.";
                return RedirectToPage("/Usuarios/Index");
            }

            var estadoActualizar = new EstadosAsientoContable
            {
                IdEstadoAsiento = EstadoForm.IdEstadoAsiento,
                Codigo = EstadoForm.Codigo,
                Nombre = EstadoForm.Nombre,
                Descripcion = EstadoForm.Descripcion,
                Estado = EstadoForm.Estado
            };

            var resultado = await _estadoService.UpdateAsync(estadoActualizar, int.Parse(idUsuario));

            TempData["Mensaje"] = resultado == 1
                ? "Estado de asiento actualizado exitosamente."
                : "Error al actualizar el estado de asiento.";

            return RedirectToPage("Index");
        }

        private Task CargarListaEstadosAsync()
        {
            ListaEstados = new List<SelectListItem>
            {
                new SelectListItem { Value = "Activo", Text = "Activo" },
                new SelectListItem { Value = "Inactivo", Text = "Inactivo" }
            };
            return Task.CompletedTask;
        }
    }
}
