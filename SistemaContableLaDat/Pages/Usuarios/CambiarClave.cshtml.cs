using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using SistemaContableLaDat.Service.Abstract;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SistemaContableLaDat.Pages.Usuarios
{
    public class CambiarClaveModel : PageModel
    {
        private readonly IUsuarioService _usuarioService;
        private readonly IBitacoraService _bitacoraService;

        public CambiarClaveModel(IUsuarioService usuarioService, IBitacoraService bitacoraService)
        {
            _usuarioService = usuarioService;
            _bitacoraService = bitacoraService;
        }

        [BindProperty]
        public CambiarClaveInputModel Input { get; set; } = new();

        public class CambiarClaveInputModel
        {
            [Required(ErrorMessage = "La clave es requerida.")]
            [DataType(DataType.Password)]
            public string NuevaClave { get; set; } = string.Empty;

            [Required(ErrorMessage = "La confirmación es requerida.")]
            [DataType(DataType.Password)]
            [Compare("NuevaClave", ErrorMessage = "Las claves no coinciden.")]
            public string ConfirmarClave { get; set; } = string.Empty;

            [Required]
            public int IdUsuario { get; set; }
        }

        public void OnGet(int IdUsuario)
        {
            Input.IdUsuario = IdUsuario;
        }

        public async Task<IActionResult> OnPostAceptarAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            // 1) Validación de la clave (que cumpla con letras, números y símbolos y empiece con letra)
            if (!ValidarClave(Input.NuevaClave))
            {
                ModelState.AddModelError("Input.NuevaClave",
                    "La clave debe iniciar con letra y contener letras, números y símbolos (+-*$.).");
                return Page();
            }

            // 2) Cambiar clave
            var resultado = await _usuarioService.CambiarClaveAsync(Input.IdUsuario, Input.NuevaClave);

            if (resultado != 1)
            {
                TempData["Mensaje"] = "No se pudo cambiar la clave.";
                return Page();
            }

            // 3) Bitácora
            var idUsuario = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

            if (int.TryParse(idUsuario, out int idUsuarioInt))
            {
                await _bitacoraService.RegistrarAccionAsync(
                    idUsuarioInt,
                    "Cambio de clave",
                    new { IdUsuario = Input.IdUsuario }
                );
            }


            TempData["Mensaje"] = "Clave cambiada correctamente.";
            return RedirectToPage("/Usuarios/Index");
        }

        public IActionResult OnPostAutogenerar()
        {
            Input.NuevaClave = GenerarClave();
            Input.ConfirmarClave = Input.NuevaClave;
            return Page();
        }

        private bool ValidarClave(string clave)
        {
            // Debe iniciar con letra
            if (!char.IsLetter(clave[0])) return false;

            bool tieneLetra = clave.Any(char.IsLetter);
            bool tieneNumero = clave.Any(char.IsDigit);
            bool tieneSimbolo = clave.Any(c => "+-*$. ".Contains(c));

            return tieneLetra && tieneNumero && tieneSimbolo;
        }

        private string GenerarClave(int longitud = 10)
        {
            const string letras = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string numeros = "0123456789";
            const string simbolos = "+-*$.";
            var rnd = new Random();

            // Inicia con letra
            var clave = new StringBuilder();
            clave.Append(letras[rnd.Next(letras.Length)]);

            // Resto
            for (int i = 1; i < longitud; i++)
            {
                string todos = letras + numeros + simbolos;
                clave.Append(todos[rnd.Next(todos.Length)]);
            }

            return clave.ToString();
        }
    }
}
