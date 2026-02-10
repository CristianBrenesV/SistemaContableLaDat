using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Repository.Asientos;
using SistemaContableLaDat.Service.Abstract;
using System.Transactions;
using SistemaContableLaDat.Entities.Cuentas;

namespace SistemaContableLaDat.Service.Asientos
{
    public class AsientoService
    {
        private readonly AsientoRepository _repo;
        private readonly IBitacoraService _bitacora;

        public AsientoService(
            AsientoRepository repo,
            IBitacoraService bitacora)
        {
            _repo = repo;
            _bitacora = bitacora;
        }

        public async Task<IEnumerable<AsientoListadoDto>> ListarPorPeriodoAsync(int idPeriodo, int idUsuario, int? idEstado = null)
        {
            await _bitacora.RegistrarConsultaAsync(
                idUsuario.ToString(),
                "Asientos por Periodo",
                new
                {
                    IdPeriodo = idPeriodo,
                    IdEstado = idEstado,
                    Detalle = "Consulta de asientos por filtro de periodo"
                }
            );

            return await _repo.ListarPorPeriodoAsync(idPeriodo, idEstado);
        }

        public async Task<IEnumerable<AsientoDetalleDto>> ObtenerDetalleAsync(int idAsiento)
        {
            return await _repo.ListarDetalleAsync(idAsiento);
        }

        public async Task<int> CrearAsync(
            AsientoEncabezadoEntity encabezado,
            List<AsientoDetalleEntity> detalles,
            int idUsuario)
        {
            ValidarAsiento(detalles);

            encabezado.IdUsuario = idUsuario;
            if (encabezado.IdPeriodo <= 0) throw new Exception("Debe especificar un periodo válido.");

            decimal debe = detalles.Where(d => d.TipoMovimiento == "D").Sum(d => d.Monto);
            decimal haber = detalles.Where(d => d.TipoMovimiento == "C").Sum(d => d.Monto);

            encabezado.IdEstadoAsiento = (debe == haber && debe > 0)
                    ? (int)EstadoAsiento.PendienteAprobar
                    : (int)EstadoAsiento.Borrador;

            using var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled);

            int idAsiento = _repo.InsertarEncabezado(encabezado);

            foreach (var d in detalles)
            {
                d.IdAsiento = idAsiento;
                _repo.InsertarDetalle(d);
            }

            await _bitacora.RegistrarCreacionAsync(
                idUsuario.ToString(),
                "Asiento Contable",
                new
                {
                    IdAsiento = idAsiento,
                    Encabezado = encabezado,
                    Detalles = detalles,
                    FechaOperacion = DateTime.Now
                }
            );

            scope.Complete();
            return idAsiento;
        }

        public async Task EditarAsync(
            AsientoEncabezadoEntity encabezado,
            List<AsientoDetalleEntity> detalles,
            int idUsuario)
        {
            ValidarAsiento(detalles);

            var actual = _repo.ObtenerPorId(encabezado.IdAsiento)
                ?? throw new Exception("El asiento no existe.");

            // Validar que el estado permita edición
            if (actual.IdEstadoAsiento == (int)EstadoAsiento.Aprobado ||
                actual.IdEstadoAsiento == (int)EstadoAsiento.Anulado)
                throw new Exception($"No se puede editar un asiento en estado {actual.EstadoNombre}");

            // Captura de estado anterior para la bitácora
            var detallesAnteriores = _repo.ObtenerDetallesPorAsiento(encabezado.IdAsiento);

            decimal debe = detalles.Where(d => d.TipoMovimiento == "D").Sum(d => d.Monto);
            decimal haber = detalles.Where(d => d.TipoMovimiento == "C").Sum(d => d.Monto);

            encabezado.IdEstadoAsiento = (debe == haber && debe > 0)
                    ? (int)EstadoAsiento.PendienteAprobar
                    : (int)EstadoAsiento.Borrador;

            using var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled);

            _repo.ActualizarEncabezado(encabezado);
            _repo.EliminarDetalles(encabezado.IdAsiento); 

            foreach (var d in detalles)
            {
                d.IdAsiento = encabezado.IdAsiento;
                _repo.InsertarDetalle(d);
            }

            await _bitacora.RegistrarActualizacionAsync(
                idUsuario.ToString(),
                "Asiento Contable",
                new { Antes = new { Encabezado = actual, Detalles = detallesAnteriores } },
                new { Despues = new { Encabezado = encabezado, Detalles = detalles } }
            );

