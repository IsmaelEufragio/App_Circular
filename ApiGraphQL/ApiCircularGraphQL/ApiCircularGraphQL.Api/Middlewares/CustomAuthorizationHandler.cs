using HotChocolate.Authorization;
using HotChocolate.Resolvers;
using System.Security.Claims;

namespace ApiCircularGraphQL.Api.Middlewares
{
    public class CustomAuthorizationHandler : IAuthorizationHandler
    {

        public ValueTask<AuthorizeResult> AuthorizeAsync(IMiddlewareContext context, AuthorizeDirective directive, CancellationToken cancellationToken = default)
        {
            if (context.ContextData.TryGetValue("HttpContext", out var httpContextObj) && httpContextObj is HttpContext httpContext)
            {
                // Obtén el encabezado "Authorization"
                if (httpContext.Request.Headers.TryGetValue("Authorization", out var authHeader))
                {
                    var token = authHeader.ToString().Replace("Bearer ", ""); // Validar el token menual mente
                    return new ValueTask<AuthorizeResult>(AuthorizeResult.Allowed);
                }
                else
                {
                    return new ValueTask<AuthorizeResult>(AuthorizeResult.NotAuthenticated);
                }
            }
            else
            {
                return new ValueTask<AuthorizeResult>(AuthorizeResult.NotAllowed);
            }
        }

        public ValueTask<AuthorizeResult> AuthorizeAsync(AuthorizationContext context, IReadOnlyList<AuthorizeDirective> directives, CancellationToken cancellationToken = default)
        {
            throw new NotImplementedException();
        }
    }
}
