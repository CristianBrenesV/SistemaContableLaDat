using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Usuarios
{
    public class UsuarioEntity
    {
        public string IdUsuario { get; set; } = string.Empty;  // id_usuario
        public string Usuario { get; set; } = string.Empty;
        public string NombreUsuario { get; set; } = string.Empty;
        public string ApellidoUsuario { get; set; } = string.Empty;
        public string NombreCompleto { get; set; } = string.Empty;
        public string CorreoElectronico { get; set; } = string.Empty;

        public byte[] ClaveCifrada { get; set; } = Array.Empty<byte>();      // contrasenia_cifrada
        public byte[] TagAutenticacion { get; set; } = Array.Empty<byte>();   // tag_autenticacion
        public byte[] Nonce { get; set; } = Array.Empty<byte>();             // nonce

        public EstadoUsuario Estado { get; set; }       // estado

        // Columnas faltantes de la tabla
        public int IntentosFallidos { get; set; }      // intentos_fallidos
        public DateTime? UltimoIntento { get; set; }   // ultimo_intento

        // Campo adicional del SP (no pertenece a la tabla)
        public int Encontrado { get; set; }
    }
}
