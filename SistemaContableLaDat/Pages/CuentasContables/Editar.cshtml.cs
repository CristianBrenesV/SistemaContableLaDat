using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.CuentasContables;
using SistemaContableLaDat.Models;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.CuentasContables
{
    [Authorize]
    public class EditarModel : PageModel
    {
        private readonly ICuentasContablesService _cuentaService;

        public EditarModel(ICuentasContablesService cuentaService)
        {
            _cuentaService = cuentaService;
        }

        [BindProperty]
        public EditarCuentasContablesFormModel CuentaForm { get; set; } = new();

        public List<SelectListItem> ListaCuentas { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int IdCuenta)
        {
            var cuentaEntidad = await _cuentaService.GetByIdAsync(IdCuenta);
            if (cuentaEntidad == null)
                return RedirectToPage("Index");

            CuentaForm = new EditarCuentasContablesFormModel
            {
                IdCuenta = cuentaEntidad.IdCuenta,
                CodigoCuenta = cuentaEntidad.CodigoCuenta,
                Nombre = cuentaEntidad.Nombre,
                Tipo = cuentaEntidad.Tipo,
                CuentaPadreId = cuentaEntidad.CuentaPadre,
                TipoSaldo = cuentaEntidad.TipoSaldo,
                AceptaMovimiento = cuentaEntidad.AceptaMovimiento,
                Estado = cuentaEntidad.Estado
            };

            await CargarCuentasAsync();
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                await CargarCuentasAsync();
                return Page();
            }

            TipoSaldo tipoSaldo = CuentaForm.Tipo switch
            {
                TipoCuenta.Activo => TipoSaldo.Deudor,
                TipoCuenta.Gasto => TipoSaldo.Deudor,
                TipoCuenta.Pasivo => TipoSaldo.Acreedor,
                TipoCuenta.Capital => TipoSaldo.Acreedor,
                TipoCuenta.Ingreso => TipoSaldo.Acreedor,
                _ => throw new Exception("Tipo de cuenta no válido")
            };

            var cuentaEditada = new CuentaContable
            {
                IdCuenta = CuentaForm.IdCuenta,
                CodigoCuenta = CuentaForm.CodigoCuenta,
                Nombre = CuentaForm.Nombre,
                Tipo = CuentaForm.Tipo,
                CuentaPadre = CuentaForm.CuentaPadreId,
                TipoSaldo = tipoSaldo,
                AceptaMovimiento = CuentaForm.AceptaMovimiento,
                Estado = CuentaForm.Estado
            };

            var idUsuario = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(idUsuario))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario.";
                return RedirectToPage("/Usuarios/Index");
            }

            var resultado = await _cuentaService.UpdateAsync(cuentaEditada, int.Parse(idUsuario));

            TempData["Mensaje"] = resultado == 1
                ? "Cuenta contable actualizada correctamente."
                : "Error al actualizar la cuenta contable.";

            return RedirectToPage("/CuentasContables/Index");
        }

        private async Task CargarCuentasAsync()
        {
            var cuentas = await _cuentaService.GetAllAsync();
            ListaCuentas = cuentas
                .Where(c => c.IdCuenta != CuentaForm.IdCuenta) // evita poner la misma cuenta como padre
                .Select(c => new SelectListItem
                {
                    Value = c.IdCuenta.ToString(),
                    Text = $"{c.CodigoCuenta} - {c.Nombre}"
                }).ToList();
        }
    }
}