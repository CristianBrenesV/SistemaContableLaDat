using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Encriptado;
using System.Text;
using System.Text.RegularExpressions;

namespace SistemaContableLaDat.Pages.Pantallas
{
    [Authorize]
    public class CrearModel : PageModel
    {
        private readonly IPantallaService _pantallaService;

        public CrearModel(IPantallaService pantallaService)
        {
            _pantallaService = pantallaService;
        }

        [BindProperty]
        public NuevaPantallaFormModel Pantalla { get; set; } = new();

        public void OnGet()
        {
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
                return Page();

            var idUsuarioLogueado = ObtenerIdUsuarioLogueado();
            if (!idUsuarioLogueado.HasValue)
                return RedirectToPage("/Usuarios/Index");

            var existe = await _pantallaService.GetByIdAsync(Pantalla.IdPantalla);
            if (existe != null)
            {
                ModelState.AddModelError("Pantalla.IdPantalla", "Ya existe una pantalla con ese ID.");
                return Page();
            }

            var nuevoPantalla= new Pantalla
            {
                IdPantalla = Pantalla.IdPantalla,
                Nombre = Pantalla.Nombre.Trim(),
                Descripcion = Pantalla.Descripcion.Trim(),
                Estado = Pantalla.Estado.ToString()
            };

            var resultado = await _pantallaService.InsertAsync(
                nuevoPantalla,
                idUsuarioLogueado.Value
            );

            TempData["Mensaje"] = resultado == 1
                ? "Pantalla creada correctamente."
                : "Error al crear la pantalla.";

            return RedirectToPage("Index");
        }
        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(claim, out var IdUsuario) ? IdUsuario : (int?)null;
        }
    }
}
