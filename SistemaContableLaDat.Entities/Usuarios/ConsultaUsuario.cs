using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Usuarios
{
    public class ConsultaUsuario : UsuarioEntity // Hereda de Usuario para incluir propiedades adicionales específicas de la consulta
    {
        public int Encontrado { get; set; } // Indicador de si se encontró el usuario (1 = encontrado, 0 = no encontrado)
    }
}
