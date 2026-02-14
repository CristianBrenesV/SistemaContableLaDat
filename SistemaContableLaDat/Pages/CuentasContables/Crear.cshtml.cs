using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SistemaContableLaDat.Entities.CuentasContables;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.CuentasContables
{
    [Authorize]
    public class CrearModel : PageModel
    {
        private readonly ICuentasContablesService _cuentaService;

        public CrearModel(ICuentasContablesService cuentaService)
        {
            _cuentaService = cuentaService;
        }

        [BindProperty]
        public NuevaCuentaContableFormModel CuentaForm { get; set; } = new();

        public List<SelectListItem> ListaCuentas { get; set; } = new();

        public async Task OnGetAsync()
        {
            await CargarCuentasAsync();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                await CargarCuentasAsync();
                return Page();
            }

            // Determinar TipoSaldo automáticamente según Tipo de cuenta
            TipoSaldo tipoSaldo = CuentaForm.Tipo switch
            {
                TipoCuenta.Activo => TipoSaldo.Deudor,
                TipoCuenta.Gasto => TipoSaldo.Deudor,
                TipoCuenta.Pasivo => TipoSaldo.Acreedor,
                TipoCuenta.Capital => TipoSaldo.Acreedor,
                TipoCuenta.Ingreso => TipoSaldo.Acreedor,
                _ => throw new Exception("Tipo de cuenta no válido")
            };

            var nuevaCuenta = new CuentaContable
            {
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

            var resultado = await _cuentaService.InsertAsync(nuevaCuenta, int.Parse(idUsuario));

            TempData["Mensaje"] = resultado == 1
                ? "Cuenta contable creada exitosamente."
                : "Error al crear la cuenta contable.";

            return RedirectToPage("/CuentasContables/Index");
        }

        private async Task CargarCuentasAsync()
        {
            var cuentas = await _cuentaService.GetAllAsync();
            ListaCuentas = cuentas.Select(c => new SelectListItem
            {
                Value = c.IdCuenta.ToString(),
                Text = $"{c.CodigoCuenta} - {c.Nombre}"
            }).ToList();
        }
    }
}
