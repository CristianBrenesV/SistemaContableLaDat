namespace SistemaContableLaDat.Pages.Models
{
    public class ListarCuentaContableModel
    {
        public int IdCuenta { get; set; }

        public string CodigoCuenta { get; set; }

        public string Nombre { get; set; }

        public string Tipo { get; set; }

        public string TipoSaldo { get; set; }

        public bool AceptaMovimiento { get; set; }

        public string Estado { get; set; }
    }
}
