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

        public async Task<UsuarioEntity?> GetByIdAsync(int id)
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
                parametros.Add("pS_idUsuario", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_UsuariosInsertar", parametros, commandType: CommandType.StoredProcedure);

                usuario.IdUsuario = parametros.Get<int>("pS_idUsuario");// Guarda el ID generado en el objeto

                return parametros.Get<int>("pS_resultado");// Retorna 1 si éxito
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync: {ex.Message}");
                return 0;
            }
        }


        public async Task<int> UpdateAsync(UsuarioEntity usuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_id_usuario", usuario.IdUsuario);       
                parametros.Add("pI_usuario", usuario.Usuario);
                parametros.Add("pI_nombre_usuario", usuario.NombreUsuario);
                parametros.Add("pI_apellido_usuario", usuario.ApellidoUsuario);
                parametros.Add("pI_correo_electronico", usuario.CorreoElectronico);
                parametros.Add("pI_estado", usuario.Estado.ToString());

                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);
                parametros.Add("pS_idUsuario", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_UsuariosActualizarPorIdUsuario", parametros, commandType: CommandType.StoredProcedure);

                usuario.IdUsuario = parametros.Get<int>("pS_idUsuario"); 

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync: {ex.Message}");
                return 0;
            }
        }


        public async Task<int> DeleteAsync(int idUsuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_id_usuario", idUsuario);
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
        public async Task<int> CambiarClaveAsync(int idUsuario, byte[] claveCifrada, byte[] tag, byte[] nonce)
        {
            using var connection = _dbConnectionFactory.CreateConnection();
            var parameters = new DynamicParameters();
            parameters.Add("p_IdUsuario", idUsuario);
            parameters.Add("p_ClaveCifrada", claveCifrada, DbType.Binary);
            parameters.Add("p_Tag", tag, DbType.Binary);
            parameters.Add("p_Nonce", nonce, DbType.Binary);

            return await connection.ExecuteAsync("sp_CambiarClaveUsuario", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<int> CambiarEstadoAsync(int idUsuario, string nuevoEstado)
        {
            using var connection = _dbConnectionFactory.CreateConnection();
            var parameters = new DynamicParameters();

            parameters.Add("p_IdUsuario", idUsuario, DbType.Int32);
            parameters.Add("p_NuevoEstado", nuevoEstado, DbType.String);

            return await connection.ExecuteAsync(
                "sp_CambiarEstadoUsuario",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}

