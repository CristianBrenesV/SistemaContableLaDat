using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Pages.Models;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Pages.Roles
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private readonly IRolService _rolService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(IRolService RolService, IBitacoraService bitacoraService)
        {
            _rolService = RolService;
            _bitacoraService = bitacoraService;
        }
        public List<ListarRolesModel> Roles { get; set; } = new();

        public int PaginaActual { get; set; }
        public int TotalPaginas { get; set; }

        private const int TamanoPagina = 10;

        private int? ObtenerIdUsuarioLogueado()
        {
            var claim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (int.TryParse(claim, out var IdUsuario))
                return IdUsuario;

            return null;
        }
        public async Task<IActionResult> OnGetAsync(int pagina = 1)
        {
            var rolesEntidad = await _rolService.GetRolesPaginadosAsync(pagina, TamanoPagina);
            var total = await _rolService.CuentaRolesAsync();

            Roles = rolesEntidad.Select(r => new ListarRolesModel
            {
                IdRol = r.IdRol,
                NombreRol = r.NombreRol,
                Descripcion = r.Descripcion,
                Estado = r.Estado,
            }).ToList();

            var idUsuario = ObtenerIdUsuarioLogueado();

            if (idUsuario.HasValue)
            {
                await _bitacoraService.RegistrarConsultaAsync(
                    idUsuario.Value,
                    "Consulta paginada de roles",
                    new { Pagina = pagina, RolesMostrados = Roles.Count }
                );
            }

            return Page();
        }
    }
}
