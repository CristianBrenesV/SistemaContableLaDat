using SistemaContableLaDat.Entities.PeriodosContables;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Pages.Models
{
    public class EditarPeriodoContableFormModel
    {
        [Required]
        public int IdPeriodo { get; set; }

        [Required]
        public int Anio { get; set; }

        [Required]
        [Range(1, 12)]
        public int Mes { get; set; }

        [Required]
        public EstadoPeriodosContables Estado { get; set; }

        public int? IdUsuarioCierre { get; set; }

        public DateTime? FechaCierre { get; set; }
    }
}
