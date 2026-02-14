using SistemaContableLaDat.Entities.CuentasContables;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Pages.Models
{
    public class EditarCuentasContablesFormModel
    {
        [Required]
        public int IdCuenta { get; set; }

        [Required]
        [MaxLength(20)]
        public string CodigoCuenta { get; set; }

        [Required]
        [MaxLength(100)]
        [RegularExpression(@"^[A-Za-z0-9ÁÉÍÓÚáéíóúÑñ\s]+$",
            ErrorMessage = "El nombre solo puede contener letras, números y espacios.")]
        public string Nombre { get; set; }


        [Required]
        public TipoCuenta Tipo { get; set; }

        public int? CuentaPadreId { get; set; }

        [Required]
        public TipoSaldo TipoSaldo { get; set; }

        public bool AceptaMovimiento { get; set; }

        [Required]
        public EstadoCuenta Estado { get; set; }
    }
}
