using SistemaContableLaDat.Entities.Usuarios;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Models
{
    public class NuevoUsuarioFormModel
    {

        [Required(ErrorMessage = "El usuario es obligatorio.")]
        public string Usuario { get; set; } = string.Empty;

        [Required(ErrorMessage = "El nombre es obligatorio.")]
        [MaxLength(50, ErrorMessage = "El nombre no puede superar los 50 caracteres.")]
        [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$",
            ErrorMessage = "El nombre solo puede contener letras y espacios.")]
        public string NombreUsuario { get; set; } = string.Empty;

        [Required(ErrorMessage = "El apellido es obligatorio.")]
        [MaxLength(50, ErrorMessage = "El apellido no puede superar los 50 caracteres.")]
        [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$",
            ErrorMessage = "El apellido solo puede contener letras y espacios.")]
        public string ApellidoUsuario { get; set; } = string.Empty;


        [Required(ErrorMessage = "El correo es obligatorio.")]
        [EmailAddress(ErrorMessage = "Ingrese un correo válido.")]
        public string CorreoElectronico { get; set; } = string.Empty;

        [Required(ErrorMessage = "La contraseña es obligatoria.")]
        [MinLength(8, ErrorMessage = "La contraseña debe tener al menos 8 caracteres.")]
        public string Clave { get; set; } = string.Empty;

        [Required(ErrorMessage = "Debe confirmar la Clave.")]
        [Compare("Clave", ErrorMessage = "Las contraseñas no coinciden.")]
        public string ConfirmarClave { get; set; } = string.Empty;

        public List<string> RolesSeleccionados { get; set; } = new();

        [Required(ErrorMessage = "Debe seleccionar un estado.")]
        public EstadoUsuario Estado { get; set; }
    }
}
