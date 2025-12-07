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
    public class SubdivicionLugarRepository : Repository<tbSubdivicionLugar>, ISubdivicionLugarRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;
        public SubdivicionLugarRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<Dictionary<Guid, tbSubdivicionLugar[]>> SubdivicionLugarPorUbicacion(IReadOnlyList<Guid> idsLugar)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbLugar
                .Where(a => idsLugar.Contains(a.lug_Id))
                .Include(a => a.tbSubdivicionLugar)
                .ToDictionaryAsync(k => k.lug_Id, v => v.tbSubdivicionLugar.ToArray());
        }
    }
}
