using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Encriptado;
using System.Text;
using System.Text.RegularExpressions;

namespace SistemaContableLaDat.Pages.Roles
{
    [Authorize]
    public class CrearRolModel : PageModel
    {
        private readonly IRolService _rolService;

        public CrearRolModel(IRolService rolService)
        {
            _rolService = rolService;
        }

        [BindProperty]
        public NuevoRolFormModel Rol { get; set; } = new();

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

             var existe = await _rolService.GetByIdAsync(Rol.IdRol);
            if (existe != null)
            {
                ModelState.AddModelError("Rol.IdRol", "Ya existe un rol con ese ID.");
                return Page();
            }

            var nuevoRol = new Rol
            {
                IdRol = Rol.IdRol.Trim(),
                NombreRol = Rol.NombreRol.Trim(),
                Descripcion = Rol.Descripcion.Trim(),
                Estado = Rol.Estado.ToString()
            };

            var resultado = await _rolService.InsertAsync(
                nuevoRol,
                idUsuarioLogueado.Value
            );

            TempData["Mensaje"] = resultado == 1
                ? "Rol creado correctamente."
                : "Error al crear el rol.";

            return RedirectToPage("Index");
        }
        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(claim, out var IdUsuario) ? IdUsuario : (int?)null;
        }
    }
}
