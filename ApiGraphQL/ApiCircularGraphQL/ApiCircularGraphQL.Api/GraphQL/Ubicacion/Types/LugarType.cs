using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Domain.Entities;

namespace ApiCircularGraphQL.Api.GraphQL.Ubicacion.Types
{
    [ObjectType<LugarDTO>]
    public static partial class LugarType
    {
        public static async Task<List<SubdivicionLugarDTO>> GetColonias(
            [Parent] LugarDTO lugarDTO,
            ISubdivicionPorLugarDataLoader subdivicionPorLugarDataLoader,
            CancellationToken cancellationToken
        )
        {
            var data = await subdivicionPorLugarDataLoader.LoadAsync(lugarDTO.Id, CancellationToken.None);
            return data is null
                ? throw new GraphQLException($"No se encontraron colonia con Id Lugar {lugarDTO.Id}")
                : [..data];
        }
    }
}
