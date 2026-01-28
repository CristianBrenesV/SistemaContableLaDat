using Dapper;
using Newtonsoft.Json;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

namespace SistemaContableLaDat.Repository.Bitacora
{
    
    
    public class BitacoraRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public BitacoraRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<bool> RegistrarAccionAsync(string idUsuario, string descripcion, object accionesJson, string? idSolicitud = null)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();

                var parameters = new DynamicParameters();
                parameters.Add("pI_IdUsuarioAccion", string.IsNullOrEmpty(idUsuario) ? DBNull.Value : idUsuario, DbType.String); // Para validar si el ID de usuario es nulo o vacío (operador ternario)
                parameters.Add("pI_DescripcionAccion", descripcion, DbType.String);
                parameters.Add("pI_ListadoAccion", JsonConvert.SerializeObject(accionesJson), DbType.String);
                parameters.Add("pI_id_solicitud",string.IsNullOrWhiteSpace(idSolicitud) ? DBNull.Value : idSolicitud,DbType.String);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_BitacoraInsertar",
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                int resultado = parameters.Get<int>("pS_resultado");
                return resultado == 1; 
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public async Task<bool> RegistrarErrorAsync(string idUsuario, string errorDetalle, string? idSolicitud = null)
        {
            try
            {
                var descripcion = "Error técnico";
                var detalle = new { error = errorDetalle };

                return await RegistrarAccionAsync(idUsuario, descripcion, JsonConvert.SerializeObject(detalle), idSolicitud);
            }
            catch (Exception ex)
            {
                // Loguear el error si es necesario
                Console.WriteLine($"Error al registrar en bitácora: {ex.Message}");
                return false;
            }
        }
    }
}
