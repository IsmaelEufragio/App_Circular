using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Implementations;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Entities;

namespace ApiCircularGraphQL.Api.GraphQL.Queries
{
    [ExtendObjectType("Query")]
    public class PaisQuery
    {
        public string getHolaMundoDesdePais => "Hola mundo XD";


        //public async Task<IEnumerable<tbPais>> getPaisAll()
        //{
        //    return await _paisService.GetPaisAsync();
        //}
        [UsePaging(IncludeTotalCount = true, DefaultPageSize = 10)]
        [UseFiltering]
        [UseSorting]
        public IEnumerable<PaisDTO> GetPaises([Service] IPaisService paisService)
        {
            return paisService.GetPaisData();
        }


        public async Task<PaisDTO?> GetPaisById([Service] IPaisService paisService, Guid id)
        {
            return await paisService.GetPaisByIdAsync(id);
        }
    }
}
