using ApiCircularGraphQL.Api.GraphQL;
using ApiCircularGraphQL.Api.GraphQL.Mutations;
using ApiCircularGraphQL.Api.GraphQL.Mutations.Auth;
using ApiCircularGraphQL.Api.GraphQL.Mutations.User;
using ApiCircularGraphQL.Api.GraphQL.Queries;
using ApiCircularGraphQL.Api.Middlewares;
using ApiCircularGraphQL.Infrastructure.Persistence;
using HotChocolate.AspNetCore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;

namespace ApiCircularGraphQL.Api.Configurations
{
    public static class GraphQLConfiguration
    {
        public static IServiceCollection AddGraphQLServices(this IServiceCollection services)
        {
            services
                .AddGraphQLServer()
                .AddAuthorizationCore()
                .AddAuthorizationHandler<CustomAuthorizationHandler>()
                .AddQueryType()
                .AddTypeExtension<PaisQuery>()
                .AddTypeExtension<UserQuery>()
                .AddMutationType<Mutation>()
                .AddTypeExtension<AuthMutation>()
                .AddTypeExtension<UserMutation>()
                .AddProjections()
                .AddFiltering()
                .AddSorting()
                .RegisterDbContextFactory<AppECOContext>()
                //.AddAuthorizationCore()
            ;

            services.AddAuthorization();

            return services;
        }
    }
}
