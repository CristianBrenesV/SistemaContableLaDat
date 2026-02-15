using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Roles;

namespace SistemaContableLaDat.Pages.Pantallas
{
    public class IndexModel : PageModel
    {
        private readonly IPantallaService _pantallaService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(IPantallaService PantallaService, IBitacoraService bitacoraService)
        {
            _pantallaService = PantallaService;
            _bitacoraService = bitacoraService;
        }
        public List<ListarPantallasModel> Pantallas { get; set; } = new();

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
            var pantallasEntidad = await _pantallaService.GetPantallasPaginadosAsync(pagina, TamanoPagina);
            var total = await _pantallaService.CuentaPantallasAsync();

            Pantallas = pantallasEntidad.Select(p => new ListarPantallasModel
            {
                IdPantalla = p.IdPantalla,
                Nombre = p.Nombre,
                Descripcion = p.Descripcion,
                Ruta = p.Ruta,
                Estado = p.Estado,
            }).ToList();

            var idUsuario = ObtenerIdUsuarioLogueado();

            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta paginada de roles",
                    new { Pagina = pagina, RolesMostrados = Pantallas.Count }
                );
            }

            return Page();
        }
        public async Task<IActionResult> OnPostEliminarAsync(int idPantalla, int IdUsuario)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();
            if (!idUsuario.HasValue)
            {
                TempData["Mensaje"] = "No se pudo obtener el usuario autenticado.";
                return RedirectToPage();
            }

            int resultado = await _pantallaService.DeleteAsync(idPantalla, IdUsuario);

            TempData["Mensaje"] = resultado == 1
                ? "Pantalla eliminado correctamente."
                : "No se pudo eliminar la pantalla. Puede estar relacionado con otros registros.";

            return RedirectToPage();
        }
    }
}
