using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Entities.Cuentas;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Service.Cuentas;
using System.Security.Claims;
using System.Text.Json;

namespace SistemaContableLaDat.Pages.Asientos
{
    public class EditarModel : PageModel
    {
        private readonly AsientoService _asientoService;
        private readonly CuentaService _cuentaService;

        public EditarModel(AsientoService asientoService, CuentaService cuentaService)
        {
            _asientoService = asientoService;
            _cuentaService = cuentaService;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Encabezado { get; set; } = new();

        [BindProperty]
        public string DetallesJson { get; set; } = string.Empty;

        public List<CuentaComboDto> Cuentas { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int id)
        {
            var asiento = await _asientoService.ObtenerParaEdicionAsync(id);
            if (asiento == null) return NotFound();

            if (asiento.IdEstadoAsiento > 2)
            {
                TempData["Error"] = "Solo se pueden editar asientos en estado Borrador o Pendiente.";
                return RedirectToPage("./Index");
            }

            Encabezado = asiento;
            var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
            DetallesJson = JsonSerializer.Serialize(asiento.Detalles, options);
            Cuentas = _cuentaService.ObtenerCuentasMovimiento().ToList();

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                if (string.IsNullOrWhiteSpace(DetallesJson))
                    throw new Exception("El detalle del asiento no puede estar vacío.");

                var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
                var detalles = JsonSerializer.Deserialize<List<AsientoDetalleEntity>>(DetallesJson, options);

                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);

                int idUsuario = userIdClaim != null ? int.Parse(userIdClaim.Value) : 0;

                if (idUsuario == 0)
                {
                    throw new Exception("No se pudo identificar al usuario. Por favor, inicie sesión nuevamente.");
                }

                await _asientoService.EditarAsync(Encabezado, detalles, idUsuario);

                TempData["Success"] = "Asiento actualizado correctamente.";
                return RedirectToPage("./Index");
            }
            catch (Exception ex)
            {
                Cuentas = _cuentaService.ObtenerCuentasMovimiento().ToList();
                ModelState.AddModelError(string.Empty, "Error al guardar: " + ex.Message);
                return Page();
            }
        }
    }
}