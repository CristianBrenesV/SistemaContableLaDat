namespace SistemaContableLaDat.Entities.Asientos
{
    public class AsientoDetalleEntity
    {
        public int IdAsientoDetalle { get; set; }
        public int IdAsiento { get; set; }
        public int IdCuentaContable { get; set; }
        public string TipoMovimiento { get; set; } = string.Empty; // "D" | "C"
        public decimal Monto { get; set; }
        public string? Descripcion { get; set; }

    }
}
