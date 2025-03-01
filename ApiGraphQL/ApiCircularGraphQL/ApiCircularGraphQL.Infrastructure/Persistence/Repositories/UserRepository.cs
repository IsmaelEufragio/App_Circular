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
    public class UserRepository : Repository<tbUsuarios>, IUserRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;

        public UserRepository(IDbContextFactory<AppECOContext> contextFactory) : base(contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<List<tbUsuarios>> GetUserIdAsync(Guid idUser)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarios.Where(a => a.user_Id == idUser).ToListAsync();
        }
    }
}
