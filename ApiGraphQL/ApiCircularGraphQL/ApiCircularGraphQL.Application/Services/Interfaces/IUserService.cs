using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IUserService
    {
        Task<IEnumerable<HorarioDTO>> GetHorarioPorUsuario(IReadOnlyList<Guid> idsUsuarios);
        Task<IEnumerable<TipoIdentidadDTO>> GetIdentidadPorByIds(IReadOnlyList<Guid> idsUsuarios);
        Task<IEnumerable<TipoUsuarioDTO>> GetManyByIds(IReadOnlyList<Guid> tiposUsuarioIds);
        Task<IEnumerable<TelefonosUsuarioDTO>> GetTelefonosPorUsuario(IReadOnlyList<Guid> idsUsuarios);
        Task<List<TipoUsuarioDTO>> GetTipoUsuarioAll();
        Task<TipoUsuarioDTO> GetTipoUsuarioId(Guid id);
        IEnumerable<UserDTO> GetUserData();
        Task<List<UserPrincipalDTO>> GetUsuarioAll();
        IQueryable<UserPrincipalDTO> GetUsuarioPrincipalQuery();
        IQueryable<UserDTO> GetUsuarioQuery();
        Task<IEnumerable<UserDTO>> GetUsuariosByPrincipals(IReadOnlyList<Guid> idUsuarioPrincipal);
    }
}
