using Dapper;
using SistemaContableLaDat.Entities.CuentasContables;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

namespace SistemaContableLaDat.Repository.CuentasContables
{
    public class CuentasContablesRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public CuentasContablesRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<IEnumerable<CuentaContable>> GetAllAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                return await connection.QueryAsync<CuentaContable>(
                    "sp_CuentasContablesListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync: {ex.Message}");
                return Enumerable.Empty<CuentaContable>();
            }
        }

        public async Task<CuentaContable?> GetByIdAsync(int idCuenta)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parameters = new DynamicParameters();
                parameters.Add("pI_IdCuenta", idCuenta, DbType.Int32);

                return await connection.QuerySingleOrDefaultAsync<CuentaContable>(
                    "sp_CuentasContablesListarPorIdCuenta",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetByIdAsync: {ex.Message}");
                return null;
            }
        }

        public async Task<int> InsertAsync(CuentaContable cuentacontable)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_CodigoCuenta", cuentacontable.CodigoCuenta);
                parametros.Add("pI_Nombre", cuentacontable.Nombre);
                parametros.Add("pI_Tipo", cuentacontable.Tipo);
                parametros.Add("pI_CuentaPadre", cuentacontable.CuentaPadre);
                parametros.Add("pI_TipoSaldo", cuentacontable.TipoSaldo);
                parametros.Add("pI_AceptaMovimiento", cuentacontable.AceptaMovimiento);
                parametros.Add("pI_Estado", cuentacontable.Estado);

                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);
                parametros.Add("pS_IdCuenta", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_CuentasContablesInsertar", parametros, commandType: CommandType.StoredProcedure);

                cuentacontable.IdCuenta = parametros.Get<int>("pS_IdCuenta");

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> UpdateAsync(CuentaContable cuentacontable)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_IdCuenta", cuentacontable.IdCuenta);
                parametros.Add("pI_CodigoCuenta", cuentacontable.CodigoCuenta);
                parametros.Add("pI_Nombre", cuentacontable.Nombre);
                parametros.Add("pI_Tipo", cuentacontable.Tipo);
                parametros.Add("pI_CuentaPadre", cuentacontable.CuentaPadre);
                parametros.Add("pI_TipoSaldo", cuentacontable.TipoSaldo);
                parametros.Add("pI_AceptaMovimiento", cuentacontable.AceptaMovimiento);
                parametros.Add("pI_Estado", cuentacontable.Estado);

                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);
                parametros.Add("pS_IdCuenta", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_CuentasContablesActualizarPorIdCuenta", parametros, commandType: CommandType.StoredProcedure);

                cuentacontable.IdCuenta = parametros.Get<int>("pS_IdCuenta");

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(int idCuenta)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("pI_IdCuenta", idCuenta);
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_CuentasContablesEliminarPorIdCuenta", parametros, commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<IEnumerable<CuentaContable>> GetPaginadoAsync(int pagina, int tamanoPagina)
        {
            using var connection = _dbConnectionFactory.CreateConnection();
            var parametros = new DynamicParameters();
            parametros.Add("p_Limite", tamanoPagina);
            parametros.Add("p_Offset", (pagina - 1) * tamanoPagina);

            return await connection.QueryAsync<CuentaContable>(
                "sp_CuentasContablesListar10",
                parametros,
                commandType: CommandType.StoredProcedure);
        }

        public async Task<int> CountAsync()
        {
            using var connection = _dbConnectionFactory.CreateConnection();
            return await connection.ExecuteScalarAsync<int>("sp_CuentasContables_Count", commandType: CommandType.StoredProcedure);
        }
    }
}