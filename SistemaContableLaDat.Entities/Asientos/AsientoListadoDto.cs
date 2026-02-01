namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoListadoDto
    {
        public int IdAsiento { get; set; }
        public string Consecutivo { get; set; } = string.Empty;
        public DateTime Fecha { get; set; }
        public string Referencia { get; set; } = string.Empty;
        public int IdEstadoAsiento { get; set; }
        public string EstadoNombre { get; set; } = string.Empty;

        public bool PuedeEditar =>
            IdEstadoAsiento == (int)EstadoAsiento.Borrador ||
            IdEstadoAsiento == (int)EstadoAsiento.PendienteAprobar;
    }


}
