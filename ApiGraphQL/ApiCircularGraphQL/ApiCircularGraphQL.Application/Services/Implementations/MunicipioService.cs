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
    public class MunicipioService : IMunicipioService
    {
        private readonly IMunicipalityRepository _municipioRepository;
        public MunicipioService(IMunicipalityRepository municipioRepository)
        {
            _municipioRepository = municipioRepository;
        }

        public async Task<IEnumerable<MunicipioDTO>> GetMunicipios()
        {
            var muni = await _municipioRepository.GetAllAsync();

            return muni.Select(a => new MunicipioDTO
            {
                Id = a.muni_Id,
                Descripcion = a.muni_Nombre
            });
        }

        public async Task<Dictionary<Guid, MunicipioDTO[]>> GetMunicipiosPorDepartamento(IReadOnlyList<Guid> ids)
        {
            var data = await _municipioRepository.MunicipiosPorDepartamentoAsync(ids);
            if (data is null)
                return ids.ToDictionary(k => k, v => Array.Empty<MunicipioDTO>());

            var dataDto = data.ToDictionary(k => k.Key, v => v.Value.Select(a => new MunicipioDTO
            {
                Id = a.muni_Id,
                Descripcion = a.muni_Nombre
            }).ToArray());

            return dataDto;
        }
    }
}
