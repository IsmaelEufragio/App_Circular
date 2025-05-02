using ApiCircularGraphQL.Api.Middlewares;
using ApiCircularGraphQL.Domain.Interfaces;
using HotChocolate.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using System.Text.Json;

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
                options.MapInboundClaims = false;
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
                options.Events = new JwtBearerEvents
                {
                    /*OnTokenValidated = async context =>
                    {
                        var tokenBlacklistService = context.HttpContext.RequestServices
                            .GetRequiredService<ITokenBlacklistRepository>();
                
                        var jti = context.Principal?.Claims
                            .FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Jti)?.Value;
                
                        if (jti != null && await tokenBlacklistService.IsTokenBlacklistedAsync(jti))
                        {
                            
                            context.Fail("Token revocado");
                            context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                            context.NoResult();
                            await context.Response.WriteAsJsonAsync(new {mesa= "tes"});
                            await context.Response.WriteAsync("Nada funiona");
                            await context.Response.CompleteAsync();
                            //throw new TokenRevokedException("Token Revocado.");
                        }
                    }*/
                };
            });
            services.AddAuthorization(opciones =>
            {
                opciones.AddPolicy("EditarCorreo", politica => politica.RequireClaim("Permiso", "EditarCorreo"));
            });


            //services.AddSingleton<IAuthorizationHandler, CustomAuthorizationHandler>();
            services.AddSingleton<Microsoft.AspNetCore.Authorization.IAuthorizationHandler, TokenValidationRequerementHandler>();
            return services;
        }
    }
}
