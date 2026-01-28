using Microsoft.Extensions.Configuration;
using SistemaContableLaDat.Service.Abstract;
using System;
using System.Text;

namespace SistemaContableLaDat.Service.Seguridad
{
    public class SeguridadService : ISeguridadService
    {
        private readonly IConfiguration _configuration;

        public SeguridadService(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public byte[] GetLlaveEncriptacion()
        {
            // Retrieve the encryption key from the configuration file
            string key = _configuration["Security:EncryptionKey"];
            return Encoding.UTF8.GetBytes(key); 
        }
    }
}
