using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario.Types
{
    public class UserPrincipalType
    {
        public Guid Id { get; set; }
        public bool UnicoUsuario { get; set; }
        public string Nombre { get; set; }
        public string RutaDelLogo { get; set; }
        public string RutaDeLaPaginaWeb { get; set; }
        public Guid IdTipoUsuario { get; set; }
        [GraphQLNonNullType]
        public  async Task<TipoUserType> TipoUsuario([Service] ITipoUsuarioByIdDataLoader tipoUsuarioByIdDataLoader) {
            var data = await tipoUsuarioByIdDataLoader.LoadAsync(IdTipoUsuario,CancellationToken.None);
            if (data is null)
                throw new GraphQLException($"No se encontró el tipo de usuario con ID {IdTipoUsuario}");
            
            return new TipoUserType() { 
                Descripcion = data.Descripcion
            };
        }
        [GraphQLNonNullType]
        public async Task<IEnumerable<UserType>> Usuarios([Service] IUsuarioByUserPrincipalIdDataLoader usuarioByUserPrincipalIdDataLoader)
        {
            var data = await usuarioByUserPrincipalIdDataLoader.LoadAsync(Id, CancellationToken.None);
            if (data is null)
                throw new GraphQLException($"No se encontraron Usuarios con Id {Id}");

            return data.Select(a => new UserType { 
                Id = a.Id,
                NombreUsuario = a.NombreUsuario,
                Despcripcion = a.Despcripcion,
                Correo = a.Correo,
                Identidad = a.Identidad,
                Envio = a.Envio,
                Fecebook = a.Fecebook,
                FechaCreacion = a.FechaCreacion,
                UsuarioPrincipal = a.UsuarioPrincipal,
                IdTipoIdentidad = a.IdTipoIdentidad
            });
        }
    }
}
