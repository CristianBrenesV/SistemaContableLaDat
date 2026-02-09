using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Periodos
{
    public class PeriodoDto
    {
        public int IdPeriodo { get; set; }
        public string Descripcion { get; set; } = string.Empty;
        public bool EstaAbierto { get; set; }
    }
}
