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
                        ValidIssuer = "https://auth.chillicream.com",
                        ValidAudience = "https://graphql.chillicream.com",
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = key
                    };
            });

            services.AddAuthorization();


            return services;
        }
    }
}
