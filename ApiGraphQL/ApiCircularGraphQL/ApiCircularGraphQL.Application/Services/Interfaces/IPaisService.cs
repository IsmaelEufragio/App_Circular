using ApiCircularGraphQL.Application.DTOs;
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
        Task<IEnumerable<PaisDTO>> GetPaisAsync();
        Task<PaisDTO> GetPaisByIdAsync(Guid id);
        IEnumerable<PaisDTO> GetPaisData();
    }
}
