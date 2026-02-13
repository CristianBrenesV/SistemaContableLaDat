using SistemaContableLaDat.Entities.Pantallas;
using System.ComponentModel.DataAnnotations;

namespace SistemaContableLaDat.Pages.Models
{
    public class NuevaPantallaFormModel
    {
        public int IdPantalla { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(40, ErrorMessage = "El nombre no debe superar los 40 caracteres")]
        [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$",
       ErrorMessage = "El nombre solo debe contener letras y espacios")]
        public string Nombre { get; set; } = string.Empty;

        [Required(ErrorMessage = "La descripción es obligatoria")]
        [RegularExpression(@"^[a-zA-Z0-9\s]+$",
            ErrorMessage = "La descripción solo debe contener letras, números y espacios")]
        public string Descripcion { get; set; } = string.Empty;
        public string Ruta { get; set; } = string.Empty;
        public EstadoPantalla Estado { get; set; }
    }
}
