using ApiCircularGraphQL.Application.Configuracion;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Domain.Entities;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IUserService
    {
        Task<ServiceResult> CrearUsaurio(UserCreateRequest model);
        Task<Dictionary<Guid, UsuariosClaimsDTO[]>> GetClaimsUsuario(IReadOnlyList<Guid> idsUsuarios);
        Task<IEnumerable<HorarioDTO>> GetHorarioPorUsuario(IReadOnlyList<Guid> idsUsuarios);
        Task<IEnumerable<TipoIdentidadDTO>> GetIdentidadPorByIds(IReadOnlyList<Guid> idsUsuarios);
        Task<IEnumerable<UserPrincipalDTO>> GetInfUsuarioPrincipal(IReadOnlyList<Guid> idUsuarioPrincipal);
        Task<IEnumerable<TipoUsuarioDTO>> GetManyByIds(IReadOnlyList<Guid> tiposUsuarioIds);
        Task<Dictionary<Guid, RolDTO[]>> GetRolesUsuario(IReadOnlyList<Guid> idsUsuarios);
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
