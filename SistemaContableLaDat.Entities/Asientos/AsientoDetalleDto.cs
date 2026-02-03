using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoDetalleDto
    {
        public int IdAsientoDetalle { get; set; }
        public string Cuenta { get; set; } = "";
        public string TipoMovimiento { get; set; } = "";
        public decimal Monto { get; set; }
        public string Descripcion { get; set; } = "";
    }
}
