using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.DTOs.Usuarios;

namespace ApiCircularGraphQL.Api.GraphQL.Ubicacion.Types
{
    [ObjectType<DepartamentoDTO>]
    public static partial class DepartamentoType
    {
        public static async Task<List<MunicipioDTO>> GetMunicipios(
            [Parent] DepartamentoDTO departamento,
            IMunicipioPorDepartamentoDataLoader dataLoader,
            CancellationToken cancellation
        )
        {
            var data = await dataLoader.LoadAsync(departamento.Id, CancellationToken.None);
            return data is null
                ? throw new GraphQLException($"No se encontraron municipios con el ID {departamento.Id}")
                : [.. data];
        }
    }
}
