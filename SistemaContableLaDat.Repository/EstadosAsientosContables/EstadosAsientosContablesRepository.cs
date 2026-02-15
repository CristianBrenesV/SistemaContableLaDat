using Dapper; 
using SistemaContableLaDat.Entities.EstadosAsientosContables;
using SistemaContableLaDat.Repository.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaContableLaDat.Repository.EstadosAsientosContables
{
    public class EstadoAsientoContableRepository
    {
        private readonly IDbConnectionFactory _dbConnectionFactory;

        public EstadoAsientoContableRepository(IDbConnectionFactory dbConnectionFactory)
        {
            _dbConnectionFactory = dbConnectionFactory;
        }

        public async Task<IEnumerable<EstadosAsientoContable>> GetAllAsync()
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                return await connection.QueryAsync<EstadosAsientoContable>(
                    "sp_EstadoAsientoContableListar",
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetAllAsync: {ex.Message}");
                return Enumerable.Empty<EstadosAsientoContable>();
            }
        }

        public async Task<EstadosAsientoContable?> GetByIdAsync(int idEstadoAsiento)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("pI_IdEstadoAsiento", idEstadoAsiento, DbType.Int32);

                return await connection.QuerySingleOrDefaultAsync<EstadosAsientoContable>(
                    "sp_EstadoAsientoContableListarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetByIdAsync: {ex.Message}");
                return null;
            }
        }

        public async Task<int> InsertAsync(EstadosAsientoContable estado)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_Codigo", estado.Codigo);
                parametros.Add("pI_Nombre", estado.Nombre);
                parametros.Add("pI_Descripcion", estado.Descripcion);
                parametros.Add("pI_Estado", estado.Estado.ToString());

                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);
                parametros.Add("pS_IdEstado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_EstadoAsientoContableInsertar", parametros, commandType: CommandType.StoredProcedure);

                estado.IdEstadoAsiento = parametros.Get<int>("pS_IdEstado");

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en InsertAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> UpdateAsync(EstadosAsientoContable estado)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();

                parametros.Add("pI_IdEstado", estado.IdEstadoAsiento);
                parametros.Add("pI_Codigo", estado.Codigo);
                parametros.Add("pI_Nombre", estado.Nombre);
                parametros.Add("pI_Descripcion", estado.Descripcion);
                parametros.Add("pI_Estado", estado.Estado.ToString());

                parametros.Add("pS_resultado", dbType: DbType.Int32, direction: ParameterDirection.Output);

                await connection.ExecuteAsync("sp_EstadoAsientoContableActualizarPorId", parametros, commandType: CommandType.StoredProcedure);

                return parametros.Get<int>("pS_resultado");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en UpdateAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<int> DeleteAsync(int idEstadoAsiento)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("pI_IdEstadoAsiento", idEstadoAsiento);

                await connection.ExecuteAsync(
                    "sp_EstadoAsientoContableEliminarPorId",
                    parametros,
                    commandType: CommandType.StoredProcedure);

                return 1; 
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en DeleteAsync: {ex.Message}");
                return 0;
            }
        }

        public async Task<IEnumerable<EstadosAsientoContable>> GetPaginadoAsync(int pagina, int tamanoPagina)
        {
            try
            {
                using var connection = _dbConnectionFactory.CreateConnection();
                var parametros = new DynamicParameters();
                parametros.Add("p_Limite", tamanoPagina);
                parametros.Add("p_Offset", (pagina - 1) * tamanoPagina);

                return await connection.QueryAsync<EstadosAsientoContable>(
                    "sp_EstadoAsientoContableListar10",
                    parametros,
                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en GetPaginadoAsync: {ex.Message}");
                return Enumerable.Empty<EstadosAsientoContable>();
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
                    "sp_EstadoAsientoContableConteo",
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