using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }
        public IEnumerable<UserDTO> GetUserData()
        {
            return _userRepository.GetAllQuery().Select(a => new UserDTO
            {
                Id = a.user_Id,
                NombreUsuario = a.user_NombreUsuario,
                Despcripcion = a.user_Descripcion,
                Correo = a.user_Correo,
                Fecebook = a.user_Facebook,
                Intragram = a.user_Intagram,
                WhatsApp = a.user_WhatsApp,
                Envio = a.user_Envio,
                UsuarioPrincipal = a.user_UsuarioPrincipal,
                FechaCreacion = a.user_FechaCreacion,
                Identidad = a.user_Identificacion,
                IdTipoIdentidad = a.tipIde.tipIde_Id,
                TipoIdentidad = a.tipIde.tipIde_Descripcion,
                Verificado = a.user_Verificado,
                Ubicacion = new UbicacionUsuarioDTO()
                {
                    IdUbicacion = a.ubc.ubc_Id,
                    Latitud = a.ubc.ubc_Latitud,
                    Longitud = a.ubc.ubc_Longitub,
                    ColoniaCacerio = a.ubc.subLug.subLug_Nombre,
                    SubCategoria = a.ubc.subLug.catSub.catSub_Nombre,
                    Lugar = a.ubc.subLug.lug.lug_Nombre,
                    CategoriaLugar = a.ubc.subLug.lug.catLug.catLug_Nombre,
                    Municipio = a.ubc.subLug.lug.muni.muni_Nombre,
                    Departamento = a.ubc.subLug.lug.muni.dept.dept_Nombre,
                    Pais = a.ubc.subLug.lug.muni.dept.pais.pais_Nombre,
                },
                InformacionUnica = new InformacionUnicaUsuario
                {
                    IdTipoUsuario = a.usInf.tipUs.tipUs_Id,
                    TipoUsuario = a.usInf.tipUs.tipUs_Descripcion,
                    IgualSubInfo = a.usInf.usInf_IgualSubInfo,
                    Nombre = a.usInf.usInf_Nombre,
                    Logo = a.usInf.usInf_RutaLogo,
                    PaginaWeb = a.usInf.usInf_RutaPaginaWed,
                    Varificado = a.usInf.usInf_Verificado
                },
                Telefonos = a.tbUsuarioTelefono.Select(e=> new TelefonosUsuarioDTO
                {
                    IdTipoTelefono = e.tipTel.tipTel_Id,
                    //TipoTelefono = e.tipTel.tipTel_Descripcion,
                    Telefono = e.usTel_Numero,
                }).ToList()
            }).AsQueryable();
        }
        
        public IQueryable<UserDTO> GetUsuarioQuery()
        {
            return _userRepository.GetAllQuery()
                .Select( u=> new UserDTO
                {
                    Id = u.usInf_Id,
                    NombreUsuario = u.user_NombreUsuario,
                    Despcripcion = u.user_Descripcion,
                    Correo = u.user_Correo,
                    Fecebook = u.user_Facebook,
                    Intragram = u.user_Intagram,
                    WhatsApp = u.user_WhatsApp,
                    Envio = u.user_Envio,
                    UsuarioPrincipal = u.user_UsuarioPrincipal,
                    FechaCreacion = u.user_FechaCreacion,
                    Identidad = u.user_Identificacion,
                    TipoIdentidad = u.tipIde.tipIde_Descripcion,
                    Verificado = u.user_Verificado
                });
        }

        public async Task<List<UserPrincipalDTO>> GetUsuarioAll()
        {
            var data = await _userRepository.GetUserAllAsync();
            return data.Select(a=> new UserPrincipalDTO
            {
                Id = a.usInf_Id,
                Nombre = a.usInf_Nombre,
                RutaDelLogo = a.usInf_RutaLogo,
                RutaDeLaPaginaWeb = a.usInf_RutaPaginaWed,
                UnicoUsuario = a.usInf_IgualSubInfo,
                IdTipoUsuario = a.tipUs_Id
            }).ToList();
        }
        public async Task<List<TipoUsuarioDTO>> GetTipoUsuarioAll()
        {
            var data = await _userRepository.GetTipoAllAsync();
            return data.Select(a => new TipoUsuarioDTO
            {
                Descripcion = a.tipUs_Descripcion
            }).ToList();
        }

        public async Task<TipoUsuarioDTO> GetTipoUsuarioId(Guid id)
        {
            var data = await _userRepository.GetTipoIdAsync(id);
            return new TipoUsuarioDTO { 
                Descripcion = data.tipUs_Descripcion
            };
        }

        public async Task<IEnumerable<TipoUsuarioDTO>> GetManyByIds(IReadOnlyList<Guid> tiposUsuarioIds)
        {
            var data = await _userRepository.GetManyByIds(tiposUsuarioIds);
            return data.Select(a => new TipoUsuarioDTO
            {
                Id = a.tipUs_Id,
                Descripcion = a.tipUs_Descripcion
            });
        }
        public async Task<IEnumerable<UserDTO>> GetUsuariosByPrincipals(IReadOnlyList<Guid> idUsuarioPrincipal)
        {
            var data = await _userRepository.GetUsuariosByPrincipals(idUsuarioPrincipal);
            return data.Select(a => new UserDTO
            {
                Id = a.user_Id,
                IdUserPrincipal = a.usInf_Id,
                NombreUsuario = a.user_NombreUsuario,
                Despcripcion = a.user_Descripcion,
                Correo = a.user_Correo,
                Fecebook = a.user_Facebook,
                Intragram = a.user_Intagram,
                WhatsApp = a.user_WhatsApp,
                Envio = a.user_Envio,
                UsuarioPrincipal = a.user_UsuarioPrincipal,
                FechaCreacion = a.user_FechaCreacion,
                Identidad = a.user_Identificacion,
                Verificado = a.user_Verificado,
                IdTipoIdentidad = a.tipIde_Id
            });
        }

        public async Task<IEnumerable<TipoIdentidadDTO>> GetIdentidadPorByIds(IReadOnlyList<Guid> idsUsuarios)
        {
            var data = await _userRepository.GetIdentidadPorByIds(idsUsuarios);
            return data.Select(a => new TipoIdentidadDTO
            {
                IdTipoIdentidad = a.tipIde_Id,
                Nombre = a.tipIde_Descripcion,
            });
        }

        public async Task<IEnumerable<TelefonosUsuarioDTO>> GetTelefonosPorUsuario(IReadOnlyList<Guid> idsUsuarios)
        {
            var data = await _userRepository.GetTelefonosPorUsuario(idsUsuarios);
            return data.Select(a => new TelefonosUsuarioDTO
            {
                IdUsuario = a.user_Id,
                IdTipoTelefono = a.tipTel_Id,
                Telefono = a.usTel_Numero,
            });
        }

        public async Task<IEnumerable<HorarioDTO>> GetHorarioPorUsuario(IReadOnlyList<Guid> idsUsuarios)
        {
            var data = await _userRepository.GetHorarioPorUsuario(idsUsuarios);
            var dataResult = data.Select(a => new HorarioDTO
            {
                IdUsuario = a.user_Id,
                IdHorario = a.hor_Id,
                Dia = a.hor_DiaNumero,
                HoraInicio = a.hor_HoraInicio,
                HoraFin = a.hor_HoraFin,
            });
            return dataResult;
        }
    }
}
