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

        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (int.TryParse(claim, out var IdUsuario))
                return IdUsuario;

            return null;
        }

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
                Estado = u.Estado.ToString(),
                Roles = u.Roles
            }).ToList();

            var idUsuario = ObtenerIdUsuarioLogueado();

            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta paginada de usuarios",
                    new { Pagina = pagina, UsuariosMostrados = Usuarios.Count }
                );
            }

            return Page();
        }

        public async Task<IActionResult> OnPostEliminarAsync(int IdUsuario)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();
            if (!idUsuario.HasValue)
            {
                TempData["Mensaje"] = "No se pudo obtener el usuario autenticado.";
                return RedirectToPage();
            }

            int resultado = await _usuarioService.DeleteAsync(IdUsuario);

            TempData["Mensaje"] = resultado == 1
                ? "Usuario eliminado correctamente."
                : "No se pudo eliminar el usuario. Puede estar relacionado con otros registros.";

            return RedirectToPage();
        }

        public async Task<IActionResult> OnPostCambiarEstadoAsync(int IdUsuario, string NuevoEstado)
        {
            if (string.IsNullOrWhiteSpace(NuevoEstado))
            {
                TempData["Mensaje"] = "Datos incompletos para cambiar el estado.";
                return RedirectToPage();
            }

            var usuario = await _usuarioService.GetByIdAsync(IdUsuario);
            if (usuario == null)
            {
                TempData["Mensaje"] = "Usuario no encontrado.";
                return RedirectToPage();
            }

            if (!Enum.TryParse<EstadoUsuario>(NuevoEstado, out var estadoConvertido))
            {
                TempData["Mensaje"] = "Estado no válido.";
                return RedirectToPage();
            }

            var idUsuario = ObtenerIdUsuarioLogueado();
            if (!idUsuario.HasValue)
            {
                TempData["Mensaje"] = "No se pudo obtener el ID del usuario autenticado.";
                return RedirectToPage();
            }

            var actualizado = await _usuarioService.CambiarEstadoAsync(IdUsuario, NuevoEstado);

            TempData["Mensaje"] = actualizado == 1
                ? $"Estado cambiado a {NuevoEstado}."
                : "Error al cambiar el estado.";

            return RedirectToPage();
        }
    }
}
