using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoListadoDtoExtendido : AsientoListadoDto
    {
        public int Anio { get; set; }
        public int Mes { get; set; }
    }
}
