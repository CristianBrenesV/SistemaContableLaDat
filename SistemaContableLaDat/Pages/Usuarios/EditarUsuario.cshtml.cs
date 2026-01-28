using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using Microsoft.AspNetCore.Authorization;

namespace SistemaContableLaDat.Pages.Usuarios
{
    [Authorize]
    public class EditarUsuarioModel : PageModel
    {
        private readonly IUsuarioService _usuarioService;

        public EditarUsuarioModel(IUsuarioService usuarioService)
        {
            _usuarioService = usuarioService;
        }

        [BindProperty]
        public ListarUsuariosModel Usuario { get; set; }

        public async Task<IActionResult> OnGetAsync(string id)
        {
            var usuarioEntidad = await _usuarioService.GetByIdAsync(id);
            if (usuarioEntidad == null)
            {
                return RedirectToPage("ListarUsuarios");
            }

            Usuario = new ListarUsuariosModel
            {
                IdUsuario = usuarioEntidad.IdUsuario,
                Usuario = usuarioEntidad.Usuario,
                NombreUsuario = usuarioEntidad.NombreUsuario,
                ApellidoUsuario = usuarioEntidad.ApellidoUsuario,
                CorreoElectronico = usuarioEntidad.CorreoElectronico,
                Estado = usuarioEntidad.Estado.ToString()
            };

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
                return Page();

            var usuarioActualizar = new UsuarioEntity
            {
                IdUsuario = Usuario.IdUsuario,
                Usuario = Usuario.Usuario,
                NombreUsuario = Usuario.NombreUsuario,
                ApellidoUsuario = Usuario.ApellidoUsuario,
                CorreoElectronico = Usuario.CorreoElectronico,
                Estado = Enum.Parse<EstadoUsuario>(Usuario.Estado)
            };

            // Obtener ID del usuario autenticado para registrar la acción en la bitácora
            var idUsuarioEjecutor = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(idUsuarioEjecutor))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario, consulte al departamento de TI.";
                return RedirectToPage("/Usuarios/ListarUsuarios");
            }

            var actualizado = await _usuarioService.UpdateAsync(usuarioActualizar, idUsuarioEjecutor);

            if (actualizado == 1)
                TempData["Mensaje"] = "Usuario actualizado correctamente.";
            else
                TempData["Mensaje"] = "Error al actualizar el usuario.";

            return RedirectToPage("ListarUsuarios");
        }

    }
}
