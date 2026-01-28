using System.Data;

namespace SistemaContableLaDat.Repository.Infrastructure
{
    public interface IDbConnectionFactory
    {
        IDbConnection CreateConnection();
    }
}
