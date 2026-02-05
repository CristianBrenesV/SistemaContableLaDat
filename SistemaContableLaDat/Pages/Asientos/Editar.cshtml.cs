using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Service.Asientos;

namespace SistemaContableLaDat.Pages.Asientos
{
    public class EditarModel : PageModel
    {
        private readonly AsientoService _asientoService;

        public EditarModel(AsientoService asientoService)
        {
            _asientoService = asientoService;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Encabezado { get; set; } = new();

        [BindProperty]
        public List<AsientoDetalleEntity> Detalles { get; set; } = new();
        public List<SistemaContableLaDat.Entities.Cuentas.CuentaComboDto> CuentasDisponibles { get; set; } = new();


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
            Detalles = asiento.Detalles ?? new List<AsientoDetalleEntity>();

            var cuentas = await _asientoService.ObtenerCuentasParaComboAsync();
            CuentasLista = new SelectList(cuentas, "IdCuenta", "NombreCuenta");

            return Page();
        }

        public SelectList CuentasLista { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid) return Page();

            try
            {
                int idUsuarioSimulado = 1;

                await _asientoService.EditarAsync(Encabezado, Detalles, idUsuarioSimulado);

                TempData["Success"] = "Asiento actualizado correctamente.";
                return RedirectToPage("./Index");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "Error al guardar: " + ex.Message);
                return Page();
            }
        }
    }
}