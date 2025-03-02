using ApiCircularGraphQL.Api.Middlewares;
using HotChocolate.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace ApiCircularGraphQL.Api.Configurations
{
    public static class JWTConfiguration
    {
        public static IServiceCollection AddConfigurationJWT( this IServiceCollection services, IConfiguration configuration)
        {
            var jwtSettings = configuration.GetSection("Jwt");
            var key = new SymmetricSecurityKey( Encoding.UTF8.GetBytes(jwtSettings["Key"]?? string.Empty));

            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
            {
                options.TokenValidationParameters =
                    new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = jwtSettings["Issuer"],
                        ValidAudience = jwtSettings["Audience"],
                        IssuerSigningKey = key
                    };
            });
            services.AddAuthorization();

            services.AddSingleton<IAuthorizationHandler, CustomAuthorizationHandler>();

            return services;
        }
    }
}
