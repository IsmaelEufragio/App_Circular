using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;

namespace ApiCircularGraphQL.Api.GraphQL.Ubicacion
{
    [QueryType]
    public static class UbicacionQueries
    {
        public static async Task<IEnumerable<MunicipioDTO>> Municipios([Service] IMunicipioService municipioService)
        {
            return await municipioService.GetMunicipios();
        }
        public static async Task<IEnumerable<DepartamentoDTO>> Departamentos([Service] IDepartamentoService departamentoService)
        {
            return await departamentoService.GetDepartamentosAsync();
        }
    }
}
