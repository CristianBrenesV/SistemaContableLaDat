using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.PeriodosContables
{
    public class PeriodoContable
    {
        public int IdPeriodo { get; set; }

        [Required]
        public int Anio { get; set; }

        [Required]
        public int Mes { get; set; }

        [Required]
        public EstadoPeriodosContables Estado { get; set; }

        public int? IdUsuarioCierre { get; set; }

        public DateTime? FechaCierre { get; set; }

        public string UsuarioCierreNombre { get; set; }
    }
}
