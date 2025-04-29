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
        public SubdivicionLugarRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
        }
    }
}
