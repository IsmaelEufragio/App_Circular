using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using System;
using System.Collections;
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
        public async Task<IEnumerable<PaisDTO>> GetPaisAsync()
        {
            var paises = await _paisRepository.GetAllAsync();
            return paises.Select(pais => new PaisDTO { 
                Id = pais.pais_Id,
                Name = pais.pais_Nombre
            }).ToList();
        }

        public async Task<PaisDTO?> GetPaisByIdAsync(Guid id)
        {
            var pais = await _paisRepository.GetByIdAsync(id);
            
            return pais == null ? null : new PaisDTO { Id = id, Name =pais.pais_Nombre };
        }

        public IEnumerable<PaisDTO> GetPaisData()
        {
            return _paisRepository.GetAllQuery().Select(a=> new PaisDTO
            {
                Id = a.pais_Id,
                Name = a.pais_Nombre
            }).AsQueryable();
        }
    }
}
