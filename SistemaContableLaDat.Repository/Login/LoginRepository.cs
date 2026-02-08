using Dapper;
using System.Data;
using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Infrastructure;

namespace SistemaContableLaDat.Repository.Login
{
    public class LoginRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public LoginRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public UsuarioEntity? VerificarUsuario(string nombreUsuario)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(nombreUsuario))
                    throw new ArgumentException("Nombre de usuario inválido", nameof(nombreUsuario));

                using var connection = _dbConnectionFactory.CreateConnection();
                connection.Open();
                Console.WriteLine(connection.Database);
                var parameters = new DynamicParameters();
                parameters.Add("@pI_usuario", nombreUsuario, DbType.String, ParameterDirection.Input);

                // Ahora usamos QueryFirstOrDefault porque el SP devuelve un SELECT
                var usuario = connection.QueryFirstOrDefault<UsuarioEntity>(
                    "sp_VerificarCredencial",
                    parameters,
                    commandType: CommandType.StoredProcedure
                );

                return usuario;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en VerificarUsuario: {ex.Message}");
                return null;
            }
        }

        public void RegistrarIntentoFallido(string nombreUsuario)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(nombreUsuario))
                    throw new ArgumentException("Nombre de usuario inválido", nameof(nombreUsuario));

                using var connection = _dbConnectionFactory.CreateConnection();
                connection.Open();

                var parameters = new DynamicParameters();
                parameters.Add("pI_usuario", nombreUsuario, DbType.String, ParameterDirection.Input);
                parameters.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("sp_RegistrarIntentoFallido", parameters, commandType: CommandType.StoredProcedure);

                int resultado = parameters.Get<int>("pS_resultado");

                Console.WriteLine($"Resultado bitácora: {resultado}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en RegistrarIntentoFallido: {ex.Message}");
            }
        }


        public void ReiniciarIntentos(string nombreUsuario)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(nombreUsuario))
                    throw new ArgumentException("Nombre de usuario inválido", nameof(nombreUsuario));

                using var connection = _dbConnectionFactory.CreateConnection();
                connection.Open();

                var parameters = new DynamicParameters();
                parameters.Add("pI_usuario", nombreUsuario, DbType.String, ParameterDirection.Input);

                connection.Execute("sp_ReiniciarIntentos", parameters, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en ReiniciarIntentos: {ex.Message}");
            }
        }
    }
}
