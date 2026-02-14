using Dapper;
using SistemaContableLaDat.Entities.PeriodosContables;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

namespace SistemaContableLaDat.Repository.PeriodosContables
{
    public class PeriodoContableRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public PeriodoContableRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<IEnumerable<PeriodoContable>> GetAllAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                return await connection.QueryAsync<PeriodoContable>(
                    "sp_PeriodoContableListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync: {ex.Message}");
                return Enumerable.Empty<PeriodoContable>();
            }
        }

        public async Task<PeriodoContable?> GetByIdAsync(int idPeriodo)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("pI_IdPeriodo", idPeriodo, DbType.Int32);

                return await connection.QuerySingleOrDefaultAsync<PeriodoContable>(
                    "sp_PeriodoContableListarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetByIdAsync: {ex.Message}");
                return null;
            }
        }

        public async Task<int> InsertAsync(PeriodoContable periodo)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_Anio", periodo.Anio);
                parametros.Add("pI_Mes", periodo.Mes);
                parametros.Add("pI_Estado", periodo.Estado);
                parametros.Add("pI_IdUsuarioCierre", periodo.IdUsuarioCierre);
                parametros.Add("pI_FechaCierre", periodo.FechaCierre);

                await connection.ExecuteAsync(
                    "sp_PeriodoContableInsertar",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return 1; // Retorna 1 si se insertó correctamente
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> UpdateAsync(PeriodoContable periodo)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_IdPeriodo", periodo.IdPeriodo);
                parametros.Add("pI_Anio", periodo.Anio);
                parametros.Add("pI_Mes", periodo.Mes);
                parametros.Add("pI_Estado", periodo.Estado);
                parametros.Add("pI_IdUsuarioCierre", periodo.IdUsuarioCierre);
                parametros.Add("pI_FechaCierre", periodo.FechaCierre);

                await connection.ExecuteAsync(
                    "sp_PeriodoContableActualizarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return 1; // Retorna 1 si se actualizó correctamente
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(int idPeriodo)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("pI_IdPeriodo", idPeriodo);

                await connection.ExecuteAsync(
                    "sp_PeriodoContableEliminarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return 1; // Retorna 1 si se eliminó correctamente
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<IEnumerable<PeriodoContable>> GetPaginadoAsync(int pagina, int tamanoPagina)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("p_Limite", tamanoPagina);
                parametros.Add("p_Offset", (pagina - 1) * tamanoPagina);

                return await connection.QueryAsync<PeriodoContable>(
                    "sp_PeriodoContableListar10",
                    parametros,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetPaginadoAsync: {ex.Message}");
                return Enumerable.Empty<PeriodoContable>();
            }
        }

        public async Task<int> CountAsync(string? estado = null)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("pI_Estado", estado);

                return await connection.ExecuteScalarAsync<int>(
                    "sp_PeriodoContableConteo",
                    parametros,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en CountAsync: {ex.Message}");
                return 0;
            }
        }
    }
}