using Dapper;
using SistemaContableLaDat.Entities.Cuentas;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

namespace SistemaContableLaDat.Repository.Cuentas
{
    public class CuentaRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public CuentaRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        /// <summary>
        /// Retorna solo cuentas que aceptan movimiento (para asientos)
        /// </summary>
        public IEnumerable<CuentaComboDto> ListarCuentasMovimiento()
        {
            using var cn = _connectionFactory.CreateConnection();

            // CAMBIADO A SP - Necesitaríamos crear este SP también
            return cn.Query<CuentaComboDto>(
                "sp_cuentas_listar_movimiento",
                commandType: CommandType.StoredProcedure
            );
        }
    }
}