using SistemaContableLaDat.Entities.Roles;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Pages.Models
{
    public class NuevoRolFormModel
    {
        [Required(ErrorMessage = "El ID del rol es obligatorio")]
        [StringLength(40)]
        public string IdRol { get; set; }

        [Required(ErrorMessage = "El nombre del rol es obligatorio")]
        [StringLength(40)]
        public string NombreRol { get; set; }

        [StringLength(200)]
        public string Descripcion { get; set; }

        [Required]
        public EstadoRol Estado { get; set; }
    }
}
