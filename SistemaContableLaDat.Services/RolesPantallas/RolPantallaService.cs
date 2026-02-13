using SistemaContableLaDat.Repository.RolesPantallas;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Bitacora;
using SistemaContableLaDat.Service.Encriptado;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Service.RolesPantallas
{
    public class RolPantallaService : IRolPantallaService
    {
        private readonly RolPantallaRepository _rolpantallaRepository;
        private readonly IBitacoraService _bitacoraService;
        public RolPantallaService(RolPantallaRepository rolpantallaRepository, IBitacoraService bitacoraService)
        {
            _rolpantallaRepository = rolpantallaRepository;
            _bitacoraService = bitacoraService;
        }
    }
}
