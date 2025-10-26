using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;

namespace ApiCircularGraphQL.Api.GraphQL.CategoriasNegocio
{
    [QueryType]
    public static class CategoriasNegocioQueries
    {

        public static async Task<IEnumerable<CategoriaNegociosDTO>> CategoriaNegocios(
            [Service] ICategoriaService categoriaService
        ){
            return await categoriaService.CategoriaNegociosAsync();
        }
    }
}
