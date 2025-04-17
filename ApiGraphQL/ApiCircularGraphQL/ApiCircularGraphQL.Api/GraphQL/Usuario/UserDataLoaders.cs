using ApiCircularGraphQL.Api.GraphQL.Usuario.Types;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using GreenDonut.Data;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario
{
    public static class UserDataLoaders
    {
        [DataLoader]//Trea el Tipo de usuario por UsuarioPrincipal
        public static async Task<IReadOnlyDictionary<Guid, TipoUsuarioDTO>> TipoUsuarioByIdAsync(
            IReadOnlyList<Guid> ids,
            CancellationToken cancellationToken,
            IUserService userService
        )
        {
            IEnumerable<TipoUsuarioDTO> tipos = await userService.GetManyByIds(ids);
            return tipos
                .Where(i => i != null && !ids.Contains(Guid.Empty))
                .GroupBy(i => i.Id)
                .ToDictionary(g => g.Key, g => g.First());
        }

        [DataLoader]//Trae Todos los usuario por UsuarioPrincipal
        public static async Task<IReadOnlyDictionary<Guid, UserDTO[]>> UsuarioByUserPrincipalIdAsync(
        IReadOnlyList<Guid> userPrincipalIds,
        CancellationToken cancellationToken,
        IUserService userService
        )
        {
            var allUsers = await userService.GetUsuariosByPrincipals(userPrincipalIds);
            return allUsers
                .GroupBy(u => u.IdUserPrincipal)
                .ToDictionary(g => g.Key, g => g.ToArray());
        }
        [DataLoader]//Trea el tipo Identidad.
        public static async Task<IReadOnlyDictionary<Guid, TipoIdentidadDTO>> IdentidadPorUsuarioAsync(
            IReadOnlyList<Guid> ids,
            CancellationToken cancellationToken,
            IUserService userService
        )
        {
            IEnumerable<TipoIdentidadDTO> tipos = await userService.GetIdentidadPorByIds(ids);
            return tipos
                .Where(i => i != null && !ids.Contains(Guid.Empty))
                .GroupBy(i => i.IdTipoIdentidad)
                .ToDictionary(g => g.Key, g => g.First());
        }

        [DataLoader]
        public static async Task<IReadOnlyDictionary<Guid, TelefonosUsuarioDTO[]>> TelefonosPorUsuariosAsync(
            IReadOnlyList<Guid> ids,
            CancellationToken cancellationToken,
            IUserService userService
        )
        {
            var allTelefonos = await userService.GetTelefonosPorUsuario(ids);
            return allTelefonos
                .GroupBy(u => u.IdUsuario)
                .ToDictionary(g => g.Key, g => g.ToArray());
        }

        [DataLoader]
        public static async Task<IReadOnlyDictionary<Guid, HorarioDTO[]>> HorarioPorUsuario(
            IReadOnlyList<Guid> ids,
            CancellationToken cancellationToken,
            IUserService userService
        )
        {
            var allHorarios = await userService.GetHorarioPorUsuario(ids);
            return allHorarios
                .GroupBy(g => g.IdUsuario)
                .ToDictionary(g => g.Key, g => g.ToArray());
        }
    }
}
