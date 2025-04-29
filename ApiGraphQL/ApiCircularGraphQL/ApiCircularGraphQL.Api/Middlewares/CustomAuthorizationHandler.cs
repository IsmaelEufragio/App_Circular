using ApiCircularGraphQL.CrossCutting.Helpers;
using HotChocolate.Authorization;
using HotChocolate.Resolvers;
using System.Security.Claims;

namespace ApiCircularGraphQL.Api.Middlewares
{
    public class CustomAuthorizationHandler : IAuthorizationHandler
    {
        private readonly IConfiguration _configuration;

        public CustomAuthorizationHandler(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public ValueTask<AuthorizeResult> AuthorizeAsync(IMiddlewareContext context, AuthorizeDirective directive, CancellationToken cancellationToken = default)
        {
            if (context.ContextData.TryGetValue("HttpContext", out var httpContextObj) && httpContextObj is HttpContext httpContext)
            {
                if (httpContext.Request.Headers.TryGetValue("Authorization", out var authHeader))
                {
                    var token = authHeader.ToString().Replace("Bearer ", ""); // Validar el token menual mente
                    bool isTokenValid = JwtHelper.ValidateToken(token, _configuration);
                    if (!isTokenValid)
                    {
                        return new ValueTask<AuthorizeResult>(AuthorizeResult.NotAllowed);
                    }
                    if (directive.Roles is not null && directive.Roles.Count > 0)
                    {
                        var userRoles = JwtHelper.GetRolesFromToken(token);
                        bool hasRequiredRole = directive.Roles.Any(role => userRoles.Contains(role));

                        if (!hasRequiredRole)
                        {
                            return new ValueTask<AuthorizeResult>(AuthorizeResult.NotAllowed);
                        }
                    }
                    else
                    {
                        var userRoles = JwtHelper.GetRolesFromToken(token);
                        if(userRoles is not null && userRoles.Contains("Varificar"))
                            return new ValueTask<AuthorizeResult>(AuthorizeResult.NotAllowed);
                    }

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
