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
    public class PaisRepository : Repository<tbPais>, IPaisRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;

        public PaisRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<List<tbPais>> GetPedidosByPaisIdAsync(Guid idPais)
        {
            using var context = _contextFactory.CreateDbContext(); // ✅ Crear contexto correctamente
            return await context.tbPais.Where(a => a.pais_Id == idPais).ToListAsync();
        }
    }
}
