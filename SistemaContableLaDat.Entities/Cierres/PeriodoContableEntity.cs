using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Entities.Cierres
{
    public class PeriodoContableEntity
    {
        public int IdPeriodo { get; set; }
        public int Anio { get; set; }
        public int Mes { get; set; }
        public string Estado { get; set; } = string.Empty; // "Abierto", "Cerrado"
        public int? IdUsuarioCierre { get; set; }
        public DateTime? FechaCierre { get; set; }
        public string NombreMes => GetNombreMes();

        private string GetNombreMes()
        {
            return Mes switch
            {
                1 => "Enero",
                2 => "Febrero",
                3 => "Marzo",
                4 => "Abril",
                5 => "Mayo",
                6 => "Junio",
                7 => "Julio",
                8 => "Agosto",
                9 => "Septiembre",
                10 => "Octubre",
                11 => "Noviembre",
                12 => "Diciembre",
                _ => $"Mes {Mes}"
            };
        }
    }
}
