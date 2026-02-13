using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using System.Text;
using System.Text.RegularExpressions;

namespace SistemaContableLaDat.Pages.Pantallas
{
    [Authorize]
    public class EditarModel : PageModel
    {
        private readonly IPantallaService _pantallaService;
        public EditarModel(IPantallaService pantallaService)
        {
            _pantallaService = pantallaService;
        }
        [BindProperty]
        public EditarPantallaFormModel Pantalla { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int IdPantalla)
        {

            var pantallaEntidad = await _pantallaService.GetByIdAsync(IdPantalla);
            if (pantallaEntidad == null)
                return RedirectToPage("Index");

            Pantalla = new EditarPantallaFormModel
            {
                IdPantalla = pantallaEntidad.IdPantalla,
                Nombre = pantallaEntidad.Nombre,
                Descripcion = pantallaEntidad.Descripcion,
                Estado = Enum.Parse<EstadoPantalla>(pantallaEntidad.Estado)
            };

            return Page();
        }
        public async Task<IActionResult> OnPostAsync()
        {

            if (!ModelState.IsValid)
                return Page();


            var pantallaActualizar = new Pantalla
            {
                IdPantalla = Pantalla.IdPantalla,
                Nombre = Pantalla.Nombre,
                Descripcion = Pantalla.Descripcion,
                Estado = Pantalla.Estado.ToString(),
            };


            var idUsuarioLogueado = ObtenerIdUsuarioLogueado();
            if (!idUsuarioLogueado.HasValue)
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario consulte al departamento de TI.";
                return RedirectToPage("/Usuarios/Index");
            }


            var actualizado = await _pantallaService.UpdateAsync(
                pantallaActualizar,
                idUsuarioLogueado.Value
            );

            TempData["Mensaje"] = actualizado == 1
                ? "Pantalla actualizada correctamente."
                : "Error al actualizar la pantalla.";

            return RedirectToPage("Index");
        }
        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(claim, out var IdUsuario) ? IdUsuario : (int?)null;
        }
    }
}
