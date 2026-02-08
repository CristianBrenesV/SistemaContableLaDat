using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Cierres;
using SistemaContableLaDat.Service.Abstract;
using System.Security.Claims;
using System.Text.Json;

namespace SistemaContableLaDat.Web.Pages.Cierres
{
    public class EjecutarModel : PageModel
    {
        private readonly ICierreService _cierreService;

        [BindProperty(SupportsGet = true)]
        public int IdPeriodo { get; set; }

        public ResultadoCierreDto Resultado { get; set; } = new();
        public IEnumerable<SaldoCuentaDto> SaldosDetallados { get; set; } = new List<SaldoCuentaDto>();

        [TempData]
        public string SuccessMessage { get; set; } = string.Empty;

        [TempData]
        public string ErrorMessage { get; set; } = string.Empty;

        public EjecutarModel(ICierreService cierreService)
        {
            _cierreService = cierreService;
        }

        public async Task<IActionResult> OnGetAsync()
        {
            try
            {
                // Obtener resultado de la sesión si existe
                var resultadoJson = HttpContext.Session.GetString("ResultadoCierre");
                if (!string.IsNullOrEmpty(resultadoJson))
                {
                    Resultado = JsonSerializer.Deserialize<ResultadoCierreDto>(resultadoJson)!;
                    // Limpiar la sesión después de usarla
                    HttpContext.Session.Remove("ResultadoCierre");
                }
                else
                {
                    // Calcular si no hay resultado en sesión
                    Resultado = await _cierreService.CalcularCierreAsync(IdPeriodo);
                }

                // Obtener saldos detallados
                SaldosDetallados = await _cierreService.ObtenerSaldosDetalladosAsync(IdPeriodo);

                return Page();
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error al cargar información: {ex.Message}";
                return RedirectToPage("Index");
            }
        }

        public async Task<IActionResult> OnPostEjecutarCierreAsync()
        {
            try
            {
                var idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

                // PRIMERO: Verificar que el periodo existe y está abierto
                // Necesitas agregar este método al servicio primero:
                // Task<PeriodoContableEntity?> ObtenerPeriodoAsync(int idPeriodo);
                var periodo = await _cierreService.ObtenerPeriodoAsync(IdPeriodo);
                if (periodo == null)
                {
                    ErrorMessage = "Periodo no encontrado.";
                    await RecargarDatosAsync();
                    return Page();
                }

                if (periodo.Estado == "Cerrado")
                {
                    ErrorMessage = "El periodo ya está cerrado.";
                    await RecargarDatosAsync();
                    return Page();
                }

                // SEGUNDO: Validar periodos anteriores
                var puedeCerrar = await _cierreService.ValidarPeriodosAnterioresCerradosAsync(IdPeriodo);
                if (!puedeCerrar)
                {
                    ErrorMessage = "No se puede cerrar: hay periodos anteriores abiertos.";
                    await RecargarDatosAsync();
                    return Page();
                }

                // Recalcular para verificar balance
                Resultado = await _cierreService.CalcularCierreAsync(IdPeriodo);
                if (!Resultado.Balanceado)
                {
                    ErrorMessage = $"No se puede cerrar: el periodo no está balanceado. Diferencia: {Resultado.Diferencia:C}";
                    await RecargarDatosAsync();
                    return Page();
                }

                // Ejecutar cierre
                var resultado = await _cierreService.EjecutarCierreAsync(IdPeriodo, idUsuario);

                if (resultado)
                {
                    SuccessMessage = $"Cierre contable para {Resultado.MesNombre} {Resultado.Anio} ejecutado exitosamente.";
                    return RedirectToPage("Index");
                }
                else
                {
                    ErrorMessage = "Error al ejecutar el cierre.";
                    await RecargarDatosAsync();
                    return Page();
                }
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error al ejecutar cierre: {ex.Message}";
                await RecargarDatosAsync();
                return Page();
            }
        }

        private async Task RecargarDatosAsync()
        {
            // Si hubo error, recargar los datos
            if (Resultado == null || Resultado.IdPeriodo == 0)
            {
                Resultado = await _cierreService.CalcularCierreAsync(IdPeriodo);
            }

            SaldosDetallados = await _cierreService.ObtenerSaldosDetalladosAsync(IdPeriodo);
        }
    }
}