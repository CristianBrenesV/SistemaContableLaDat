using SistemaContableLaDat.Repository.Pantallas;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.Pantallas
{
    public class PantallaService : IPantallaService
    {
        private readonly PantallaRepository _pantallaRepository;
        private readonly IBitacoraService _bitacoraService;
        public PantallaService(PantallaRepository pantallaRepository, IBitacoraService bitacoraService)
        {
            _pantallaRepository = pantallaRepository;
            _bitacoraService = bitacoraService;
        }
    }
}
