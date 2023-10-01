using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.DataAccess;
using AppCircular.DataAccess.Context;
using AppCircular.DataAccess.Repositories;
using AppCircular.DataAccess.Repositories.Interface;

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
            services.AddScoped<ConfiguracionRepository>();
            services.AddScoped<JwtModel>();
            services.AddScoped<LugarRepository>();
            services.AddScoped<SubdivicionLugarRepository>();
            services.AddScoped<CategoriaRepository>();
            services.AddScoped<UsuarioRepository>();
            services.AddScoped<TelefonoRepository>();
            services.AddScoped<TipoTelefonoRepository>();
            services.AddScoped<TipoCatalogoRepository>();
            services.AddScoped<TipoImagenRepository>();
            AppCircularContext.BuildConnectionString(connectionString);
        }

        public static void BusinessLogic(this IServiceCollection services)
        {
            services.AddScoped<BaseServices>();
            services.AddScoped<UsuarioServices>();
            services.AddScoped<UbicacionServices>();
            services.AddScoped<ConfiguracionServices>();
            services.AddScoped<BaseServices>();
        }
    }
}
