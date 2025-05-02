using ApiCircularGraphQL.Api.GraphQL.Usuario.Types;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using GreenDonut.Data;
using HotChocolate.Authorization;
using HotChocolate.Execution.Processing;
using HotChocolate.Types.Pagination;
//using Microsoft.AspNetCore.Authorization;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario
{
    [QueryType]
    public static class UserQueries
    {
        public static string Message => "Error XD";

        [UsePaging]
        [UseFiltering]
        [UseSorting]
        public static IQueryable<UserDTO> GetUsuarios([Service] IUserService UsuarioService)
        {
            return UsuarioService.GetUsuarioQuery().OrderBy(a => a.Id);
        }

        [UsePaging]
        [UseFiltering]
        [UseSorting]
        [Authorize(Policy = "TokenValido")]
        public static IQueryable<UserPrincipalDTO> GetUsuariosPrincipalesAll(
            [Service] IUserService usuarioService
        )
        {
            return usuarioService.GetUsuarioPrincipalQuery()
                .OrderBy(u => u.Id);
        }
    }
}
