using AppCircular.BusinessLogic.Services;
using AppCircular.DataAccess;
using AppCircular.DataAccess.Context;
using AppCircular.DataAccess.Repositories;

namespace AppCircular
{
    public static class ServicesConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connectionString)
        {
            services.AddScoped<TipoUsuarioRepository>();
            services.AddScoped<InfoUnicaUsuarioRepository>();
            services.AddScoped<PaisRepository>();
            services.AddScoped<DepartamentoRepository>();
            services.AddScoped<MunicipioRepository>();
            services.AddScoped<CategoriaLugarRepository>();
            AppCircularContext.BuildConnectionString(connectionString);
        }

        public static void BusinessLogic(this IServiceCollection services)
        {
            services.AddScoped<UsuarioServices>();
            services.AddScoped<UbicacionServices>();
        }
    }
}
