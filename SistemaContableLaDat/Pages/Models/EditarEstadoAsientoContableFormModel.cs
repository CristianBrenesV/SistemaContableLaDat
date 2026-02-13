using System.ComponentModel.DataAnnotations;
using SistemaContableLaDat.Entities.EstadosAsientosContables;

namespace SistemaContableLaDat.Pages.Models
{
    public class EditarEstadoAsientoContableFormModel
    {
        [Required]
        public int IdEstadoAsiento { get; set; }

        [Required]
        [MaxLength(20)]
        public string Codigo { get; set; }

        [Required]
        [MaxLength(40)]
        public string Nombre { get; set; }

        [MaxLength(200)]
        public string Descripcion { get; set; }

        [Required]
        public EstadoAsiento Estado { get; set; }
    }
}
