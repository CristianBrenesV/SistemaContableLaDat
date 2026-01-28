namespace SistemaContableLaDat.Pages.Models
{
    public class ListarUsuariosModel
    {
        public string IdUsuario { get; set; }
        public string Usuario { get; set; }

        public string NombreUsuario { get; set; }
        public string ApellidoUsuario { get; set; }

        public string CorreoElectronico { get; set; }
        public string Estado { get; set; } // o usar un enum si lo tenés mapeado
    }
}
