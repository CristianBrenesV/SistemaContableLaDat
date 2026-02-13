using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Roles;
using SistemaContableLaDat.Service.RolesPantallas;
using SistemaContableLaDat.Pages.Models;

namespace SistemaContableLaDat.Pages.Roles
{
    [Authorize]
    public class PantallasModel : PageModel
    {
        private readonly IRolPantallaService _rolpantallaService;
        private readonly IRolService _rolService;

        public PantallasModel(
            IRolPantallaService rolpantallaService,
            IRolService rolService)
        {
            _rolpantallaService = rolpantallaService;
            _rolService = rolService;
        }

        [BindProperty(SupportsGet = true)]
        public string IdRol { get; set; } = string.Empty;

        [BindProperty]
        public AsignarPantallasFormModel Form { get; set; } = new();

        public string NombreRol { get; set; } = string.Empty;
        public List<Pantalla> Pantallas { get; set; } = new List<Pantalla>();

        public async Task<IActionResult> OnGetAsync()
        {
            if (string.IsNullOrEmpty(IdRol))
                return RedirectToPage("Index");

            // Obtener info del rol
            var rolEntidad = await _rolService.GetByIdAsync(IdRol);
            if (rolEntidad == null)
                return RedirectToPage("Index");

            NombreRol = rolEntidad.NombreRol;

            // Listar pantallas y asignadas
            Pantallas = (await _rolpantallaService.GetPantallasDetalleByRolAsync(IdRol)).ToList();
            Form = new AsignarPantallasFormModel
            {
                IdRol = IdRol,
                PantallasSeleccionadas = Pantallas.Select(p => p.IdPantalla).ToList()
            };

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid || string.IsNullOrEmpty(Form.IdRol))
                return Page();

            var idUsuarioLogueado = ObtenerIdUsuarioLogueado();
            if (!idUsuarioLogueado.HasValue)
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario, consulte al departamento de TI.";
                return RedirectToPage("/Usuarios/Index");
            }

            // Actualizar pantallas asignadas
            var resultado = await _rolpantallaService.ActualizarPantallasAsync(
                Form.IdRol,
                Form.PantallasSeleccionadas ?? new List<int>(),
                idUsuarioLogueado.Value
            );

            TempData["Mensaje"] = resultado == 1
                ? "Pantallas actualizadas correctamente."
                : "No se realizaron cambios.";

            return RedirectToPage(new { idRol = Form.IdRol });
        }

        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            return int.TryParse(claim, out var IdUsuario) ? IdUsuario : (int?)null;
        }
    }
}
