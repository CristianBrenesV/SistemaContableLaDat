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

        public void OnGet()
        {

            NombreUsuario = User.FindFirst("NombreUsuario")?.Value ?? "";
            ApellidoUsuario = User.FindFirst("ApellidoUsuario")?.Value ?? "";
        }
    }
}
