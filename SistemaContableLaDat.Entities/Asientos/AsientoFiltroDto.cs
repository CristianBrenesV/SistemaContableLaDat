using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoFiltroDto
    {
        public int? IdEstado { get; set; }
        public int IdPeriodo { get; set; }
        public int Pagina { get; set; } = 1;
        public int ItemsPorPagina { get; set; } = 10;
    }
}