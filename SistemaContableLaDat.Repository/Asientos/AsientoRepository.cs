using Dapper;
using System.Data;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Repository.Infrastructure;

namespace SistemaContableLaDat.Repository.Asientos
{
    public class AsientoRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public AsientoRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public IEnumerable<AsientoListadoDto> ListarPorPeriodo(int idPeriodo)
        {
            using var connection = _connectionFactory.CreateConnection();
            return connection.Query<AsientoListadoDto>(
                "sp_asientos_listar_por_periodo",
                new { p_id_periodo = idPeriodo },
                commandType: CommandType.StoredProcedure
            );
        }

        public int InsertarEncabezado(AsientoEncabezadoEntity asiento)
        {
            using var connection = _connectionFactory.CreateConnection();

            return connection.ExecuteScalar<int>(
                "sp_asiento_insertar_encabezado",
                new
                {
                    p_id_periodo = asiento.IdPeriodo,
                    p_id_usuario = asiento.IdUsuario,
                    p_fecha = asiento.FechaAsiento,
                    p_referencia = asiento.Referencia
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public void InsertarDetalle(AsientoDetalleEntity detalle)
        {
            using var connection = _connectionFactory.CreateConnection();

            connection.Execute(
                "sp_asiento_insertar_detalle",
                new
                {
                    p_id_asiento = detalle.IdAsientoEncabezado,
                    p_id_cuenta = detalle.IdCuentaContable,
                    p_tipo_mov = detalle.TipoMovimiento,
                    p_monto = detalle.Monto,
                    p_descripcion = detalle.Descripcion
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public void Anular(int idAsiento)
        {
            using var connection = _connectionFactory.CreateConnection();

            connection.Execute(
                "sp_asiento_anular",
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
