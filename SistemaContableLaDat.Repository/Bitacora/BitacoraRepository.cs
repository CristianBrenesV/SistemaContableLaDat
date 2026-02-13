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

        public async Task<bool> RegistrarAccionAsync(int idUsuario, string descripcion, object accionesJson)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();

                var parameters = new DynamicParameters();
                parameters.Add("pI_IdUsuarioAccion", idUsuario, DbType.Int32);
                parameters.Add("pI_DescripcionAccion", descripcion, DbType.String);
                parameters.Add("pI_ListadoAccion", JsonConvert.SerializeObject(accionesJson), DbType.String);

                await connection.ExecuteAsync("sp_BitacoraInsertar", parameters, commandType: CommandType.StoredProcedure);

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
