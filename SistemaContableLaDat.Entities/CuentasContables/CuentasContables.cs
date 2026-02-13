using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.CuentasContables
{
    public class CuentasContables
    {
        public int IdCuenta { get; set; }

        public string CodigoCuenta { get; set; }

        public string Nombre { get; set; }

        public TipoCuenta Tipo { get; set; }

        public int? CuentaPadre { get; set; }

        public TipoSaldo TipoSaldo { get; set; }

        public bool AceptaMovimiento { get; set; }

        public EstadoCuenta Estado { get; set; }
    }
}
