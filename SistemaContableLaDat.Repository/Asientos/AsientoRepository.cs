using Dapper;
using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Entities.Cuentas;
using SistemaContableLaDat.Repository.Infrastructure;
using System.Data;

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

        public async Task<IEnumerable<AsientoDetalleDto>> ListarDetalleAsync(int idAsiento)
        {
            using var conn = _connectionFactory.CreateConnection();
            return await conn.QueryAsync<AsientoDetalleDto>(
                "sp_asiento_listar_detalle",
                new { p_id_asiento = idAsiento },
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
            cn.Execute(
                "DELETE FROM asientocontabledetalle WHERE IdAsiento = @id",
                new { id = idAsiento }
            );
        }

        public bool TieneRelaciones(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
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
        public async Task<IEnumerable<CuentaComboDto>> ListarCuentasParaComboAsync()
        {
            using var cn = _connectionFactory.CreateConnection();

            string sql = @"SELECT IdCuenta AS IdCuentaContable, 
                          Nombre AS Descripcion 
                   FROM cuentascontables
                   WHERE Estado = 'Activa' 
                   ORDER BY CodigoCuenta";

            return await cn.QueryAsync<CuentaComboDto>(sql);
        }

        public async Task<IEnumerable<AsientoListadoDto>> ListarConFiltroAsync(AsientoFiltroDto filtro)
        {
            using var cn = _connectionFactory.CreateConnection();

            var parameters = new
            {
                p_id_periodo = filtro.IdPeriodo,
                p_id_estado = filtro.IdEstado,
                p_offset = (filtro.Pagina - 1) * filtro.ItemsPorPagina,
                p_limit = filtro.ItemsPorPagina
            };

            return await cn.QueryAsync<AsientoListadoDto>(
                "sp_asientos_listar_filtro",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<int> ContarConFiltroAsync(AsientoFiltroDto filtro)
        {
            using var cn = _connectionFactory.CreateConnection();

            var parameters = new
            {
                p_id_periodo = filtro.IdPeriodo,
                p_id_estado = filtro.IdEstado
            };

            return await cn.ExecuteScalarAsync<int>(
                "sp_asientos_contar_filtro",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<bool> CambiarEstadoAsync(int idAsiento, int idEstadoNuevo, int idUsuario)
        {
            using var cn = _connectionFactory.CreateConnection();

            var parameters = new
            {
                p_id_asiento = idAsiento,
                p_id_estado_nuevo = idEstadoNuevo,
                p_id_usuario = idUsuario
            };

            var affectedRows = await cn.ExecuteAsync(
                "sp_asiento_cambiar_estado",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return affectedRows > 0;
        }

        public async Task<AsientoEncabezadoEntity?> ObtenerConEstadoAsync(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();

            var asiento = await cn.QueryFirstOrDefaultAsync<AsientoEncabezadoEntity>(
                @"SELECT a.*, e.Nombre as NombreEstado 
          FROM asientocontableencabezado a
          INNER JOIN estadoasientocontable e ON a.IdEstadoAsiento = e.IdEstadoAsiento
          WHERE a.IdAsiento = @id",
                new { id = idAsiento }
            );

            if (asiento != null)
            {
                asiento.Detalles = (await ObtenerDetallesPorAsientoAsync(idAsiento)).ToList();
            }

            return asiento;
        }

        private async Task<IEnumerable<AsientoDetalleEntity>> ObtenerDetallesPorAsientoAsync(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();

            return await cn.QueryAsync<AsientoDetalleEntity>(
                @"SELECT * FROM asientocontabledetalle 
          WHERE IdAsiento = @id 
          ORDER BY IdAsientoDetalle",
                new { id = idAsiento }
            );
        }

    }
}