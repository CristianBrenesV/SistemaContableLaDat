using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.PeriodosContables;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Pages.Periodos
{
    [Authorize]
    public class EditarModel : PageModel
    {
        private readonly IPeriodosContablesService _periodoService;

        public EditarModel(IPeriodosContablesService periodoService)
        {
            _periodoService = periodoService;
        }

        [BindProperty]
        public EditarPeriodoContableFormModel PeriodoForm { get; set; } = new();

        public List<SelectListItem> ListaEstados { get; set; } = new();

        public async Task<IActionResult> OnGetAsync(int idPeriodo)
        {
            var periodo = await _periodoService.GetByIdAsync(idPeriodo);
            if (periodo == null)
                return RedirectToPage("Index");

            PeriodoForm = new EditarPeriodoContableFormModel
            {
                IdPeriodo = periodo.IdPeriodo,
                Anio = periodo.Anio,
                Mes = periodo.Mes,
                Estado = periodo.Estado,
                IdUsuarioCierre = periodo.IdUsuarioCierre,
                FechaCierre = periodo.FechaCierre
            };

            await CargarListaEstadosAsync();
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                await CargarListaEstadosAsync();
                return Page();
            }

            var idUsuario = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(idUsuario))
            {
                TempData["Mensaje"] = "Error al verificar credenciales del usuario.";
                return RedirectToPage("/Usuarios/Index");
            }

            var periodoActualizar = new PeriodoContable
            {
                IdPeriodo = PeriodoForm.IdPeriodo,
                Anio = PeriodoForm.Anio,
                Mes = PeriodoForm.Mes,
                Estado = PeriodoForm.Estado,
                IdUsuarioCierre = PeriodoForm.IdUsuarioCierre,
                FechaCierre = PeriodoForm.FechaCierre
            };

            var resultado = await _periodoService.UpdateAsync(periodoActualizar, int.Parse(idUsuario));

            TempData["Mensaje"] = resultado == 1
                ? "Periodo contable actualizado exitosamente."
                : "Error al actualizar el periodo contable.";

            return RedirectToPage("Index");
        }

        private Task CargarListaEstadosAsync()
        {
            ListaEstados = new List<SelectListItem>
            {
                new SelectListItem { Value = "Abierto", Text = "Abierto" },
                new SelectListItem { Value = "Cerrado", Text = "Cerrado" }
            };
            return Task.CompletedTask;
        }
    }
}
