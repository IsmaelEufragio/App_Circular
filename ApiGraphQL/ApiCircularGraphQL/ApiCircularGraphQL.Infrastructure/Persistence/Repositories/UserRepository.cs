using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Globalization;
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

        public async Task<List<tbInfoUnicaUsuario>> GetUserAllAsync()
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbInfoUnicaUsuario.OrderBy(a=> a.usInf_Id).ToListAsync();
        }

        public async Task<List<tbTipoUsuario>> GetTipoAllAsync()
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoUsuario.ToListAsync();
        }
        public async Task<tbTipoUsuario> GetTipoIdAsync(Guid id)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoUsuario.FirstOrDefaultAsync(a=> a.tipUs_Id == id);
        }

        public async Task<IEnumerable<tbTipoUsuario>> GetManyByIds(IReadOnlyList<Guid> tiposUsuarioIds)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoUsuario.Where(a => tiposUsuarioIds.Contains(a.tipUs_Id)).ToListAsync();
        }

        public async Task<IEnumerable<tbUsuarios>> GetUsuariosByPrincipals(IReadOnlyList<Guid> idUsuarioPrincipal)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarios.Where(a => idUsuarioPrincipal.Contains(a.usInf_Id)).ToListAsync();
        }

        public async Task<IEnumerable<tbTipoIdentificacion>> GetIdentidadPorByIds(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoIdentificacion.Where(a => ids.Contains(a.tipIde_Id)).ToListAsync();
        }
        public async Task<IEnumerable<tbUsuarioTelefono>> GetTelefonosPorUsuario(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarioTelefono.Where(a => ids.Contains(a.user_Id)).ToListAsync();
        }
        public async Task<IEnumerable<tbHorario>> GetHorarioPorUsuario(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbHorario.Where(a => ids.Contains(a.user_Id)).ToListAsync();
        }

        public IQueryable<tbInfoUnicaUsuario> GetUserAllQueryableAsync()
        {
            var context = _contextFactory.CreateDbContext();
            return context.tbInfoUnicaUsuario;
        }
    }
}
