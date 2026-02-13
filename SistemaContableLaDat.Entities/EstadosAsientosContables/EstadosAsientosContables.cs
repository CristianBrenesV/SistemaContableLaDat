using SistemaContableLaDat.Entities.Asientos;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.EstadosAsientosContables
{
    public class EstadosAsientosContables
    {
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
