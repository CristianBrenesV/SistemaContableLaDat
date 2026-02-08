using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Bitacora
{
    public class BitacoraAccion
    {
        public string TipoAccion { get; set; } = string.Empty; // CREAR, ACTUALIZAR, ELIMINAR, CONSULTAR
        public string Elemento { get; set; } = string.Empty; // "Asiento", "Usuario", "Cierre", etc.
        public object? Datos { get; set; } // Datos específicos según el tipo
        public DateTime Fecha { get; set; } = DateTime.Now;
    }

    public class BitacoraActualizacion
    {
        public object? Antes { get; set; }
        public object? Despues { get; set; }
    }
}
