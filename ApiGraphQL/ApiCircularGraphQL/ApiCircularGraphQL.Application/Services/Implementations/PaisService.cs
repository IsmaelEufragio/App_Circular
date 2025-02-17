using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class PaisService : IPaisService
    {
        private readonly IPaisRepository _paisRepository;
        public PaisService(IPaisRepository paisRepository)
        {
            _paisRepository = paisRepository;
        }
        public async Task<IEnumerable<tbPais>> GetPaisAsync()
        {
            return await _paisRepository.GetAllAsync();
        }

        public async Task<tbPais?> GetPaisByIdAsync(Guid id)
        {
            return await _paisRepository.GetByIdAsync(id);
        }
    }
}
