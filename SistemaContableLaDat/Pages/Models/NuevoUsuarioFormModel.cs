using SistemaContableLaDat.Entities.Usuarios;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Models
{
    public class NuevoUsuarioFormModel
    {

        [Required(ErrorMessage = "El usuario es obligatorio.")]
        public string Usuario { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio.")]
        public string NombreUsuario { get; set; }

        [Required(ErrorMessage = "El apellido es obligatorio.")]
        public string ApellidoUsuario { get; set; }

        [Required(ErrorMessage = "El correo es obligatorio.")]
        [EmailAddress(ErrorMessage = "Ingrese un correo válido.")]
        public string CorreoElectronico { get; set; }

        [Required(ErrorMessage = "La contraseña es obligatoria.")]
        [MinLength(8, ErrorMessage = "La contraseña debe tener al menos 8 caracteres.")]
        public string Clave { get; set; }

        [Required(ErrorMessage = "Debe confirmar la Clave.")]
        [Compare("Clave", ErrorMessage = "Las contraseñas no coinciden.")]
        public string ConfirmarClave { get; set; } 

        [Required(ErrorMessage = "Debe seleccionar un estado.")]
        public EstadoUsuario Estado { get; set; }
    }
}
