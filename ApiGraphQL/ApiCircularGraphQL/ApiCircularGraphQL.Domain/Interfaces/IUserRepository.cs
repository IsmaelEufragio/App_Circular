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
        Task<bool> ValidarSiExisteCorreo(string correo);
        Task<bool> ValidarSiExisteLosTelefonos(IEnumerable<string> telefonos);
        Task<Guid> CrearUsuarioPrincipal(tbInfoUnicaUsuario usuario);
        Task GuardarToken(Guid idUsuario,Guid idTipoToken, string token);
        Task<List<string>> UsuarioVerificado(Guid idUsuario);
        Task<tbUsuarios> GetUserIdAsync(Guid idUser);
        Task<string[]> RolesUsuario(Guid idUsuario);
        Task<Dictionary<string, string>> ClaimsUsuario(Guid idUsuario);
        Task<bool> TokesUsuarios(Guid idUsuario, Guid idTipoUsuario, string token);
        Task<tbUsuarios?> UsuarioVerificado(string correo, string contraseña);
        Task<Dictionary<Guid, tbRoles[]>?> GetRolesPorUsuarios(IReadOnlyList<Guid> ids);
        Task<Dictionary<Guid, Dictionary<string, string>>> ClaimsPorUsuarios(IReadOnlyList<Guid> idsUsuarios);
    }
}
