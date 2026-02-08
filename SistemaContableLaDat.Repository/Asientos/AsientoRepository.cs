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

        public async Task<IEnumerable<AsientoListadoDto>> ListarPorPeriodoAsync(
            int idPeriodo, int? idEstado = null)
        {
            using var cn = _connectionFactory.CreateConnection();

            return await cn.QueryAsync<AsientoListadoDto>(
                "sp_asientos_listar_por_periodo",
                new
                {
                    p_id_periodo = idPeriodo,
                    p_id_estado = idEstado
                },
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
                "sp_asiento_obtener_por_id",  // CAMBIADO A SP
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
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
            using var cn = _connectionFactory.CreateConnection();

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
                "sp_asiento_actualizar_encabezado",  // CAMBIADO A SP
                new
                {
                    p_id_asiento = a.IdAsiento,
                    p_fecha = a.Fecha,
                    p_referencia = a.Referencia,
                    p_id_estado_asiento = a.IdEstadoAsiento,
                    p_codigo = a.Codigo,
                    p_consecutivo = a.Consecutivo
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public IEnumerable<AsientoDetalleEntity> ObtenerDetallesPorAsiento(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            return cn.Query<AsientoDetalleEntity>(
                "sp_asiento_obtener_detalles",  // CAMBIADO A SP
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
            );
        }

        public void EliminarDetalles(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            cn.Execute(
                "sp_asiento_eliminar_detalles",  // CAMBIADO A SP
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
            );
        }

        public bool TieneRelaciones(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            var parameters = new DynamicParameters();
            parameters.Add("p_id_asiento", idAsiento);
            parameters.Add("p_tiene_relaciones", dbType: DbType.Boolean, direction: ParameterDirection.Output);

            cn.Execute(
                "sp_asiento_tiene_relaciones",  // CAMBIADO A SP
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return parameters.Get<bool>("p_tiene_relaciones");
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
            return await cn.QueryAsync<CuentaComboDto>(
                "sp_cuentas_listar_para_combo",  // CAMBIADO A SP
                commandType: CommandType.StoredProcedure
            );
        }

        // NUEVOS MÉTODOS PARA APROBACIÓN (ya en SP)
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
                "sp_asiento_obtener_por_id",
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
            );

            if (asiento != null)
            {
                // Obtener detalles también por SP
                asiento.Detalles = (await ObtenerDetallesPorAsientoAsync(idAsiento)).ToList();
            }

            return asiento;
        }

        private async Task<IEnumerable<AsientoDetalleEntity>> ObtenerDetallesPorAsientoAsync(int idAsiento)
        {
            using var cn = _connectionFactory.CreateConnection();
            return await cn.QueryAsync<AsientoDetalleEntity>(
                "sp_asiento_obtener_detalles",
                new { p_id_asiento = idAsiento },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}