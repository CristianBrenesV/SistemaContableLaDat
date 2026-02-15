namespace SistemaContableLaDat.Pages.Models
{
    public class AsignarPantallasFormModel
    {
        public string IdRol { get; set; } = string.Empty;
        public List<int> PantallasSeleccionadas { get; set; } = new List<int>();
    }
}
