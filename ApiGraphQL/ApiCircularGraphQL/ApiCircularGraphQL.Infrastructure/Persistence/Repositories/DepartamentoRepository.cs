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
    public class DepartamentoRepository : Repository<tbDepartamento>, IDepartamentoRepository
    {
        public DepartamentoRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
        }
    }
}
