using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class SubdivicionLugarService : ISubdivicionLugarService
    {
        private readonly ISubdivicionLugarRepository _subdivicionLugarRepository;
        public SubdivicionLugarService(ISubdivicionLugarRepository subdivicionLugarRepository)
        {
            _subdivicionLugarRepository = subdivicionLugarRepository;
        }

        public async Task<IEnumerable<SubdivicionLugarDTO>> GetSubdivicionLugarAsync()
        {
            var sub = await _subdivicionLugarRepository.GetAllAsync();
            return sub.Select(a => new SubdivicionLugarDTO
            {
                Id = a.subLug_Id,
                Nombre = a.subLug_Nombre,
            });
        }

        public async Task<Dictionary<Guid, SubdivicionLugarDTO[]>> GetSubdivicionPorLugar(IReadOnlyList<Guid> idsLugar)
        {
            var data = await _subdivicionLugarRepository.SubdivicionLugarPorUbicacion(idsLugar);
            if (data is null)
                return idsLugar.ToDictionary(k => k, v => Array.Empty<SubdivicionLugarDTO>());

            var dataDto = data.ToDictionary(k => k.Key, v => v.Value.Select(a => new SubdivicionLugarDTO
            {
                Id = a.subLug_Id,
                Nombre = a.subLug_Nombre,
            }).ToArray());

            return dataDto;
        }
    }
}
