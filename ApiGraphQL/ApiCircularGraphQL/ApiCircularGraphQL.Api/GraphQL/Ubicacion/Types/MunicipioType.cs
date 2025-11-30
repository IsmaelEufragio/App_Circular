using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Domain.Entities;

namespace ApiCircularGraphQL.Api.GraphQL.Ubicacion.Types
{
    [ObjectType<MunicipioDTO>]
    public static partial class MunicipioType
    {
        public static async Task<List<LugarDTO>> GetLugares(
            [Parent] MunicipioDTO municipio,
            ILugarPorMunicipioDataLoader dataLoader,
            CancellationToken cancellation
        )
        {
            var data = await dataLoader.LoadAsync(municipio.Id, CancellationToken.None);
            return data is null
                ? throw new GraphQLException($"No se encontraron un Lugar con el IdMunicipio {municipio.Id}")
                : [.. data];
        }
    }
}
