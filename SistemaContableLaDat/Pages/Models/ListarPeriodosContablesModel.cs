namespace SistemaContableLaDat.Pages.Models
{
    public class ListarPeriodosContablesModel
    {
        public int IdPeriodo { get; set; }

        public int Anio { get; set; }

        public int Mes { get; set; }

        public string Estado { get; set; }

        public int? IdUsuarioCierre { get; set; }

        public DateTime? FechaCierre { get; set; }
        public string UsuarioCierreNombre { get; set; }

    }
}