            scope.Complete();
        }

        public async Task<AsientoEncabezadoEntity?> ObtenerParaEdicionAsync(int idAsiento)
        {
            var encabezado = _repo.ObtenerPorId(idAsiento);

            if (encabezado != null)
            {
                encabezado.Detalles = _repo.ObtenerDetallesPorAsiento(idAsiento).ToList();
            }

            return encabezado;
        }

        public async Task<IEnumerable<CuentaComboDto>> ObtenerCuentasParaComboAsync()
        {
            return await _repo.ListarCuentasParaComboAsync();
        }

        public async Task AnularAsync(int idAsiento, int idUsuario)
        {
            var asiento = _repo.ObtenerPorId(idAsiento)
                ?? throw new Exception("El asiento no existe.");

            if (asiento.IdEstadoAsiento == (int)EstadoAsiento.Anulado)
                throw new Exception("El asiento ya se encuentra anulado.");

            _repo.Anular(idAsiento);

            await _bitacora.RegistrarEliminacionAsync(
                idUsuario.ToString(),
                "Asiento Contable",
                new
                {
                    IdAsiento = idAsiento,
                    Codigo = asiento.Codigo,
                    Motivo = "Anulación manual por el usuario",
                    FechaAnulacion = DateTime.Now
                }
            );
        }

        public async Task<(IEnumerable<AsientoListadoDto> Asientos, int Total)> ListarConFiltroAsync(
            AsientoFiltroDto filtro, int idUsuario)
        {
            var asientos = await _repo.ListarConFiltroAsync(filtro);
            var total = await _repo.ContarConFiltroAsync(filtro);

            return (asientos, total);
        }

        public async Task<bool> CambiarEstadoAsync(int idAsiento, int idEstadoNuevo, int idUsuario)
        {
            var asiento = await _repo.ObtenerConEstadoAsync(idAsiento);
            if (asiento == null) throw new Exception("Asiento no encontrado");

            if (!ValidarCambioEstado(asiento.IdEstadoAsiento, idEstadoNuevo))
                throw new Exception("El flujo de cambio de estado solicitado no es válido.");

            var resultado = await _repo.CambiarEstadoAsync(idAsiento, idEstadoNuevo, idUsuario);

            if (resultado)
            {
                await _bitacora.RegistrarAccionAsync(
                    idUsuario.ToString(),
                    "Cambio de Estado Asiento",
                    new { IdAsiento = idAsiento, De = asiento.IdEstadoAsiento, A = idEstadoNuevo }
                );
            }

            return resultado;
        }

        private bool ValidarCambioEstado(int estadoActual, int estadoNuevo)
        {
            if (estadoActual == (int)EstadoAsiento.Anulado || estadoActual == (int)EstadoAsiento.Borrador)
                return false;

            return estadoActual switch
            {
                (int)EstadoAsiento.PendienteAprobar =>
                    estadoNuevo == (int)EstadoAsiento.Anulado ||
                    estadoNuevo == (int)EstadoAsiento.Aprobado ||
                    estadoNuevo == (int)EstadoAsiento.Rechazado,

                (int)EstadoAsiento.Aprobado =>
                    estadoNuevo == (int)EstadoAsiento.PendienteAprobar ||
                    estadoNuevo == (int)EstadoAsiento.Anulado,

                (int)EstadoAsiento.Rechazado =>
                    estadoNuevo == (int)EstadoAsiento.PendienteAprobar,

                _ => false
            };
        }

        public async Task<Dictionary<string, string>> ObtenerEstadosPermitidosAsync(int idAsiento)
        {
            var asiento = await _repo.ObtenerConEstadoAsync(idAsiento);
            var estadosPermitidos = new Dictionary<string, string>();

            if (asiento == null) return estadosPermitidos;

            switch (asiento.IdEstadoAsiento)
            {
                case (int)EstadoAsiento.PendienteAprobar:
                    estadosPermitidos.Add("Aprobar", ((int)EstadoAsiento.Aprobado).ToString());
                    estadosPermitidos.Add("Rechazar", ((int)EstadoAsiento.Rechazado).ToString());
                    estadosPermitidos.Add("Anular", ((int)EstadoAsiento.Anulado).ToString());
                    break;

                case (int)EstadoAsiento.Aprobado:
                    estadosPermitidos.Add("Reversar Aprobación", ((int)EstadoAsiento.PendienteAprobar).ToString());
                    estadosPermitidos.Add("Anular", ((int)EstadoAsiento.Anulado).ToString());
                    break;

                case (int)EstadoAsiento.Rechazado:
                    estadosPermitidos.Add("Reversar Rechazo", ((int)EstadoAsiento.PendienteAprobar).ToString());
                    break;
            }

            return estadosPermitidos;
        }

        private void ValidarAsiento(List<AsientoDetalleEntity> detalles)
        {
            if (detalles == null || !detalles.Any())
                throw new Exception("El asiento debe tener al menos una línea de detalle.");

            if (detalles.Any(d => d.IdCuentaContable <= 0))
                throw new Exception("Todas las líneas deben tener una cuenta contable asignada.");

            if (detalles.Any(d => d.Monto <= 0))
                throw new Exception("Los montos en las líneas deben ser mayores a cero.");

            if (!detalles.Any(d => d.TipoMovimiento == "D") || !detalles.Any(d => d.TipoMovimiento == "C"))
                throw new Exception("El asiento debe contener al menos un Débito y un Crédito.");
        }

        public async Task<IEnumerable<PeriodoComboDto>> ObtenerPeriodosParaComboAsync()
        {
            return await _repo.ListarPeriodosParaComboAsync();
        }
        public async Task<int> ObtenerSiguienteConsecutivoAsync()
        {
            return await _repo.ObtenerSiguienteConsecutivoAsync();
        }

    }
}