namespace SistemaContableLaDat.Service.Abstract
{
    public interface IBitacoraService
    {
        Task<bool> RegistrarCreacionAsync(int idUsuario, string elemento, object datosNuevos);
        Task<bool> RegistrarActualizacionAsync(int idUsuario, string elemento, object datosAnteriores, object datosNuevos);
        Task<bool> RegistrarEliminacionAsync(int idUsuario, string elemento, object datosEliminados);
        Task<bool> RegistrarConsultaAsync(int idUsuario, string elemento, object? filtros = null);

        Task<bool> RegistrarAccionAsync(int idUsuario, string descripcion, object accionesJson);

        Task<bool> RegistrarErrorAsync(int idUsuario, string errorDetalle);
    }
}
