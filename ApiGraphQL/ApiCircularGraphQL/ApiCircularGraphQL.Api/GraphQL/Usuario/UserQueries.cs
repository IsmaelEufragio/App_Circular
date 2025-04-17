using ApiCircularGraphQL.Api.GraphQL.Usuario.Types;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using GreenDonut.Data;
using HotChocolate.Execution.Processing;
using HotChocolate.Types.Pagination;

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
            return UsuarioService.GetUsuarioQuery().OrderBy(a=> a.Id);
        }
        
        public static async Task<IEnumerable<UserPrincipalType>> GetUserAll(
            [Service] IUserService UsuarioService
            //PagingArguments pagingArguments,
            //ISelection selection
        )
        {
            var data = await UsuarioService.GetUsuarioAll();
            return data.Select(a => new UserPrincipalType
            {
                Id = a.Id,
                Nombre = a.Nombre,
                RutaDelLogo = a.RutaDelLogo,
                RutaDeLaPaginaWeb = a.RutaDeLaPaginaWeb,
                UnicoUsuario = a.UnicoUsuario,
                IdTipoUsuario = a.IdTipoUsuario 
            });
        }
    }
}
