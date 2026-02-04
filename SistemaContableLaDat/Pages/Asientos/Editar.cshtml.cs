using Microsoft.AspNetCore.Authorization;
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
    [Authorize]
    public class EditarModel : PageModel
    {
        private readonly AsientoService _service;
        private readonly CuentaService _cuentaService;

        public EditarModel(
            AsientoService service,
            CuentaService cuentaService)
        {
            _service = service;
            _cuentaService = cuentaService;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Encabezado { get; set; } = new();

        [BindProperty]
        public string DetallesJson { get; set; } = string.Empty;

        public List<AsientoDetalleEntity> Detalles { get; set; } = new();
        public List<CuentaComboDto> Cuentas { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int id)
        {
            var asiento = await _service.ObtenerParaEdicionAsync(id);

            if (asiento == null)
                return RedirectToPage("Index");

            if (asiento.IdEstadoAsiento != (int)EstadoAsiento.Borrador &&
                asiento.IdEstadoAsiento != (int)EstadoAsiento.PendienteAprobar)
            {
                TempData["Mensaje"] = "No se puede editar este asiento.";
                return RedirectToPage("Index");
            }

            Encabezado = asiento;
            Detalles = asiento.Detalles ?? new List<AsientoDetalleEntity>();

            Cuentas = _cuentaService.ObtenerCuentasMovimiento().ToList();

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            var detalles = JsonSerializer.Deserialize<List<AsientoDetalleEntity>>(DetallesJson) ?? [];

            if (!detalles.Any())
                throw new Exception("El asiento debe tener al menos una línea.");

            if (detalles.Any(d => d.IdCuentaContable == 0))
                throw new Exception("Existen líneas sin cuenta contable.");

            if (detalles.Any(d => d.Monto <= 0))
                throw new Exception("Existen montos inválidos.");

            int idUsuario = int.Parse(
                User.FindFirst(ClaimTypes.NameIdentifier)!.Value
            );

            await _service.EditarAsync(Encabezado, detalles, idUsuario);

            TempData["Mensaje"] = "Asiento actualizado correctamente.";
            return RedirectToPage("Index");
        }

    }
}
