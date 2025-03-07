using ApiCircularGraphQL.Application.DTOs;
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
                    TipoTelefono = e.tipTel.tipTel_Descripcion,
                    Telefono = e.usTel_Numero,
                }).ToList()
            }).AsQueryable();
        }
    }
}
