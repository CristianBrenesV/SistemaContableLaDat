namespace SistemaContableLaDat.Service.Abstract
{
    public interface IEncriptadoService
    {
        (byte[] ciphertext, byte[] tag, byte[] nonce) Encriptar(byte[] plaintext);
        (byte[] ciphertext, byte[] tag, byte[] nonce) EncriptarInput(byte[] plaintext);
        string Desencriptar(byte[] ciphertext, byte[] tag, byte[] nonce);
        bool VerificarClave(byte[] ClaveCifrada, byte[] tagDb, byte[] nonceDb, string inputClave);
    }
}