using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Cierres
{
    public class ResultadoCierreDto
    {
        public int IdPeriodo { get; set; }
        public int Anio { get; set; }
        public int Mes { get; set; }
        public string MesNombre { get; set; } = string.Empty;
        public decimal TotalDebe { get; set; }
        public decimal TotalHaber { get; set; }
        public bool Balanceado => TotalDebe == TotalHaber;
        public decimal Diferencia => Math.Abs(TotalDebe - TotalHaber);
        public DateTime FechaCierre { get; set; }
        public string EstadoPeriodo { get; set; } = string.Empty;
        public bool PuedeCerrar { get; set; }
        public string MensajeValidacion { get; set; } = string.Empty;
    }
}
