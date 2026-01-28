using SistemaContableLaDat.Entities.Usuarios;

namespace SistemaContableLaDat.Service.Login
{
    public class LoginResult
    {
        public bool Exito { get; set; }
        public string Mensaje { get; set; } = string.Empty;
        public UsuarioEntity? Usuario { get; set; }
    }
}
