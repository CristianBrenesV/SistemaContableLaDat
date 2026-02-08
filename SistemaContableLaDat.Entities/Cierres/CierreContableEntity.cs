using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Cierres
{
    public class CierreContableEntity
    {
        public int IdCierre { get; set; }
        public int IdPeriodo { get; set; }
        public int Anio { get; set; }
        public int Mes { get; set; }
        public DateTime FechaCierre { get; set; }
        public int IdUsuarioCierre { get; set; }
        public string NombreUsuario { get; set; } = string.Empty;
        public string Estado { get; set; } = string.Empty; // "PROCESANDO", "COMPLETADO", "ERROR"
        public string Mensaje { get; set; } = string.Empty;
        public decimal TotalDebe { get; set; }
        public decimal TotalHaber { get; set; }
        public bool Balanceado { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}
