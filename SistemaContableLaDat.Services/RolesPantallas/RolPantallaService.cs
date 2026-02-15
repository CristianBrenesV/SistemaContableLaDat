using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Entities.RolesPantallas;
using SistemaContableLaDat.Repository.RolesPantallas;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Bitacora;
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
        public Task<IEnumerable<RolPantalla>> GetPantallasByRolAsync(string idRol)
        {
            return _rolpantallaRepository.GetPantallasByRolAsync(idRol);
        }

        public Task<IEnumerable<Pantalla>> GetPantallasDetalleByRolAsync(string idRol)
        {
            return _rolpantallaRepository.GetPantallasDetalleByRolAsync(idRol);
        }

        public async Task<int> AsignarPantallaAsync(string idRol, int idPantalla, int idUsuarioEjecutor)
        {
            try
            {
                var resultado = await _rolpantallaRepository.InsertAsync(idRol, idPantalla);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuarioEjecutor,
                        "Pantalla asignada a rol",
                        new { idRol, idPantalla }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuarioEjecutor, ex.ToString());
                throw;
            }
        }

        public async Task<int> RemoverPantallaAsync(string idRol, int idPantalla, int idUsuarioEjecutor)
        {
            try
            {
                var resultado = await _rolpantallaRepository.DeleteAsync(idRol, idPantalla);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuarioEjecutor,
                        "Pantalla removida de rol",
                        new { idRol, idPantalla }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuarioEjecutor, ex.ToString());
                throw;
            }
        }

        public async Task<int> ActualizarPantallasAsync(string idRol, List<int> pantallas, int idUsuarioEjecutor)
        {
            try
            {
                var resultado = await _rolpantallaRepository.ActualizarPantallasAsync(idRol, pantallas);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        idUsuarioEjecutor,
                        "Pantallas actualizadas de rol",
                        new { idRol, pantallas }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(idUsuarioEjecutor, ex.ToString());
                throw;
            }
        }

        public Task<IEnumerable<RolPantalla>> Listar10Async(int limite, int offset)
        {
            return _rolpantallaRepository.Listar10Async(limite, offset);
        }

        public Task<IEnumerable<RolPantalla>> ListarAsync()
        {
            return _rolpantallaRepository.ListarAsync();
        }

        public Task<int> ConteoAsync()
        {
            return _rolpantallaRepository.ConteoAsync();
        }
    }
}