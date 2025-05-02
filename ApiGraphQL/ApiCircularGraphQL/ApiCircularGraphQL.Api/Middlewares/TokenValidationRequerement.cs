using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components.Web;

namespace ApiCircularGraphQL.Api.Middlewares
{
    public class TokenValidationRequerement: IAuthorizationRequirement
    {
        public TokenValidationRequerement()
        {
        }
    }

    public class TokenValidationRequerementHandler : AuthorizationHandler<TokenValidationRequerement>
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly ITokenBlacklistRepository _tokenBlacklistRepository;
        private readonly IConfiguration _configuration;
        public TokenValidationRequerementHandler(IHttpContextAccessor httpContextAccessor, 
            ITokenBlacklistRepository tokenBlacklistRepository, IConfiguration configuration)
        {
            _httpContextAccessor = httpContextAccessor;
            _tokenBlacklistRepository = tokenBlacklistRepository;
            _configuration = configuration;
        }
        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, TokenValidationRequerement requirement)
        {
            var httpContext = _httpContextAccessor.HttpContext;

            if(httpContext?.Request?.Headers?.TryGetValue("Authorization", out var authHeader)?? false)
            {
                var token = authHeader.ToString().Replace("Bearer ", "");
                if(token != null)
                {
                    if(JwtHelper.ValidateToken(token, _configuration))
                    {
                        var (jti, _) = JwtHelper.GetTokenInfo(token);
                        if (await _tokenBlacklistRepository.IsTokenBlacklistedAsync(jti.ToString()))
                        {
                            return;
                        }
                    }else
                        return;
                }
            }

            context.Succeed(requirement);
            return;
            
        }
    }
}
