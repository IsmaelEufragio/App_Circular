using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Domain.Entities;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario.Types
{
    [ObjectType<UserDTO>]
    public static partial class UserType
    {
        public static async Task<List<TelefonosUsuarioDTO>> GetTelefonos(//Telefonos Por Usuario.
            [Parent]UserDTO userDTO,
            ITelefonosPorUsuariosDataLoader telefonosPorUsuariosDataLoader,
            CancellationToken cancellationToken
        )
        {
            var data = await telefonosPorUsuariosDataLoader.LoadAsync(userDTO.Id, CancellationToken.None);
            return data is null ? throw new GraphQLException($"No se encontraron Telefonos con IdUsuarios {userDTO.Id}") : [.. data];
        }

        public static async Task<TipoIdentidadDTO> GetTipoIdentidad(
            [Parent] UserDTO userDTO,
            IIdentidadPorUsuarioDataLoader identidadPorUsuarioDataLoader,
            CancellationToken cancellationToken
        )
        {
            var data = await identidadPorUsuarioDataLoader.LoadAsync(userDTO.IdTipoIdentidad, CancellationToken.None);
            return data is null
                ? throw new GraphQLException($"No se encontró el tipo de Identificacion con ID {userDTO.IdTipoIdentidad}")
                : data;
        }

        public static async Task<List<HorarioDTO>> GetHorarios(
            [Parent] UserDTO userDTO,
            IHorarioPorUsuarioDataLoader horarioPorUsuarioDataLoader,
            CancellationToken cancellationToken
        )
        {
            var data = await horarioPorUsuarioDataLoader.LoadAsync(userDTO.Id, CancellationToken.None);
            return data is null ? throw new GraphQLException($"No se encontraron los Horarios con IdUsuarios {userDTO.Id}") : [.. data];
        }

        [BindMember(nameof(UserDTO.UsuarioRole))]
        public static async Task<List<RolDTO>> GetRolesAsync(
            [Parent(nameof(UserDTO.Id))] UserDTO userDTO,
            IRolPorUsuarioDataLoader rolPorUsuarioDataLoader
        )
        {
            var data = await rolPorUsuarioDataLoader.LoadRequiredAsync(userDTO.Id, CancellationToken.None);
            if (data is null)
                return [];

            return [.. data];
        }
    }
}
