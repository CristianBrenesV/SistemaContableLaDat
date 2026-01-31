using SistemaContableLaDat.Entities.Asientos;
using SistemaContableLaDat.Repository.Asientos;
using SistemaContableLaDat.Service.Bitacora;
using System.Transactions;

namespace SistemaContableLaDat.Service.Asientos
{
    public class AsientoService
    {
        private readonly AsientoRepository _asientoRepository;
        private readonly BitacoraService _bitacoraService;

        public AsientoService(
            AsientoRepository asientoRepository,
            BitacoraService bitacoraService)
        {
            _asientoRepository = asientoRepository;
            _bitacoraService = bitacoraService;
        }

        public async Task<IEnumerable<AsientoListadoDto>> ListarPorPeriodoAsync(
            int idPeriodo,
            int idUsuario)
        {
            await _bitacoraService.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Consulta de asientos por periodo",
                new { idPeriodo }
            );

            return _asientoRepository.ListarPorPeriodo(idPeriodo);
        }

        public async Task<int> CrearAsientoAsync(
            AsientoEncabezadoEntity encabezado,
            List<AsientoDetalleEntity> detalles,
            int idUsuario)
        {
            if (!detalles.Any())
                throw new Exception("El asiento debe tener detalles.");

            decimal debe = detalles.Where(x => x.TipoMovimiento == "D").Sum(x => x.Monto);
            decimal haber = detalles.Where(x => x.TipoMovimiento == "C").Sum(x => x.Monto);

            encabezado.IdEstadoAsiento =
                debe == haber
                    ? (int)EstadoAsiento.PendienteAprobar
                    : (int)EstadoAsiento.Borrador;

            using var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled);

            int idAsiento = _asientoRepository.InsertarEncabezado(encabezado);

            foreach (var d in detalles)
            {
                d.IdAsientoEncabezado = idAsiento;
                _asientoRepository.InsertarDetalle(d);
            }

            await _bitacoraService.RegistrarAccionAsync(
                idUsuario.ToString(),
                "Creación de asiento contable",
                new { encabezado, detalles }
            );

            scope.Complete();
            return idAsiento;
        }
    }
}
