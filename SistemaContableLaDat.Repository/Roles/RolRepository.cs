using Dapper;
using SistemaContableLaDat.Entities.Roles;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SistemaContableLaDat.Repository.Roles
{
    public class RolRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public RolRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<IEnumerable<Rol>> GetAllAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();

                return await connection.QueryAsync<Rol>(
                    "sp_RolesListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync (Roles): {ex.Message}");
                return Enumerable.Empty<Rol>();
            }
        }

        public async Task<Rol?> GetByIdAsync(string idRol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_rol", idRol, DbType.String);

                return await connection.QuerySingleOrDefaultAsync<Rol>(
                    "sp_RolesListarPorIdRol",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetByIdAsync (Rol): {ex.Message}");
                return null;
            }
        }

        public async Task<int> InsertAsync(Rol rol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_rol", rol.IdRol);
                parameters.Add("pI_nombre_rol", rol.NombreRol);
                parameters.Add("pI_descripcion", rol.Descripcion);
                parameters.Add("pI_estado", rol.Estado.ToString());
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_RolesInsertar",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync (Rol): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> UpdateAsync(Rol rol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_rol", rol.IdRol);
                parameters.Add("pI_nombre_rol", rol.NombreRol);
                parameters.Add("pI_descripcion", rol.Descripcion);
                parameters.Add("pI_estado", rol.Estado.ToString());
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_RolesActualizarPorIdRol",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync (Rol): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(string idRol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_rol", idRol);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_RolesEliminarPorIdRol",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync (Rol): {ex.Message}");
                return 0;
            }
        }
        public async Task<IEnumerable<Rol>> GetRolesPaginadosAsync(int pagina, int tamanoPagina)
        {
            using var connection = _dbConnectionFactory.CreateConnection();

            var parameters = new DynamicParameters();
            parameters.Add("p_Limite", tamanoPagina);
            parameters.Add("p_Offset", (pagina - 1) * tamanoPagina);

            return await connection.QueryAsync<Rol>(
                "sp_RolesListar10",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }
        public async Task<int> CuentaRolesAsync()
        {
            using var connection = _dbConnectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "sp_RolesConteo"
            );
        }
    }
}