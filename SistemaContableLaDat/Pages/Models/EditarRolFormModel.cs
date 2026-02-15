using SistemaContableLaDat.Entities.Roles;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Pages.Models
{
    public class EditarRolFormModel
    {
        [Required(ErrorMessage = "El ID del rol es obligatorio")]
        [StringLength(40)]
        public string IdRol { get; set; } = string.Empty;

        [Required(ErrorMessage = "El nombre del rol es obligatorio")]
        [StringLength(40)]
        public string NombreRol { get; set; } = string.Empty;

        [StringLength(200)]
        public string Descripcion { get; set; } = string.Empty;

        [Required]
        public EstadoRol Estado { get; set; }
    }
}
