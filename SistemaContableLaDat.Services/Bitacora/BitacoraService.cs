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

        public async Task<bool> RegistrarCreacionAsync(int idUsuario, string elemento, object datosNuevos)
        {
            var accion = new BitacoraAccion
            {
                TipoAccion = "CREAR",
                Elemento = elemento,
                Datos = datosNuevos,
                Fecha = DateTime.Now
            };

            string descripcion = $"Creación de {elemento}";
            return await _repository.RegistrarAccionAsync(idUsuario, descripcion, accion);
        }

        public async Task<bool> RegistrarActualizacionAsync(int idUsuario, string elemento, object datosAnteriores, object datosNuevos)
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
            return await _repository.RegistrarAccionAsync(idUsuario, descripcion, accion);
        }

        public async Task<bool> RegistrarEliminacionAsync(int idUsuario, string elemento, object datosEliminados)
        {
            var accion = new BitacoraAccion
            {
                TipoAccion = "ELIMINAR",
                Elemento = elemento,
                Datos = datosEliminados,
                Fecha = DateTime.Now
            };

            string descripcion = $"Eliminación de {elemento}";
            return await _repository.RegistrarAccionAsync(idUsuario, descripcion, accion);
        }

        public async Task<bool> RegistrarConsultaAsync(int idUsuario, string elemento, object? filtros = null)
        {
            var accion = new BitacoraAccion
            {
                TipoAccion = "CONSULTAR",
                Elemento = elemento,
                Datos = filtros ?? new { },
                Fecha = DateTime.Now
            };

            string descripcion = $"Consulta de {elemento}";
            return await _repository.RegistrarAccionAsync(idUsuario, descripcion, accion);
        }

        public async Task<bool> RegistrarAccionAsync(int idUsuario, string descripcion, object accionesJson)
        {
            return await _repository.RegistrarAccionAsync(idUsuario, descripcion, accionesJson);
        }

        public async Task<bool> RegistrarErrorAsync(int idUsuario, string errorDetalle)
        {
            var detalle = new { error = errorDetalle };
            return await _repository.RegistrarAccionAsync(idUsuario, "Error técnico", detalle);
        }
    }
}
