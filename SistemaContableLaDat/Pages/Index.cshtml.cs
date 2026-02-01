using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Login;
using System.Security.Claims;

namespace SistemaContableLaDat.Pages
{
    public class IndexModel : PageModel
    {
        private readonly LoginService _loginService;
        private readonly IBitacoraService _bitacoraService;

        public IndexModel(LoginService loginService, IBitacoraService bitacoraService)
        {
            _loginService = loginService;
            _bitacoraService = bitacoraService;
        }

        [BindProperty]
        public string Usuario { get; set; }

        [BindProperty]
        public string Clave { get; set; }

        public string Mensaje { get; set; }
        public string MensajeInfo { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            var resultado = _loginService.Login(Usuario, Clave);

            if (!resultado.Exito)
            {
                Mensaje = resultado.Mensaje;
                return Page();
            }

            var usuario = resultado.Usuario!;

            var claims = new List<Claim>
            {
                new Claim("IdUsuario", usuario.IdUsuario.ToString()),
                new Claim(ClaimTypes.NameIdentifier, usuario.IdUsuario.ToString()),
                new Claim("NombreUsuario", usuario.NombreUsuario),
                new Claim("ApellidoUsuario", usuario.ApellidoUsuario),
                new Claim("NombreCompleto", $"{usuario.NombreUsuario} {usuario.ApellidoUsuario}".Trim())
            };

            var identidad = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identidad);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

            await _bitacoraService.RegistrarAccionAsync(
                usuario.IdUsuario,
                "Inicio de sesión",
                new
                {
                    usuario.NombreUsuario,
                    Fecha = DateTime.UtcNow
                }
            );

            return RedirectToPage("/Principal");
        }

        public async Task OnGetAsync()
        {
            var returnUrl = Request.Query["returnUrl"].ToString();

            if (!User.Identity.IsAuthenticated && !string.IsNullOrEmpty(returnUrl))
            {
                MensajeInfo = "Por favor inicie sesión para utilizar el sistema.";

                try
                {
                    bool guardado = await _bitacoraService.RegistrarAccionAsync(
                         null,
                         "Intento de acceso no autorizado",
                         new
                         {
                             Ruta = returnUrl,
                             Fecha = DateTime.UtcNow,
                             IP = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Desconocida",
                             Navegador = Request.Headers["User-Agent"].ToString()
                         }
                     );
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[Bitácora] Error al registrar: {ex.Message}");
                }
            }
        }
    }
}
