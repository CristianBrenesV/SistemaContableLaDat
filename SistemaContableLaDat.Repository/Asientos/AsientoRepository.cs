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
            using var cn = _connectionFactory.CreateConnection();
            return cn.Query<AsientoListadoDto>(
                "sp_asientos_listar_por_periodo",
                new { p_id_periodo = idPeriodo },
                commandType: CommandType.StoredProcedure
            );
        }

        public AsientoEncabezadoEntity? ObtenerPorId(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            return cn.QueryFirstOrDefault<AsientoEncabezadoEntity>(
                "SELECT * FROM asientocontableencabezado WHERE IdAsiento = @id",
                new { id = idAsiento }
            );
        }

        public int InsertarEncabezado(AsientoEncabezadoEntity e)
        {
            using var cn = _connectionFactory.CreateConnection();

            var p = new DynamicParameters();
            p.Add("p_id_periodo", e.IdPeriodo);
            p.Add("p_id_usuario", e.IdUsuario);
            p.Add("p_fecha", e.Fecha);
            p.Add("p_codigo", e.Codigo);
            p.Add("p_referencia", e.Referencia);
            p.Add("p_id_estado", e.IdEstadoAsiento);
            p.Add("p_id_asiento", dbType: DbType.Int32, direction: ParameterDirection.Output);

            cn.Execute(
                "sp_asiento_insertar_encabezado",
                p,
                commandType: CommandType.StoredProcedure
            );

            return p.Get<int>("p_id_asiento");
        }




        public void InsertarDetalle(AsientoDetalleEntity d)
        {
            using var cn = _connectionFactory.CreateConnection(); // 🔴 AQUÍ

            cn.Execute(
                "sp_asiento_insertar_detalle",
                new
                {
                    p_id_asiento = d.IdAsiento,
                    p_id_cuenta = d.IdCuentaContable,
                    p_tipo_mov = d.TipoMovimiento,
                    p_monto = d.Monto,
                    p_descripcion = d.Descripcion
                },
                commandType: CommandType.StoredProcedure
            );
        }




        public void ActualizarEncabezado(AsientoEncabezadoEntity a)
        {
            using var cn = _connectionFactory.CreateConnection();
            cn.Execute(
                @"UPDATE asientocontableencabezado
                  SET Fecha = @Fecha,
                      Referencia = @Referencia,
                      IdEstadoAsiento = @IdEstadoAsiento,
                      Codigo = @Codigo,   
                      Consecutivo = @Consecutivo 
                  WHERE IdAsiento = @IdAsiento",
                a
            );
        }

        public IEnumerable<AsientoDetalleEntity> ObtenerDetallesPorAsiento(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();

            return cn.Query<AsientoDetalleEntity>(
                @"SELECT 
            IdAsientoDetalle,
            IdAsiento AS IdAsiento,
            IdCuentaContable,
            TipoMovimiento,
            Monto,
            Descripcion
          FROM asientocontabledetalle
          WHERE IdAsiento = @id",
                new { id = idAsiento }
            );
        }


        public void EliminarDetalles(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            // Adaptado a tabla real: asientocontabledetalle
            cn.Execute(
                "DELETE FROM asientocontabledetalle WHERE IdAsiento = @id",
                new { id = idAsiento }
            );
        }

        public bool TieneRelaciones(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            // Adaptado a tabla real: asientocontabledetalle
            int count = cn.ExecuteScalar<int>(
                "SELECT COUNT(*) FROM asientocontabledetalle WHERE IdAsiento = @id",
                new { id = idAsiento}
            );
            return count > 0;
        }

        public void Anular(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            cn.Execute(
                "sp_asiento_anular",
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}