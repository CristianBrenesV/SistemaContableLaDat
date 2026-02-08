using SistemaContableLaDat.Entities.Usuarios;
using SistemaContableLaDat.Repository.Login;
using SistemaContableLaDat.Service.Encriptado;

namespace SistemaContableLaDat.Service.Login
{
    public class LoginService
    {
        private readonly LoginRepository _loginRepository;
        private readonly EncriptadoService _encriptadoService;

        public LoginService(LoginRepository loginRepository, EncriptadoService encriptadoService)
        {
            _loginRepository = loginRepository;
            _encriptadoService = encriptadoService;
        }

        public LoginResult Login(string usuario, string inputClave)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(usuario) || string.IsNullOrWhiteSpace(inputClave))
                    return new LoginResult { Exito = false, Mensaje = "El usuario o la contraseña no pueden estar vacíos." };

                var usuarioDb = _loginRepository.VerificarUsuario(usuario);

                if (usuarioDb == null || usuarioDb.Encontrado != 1)
                    return new LoginResult { Exito = false, Mensaje = "Usuario y/o clave incorrectos." };

                // 🔒 Si está bloqueado
                if (usuarioDb.Estado == EstadoUsuario.Bloqueado)
                    return new LoginResult { Exito = false, Mensaje = "Usuario bloqueado por múltiples intentos fallidos." };

                if (usuarioDb.ClaveCifrada == null || usuarioDb.Nonce == null || usuarioDb.TagAutenticacion == null)
                    return new LoginResult { Exito = false, Mensaje = "Datos de autenticación incompletos." };

                bool esValida = _encriptadoService.VerificarClave(
                    usuarioDb.ClaveCifrada,
                    usuarioDb.TagAutenticacion,
                    usuarioDb.Nonce,
                    inputClave
                );

                if (esValida)
                {
                    _loginRepository.ReiniciarIntentos(usuario);
                    return new LoginResult { Exito = true, Mensaje = "Login exitoso.", Usuario = usuarioDb };
                }
                else
                {
                    _loginRepository.RegistrarIntentoFallido(usuario);
                    return new LoginResult { Exito = false, Mensaje = "Usuario y/o clave incorrectos." };
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en Login: {ex.Message}");
                return new LoginResult { Exito = false, Mensaje = "Error al intentar iniciar sesión." };
            }
        }
    }
}
