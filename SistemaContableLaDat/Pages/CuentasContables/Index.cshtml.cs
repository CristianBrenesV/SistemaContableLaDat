using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.CuentasContables;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.CuentasContables
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly ICuentasContablesService _cuentasService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(
            ICuentasContablesService cuentasService,
            IBitacoraService bitacoraService)
        {
            _cuentasService = cuentasService;
            _bitacoraService = bitacoraService;
        }

        public List<CuentaContable> Cuentas { get; set; } = new();

        public int PaginaActual { get; set; }
        public int TotalPaginas { get; set; }

        private const int TamanoPagina = 10;

        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (int.TryParse(claim, out var idUsuario))
                return idUsuario;

            return null;
        }

        public async Task<IActionResult> OnGetAsync(int pagina = 1)
        {
            var cuentasEntidad = await _cuentasService.GetPaginadoAsync(pagina, TamanoPagina);
            var total = await _cuentasService.CountAsync();

            PaginaActual = pagina;
            TotalPaginas = (int)Math.Ceiling(total / (double)TamanoPagina);

            Cuentas = cuentasEntidad.ToList();

            var idUsuario = ObtenerIdUsuarioLogueado();
            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta paginada de cuentas contables",
                    new { Pagina = pagina, RegistrosMostrados = Cuentas.Count }
                );
            }

            return Page();
        }

        public async Task<IActionResult> OnPostEliminarAsync(int idCuenta)
        {
            var idUsuario = ObtenerIdUsuarioLogueado();

            if (!idUsuario.HasValue)
            {
                TempData["Mensaje"] = "No se pudo obtener el usuario autenticado.";
                return RedirectToPage();
            }

            var resultado = await _cuentasService.DeleteAsync(idCuenta, idUsuario.Value);

            TempData["Mensaje"] = resultado == 1
                ? "Cuenta contable eliminada correctamente."
                : "No se pudo eliminar la cuenta contable.";

            return RedirectToPage();
        }
    }
}