using System.ComponentModel.DataAnnotations;
using SistemaContableLaDat.Entities.PeriodosContables;

namespace SistemaContableLaDat.Pages.Models
{
    public class NuevoPeriodoContableFormModel
    {
        [Required]
        public int Anio { get; set; }

        [Required]
        [Range(1, 12, ErrorMessage = "El mes debe ser entre 1 y 12")]
        public int Mes { get; set; }

        [Required]
        public EstadoPeriodosContables Estado { get; set; }
    }
}
