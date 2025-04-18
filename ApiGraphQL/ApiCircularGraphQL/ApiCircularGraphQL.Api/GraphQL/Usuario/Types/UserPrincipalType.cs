using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using GreenDonut.Data;
using HotChocolate.Types.Pagination;
using Microsoft.Identity.Client;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario.Types
{
    [ObjectType<UserPrincipalDTO>]
    public static partial class UserPrincipalType
    {
        /*static partial void Configure(IObjectTypeDescriptor<UserPrincipalDTO> descriptor)
        {
            descriptor.Field(a => a.Usuarios)
                .UsePaging()
                .UseFiltering()
                .Cost(2000);
        }*/

        public static async Task<TipoUsuarioDTO> GetTipoUsuario( //Tiene que ser el mismo Nombre de la Propiedad agregando el Get.
            [Parent] UserPrincipalDTO usuarioPricipal,
            ITipoUsuarioByIdDataLoader tipoUsuarioByIdDataLoader,
            CancellationToken cancellationToken
        )
        {
            var data = await tipoUsuarioByIdDataLoader.LoadAsync(usuarioPricipal.IdTipoUsuario, CancellationToken.None);
            if (data is null)
                throw new GraphQLException($"No se encontró el tipo de usuario con ID {usuarioPricipal.IdTipoUsuario}");

            return data;
        }
        [UsePaging]
        [UseFiltering]
        public static async Task<Connection<UserDTO>> GetUsuarios( //Tiene que ser el mismo Nombre de la Propiedad agregando el Get.
            [Parent] UserPrincipalDTO usuarioPricipal,
            IUsuarioPorUsuarioPrincipalDataLoader usuarioPorUsuarioPrincipalDataLoader,
            PagingArguments pagingArguments,
            CancellationToken cancellationToken
        )
        {
            return await usuarioPorUsuarioPrincipalDataLoader.With(pagingArguments).LoadAsync(usuarioPricipal.Id, CancellationToken.None).ToConnectionAsync();
        }
    }
}
