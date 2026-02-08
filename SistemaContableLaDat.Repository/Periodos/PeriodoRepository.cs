using System.Data;
using Dapper;
using SistemaContableLaDat.Entities.Periodos;
using SistemaContableLaDat.Repository.Infrastructure;

namespace SistemaContableLaDat.Repository.Periodos
{
    public class PeriodoRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public PeriodoRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<PeriodoContable>> ObtenerTodosAsync()
        {
            using var cn = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM periodocontable ORDER BY Anio DESC, Mes DESC";
            return await cn.QueryAsync<PeriodoContable>(sql);
        }

        public async Task<PeriodoContable?> ObtenerActivoAsync()
        {
            using var cn = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM periodocontable WHERE Estado = 'Abierto' LIMIT 1";
            return await cn.QueryFirstOrDefaultAsync<PeriodoContable>(sql);
        }
    }
}