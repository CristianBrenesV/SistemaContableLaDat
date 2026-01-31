namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoListadoDto
    {
        public int IdAsientoEncabezado { get; set; }
        public int Consecutivo { get; set; }
        public DateTime FechaAsiento { get; set; }
        public string Referencia { get; set; } = string.Empty;
        public int IdEstadoAsiento { get; set; }
    }
}
