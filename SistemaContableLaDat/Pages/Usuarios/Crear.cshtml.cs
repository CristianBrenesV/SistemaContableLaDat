using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Service.Abstract;
using System.Text;
using System.Text.RegularExpressions;

namespace SistemaContableLaDat.Pages.Usuarios
{
    [Authorize]
    public class AgregarUsuarioModel : PageModel
    {
        private readonly IUsuarioService _usuarioService;
        private readonly IEncriptadoService _encriptadoService;
        private readonly IRolService _rolService;

        public AgregarUsuarioModel(
            IUsuarioService usuarioService,
            IEncriptadoService encriptadoService,
            IRolService rolService)
        {
            _usuarioService = usuarioService;
            _encriptadoService = encriptadoService;
            _rolService = rolService;
        }

        [BindProperty]
        public NuevoUsuarioFormModel UsuarioForm { get; set; } = new();

        public List<SelectListItem> ListaRoles { get; set; } = new();
        public List<string> RolesSeleccionados { get; set; } = new();

        public async Task OnGetAsync()
        {
            await CargarRolesAsync();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            await CargarRolesAsync();

            if (!ModelState.IsValid)
                return Page();

            if (!Regex.IsMatch(UsuarioForm.Clave, @"^[A-Za-z]"))
            {
                ModelState.AddModelError("", "La contrasena debe iniciar con una letra.");
                return Page();
            }

            if (!Regex.IsMatch(UsuarioForm.Clave, @"[0-9]") ||
                !Regex.IsMatch(UsuarioForm.Clave, @"[+\-\*\$\.]"))
            {
                ModelState.AddModelError("", "La contrasena debe contener letras, numeros y simbolos (+-*$.).");
                return Page();
            }

            var (cifrada, tag, nonce) =
                _encriptadoService.Encriptar(Encoding.UTF8.GetBytes(UsuarioForm.Clave));

            var nuevoUsuario = new UsuarioEntity
            {
                Usuario = UsuarioForm.Usuario,
                NombreUsuario = UsuarioForm.NombreUsuario,
                ApellidoUsuario = UsuarioForm.ApellidoUsuario,
                CorreoElectronico = UsuarioForm.CorreoElectronico,
                ClaveCifrada = cifrada,
                TagAutenticacion = tag,
                Nonce = nonce,
                Estado = UsuarioForm.Estado
            };

            var idUsuario = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(idUsuario))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario.";
                return RedirectToPage("/Usuarios/Index");
            }

            // Si no seleccionó roles, enviamos lista vacía
            var roles = UsuarioForm.RolesSeleccionados ?? new List<string>();

            var resultado = await _usuarioService.InsertAsync(
                nuevoUsuario,
                roles,
                int.Parse(idUsuario)
            );

            TempData["Mensaje"] = resultado == 1
                ? "Usuario agregado exitosamente."
                : "Error al agregar usuario.";

            return RedirectToPage("/Usuarios/Index");
        }

        private async Task CargarRolesAsync()
        {
            ListaRoles = (await _rolService.GetAllAsync())
                .Select(r => new SelectListItem
                {
                    Value = r.IdRol.ToString(),
                    Text = r.NombreRol
                })
                .ToList();
        }
    }
}
