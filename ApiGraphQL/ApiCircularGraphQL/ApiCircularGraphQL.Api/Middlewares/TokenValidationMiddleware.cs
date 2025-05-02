using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.Domain.Interfaces;
using HotChocolate.Resolvers;
using Microsoft.IdentityModel.Tokens;
using StackExchange.Redis;

namespace ApiCircularGraphQL.Api.Middlewares
{
    public class TokenValidationMiddleware
    {
        private readonly FieldDelegate _next;
        private readonly ITokenBlacklistRepository _tokenBlacklistRepository;
        private readonly IConfiguration _configuration;
        public TokenValidationMiddleware(FieldDelegate next,
            ITokenBlacklistRepository tokenBlacklistRepository
,
            IConfiguration configuration)
        {
            _next = next;
            _tokenBlacklistRepository = tokenBlacklistRepository;
            _configuration = configuration;
        }

        public async Task InvokeAsync(IMiddlewareContext context)
        {
            if(context != null && (context?.GetUser()?.Identity?.IsAuthenticated??false))
            {
                var tokenId = ((CaseSensitiveClaimsIdentity)context.GetUser().Identity).SecurityToken.Id.ToString();
                if(tokenId != null)
                {
                    if (await _tokenBlacklistRepository.IsTokenBlacklistedAsync(tokenId))
                    {
                        throw new TokenRevokedException("Token No valido.");
                    }
                }
            }

            await _next(context);
        }
    }
}
