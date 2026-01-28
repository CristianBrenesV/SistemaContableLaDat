using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.Usuarios
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly IUsuarioService _usuarioService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(IUsuarioService usuarioService, IBitacoraService bitacoraService)
        {
            _usuarioService = usuarioService;
            _bitacoraService = bitacoraService;
        }

        public List<ListarUsuariosModel> Usuarios { get; set; } = new();
        public int PaginaActual { get; set; }
        public int TotalPaginas { get; set; }

        private const int TamanoPagina = 10;

        public async Task<IActionResult> OnGetAsync(int pagina = 1)
        {
            var usuariosEntidad = await _usuarioService.GetUsuariosPaginadosAsync(pagina, TamanoPagina);
            var total = await _usuarioService.CuentaUsuariosAsync();

            TotalPaginas = (int)Math.Ceiling(total / (double)TamanoPagina);
            PaginaActual = pagina;

            Usuarios = usuariosEntidad.Select(u => new ListarUsuariosModel
            {
                IdUsuario = u.IdUsuario,
                Usuario = u.Usuario,
                NombreUsuario = u.NombreUsuario,
                ApellidoUsuario = u.ApellidoUsuario,
                CorreoElectronico = u.CorreoElectronico,
                Estado = u.Estado.ToString()
            }).ToList();

            // Registrar bitácora
            var idUsuarioEjecutor = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (!string.IsNullOrEmpty(idUsuarioEjecutor))
            {
                await _bitacoraService.RegistrarAccionAsync(
                    idUsuarioEjecutor,
                    "Consulta paginada de usuarios",
                    new { Pagina = pagina, UsuariosMostrados = Usuarios.Count }
                );
            }

            return Page();
        }

        public async Task<IActionResult> OnPostEliminarAsync(string id_usuario)
        {
            var idUsuarioEjecutor = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(idUsuarioEjecutor))
            {
                TempData["Mensaje"] = "No se pudo obtener el usuario autenticado.";
                return RedirectToPage();
            }

            int resultado = await _usuarioService.DeleteAsync(id_usuario, idUsuarioEjecutor);

            TempData["Mensaje"] = resultado == 1
                ? "Usuario eliminado correctamente."
                : "No se pudo eliminar el usuario. Puede estar relacionado con otros registros.";

            return RedirectToPage();
        }

        public async Task<IActionResult> OnPostCambiarEstadoAsync(string id_usuario, string nuevo_estado)
        {
            if (string.IsNullOrWhiteSpace(id_usuario) || string.IsNullOrWhiteSpace(nuevo_estado))
            {
                TempData["Mensaje"] = "Datos incompletos para cambiar el estado.";
                return RedirectToPage();
            }

            var usuario = await _usuarioService.GetByIdAsync(id_usuario);
            if (usuario == null)
            {
                TempData["Mensaje"] = "Usuario no encontrado.";
                return RedirectToPage();
            }

            if (!Enum.TryParse<EstadoUsuario>(nuevo_estado, out var estadoConvertido))
            {
                TempData["Mensaje"] = "Estado no válido.";
                return RedirectToPage();
            }

            var estadoAnterior = usuario.Estado;
            usuario.Estado = estadoConvertido;

            var idUsuarioEjecutor = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(idUsuarioEjecutor))
            {
                TempData["Mensaje"] = "No se pudo obtener el ID del usuario autenticado.";
                return RedirectToPage();
            }

            var actualizado = await _usuarioService.UpdateAsync(usuario, idUsuarioEjecutor);

            if (actualizado == 1)
            {
                await _bitacoraService.RegistrarAccionAsync(
                    idUsuarioEjecutor,
                    $"Cambio de estado de usuario",
                    new
                    {
                        Id_Usuario = usuario.IdUsuario,
                        Nombre_Usuario = usuario.NombreUsuario,
                        Apellido_Usuario = usuario.ApellidoUsuario,
                        Estado_Anterior = estadoAnterior.ToString(),
                        Estado_Nuevo = nuevo_estado
                    }
                );
                TempData["Mensaje"] = $"Estado cambiado a {nuevo_estado}.";
            }
            else
            {
                TempData["Mensaje"] = "Error al cambiar el estado.";
            }

            return RedirectToPage();
        }
    }
}
