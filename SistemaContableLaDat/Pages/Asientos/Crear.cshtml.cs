using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Entities.Cuentas;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Service.Cuentas;
using SistemaContableLaDat.Service.Periodos; 
using System.Security.Claims;
using System.Text.Json;

namespace SistemaContableLaDat.Web.Pages.Asientos
{
    public class CrearModel : PageModel
    {
        private readonly AsientoService _asientoService;
        private readonly CuentaService _cuentaService;
        private readonly PeriodoService _periodoService; 

        public CrearModel(AsientoService asientoService, CuentaService cuentaService, PeriodoService periodoService)
        {
            _asientoService = asientoService;
            _cuentaService = cuentaService;
            _periodoService = periodoService;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Encabezado { get; set; } = new();

        [BindProperty]
        public string DetallesJson { get; set; } = string.Empty;

        public List<CuentaComboDto> Cuentas { get; set; } = new();

        public async Task OnGetAsync()
        {
            Encabezado.Fecha = DateTime.Today;

            int siguiente = await _asientoService.ObtenerSiguienteConsecutivoAsync();

            Encabezado.Consecutivo = siguiente;

            Encabezado.Codigo = $"AS-{siguiente:D4}";

            CargarDatos();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                if (string.IsNullOrWhiteSpace(DetallesJson))
                    throw new Exception("Debe ingresar al menos una línea de detalle.");

                var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
                var detalles = JsonSerializer.Deserialize<List<AsientoDetalleEntity>>(DetallesJson, options);

                if (detalles == null || !detalles.Any())
                    throw new Exception("El detalle del asiento no puede estar vacío.");

                int idPeriodo = await _periodoService.ObtenerIdPeriodoPorFechaAsync(Encabezado.Fecha);

                if (idPeriodo == 0)
                {
                    throw new Exception($"No se encontró un periodo contable ABIERTO para la fecha " +
                                        $"{Encabezado.Fecha:MM/yyyy}. Verifique que el periodo esté creado y abierto.");
                }

                Encabezado.IdPeriodo = idPeriodo;

                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
                int idUsuario = userIdClaim != null ? int.Parse(userIdClaim.Value) : 0;

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