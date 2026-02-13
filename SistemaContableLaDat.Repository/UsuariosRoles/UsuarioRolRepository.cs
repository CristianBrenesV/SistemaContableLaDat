using Dapper;
using SistemaContableLaDat.Entities.UsuariosRoles;
using SistemaContableLaDat.Repository.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace SistemaContableLaDat.Repository.UsuariosRoles
{
    public class UsuarioRolRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public UsuarioRolRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<IEnumerable<UsuarioRol>> GetRolesByUsuarioAsync(int idUsuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_usuario", idUsuario, DbType.Int32);

                return await connection.QueryAsync<UsuarioRol>(
                    "sp_UsuariosRolesListarRolesPorIdUsuario",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetRolesByUsuarioAsync: {ex.Message}");
                return Enumerable.Empty<UsuarioRol>();
            }
        }

        public async Task<int> InsertAsync(int idUsuario, string idRol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_usuario", idUsuario);
                parameters.Add("pI_id_rol", idRol);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_UsuariosRolesInsertar",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync (UsuarioRol): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(int idUsuario, string idRol)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();

                parameters.Add("pI_id_usuario", idUsuario);
                parameters.Add("pI_id_rol", idRol);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_UsuariosRolesEliminarPorIdUsuarioIdRol",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync (UsuarioRol): {ex.Message}");
                return 0;
            }
        }
    }
}