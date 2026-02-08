using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Cierres
{
    public class SaldoCuentaDto
    {
        public int IdCuenta { get; set; }
        public string CodigoCuenta { get; set; } = string.Empty;
        public string NombreCuenta { get; set; } = string.Empty;
        public string TipoCuenta { get; set; } = string.Empty; // Activo, Pasivo, etc.
        public string TipoSaldo { get; set; } = string.Empty; // Deudor, Acreedor
        public decimal SaldoAnterior { get; set; }
        public decimal DebitosMes { get; set; }
        public decimal CreditosMes { get; set; }
        public decimal SaldoActual { get; set; }
        public string Naturaleza { get; set; } = string.Empty; // Para el balance
    }
}
