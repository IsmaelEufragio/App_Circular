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
    public class MunicipalityRepository : Repository<tbMunicipio>, IMunicipalityRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;
        public MunicipalityRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<Dictionary<Guid, tbMunicipio[]>> MunicipiosPorDepartamentoAsync(IReadOnlyList<Guid> idsDepartamento)
        {
            using var context = _contextFactory.CreateDbContext();

            return await context.tbDepartamento
                        .Where(a => idsDepartamento.Contains(a.dept_Id))
                        .Include(a => a.tbMunicipio)
                        .ToDictionaryAsync(d => d.dept_Id, d => d.tbMunicipio.ToArray());
        }
    }
}
