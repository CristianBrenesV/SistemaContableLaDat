using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MySqlConnector;

namespace SistemaContableLaDat.Pages
{
    public class TestConnectionModel : PageModel
    {
        private readonly IConfiguration _config;

        public string Message { get; set; }

        public TestConnectionModel(IConfiguration config)
        {
            _config = config;
        }

        public async Task OnGet()
        {
            using var conn = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            try
            {
                await conn.OpenAsync();
                Message = "Conexión abierta OK";
            }
            catch (Exception ex)
            {
                Message = "Error al abrir conexión: " + ex.Message;
            }
        }
    }
}
