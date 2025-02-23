using ApiCircularGraphQL.Application.Services.Implementations;
using ApiCircularGraphQL.Application.Services.Interfaces;
using Microsoft.Extensions.DependencyInjection;

namespace ApiCircularGraphQL.Application
{
    public static class ServiceExtensionsApplication
    {
        public static IServiceCollection AddServiceExtensionsApplication(this IServiceCollection services)
        {
            services.AddScoped<IPaisService, PaisService>();
            return services;
        }
    }
}
