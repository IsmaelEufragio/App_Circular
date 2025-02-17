using ApiCircularGraphQL.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IPaisService
    {
        Task<IEnumerable<tbPais>> GetPaisAsync();
        Task<tbPais> GetPaisByIdAsync(Guid id);
    }
}
