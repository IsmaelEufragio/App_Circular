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
    public class LugarRepository : Repository<tbLugar>, ILugarRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;
        public LugarRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<Dictionary<Guid, tbLugar[]>> LugarPorMunicipio(IReadOnlyList<Guid> idsMunicipio)
        {
            using var context = _contextFactory.CreateDbContext();

            return await context.tbMunicipio
                    .Where(a => idsMunicipio.Contains(a.muni_Id))
                    .Include(a => a.tbLugar)
                    .ToDictionaryAsync(k => k.muni_Id, v => v.tbLugar.ToArray());
        }
    }
}
