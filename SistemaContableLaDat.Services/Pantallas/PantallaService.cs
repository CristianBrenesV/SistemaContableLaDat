using SistemaContableLaDat.Entities.Pantallas;
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
        public Task<IEnumerable<Pantalla>> GetAllAsync()
        {
            return _pantallaRepository.GetAllAsync();
        }

        public Task<Pantalla?> GetByIdAsync(int IdPantalla)
        {
            return _pantallaRepository.GetByIdAsync(IdPantalla);
        }
        public Task<IEnumerable<Pantalla>> GetPantallasPaginadosAsync(int pagina, int tamanoPagina)
        {
            return _pantallaRepository.GetPantallasPaginadosAsync(pagina, tamanoPagina);
        }
        public async Task<int> InsertAsync(Pantalla pantalla, int IdUsuario)
        {
            try
            {
                var resultado = await _pantallaRepository.InsertAsync(pantalla);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Rol creado",
                        new
                        {
                            pantalla.IdPantalla,
                            pantalla.Nombre,
                            pantalla.Descripcion,
                            Estado = pantalla.Estado.ToString()
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> UpdateAsync(Pantalla pantalla, int IdUsuario)
        {
            try
            {
                var pantallaAnterior = await _pantallaRepository.GetByIdAsync(pantalla.IdPantalla);
                var resultado = await _pantallaRepository.UpdateAsync(pantalla);

                if (resultado == 1 && pantallaAnterior != null)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Rol actualizado",
                        new
                        {
                            Antes = pantallaAnterior,
                            Despues = pantalla
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }

        public async Task<int> DeleteAsync(int IdPantalla, int IdUsuario)
        {
            try
            {
                var pantallaExistente = await _pantallaRepository.GetByIdAsync(IdPantalla);

                if (pantallaExistente == null)
                    return 0;

                var resultado = await _pantallaRepository.DeleteAsync(IdPantalla);

                if (resultado == 1)
                {
                    await _bitacoraService.RegistrarAccionAsync(
                        IdUsuario,
                        "Rol eliminado",
                        new
                        {
                            pantallaExistente.IdPantalla,
                            pantallaExistente.Nombre,
                            pantallaExistente.Descripcion,
                            Estado = pantallaExistente.Estado.ToString()
                        }
                    );
                }

                return resultado;
            }
            catch (Exception ex)
            {
                await _bitacoraService.RegistrarErrorAsync(IdUsuario, ex.ToString());
                throw;
            }
        }
        public Task<int> CuentaPantallasAsync()
        {
            return _pantallaRepository.CuentaPantallasAsync();
        }
    }
}
