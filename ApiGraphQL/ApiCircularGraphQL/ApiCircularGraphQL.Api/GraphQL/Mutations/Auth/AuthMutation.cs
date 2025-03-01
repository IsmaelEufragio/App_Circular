using ApiCircularGraphQL.Application.Services.Interfaces;

namespace ApiCircularGraphQL.Api.GraphQL.Mutations.Auth
{
    [ExtendObjectType(typeof(Mutation))]
    public class AuthMutation
    {
        private readonly IAuthService _authService;

        public AuthMutation(IAuthService authService)
        {
            _authService = authService;
        }

        public string Login(string username, string password)
        {
            var token = _authService.Authenticate(username, password);
            if (token == null)
            {
                throw new GraphQLException("Credenciales inválidas.");
            }

            return token;
        }
    }
}
