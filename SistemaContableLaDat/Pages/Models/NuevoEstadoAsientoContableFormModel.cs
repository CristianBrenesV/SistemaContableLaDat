using System.ComponentModel.DataAnnotations;
using SistemaContableLaDat.Entities.EstadosAsientosContables;

namespace SistemaContableLaDat.Pages.Models
{
    public class NuevoEstadoAsientoContableFormModel
    {

        [Required]
        [MaxLength(20)]
        public string Codigo { get; set; }

        [Required]
        [MaxLength(40)]
        [RegularExpression(@"^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$",
            ErrorMessage = "El nombre solo puede contener letras y espacios.")]
        public string Nombre { get; set; }

        [MaxLength(200)]
        [RegularExpression(@"^[A-Za-z0-9ÁÉÍÓÚáéíóúÑñ\s]*$",
            ErrorMessage = "La descripción solo puede contener letras, números y espacios.")]
        public string Descripcion { get; set; }

        [Required]
        public EstadoAsiento Estado { get; set; }
    }
}
