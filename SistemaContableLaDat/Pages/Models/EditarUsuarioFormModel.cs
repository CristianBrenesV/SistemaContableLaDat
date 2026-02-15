namespace SistemaContableLaDat.Pages.Models
{
    public class EditarUsuarioFormModel
    {
        public int IdUsuario { get; set; }

        public string Usuario { get; set; } = string.Empty;
        public string NombreUsuario { get; set; } = string.Empty;
        public string ApellidoUsuario { get; set; } = string.Empty;
        public string CorreoElectronico { get; set; } = string.Empty;

        public string Estado { get; set; } = string.Empty;

        // Para cambiar clave (opcional)
        public string Clave { get; set; } = string.Empty;
        public string ConfirmarClave { get; set; } = string.Empty;

        // Roles seleccionados
        public List<string> RolesSeleccionados { get; set; } = new();
    }

}
