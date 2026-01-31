using SistemaContableLaDat.Repository.Bitacora;
using SistemaContableLaDat.Service.Abstract;

namespace SistemaContableLaDat.Service.Bitacora
{
    public class BitacoraService : IBitacoraService
    {
        private readonly BitacoraRepository _repository;

        public BitacoraService(BitacoraRepository repository)
        {
            _repository = repository;
        }

        public async Task<bool> RegistrarAccionAsync(
            string idUsuario,
            string descripcion,
            object accionesJson,
            string? idSolicitud = null)
        {
            return await _repository.RegistrarAccionAsync(
                idUsuario,
                descripcion,
                accionesJson,
                idSolicitud
            );
        }

        public async Task<bool> RegistrarErrorAsync(
            string idUsuario,
            string errorDetalle,
            string? idSolicitud = null)
        {
            return await _repository.RegistrarErrorAsync(
                idUsuario,
                errorDetalle,
                idSolicitud
            );
        }
    }
}
