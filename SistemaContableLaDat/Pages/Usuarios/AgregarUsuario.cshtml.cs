using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Models; 
using SistemaContableLaDat.Service.Abstract;
using System.Text;
using Microsoft.AspNetCore.Authorization;

namespace SistemaContableLaDat.Pages.Usuarios
{
    [Authorize]
    public class AgregarUsuarioModel : PageModel
    {
        private readonly IUsuarioService _usuarioService;
        private readonly IEncriptadoService _encriptadoService;

        public AgregarUsuarioModel(IUsuarioService usuarioService, IEncriptadoService encriptadoService)
        {
            _usuarioService = usuarioService;
            _encriptadoService = encriptadoService;
        }

        [BindProperty]
        public NuevoUsuarioFormModel UsuarioForm { get; set; } // Para usar el modelo de formulario

        public string Mensaje { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid) return Page(); // Verifica si el formulario cumple con las validaciones ([Required], [EmailAddress], etc.). Si hay errores, recarga la misma página para mostrar mensajes.

            var (cifrada, tag, nonce) = _encriptadoService.Encriptar(Encoding.UTF8.GetBytes(UsuarioForm.Clave));

            var nuevoUsuario = new UsuarioEntity
            {
                Usuario = UsuarioForm.Usuario,
                NombreUsuario = UsuarioForm.NombreUsuario,
                ApellidoUsuario = UsuarioForm.ApellidoUsuario,
                CorreoElectronico = UsuarioForm.CorreoElectronico,
                ClaveCifrada = cifrada,
                TagAutenticacion = tag,
                Nonce = nonce,
                Estado = UsuarioForm.Estado  // <-- aquí ya es EstadoUsuario
            };

            // Obtener el ID del usuario autenticado
            var idUsuarioEjecutor = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(idUsuarioEjecutor))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario";
                return RedirectToPage("/Usuarios/ListarUsuarios");
            }

            var resultado = await _usuarioService.InsertAsync(nuevoUsuario, idUsuarioEjecutor);

            if (resultado == 1)
            {
                TempData["Mensaje"] = "Usuario agregado exitosamente.";
                return RedirectToPage("/Usuarios/ListarUsuarios");
            }
            else
            {
                TempData["Mensaje"] = "Error al agregar usuario.";
                return RedirectToPage("/Usuarios/ListarUsuarios");
            }
        }
    }
}