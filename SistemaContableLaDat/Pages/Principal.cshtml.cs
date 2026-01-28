using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace SistemaContableLaDat.Pages
{
    [Authorize(AuthenticationSchemes = "Cookies")]
    public class PrincipalModel : PageModel
    {
        public string NombreUsuario { get; set; } = "";
        public string ApellidoUsuario { get; set; } = "";

        public string NombreCompleto => $"{NombreUsuario} {ApellidoUsuario}".Trim();
        public bool SesionExpirada { get; set; } = false;

        public void OnGet()
        {

            // Si no está autenticado, se redirige al login automáticamente
            if (!User.Identity.IsAuthenticated)
            {
                SesionExpirada = true;
                return;
            }

            NombreUsuario = User.FindFirst("NombreUsuario")?.Value ?? "";
            ApellidoUsuario = User.FindFirst("ApellidoUsuario")?.Value ?? "";
        }
    }
}
