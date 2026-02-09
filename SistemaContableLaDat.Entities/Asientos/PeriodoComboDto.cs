using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Asientos
{
    public class PeriodoComboDto
    {
        public int IdPeriodo { get; set; }
        public string Descripcion { get; set; } = string.Empty;
        public int Anio { get; set; }
        public int Mes { get; set; }
        public string Estado { get; set; } = string.Empty;
    }
}
