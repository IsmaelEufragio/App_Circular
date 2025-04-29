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
    public class UbicacionRepository : Repository<tbUbicacion>, IUbicacionRepository
    {
        public UbicacionRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
        }
    }
}
