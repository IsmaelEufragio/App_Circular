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
                //.AddGlobalObjectIdentification()
                .AddMutationConventions()
                .AddDbContextCursorPagingProvider()
                .AddPagingArguments()
                .AddFiltering()
                .AddSorting()
                .AddApiTypes();

            services.AddAuthorization();

            return services;
        }
    }
}
