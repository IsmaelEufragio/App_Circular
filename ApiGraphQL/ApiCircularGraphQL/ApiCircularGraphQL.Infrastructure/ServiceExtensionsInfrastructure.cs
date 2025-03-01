using ApiCircularGraphQL.Domain.Interfaces;
using ApiCircularGraphQL.Infrastructure.Persistence;
using ApiCircularGraphQL.Infrastructure.Persistence.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace ApiCircularGraphQL.Infrastructure
{
    public static class ServiceExtensionsInfrastructure
    {
        public static IServiceCollection AddServiceExtensionsInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            
            services.AddPooledDbContextFactory<AppECOContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

            services.AddScoped<IPaisRepository, PaisRepository>();
            services.AddScoped<IUserRepository, UserRepository>();


            return services;
        }
    }
}
