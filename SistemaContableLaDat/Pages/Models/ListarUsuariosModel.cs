namespace SistemaContableLaDat.Pages.Models
{
    public class ListarUsuariosModel
    {
        public int IdUsuario { get; set; }
        public string Usuario { get; set; } = string.Empty;

        public string NombreUsuario { get; set; } = string.Empty;
        public string ApellidoUsuario { get; set; } = string.Empty;

        public string CorreoElectronico { get; set; } = string.Empty;
        public string Estado { get; set; } 
        public string Roles { get; set; } = "";

    }
}
