using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Cuentas
{
    public class CuentaComboDto
    {
        public int IdCuenta { get; set; }
        public string CodigoCuenta { get; set; } = "";
        public string Nombre { get; set; } = "";

        public string Descripcion { get; set; }
    }
}
