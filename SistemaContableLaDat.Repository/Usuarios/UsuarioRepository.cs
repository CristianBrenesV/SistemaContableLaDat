using Dapper;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

namespace SistemaContableLaDat.Repository.Usuarios
{
    public class UsuarioRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public UsuarioRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }


        public async Task<IEnumerable<UsuarioEntity>> GetAllAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                return await connection.QueryAsync<UsuarioEntity>(
                    "sp_UsuariosListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync: {ex.Message}");
                return Enumerable.Empty<UsuarioEntity>(); // Retorna lista vacía en caso de error
            }
        }

        public async Task<UsuarioEntity?> GetByIdAsync(string id)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_usuario", id, DbType.String);

                return await connection.QuerySingleOrDefaultAsync<UsuarioEntity>(
                    "sp_UsuariosListarPorIdUsuario",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetByIdAsync: {ex.Message}");
                return null; // Retorna `null` en caso de error
            }
        }

        public async Task<int> InsertAsync(UsuarioEntity usuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_usuario", usuario.Usuario);
                parametros.Add("pI_clave_cifrada", usuario.ClaveCifrada, DbType.Binary);
                parametros.Add("pI_nombre_usuario", usuario.NombreUsuario);
                parametros.Add("pI_apellido_usuario", usuario.ApellidoUsuario);
                parametros.Add("pI_correo_electronico", usuario.CorreoElectronico);
                parametros.Add("pI_tag", usuario.TagAutenticacion, DbType.Binary);
                parametros.Add("pI_nonce", usuario.Nonce, DbType.Binary);
                parametros.Add("pI_estado", usuario.Estado.ToString());
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_UsuariosInsertar", parametros, commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado"); // 1 si éxito, 0 si error
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync: {ex.Message}");
                return 0; // Retorna `0` en caso de error
            }
        }

        public async Task<int> UpdateAsync(UsuarioEntity usuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_usuario", usuario.Usuario);
                parametros.Add("pI_clave_cifrada", usuario.ClaveCifrada, DbType.Binary);
                parametros.Add("pI_nombre_usuario", usuario.NombreUsuario);
                parametros.Add("pI_apellido_usuario", usuario.ApellidoUsuario);
                parametros.Add("pI_correo_electronico", usuario.CorreoElectronico);
                parametros.Add("pI_tag", usuario.TagAutenticacion, DbType.Binary);
                parametros.Add("pI_nonce", usuario.Nonce, DbType.Binary);
                parametros.Add("pI_estado", usuario.Estado.ToString());
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_UsuariosActualizarPorIdUsuario", parametros, commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync: {ex.Message}");
                return 0; // Retorna `0` en caso de error
            }
        }

        public async Task<int> DeleteAsync(string id_usuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_usuario", id_usuario);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("eliminar_usuario_por_id", parameters, commandType: CommandType.StoredProcedure);
                return parameters.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync: {ex.Message}");
                return 0; // Retorna `0` en caso de error
            }
        }

        public async Task<IEnumerable<UsuarioEntity>> GetUsuariosPaginadosAsync(int pagina, int tamanoPagina)
        {
            using var connection = _dbConnectionFactory.CreateConnection();

            var parameters = new DynamicParameters();
            parameters.Add("p_Limite", tamanoPagina);
            parameters.Add("p_Offset", (pagina - 1) * tamanoPagina);

            return await connection.QueryAsync<UsuarioEntity>(
                "sp_UsuariosListar10",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }


        public async Task<int> CuentaUsuariosAsync()
        {
            using var connection = _dbConnectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "sp_UsuariosConteo"
            );
        }

    }
}

