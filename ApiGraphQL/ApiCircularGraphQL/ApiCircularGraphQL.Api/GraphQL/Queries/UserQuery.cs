using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;
using HotChocolate.Authorization;

namespace ApiCircularGraphQL.Api.GraphQL.Queries
{
    [ExtendObjectType("Query")]
    public class UserQuery
    {
        [UsePaging(IncludeTotalCount = true, DefaultPageSize = 10)]
        [UseFiltering]
        [UseSorting]
        public IEnumerable<UserDTO> GetUser([Service] IUserService paisService)
        {
            return paisService.GetUserData();
        }

        [Authorize(Roles = ["Admin"])]
        public string MessaUser() => "Esto es necesario autenticacion";
    }
}
