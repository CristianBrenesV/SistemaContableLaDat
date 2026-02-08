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

        public async Task<IEnumerable<AsientoListadoDto>> ListarPorPeriodoAsync(int idPeriodo, int idUsuario)
        {
            await _bitacora.RegistrarConsultaAsync(
                idUsuario.ToString(),
                "Asientos por Periodo",
                new { IdPeriodo = idPeriodo }
            );

            return _repo.ListarPorPeriodo(idPeriodo);
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
            if (detalles == null || !detalles.Any())
                throw new Exception("El asiento debe tener detalle.");

            if (detalles.Any(d => d.IdCuentaContable <= 0))
                throw new Exception("Todas las líneas deben tener cuenta contable.");

            if (detalles.Any(d => d.Monto <= 0))
                throw new Exception("Monto inválido.");

            encabezado.IdUsuario = idUsuario;
            encabezado.IdPeriodo = encabezado.IdPeriodo == 0 ? 1 : encabezado.IdPeriodo;

            decimal debe = detalles.Where(d => d.TipoMovimiento == "D").Sum(d => d.Monto);
            decimal haber = detalles.Where(d => d.TipoMovimiento == "C").Sum(d => d.Monto);

            encabezado.IdEstadoAsiento =
                debe == haber
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
                    FechaCreacion = DateTime.Now
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
            if (detalles == null || !detalles.Any())
                throw new Exception("El asiento debe tener detalle.");

            if (detalles.Any(d => d.IdCuentaContable <= 0))
                throw new Exception("Todas las líneas deben tener cuenta contable.");

            var actual = _repo.ObtenerPorId(encabezado.IdAsiento)
                ?? throw new Exception("Asiento no existe.");

            if (actual.IdEstadoAsiento != (int)EstadoAsiento.Borrador &&
                actual.IdEstadoAsiento != (int)EstadoAsiento.PendienteAprobar)
                throw new Exception("Estado no editable.");

            var antes = new
            {
                Encabezado = actual,
                Detalles = _repo.ObtenerDetallesPorAsiento(encabezado.IdAsiento)
            };

            decimal debe = detalles.Where(d => d.TipoMovimiento == "D").Sum(d => d.Monto);
            decimal haber = detalles.Where(d => d.TipoMovimiento == "C").Sum(d => d.Monto);

            encabezado.IdEstadoAsiento =
                debe == haber
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
                new
                {
                    Antes = new
                    {
                        Encabezado = actual,
                        Detalles = _repo.ObtenerDetallesPorAsiento(encabezado.IdAsiento)
                    }
                },
                new
                {
                    Despues = new
                    {
                        Encabezado = encabezado,
                        Detalles = detalles
                    }
                }
            );

            scope.Complete();
        }

        public async Task<AsientoEncabezadoEntity?> ObtenerParaEdicionAsync(int idAsiento)
        {
            var encabezado = _repo.ObtenerPorId(idAsiento);

            if (encabezado != null)
            {
                encabezado.Detalles =
                    _repo.ObtenerDetallesPorAsiento(idAsiento).ToList();
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

            if (asiento.IdEstadoAsiento == 5)
                throw new Exception("El asiento ya se encuentra anulado.");

            _repo.Anular(idAsiento);

            await _bitacora.RegistrarEliminacionAsync(
                idUsuario.ToString(),
                "Asiento Contable",
                new
                {
                    IdAsiento = idAsiento,
                    Codigo = asiento.Codigo,
                    Referencia = asiento.Referencia,
                    Fecha = asiento.Fecha,
                    Motivo = "Anulación manual desde interfaz de usuario",
                    FechaAnulacion = DateTime.Now
                }
            );
        }

        public async Task<(IEnumerable<AsientoListadoDto> Asientos, int Total)> ListarConFiltroAsync(
    AsientoFiltroDto filtro, int idUsuario)
        {
            // Registrar en bitácora
            await _bitacora.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Consulta de asientos con filtro",
                filtro
            );

            var asientos = await _repo.ListarConFiltroAsync(filtro);
            var total = await _repo.ContarConFiltroAsync(filtro);

            return (asientos, total);
        }

        public async Task<bool> CambiarEstadoAsync(int idAsiento, int idEstadoNuevo, int idUsuario)
        {
            var asiento = await _repo.ObtenerConEstadoAsync(idAsiento);
            if (asiento == null)
                throw new Exception("Asiento no encontrado");

            // Validar reglas de negocio según la historia de usuario
            var puedeCambiar = ValidarCambioEstado(asiento.IdEstadoAsiento, idEstadoNuevo);
            if (!puedeCambiar)
                throw new Exception("Cambio de estado no permitido");

            // Registrar en bitácora antes del cambio
            await _bitacora.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Intento de cambio de estado de asiento",
                new
                {
                    AsientoId = idAsiento,
                    EstadoActual = asiento.IdEstadoAsiento,
                    EstadoNuevo = idEstadoNuevo,
                    Codigo = asiento.Codigo
                }
            );

            var resultado = await _repo.CambiarEstadoAsync(idAsiento, idEstadoNuevo, idUsuario);

            if (resultado)
            {
                // Registrar confirmación
                await _bitacora.RegistrarAccionAsync(
                    idUsuario.ToString(),
                    "Cambio de estado de asiento exitoso",
                    new
                    {
                        AsientoId = idAsiento,
                        EstadoActual = asiento.IdEstadoAsiento,
                        EstadoNuevo = idEstadoNuevo
                    }
                );
            }

            return resultado;
        }

        private bool ValidarCambioEstado(int estadoActual, int estadoNuevo)
        {
            // Reglas según historia de usuario
            if (estadoActual == (int)EstadoAsiento.Anulado)
                return false; // Anulado no permite ninguna acción

            if (estadoActual == (int)EstadoAsiento.Borrador)
                return false; // Borrador no permite ninguna acción

            if (estadoActual == (int)EstadoAsiento.PendienteAprobar)
            {
                // Puede ir a: Anulado, Aprobado, Rechazado
                return estadoNuevo == (int)EstadoAsiento.Anulado ||
                       estadoNuevo == (int)EstadoAsiento.Aprobado ||
                       estadoNuevo == (int)EstadoAsiento.Rechazado;
            }

            if (estadoActual == (int)EstadoAsiento.Aprobado)
            {
                // Puede ir a: PendienteAprobar (reversar), Anulado
                return estadoNuevo == (int)EstadoAsiento.PendienteAprobar ||
                       estadoNuevo == (int)EstadoAsiento.Anulado;
            }

            if (estadoActual == (int)EstadoAsiento.Rechazado)
            {
                // Solo puede reversar a PendienteAprobar
                return estadoNuevo == (int)EstadoAsiento.PendienteAprobar;
            }

            return false;
        }

        public async Task<Dictionary<string, string>> ObtenerEstadosPermitidosAsync(int idAsiento)
        {
            var asiento = await _repo.ObtenerConEstadoAsync(idAsiento);
            if (asiento == null)
                return new Dictionary<string, string>();

            var estadosPermitidos = new Dictionary<string, string>();

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

                case (int)EstadoAsiento.Borrador:
                case (int)EstadoAsiento.Anulado:
                    // No hay acciones permitidas
                    break;
            }

            return estadosPermitidos;
        }
    }
}
