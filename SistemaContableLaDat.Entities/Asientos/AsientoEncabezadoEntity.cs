namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoEncabezadoEntity
    {
        public int IdAsientoEncabezado { get; set; }
        public int IdPeriodo { get; set; }
        public int IdEstadoAsiento { get; set; }
        public int IdUsuario { get; set; }
        public DateTime FechaAsiento { get; set; }
        public string Referencia { get; set; } = string.Empty;
        public bool Activo { get; set; }
        public DateTime FechaCreacion { get; set; }
    }
}
