using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using System.Text;
using System.Text.RegularExpressions;

namespace SistemaContableLaDat.Pages.Roles
{
    [Authorize]
    public class EditarRolModel : PageModel
    {
        private readonly IRolService _rolService;
        public EditarRolModel(IRolService rolService)
        {
            _rolService = rolService;
        }
        [BindProperty]
        public EditarRolFormModel Rol { get; set; } = new();
        public List<SelectListItem> ListaRoles { get; set; } = new();

        public List<string> RolesSeleccionados { get; set; } = new();
        public async Task<IActionResult> OnGetAsync(string IdRol)
        {

            var rolEntidad = await _rolService.GetByIdAsync(IdRol);
            if (rolEntidad == null)
                return RedirectToPage("Index");

            Rol = new EditarRolFormModel
            {
                IdRol = rolEntidad.IdRol,
                NombreRol= rolEntidad.NombreRol,
                Descripcion = rolEntidad.Descripcion,
                Estado = rolEntidad.Estado.ToString(),
            };

            return Page();
        }
        public async Task<IActionResult> OnPostAsync()
        {

            if (!ModelState.IsValid)
                return Page();


            var rolActualizar = new Rol
            {
                IdRol = Rol.IdRol,
                NombreRol = Rol.NombreRol,
                Descripcion = Rol.Descripcion,
                Estado = Rol.Estado.ToString(),
            };


            var idUsuarioLogueado = ObtenerIdUsuarioLogueado();
            if (!idUsuarioLogueado.HasValue)
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario consulte al departamento de TI.";
                return RedirectToPage("/Usuarios/Index");
            }


            var actualizado = await _rolService.UpdateAsync(
                rolActualizar,
                idUsuarioLogueado.Value
            );

            TempData["Mensaje"] = actualizado == 1
                ? "Usuario actualizado correctamente."
                : "Error al actualizar el usuario.";

            return RedirectToPage("Index");
        }
        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(claim, out var IdUsuario) ? IdUsuario : (int?)null;
        }
    }
}
