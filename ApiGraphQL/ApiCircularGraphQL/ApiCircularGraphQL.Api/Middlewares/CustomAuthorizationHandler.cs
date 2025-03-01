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
                    var token = authHeader.ToString().Replace("Bearer ", ""); // Extrae el token JWT
                    Console.WriteLine($"Token recibido: {token}"); // Imprime el token en la consola (para depuración)
                }
                else
                {
                    Console.WriteLine("No se encontró el encabezado Authorization.");
                }
            }
            else
            {
                Console.WriteLine("No se pudo acceder al HttpContext.");
            }

            // Lógica personalizada de autorización
            if (context.ContextData.TryGetValue("User", out var user) && user is ClaimsPrincipal principal)
            {
                if (principal.IsInRole("Admin"))
                {
                    return new ValueTask<AuthorizeResult>(AuthorizeResult.Allowed);
                }
            }

            return new ValueTask<AuthorizeResult>(AuthorizeResult.NotAllowed);
        }

        public ValueTask<AuthorizeResult> AuthorizeAsync(AuthorizationContext context, IReadOnlyList<AuthorizeDirective> directives, CancellationToken cancellationToken = default)
        {
            throw new NotImplementedException();
        }
    }
}
