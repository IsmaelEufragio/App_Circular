using ApiCircularGraphQL.Api.GraphQL;
using ApiCircularGraphQL.Api.GraphQL.Queries;
using ApiCircularGraphQL.Infrastructure.Persistence;
using HotChocolate.AspNetCore;
using Microsoft.Extensions.DependencyInjection;

namespace ApiCircularGraphQL.Api.Configurations
{
    public static class GraphQLConfiguration
    {
        public static IServiceCollection AddGraphQLServices(this IServiceCollection services)
        {
            services
                .AddGraphQLServer()
                .AddQueryType()
                .AddTypeExtension<PaisQuery>()
                .AddProjections()
                .AddFiltering()
                .AddSorting()
                .RegisterDbContextFactory<AppECOContext>()
            ;

            return services;
        }
    }
}
