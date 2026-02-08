using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Entities.Cuentas;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Service.Cuentas;
using System.Security.Claims;
using System.Text.Json;

namespace SistemaContableLaDat.Web.Pages.Asientos
{
    public class CrearModel : PageModel
    {
        private readonly AsientoService _asientoService;
        private readonly CuentaService _cuentaService;

        public CrearModel(AsientoService asientoService, CuentaService cuentaService)
        {
            _asientoService = asientoService;
            _cuentaService = cuentaService;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Encabezado { get; set; } = new();

        [BindProperty]
        public string DetallesJson { get; set; } = string.Empty;

        public List<CuentaComboDto> Cuentas { get; set; } = new();

        public void OnGet()
        {
            Encabezado.Fecha = DateTime.Today;
            CargarDatos();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                if (string.IsNullOrWhiteSpace(DetallesJson))
                {
                    ModelState.AddModelError("", "Debe ingresar al menos una línea de detalle.");
                    CargarDatos();
                    return Page();
                }

                var detalles = JsonSerializer.Deserialize<List<AsientoDetalleEntity>>(DetallesJson);

                if (detalles == null || !detalles.Any())
                {
                    ModelState.AddModelError("", "El detalle del asiento no puede estar vacío.");
                    CargarDatos();
                    return Page();
                }

                // Obtener ID de usuario desde los Claims
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
                int idUsuario = userIdClaim != null ? int.Parse(userIdClaim.Value) : 0;

                // Llamada al servicio con el nombre corregido
                await _asientoService.CrearAsync(Encabezado, detalles, idUsuario);

                return RedirectToPage("Index");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                CargarDatos();
                return Page();
            }
        }

        private void CargarDatos()
        {
            Cuentas = _cuentaService.ObtenerCuentasMovimiento().ToList();
        }
    }
}