using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Periodos
{
    public class PeriodoContable
    {
        public int IdPeriodo { get; set; }
        public int Anio { get; set; }
        public int Mes { get; set; }
        public string Estado { get; set; } = string.Empty;
        public int? IdUsuarioCierre { get; set; }
        public DateTime? FechaCierre { get; set; }
    }
}
