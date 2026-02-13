using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using System.Text;
using System.Text.RegularExpressions;

namespace SistemaContableLaDat.Pages.Usuarios
{
    [Authorize]
    public class EditarUsuarioModel : PageModel
    {
        private readonly IUsuarioService _usuarioService;
        private readonly IEncriptadoService _encriptadoService;
        private readonly IRolService _rolService;
        private readonly IUsuarioRolService _usuarioRolService;
        public EditarUsuarioModel(
            IUsuarioService usuarioService,
            IEncriptadoService encriptadoService,
            IRolService rolService,
            IUsuarioRolService usuarioRolService)
        {
            _usuarioService = usuarioService;
            _encriptadoService = encriptadoService;
            _rolService = rolService;
            _usuarioRolService = usuarioRolService;
        }

        [BindProperty]
        public EditarUsuarioFormModel Usuario { get; set; } = new();
        public List<SelectListItem> ListaRoles { get; set; } = new();

        public List<string> RolesSeleccionados { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int IdUsuario)
        {
            await CargarRolesAsync();

            var usuarioEntidad = await _usuarioService.GetByIdAsync(IdUsuario);
            if (usuarioEntidad == null)
                return RedirectToPage("Index");

            var rolesUsuario = await _usuarioRolService.GetRolesByUsuarioAsync(IdUsuario);

            Usuario = new EditarUsuarioFormModel
            {
                IdUsuario = usuarioEntidad.IdUsuario,
                Usuario = usuarioEntidad.Usuario,
                NombreUsuario = usuarioEntidad.NombreUsuario,
                ApellidoUsuario = usuarioEntidad.ApellidoUsuario,
                CorreoElectronico = usuarioEntidad.CorreoElectronico,
                Estado = usuarioEntidad.Estado.ToString(),
                RolesSeleccionados = rolesUsuario.Select(r => r.IdRol).ToList()
            };

            return Page();
        }


        public async Task<IActionResult> OnPostAsync()
        {
            await CargarRolesAsync();

            if (!ModelState.IsValid)
                return Page();

            // Validar contraseña solo si el usuario escribe una
            if (!string.IsNullOrEmpty(Usuario.Clave))
            {
                if (Usuario.Clave != Usuario.ConfirmarClave)
                {
                    ModelState.AddModelError("", "Las contraseñas no coinciden.");
                    return Page();
                }

                if (!Regex.IsMatch(Usuario.Clave, @"^[A-Za-z]") ||
                    !Regex.IsMatch(Usuario.Clave, @"[0-9]") ||
                    !Regex.IsMatch(Usuario.Clave, @"[+\-\*\$\.]"))
                {
                    ModelState.AddModelError("", "La contraseña debe iniciar con letra, contener números y símbolos (+-*$.).");
                    return Page();
                }
            }

            var usuarioActualizar = new UsuarioEntity
            {
                IdUsuario = Usuario.IdUsuario,
                Usuario = Usuario.Usuario,
                NombreUsuario = Usuario.NombreUsuario,
                ApellidoUsuario = Usuario.ApellidoUsuario,
                CorreoElectronico = Usuario.CorreoElectronico,
                Estado = Enum.Parse<EstadoUsuario>(Usuario.Estado)
            };

            // Si cambió contraseña, encriptarla
            if (!string.IsNullOrEmpty(Usuario.Clave))
            {
                var (cifrada, tag, nonce) = _encriptadoService.Encriptar(Encoding.UTF8.GetBytes(Usuario.Clave));
                usuarioActualizar.ClaveCifrada = cifrada;
                usuarioActualizar.TagAutenticacion = tag;
                usuarioActualizar.Nonce = nonce;
            }

            var idUsuarioLogueado = ObtenerIdUsuarioLogueado();
            if (!idUsuarioLogueado.HasValue)
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario consulte al departamento de TI.";
                return RedirectToPage("/Usuarios/Index");
            }

            var roles = Usuario.RolesSeleccionados ?? new List<string>();

            var actualizado = await _usuarioService.UpdateAsync(
                usuarioActualizar,
                roles,
                idUsuarioLogueado.Value
            );

            TempData["Mensaje"] = actualizado == 1
                ? "Usuario actualizado correctamente."
                : "Error al actualizar el usuario.";

            return RedirectToPage("Index");
        }

        private async Task CargarRolesAsync()
        {
            ListaRoles = (await _rolService.GetAllAsync())
                .Select(r => new SelectListItem
                {
                    Value = r.IdRol,   // <-- NO .ToString()
                    Text = r.NombreRol
                })
                .ToList();

        }

        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(claim, out var IdUsuario) ? IdUsuario : (int?)null;
        }
    }
}
