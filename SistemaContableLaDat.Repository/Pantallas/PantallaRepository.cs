using Dapper;
using SistemaContableLaDat.Entities.Pantallas;
using SistemaContableLaDat.Entities.RolesPantallas;
using SistemaContableLaDat.Repository.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Repository.Pantallas
{
    public class PantallaRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public PantallaRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }
        public async Task<IEnumerable<Pantalla>> GetAllAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();

                return await connection.QueryAsync<Pantalla>(
                    "sp_PantallasListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync (Pantallas): {ex.Message}");
                return Enumerable.Empty<Pantalla>();
            }
        }

        public async Task<Pantalla?> GetByIdAsync(int IdPantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_pantalla", IdPantalla, DbType.String);

                return await connection.QuerySingleOrDefaultAsync<Pantalla>(
                    "sp_PantallasListarPorIdPantalla",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetByIdAsync (Pantalla): {ex.Message}");
                return null;
            }
        }
        public async Task<IEnumerable<Pantalla>> GetPantallasPaginadosAsync(int pagina, int tamanoPagina)
        {
            using var connection = _dbConnectionFactory.CreateConnection();

            var parameters = new DynamicParameters();
            parameters.Add("p_Limite", tamanoPagina);
            parameters.Add("p_Offset", (pagina - 1) * tamanoPagina);

            return await connection.QueryAsync<Pantalla>(
                "sp_PantallasListar10",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int> InsertAsync(Pantalla pantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_nombre", pantalla.Nombre);
                parameters.Add("pI_descripcion", pantalla.Descripcion);
                parameters.Add("pI_ruta", pantalla.Ruta);
                parameters.Add("pI_estado", pantalla.Estado.ToString());
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PantallasInsertar",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync (Pantalla): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> UpdateAsync(Pantalla pantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_nombre", pantalla.Nombre);
                parameters.Add("pI_descripcion", pantalla.Descripcion);
                parameters.Add("pI_ruta", pantalla.Ruta);
                parameters.Add("pI_estado", pantalla.Estado.ToString());
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PantallasActualizarPorIdPantalla",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync (Pantalla): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(int IdPantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_pantalla", IdPantalla);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PantallasEliminarPorIdPantalla",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync (Pantalla): {ex.Message}");
                return 0;
            }
        }
        public async Task<int> CuentaPantallasAsync()
        {
            using var connection = _dbConnectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "sp_PantallasConteo"
            );
        }
    }
}