using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Pantallas
{
    public class Pantalla
    {
        public int IdPantalla { get; set; } 
        public string Nombre { get; set; } = string.Empty;
        public string Descripcion { get; set; } = string.Empty;
        public string Ruta { get; set; } = string.Empty;
        public string Estado { get; set; } = string.Empty; // "Activa" o "Inactiva"
    }
}
