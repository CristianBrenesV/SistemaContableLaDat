using Dapper;
using System.Data;
using SistemaContableLaDat.Entities.Cuentas;
using SistemaContableLaDat.Repository.Infrastructure;

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

            return cn.Query<CuentaComboDto>(
                @"SELECT 
                    IdCuenta,
                    CodigoCuenta,
                    Nombre
                  FROM cuentascontables
                  WHERE AceptaMovimiento = 1
                    AND Estado = 1
                  ORDER BY CodigoCuenta"
            );
        }
    }
}
