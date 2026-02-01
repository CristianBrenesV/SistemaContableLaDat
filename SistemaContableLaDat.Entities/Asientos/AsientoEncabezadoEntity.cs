namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoEncabezadoEntity
    {
        public int IdAsiento { get; set; }
        public int Consecutivo { get; set; }
        public DateTime Fecha { get; set; }
        public string Codigo { get; set; } = string.Empty;
        public string Referencia { get; set; } = string.Empty;
        public int IdPeriodo { get; set; }
        public int IdEstadoAsiento { get; set; }
        public int IdUsuario { get; set; }

        // PARA EDICIÓN
        public List<AsientoDetalleEntity> Detalles { get; set; } = new();
    }
}
