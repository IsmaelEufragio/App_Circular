using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;

namespace ApiCircularGraphQL.Api.GraphQL.Ubicacion
{
    public static class UbicacionDataLoaders
    {
        [DataLoader]
        public static async Task<IReadOnlyDictionary<Guid, MunicipioDTO[]>> MunicipioPorDepartamento(
            IReadOnlyList<Guid> idsDepartamento,
            IMunicipioService municipioService,
            CancellationToken cancellationToken
        )
        {
            var data = await municipioService.GetMunicipiosPorDepartamento(idsDepartamento);
            return data;
        }

        [DataLoader]
        public static async Task<IReadOnlyDictionary<Guid, LugarDTO[]>> LugarPorMunicipio(
            IReadOnlyList<Guid> idsMunicipio,
            ILugarService lugarService,
            CancellationToken cancellationToken
        )
        {
            var data = await lugarService.GetLugarPorMunicipio(idsMunicipio);
            return data;
        }
    }
}
