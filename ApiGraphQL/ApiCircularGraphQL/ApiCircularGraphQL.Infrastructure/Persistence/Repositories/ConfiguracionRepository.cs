using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Infrastructure.Persistence.Repositories
{
    public class ConfiguracionRepository : Repository<tbConfiguracion>, IConfiguracionRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;
        public ConfiguracionRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<string> GetConfiguracion(string nombre)
        {
            string strigVa = nombre.Replace(" ", "");
            if (strigVa == "")
                throw new Exception("Nombre de la configuracion no puede estar vacio.");

            using var context = _contextFactory.CreateDbContext();
            var tbConfi = await context.tbConfiguracion.SingleOrDefaultAsync(a => a.conf_Nombre.ToLower() == nombre.ToLower())??
                throw new Exception("No se encontro la configuracion.");

            return tbConfi.conf_Valor;
        }
    }
}
