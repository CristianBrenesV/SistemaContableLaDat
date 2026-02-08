// SistemaContableLaDat.Service/Abstract/IBitacoraService.cs
namespace SistemaContableLaDat.Service.Abstract
{
    public interface IBitacoraService
    {
        // Métodos específicos por tipo de acción
        Task<bool> RegistrarCreacionAsync(string idUsuario, string elemento, object datosNuevos, string? idSolicitud = null);
        Task<bool> RegistrarActualizacionAsync(string idUsuario, string elemento, object datosAnteriores, object datosNuevos, string? idSolicitud = null);
        Task<bool> RegistrarEliminacionAsync(string idUsuario, string elemento, object datosEliminados, string? idSolicitud = null);
        Task<bool> RegistrarConsultaAsync(string idUsuario, string elemento, object? filtros = null, string? idSolicitud = null);

        // Método genérico (mantener para compatibilidad)
        Task<bool> RegistrarAccionAsync(string idUsuario, string descripcion, object accionesJson, string? idSolicitud = null);

        // Para errores
        Task<bool> RegistrarErrorAsync(string idUsuario, string errorDetalle, string? idSolicitud = null);
    }
}