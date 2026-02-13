using SistemaContableLaDat.Service.Abstract;
using System.Security.Cryptography;
using System.Text;

namespace SistemaContableLaDat.Service.Encriptado
{
    public class EncriptadoService : IEncriptadoService
    {
        private readonly ISeguridadService _seguridadService;
        private readonly byte[] _key;
        private const int NonceSize = 12; // estándar en GCM
        private const int TagSize = 16;   // 128 bits

        public EncriptadoService(ISeguridadService seguridadService)
        {
            _seguridadService = seguridadService;
            _key = _seguridadService.GetLlaveEncriptacion();
        }

        public (byte[] ciphertext, byte[] tag, byte[] nonce) Encriptar(byte[] plaintext)
        {
            byte[] nonce = new byte[NonceSize];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(nonce);

            byte[] ciphertext = new byte[plaintext.Length];
            byte[] tag = new byte[TagSize];

            using var aesGcm = new AesGcm(_key, tagSizeInBytes: TagSize);
            aesGcm.Encrypt(nonce, plaintext, ciphertext, tag);

            return (ciphertext, tag, nonce);
        }

        public (byte[] ciphertext, byte[] tag, byte[] nonce) EncriptarInput(byte[] plaintext)
        {
            byte[] nonce = new byte[NonceSize];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(nonce);

            byte[] ciphertext = new byte[plaintext.Length];
            byte[] tag = new byte[TagSize];

            using var aesGcm = new AesGcm(_key, tagSizeInBytes: TagSize);
            aesGcm.Encrypt(nonce, plaintext, ciphertext, tag);

            return (ciphertext, tag, nonce);
        }

        public string Desencriptar(byte[] ciphertext, byte[] tag, byte[] nonce)
        {
            byte[] plaintext = new byte[ciphertext.Length];

            using var aesGcm = new AesGcm(_key, tagSizeInBytes: TagSize);
            aesGcm.Decrypt(nonce, ciphertext, tag, plaintext);

            return Encoding.UTF8.GetString(plaintext);
        }
        public bool VerificarClave(byte[] ClaveCifrada, byte[] tagDb, byte[] nonceDb, string inputClave)
        {
            try
            {
                byte[] inputTextoPlano = Encoding.UTF8.GetBytes(inputClave);
                byte[] inputTextoCifrado = new byte[inputTextoPlano.Length];
                byte[] inputTag = new byte[TagSize];

                using var aesGcm = new AesGcm(_key, tagSizeInBytes: TagSize);
                aesGcm.Encrypt(nonceDb, inputTextoPlano, inputTextoCifrado, inputTag);

                return CryptographicOperations.FixedTimeEquals(ClaveCifrada, inputTextoCifrado) &&
                       CryptographicOperations.FixedTimeEquals(tagDb, inputTag);
            }
            catch
            {
                return false;
            }
        }

    }
}
