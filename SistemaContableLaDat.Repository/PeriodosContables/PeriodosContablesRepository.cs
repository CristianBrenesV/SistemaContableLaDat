using Dapper;
using SistemaContableLaDat.Entities.PeriodosContables;
using SistemaContableLaDat.Repository.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

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
                Console.WriteLine($"Error en GetAllAsync (Periodos): {ex.Message}");
                return Enumerable.Empty<PeriodoContable>();
            }
        }

        public async Task<IEnumerable<PeriodoContable>> GetAnioMesAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                return await connection.QueryAsync<PeriodoContable>(
                    "sp_PeriodoContableListarAnioMes",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync (Periodos): {ex.Message}");
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
                Console.WriteLine($"Error en GetByIdAsync (Periodo): {ex.Message}");
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
                parametros.Add("pI_Estado", periodo.Estado.ToString());
                parametros.Add("pI_IdUsuarioCierre", periodo.IdUsuarioCierre);
                parametros.Add("pI_FechaCierre", periodo.FechaCierre);
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PeriodoContableInsertar",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync (Periodo): {ex.Message}");
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
                parametros.Add("pI_Estado", periodo.Estado.ToString());
                parametros.Add("pI_IdUsuarioCierre", periodo.IdUsuarioCierre);
                parametros.Add("pI_FechaCierre", periodo.FechaCierre);
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PeriodoContableActualizarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync (Periodo): {ex.Message}");
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
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PeriodoContableEliminarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync (Periodo): {ex.Message}");
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
                Console.WriteLine($"Error en GetPaginadoAsync (Periodo): {ex.Message}");
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
                Console.WriteLine($"Error en CountAsync (Periodo): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> CerrarPeriodoAsync(int idPeriodo, int idUsuario)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("p_IdPeriodo", idPeriodo, DbType.Int32);
                parametros.Add("p_IdUsuario", idUsuario, DbType.Int32);
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PeriodoCerrar",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en CerrarPeriodoAsync (Periodo): {ex.Message}");
                return 0;
            }
        }

        public async Task<int> ReabrirPeriodoAsync(int idPeriodo)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("p_IdPeriodo", idPeriodo, DbType.Int32);
                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync(
                    "sp_PeriodoReabrir",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en ReabrirPeriodoAsync (Periodo): {ex.Message}");
                return 0;
            }
        }
    }
}
