using ApiCircularGraphQL.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Domain.Interfaces
{
    public interface IPaisRepository : IRepository<tbPais>
    {
        Task<List<tbPais>> GetPedidosByPaisIdAsync(Guid idPais);
    }
}
