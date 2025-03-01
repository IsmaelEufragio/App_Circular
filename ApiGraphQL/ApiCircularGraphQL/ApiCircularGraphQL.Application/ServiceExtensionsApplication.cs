using ApiCircularGraphQL.Application.Services.Implementations;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Logging;
using Microsoft.Extensions.DependencyInjection;

namespace ApiCircularGraphQL.Application
{
    public static class ServiceExtensionsApplication
    {
        public static IServiceCollection AddServiceExtensionsApplication(this IServiceCollection services)
        {
            services.AddScoped<IAuthService, AuthService>();
            services.AddScoped<IPaisService, PaisService>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<AuthLogger>();
            return services;
        }
    }
}
