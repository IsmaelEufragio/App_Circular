using ApiCircularGraphQL.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Domain.Interfaces
{
    public interface IUserRepository : IRepository<tbUsuarios>
    {
        Task<List<tbInfoUnicaUsuario>> GetUserAllAsync();
        Task<List<tbTipoUsuario>> GetTipoAllAsync();
        Task<tbTipoUsuario?> GetTipoIdAsync(Guid id);
        Task<IEnumerable<tbTipoUsuario>> GetManyByIds(IReadOnlyList<Guid> tiposUsuarioIds);
        IQueryable<tbInfoUnicaUsuario> GetUserAllQueryableAsync();
        Task<IEnumerable<tbUsuarios>> GetUsuariosByPrincipals(IReadOnlyList<Guid> idUsuarioPrincipal);
        Task<IEnumerable<tbTipoIdentificacion>> GetIdentidadPorByIds(IReadOnlyList<Guid> ids);
        Task<IEnumerable<tbUsuarioTelefono>> GetTelefonosPorUsuario(IReadOnlyList<Guid> ids);
        Task<IEnumerable<tbHorario>> GetHorarioPorUsuario(IReadOnlyList<Guid> ids);
    }
}
