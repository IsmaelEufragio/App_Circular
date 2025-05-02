using ApiCircularGraphQL.Api.Middlewares;
using ApiCircularGraphQL.Infrastructure.Persistence;
using HotChocolate.AspNetCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;
using StackExchange.Redis;

namespace ApiCircularGraphQL.Api.Configurations
{
    public static class GraphQLConfiguration
    {
        public static IServiceCollection AddGraphQLServices(this IServiceCollection services)
        {
            services
                .AddGraphQLServer()
                .AddAuthorization(opciones=>
                {
                    opciones.AddPolicy("TokenValido", policy =>
                    {
                        policy.RequireAuthenticatedUser();
                        policy.Requirements.Add(new TokenValidationRequerement());
                    });
                    //opciones.DefaultPolicy = opciones.GetPolicy("TokenValido");
                })
                /*.UseField(next => async context =>
                {
                    context.ContextData["HttpContext"] = context.Services.GetRequiredService<IHttpContextAccessor>().HttpContext!;
                    await next(context);
                })*/
                //.UseField<TokenValidationMiddleware>()
                //.AddGlobalObjectIdentification()
                .AddErrorFilter(error =>
                {
                    if (error.Exception != null)
                    {
                        if(error.Exception is TokenRevokedException ex)
                        {
                            var er = error.WithMessage("Token revocado")
                                        .WithCode("UNAUTHORIZED")
                                        .SetExtension("statusCode", 401)
                                        .SetExtension("statusText", "Unauthorized")
                                        .SetExtension("bodyText", "Token en lista negra");
                            return er;
                        }
                    }
                    return error; // Otros errores se manejan normalmente
                })
                .AddMutationConventions()
                .AddDbContextCursorPagingProvider()
                .AddPagingArguments()
                .AddFiltering()
                .AddSorting()
                .AddApiTypes();

            services.AddHttpContextAccessor();

            services.AddAuthorization();

            return services;
        }
    }
}
