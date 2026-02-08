using SistemaContableLaDat.Repository.Cuentas;
using SistemaContableLaDat.Entities.Cuentas;

namespace SistemaContableLaDat.Service.Cuentas
{
    public class CuentaService
    {
        private readonly CuentaRepository _repository;

        public CuentaService(CuentaRepository repository)
        {
            _repository = repository;
        }

        public IEnumerable<CuentaComboDto> ObtenerCuentasMovimiento()
        {
            return _repository.ListarCuentasMovimiento();
        }
    }
}
