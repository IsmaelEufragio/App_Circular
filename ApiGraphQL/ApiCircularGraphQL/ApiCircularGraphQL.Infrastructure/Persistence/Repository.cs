using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Infrastructure.Persistence
{
    public class Repository<T> : IRepository<T> where T : class
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;

        public Repository(IDbContextFactory<AppECOContext> contextFactory)
        {
            _contextFactory = contextFactory;
        }

        public async Task<List<T>> GetAllAsync()
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.Set<T>().ToListAsync();
        }

        public async Task<T?> GetByIdAsync(Guid id)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.Set<T>().FindAsync(id);
        }

        public async Task<T> AddAsync(T entity)
        {
            using var context = _contextFactory.CreateDbContext();
            await context.Set<T>().AddAsync(entity);
            await context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync(T entity)
        {
            using var context = _contextFactory.CreateDbContext();
            context.Set<T>().Update(entity);
            await context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            using var context = _contextFactory.CreateDbContext();
            var entity = await context.Set<T>().FindAsync(id);
            if (entity != null)
            {
                context.Set<T>().Remove(entity);
                await context.SaveChangesAsync();
            }
        }

        public IQueryable<T> GetAllQuery()
        {
            var context = _contextFactory.CreateDbContext();
            return context.Set<T>();
        }
    }
}
