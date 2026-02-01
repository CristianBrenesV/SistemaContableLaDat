using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Service.Asientos;
using System.Text.Json;

namespace SistemaContableLaDat.Web.Pages.Asientos
{
    public class EditarModel : PageModel
    {
        private readonly AsientoService _service;

        public EditarModel(AsientoService service)
        {
            _service = service;
        }

        [BindProperty]
        public AsientoEncabezadoEntity Encabezado { get; set; } = new();

        [BindProperty]
        public string DetallesJson { get; set; } = string.Empty;

        public List<AsientoDetalleEntity> Detalles { get; set; } = new();

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
            Detalles = asiento.Detalles;

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            var detalles = JsonSerializer.Deserialize<List<AsientoDetalleEntity>>(DetallesJson)
                           ?? new List<AsientoDetalleEntity>();

            int idUsuario = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)!.Value);

            await _service.EditarAsync(Encabezado, detalles, idUsuario);

            return RedirectToPage("Index");
        }
    }
}
