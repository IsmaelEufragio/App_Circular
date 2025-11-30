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
    public class LugarService : ILugarService
    {
        private readonly ILugarRepository _lugarRepository;
        public LugarService(ILugarRepository lugarRepository)
        {
            _lugarRepository = lugarRepository;
        }

        public async Task<IEnumerable<LugarDTO>> GetLugarsAsync()
        {
            var lug = await _lugarRepository.GetAllAsync();
            return lug.Select(a => new LugarDTO
            {
                Id = a.lug_Id,
                Descripcion = a.lug_Nombre
            });
        }

        public async Task<Dictionary<Guid, LugarDTO[]>> GetLugarPorMunicipio(IReadOnlyList<Guid> ids)
        {
            var data = await _lugarRepository.LugarPorMunicipio(ids);
            if (data is null)
                return ids.ToDictionary(k => k, v => Array.Empty<LugarDTO>());

            var dataDTO = data.ToDictionary(k => k.Key, v => v.Value.Select(a => new LugarDTO
            {
                Id = a.lug_Id,
                Descripcion = a.lug_Nombre
            }).ToArray());

            return dataDTO;
        }
    }
}
