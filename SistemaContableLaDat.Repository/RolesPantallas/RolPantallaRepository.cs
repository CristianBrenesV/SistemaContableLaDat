using Dapper;
using SistemaContableLaDat.Repository.Infrastructure;
using SistemaContableLaDat.Entities.RolesPantallas;
using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Entities.Pantallas;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Repository.RolesPantallas
{
    public class RolPantallaRepository

    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public RolPantallaRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<IEnumerable<RolPantalla>> GetPantallasByRolAsync(string idRol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_rol", idRol, DbType.String);

                return await connection.QueryAsync<RolPantalla>(
                    "sp_RolesPantallasListarPorIdRol",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetPantallasByRolAsync: {ex.Message}");
                return Enumerable.Empty<RolPantalla>();
            }
        }

        public async Task<IEnumerable<RolPantalla>> GetRolesByPantallaAsync(int idPantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_pantalla", idPantalla, DbType.Int32);

                return await connection.QueryAsync<RolPantalla>(
                    "sp_RolesPantallasListarPorIdPantalla",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetRolesByPantallaAsync: {ex.Message}");
                return Enumerable.Empty<RolPantalla>();
            }
        }

        public async Task<IEnumerable<Pantalla>> GetPantallasDetalleByRolAsync(string idRol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_rol", idRol, DbType.String);

                return await connection.QueryAsync<Pantalla>(
                    "sp_RolesPantallasListarPantallasPorIdRol",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetPantallasDetalleByRolAsync: {ex.Message}");
                return Enumerable.Empty<Pantalla>();
            }
        }

        public async Task<int> InsertAsync(string idRol, int idPantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_rol", idRol, DbType.String);
                parameters.Add("pI_id_pantalla", idPantalla, DbType.Int32);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_RolesPantallasInsertar",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync (RolPantalla): {ex.Message}");
                return 0;
            }
        }
        public async Task<int> ActualizarPantallasAsync(string idRol, List<int> pantallas)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_rol", idRol, DbType.String);
                parameters.Add("pI_pantallas", string.Join(",", pantallas), DbType.String); // Lista separada por coma
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_RolesPantallasActualizar",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en ActualizarPantallasAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(string idRol, int idPantalla)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_rol", idRol, DbType.String);
                parameters.Add("pI_id_pantalla", idPantalla, DbType.Int32);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_RolesPantallasEliminarPorIdRolIdPantalla",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync (RolPantalla): {ex.Message}");
                return 0;
            }
        }

        public async Task<IEnumerable<RolPantalla>> Listar10Async(int limite, int offset)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("p_Limite", limite, DbType.Int32);
                parameters.Add("p_Offset", offset, DbType.Int32);

                return await connection.QueryAsync<RolPantalla>(
                    "sp_RolesPantallasListar10",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en Listar10Async: {ex.Message}");
                return Enumerable.Empty<RolPantalla>();
            }
        }

        public async Task<IEnumerable<RolPantalla>> ListarAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();

                return await connection.QueryAsync<RolPantalla>(
                    "sp_RolesPantallasListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en ListarAsync: {ex.Message}");
                return Enumerable.Empty<RolPantalla>();
            }
        }

        public async Task<int> ConteoAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();

                return await connection.QueryFirstOrDefaultAsync<int>(
                    "sp_RolesPantallasConteo",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en ConteoAsync: {ex.Message}");
                return 0;
            }
        }
    }
}
