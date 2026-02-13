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
        public string Usuario { get; set; } = string.Empty;

        [BindProperty]
        public string Clave { get; set; } = string.Empty;

        public string Mensaje { get; set; } = string.Empty;
        public string MensajeInfo { get; set; } = string.Empty;

        public async Task<IActionResult> OnPostAsync()
        {
            var resultado = _loginService.Login(Usuario, Clave);

            if (!resultado.Exito)
            {
                Mensaje = resultado.Mensaje;
                return Page();
            }

            if (resultado.Usuario == null)
            {
                Mensaje = "Ocurrió un error interno al obtener el usuario.";
                return Page();
            }

            var usuario = resultado.Usuario;

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
                    Fecha = GetUtcMinus6()
                }
            );

            return RedirectToPage("/Principal");
        }

        public async Task OnGetAsync()
        {
            var returnUrl = Request.Query["returnUrl"].ToString();

            if (User.Identity != null && !User.Identity.IsAuthenticated && !string.IsNullOrEmpty(returnUrl))
            {
                MensajeInfo = "Por favor inicie sesión para utilizar el sistema.";

                try
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        0, // <-- usar 0 cuando no hay usuario
                        "Intento de acceso no autorizado",
                        new
                        {
                            Ruta = returnUrl,
                            Fecha = GetUtcMinus6(),
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
        private DateTime GetUtcMinus6()
        {
            DateTime utcNow = DateTime.UtcNow;
            TimeZoneInfo tz = TimeZoneInfo.FindSystemTimeZoneById("Central Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcNow, tz);
        }

    }
}
