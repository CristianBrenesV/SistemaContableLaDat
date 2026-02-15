namespace SistemaContableLaDat.Pages.Models
{
    public class ListarPantallasModel
    {
        public int IdPantalla { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Descripcion { get; set; } = string.Empty;
        public string Ruta { get; set; } = string.Empty;
        public string Estado { get; set; } = string.Empty;
    }
}
