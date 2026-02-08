using SistemaContableLaDat.Entities.Bitacora;
using SistemaContableLaDat.Repository.Bitacora;
using SistemaContableLaDat.Service.Abstract;
using System.Text.Json;

namespace SistemaContableLaDat.Service.Bitacora
{
    public class BitacoraService : IBitacoraService
    {
        private readonly BitacoraRepository _repository;

        public BitacoraService(BitacoraRepository repository)
        {
            _repository = repository;
        }

        public async Task<bool> RegistrarCreacionAsync(
            string idUsuario,
            string elemento,
            object datosNuevos,
            string? idSolicitud = null)
        {
            var accion = new BitacoraAccion
            {
                TipoAccion = "CREAR",
                Elemento = elemento,
                Datos = datosNuevos,
                Fecha = DateTime.Now
            };

            string descripcion = $"Creación de {elemento}";
            string accionesJson = JsonSerializer.Serialize(accion.Datos);

            return await _repository.RegistrarAccionAsync(
                idUsuario,
                descripcion,
                accionesJson,
                idSolicitud
            );
        }

        public async Task<bool> RegistrarActualizacionAsync(
            string idUsuario,
            string elemento,
            object datosAnteriores,
            object datosNuevos,
            string? idSolicitud = null)
        {
            var actualizacion = new BitacoraActualizacion
            {
                Antes = datosAnteriores,
                Despues = datosNuevos
            };

            var accion = new BitacoraAccion
            {
                TipoAccion = "ACTUALIZAR",
                Elemento = elemento,
                Datos = actualizacion,
                Fecha = DateTime.Now
            };

            string descripcion = $"Actualización de {elemento}";
            string accionesJson = JsonSerializer.Serialize(accion.Datos);

            return await _repository.RegistrarAccionAsync(
                idUsuario,
                descripcion,
                accionesJson,
                idSolicitud
            );
        }

        public async Task<bool> RegistrarEliminacionAsync(
            string idUsuario,
            string elemento,
            object datosEliminados,
            string? idSolicitud = null)
        {
            var accion = new BitacoraAccion
            {
                TipoAccion = "ELIMINAR",
                Elemento = elemento,
                Datos = datosEliminados,
                Fecha = DateTime.Now
            };

            string descripcion = $"Eliminación de {elemento}";
            string accionesJson = JsonSerializer.Serialize(accion.Datos);

            return await _repository.RegistrarAccionAsync(
                idUsuario,
                descripcion,
                accionesJson,
                idSolicitud
            );
        }

        public async Task<bool> RegistrarConsultaAsync(
            string idUsuario,
            string elemento,
            object? filtros = null,
            string? idSolicitud = null)
        {
            var accion = new BitacoraAccion
            {
                TipoAccion = "CONSULTAR",
                Elemento = elemento,
                Datos = filtros,
                Fecha = DateTime.Now
            };

            string descripcion = $"El usuario consulta {elemento}";
            string accionesJson = filtros != null
                ? JsonSerializer.Serialize(accion.Datos)
                : "{}";

            return await _repository.RegistrarAccionAsync(
                idUsuario,
                descripcion,
                accionesJson,
                idSolicitud
            );
        }

        // Mantener compatibilidad con el método antiguo
        public async Task<bool> RegistrarAccionAsync(
            string idUsuario,
            string descripcion,
            object accionesJson,
            string? idSolicitud = null)
        {
            // Serializar si es un objeto
            string json = accionesJson is string str ? str : JsonSerializer.Serialize(accionesJson);

            return await _repository.RegistrarAccionAsync(
                idUsuario,
                descripcion,
                json,
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