using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Bitacora
{
    public class Bitacora
    {
        public int IdBitacora { get; set; }
        public int IdUsuarioAccion { get; set; }
        public DateTime FechaBitacora { get; set; }
        public string DescripcionAccion { get; set; } = string.Empty;
        public string ListadoAccion { get; set; } = string.Empty; // JSON como string
    }
}
