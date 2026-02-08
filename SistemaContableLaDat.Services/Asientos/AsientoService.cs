using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Repository.Asientos;
using SistemaContableLaDat.Service.Abstract;
using System.Transactions;

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
            await _bitacora.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Consulta de asientos",
                new { idPeriodo }
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

            await _bitacora.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Creación de asiento",
                new { encabezado, detalles }
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

            await _bitacora.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Edición de asiento",
                new { Antes = antes, Despues = new { encabezado, detalles } }
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

        public async Task AnularAsync(int idAsiento, int idUsuario)
        {
            var asiento = _repo.ObtenerPorId(idAsiento)
                ?? throw new Exception("Asiento no existe.");

            if (asiento.IdEstadoAsiento != (int)EstadoAsiento.Borrador &&
                asiento.IdEstadoAsiento != (int)EstadoAsiento.PendienteAprobar)
                throw new Exception("Estado no anulable.");

            if (_repo.TieneRelaciones(idAsiento))
                throw new Exception("No se puede eliminar un registro con datos relacionados.");

            _repo.Anular(idAsiento);

            await _bitacora.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Anulación de asiento",
                new { idAsiento }
            );
        }
    }
}
