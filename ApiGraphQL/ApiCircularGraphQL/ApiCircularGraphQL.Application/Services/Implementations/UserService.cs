using ApiCircularGraphQL.Application.Configuracion;
using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.DTOs.Utilidades;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.CrossCutting.Model;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IBaseServices _baseServices;
        private readonly ICategoriaRepository _categoriaRepository;
        private readonly ISubdivicionLugarRepository _subdivicionLugarRepository;
        private readonly IUbicacionRepository _ubicacionRepository;
        private readonly IConfiguration _configuration;
        public UserService(IUserRepository userRepository,
            IBaseServices baseServices,
            ICategoriaRepository categoriaRepository,
            ISubdivicionLugarRepository subdivicionLugarRepository,
            IUbicacionRepository ubicacionRepository,
            IConfiguration configuration)
        {
            _userRepository = userRepository;
            _baseServices = baseServices;
            _categoriaRepository = categoriaRepository;
            _subdivicionLugarRepository = subdivicionLugarRepository;
            _ubicacionRepository = ubicacionRepository;
            _configuration = configuration;
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
                //TipoIdentidad = a.tipIde.tipIde_Descripcion,
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
                    Id = u.user_Id,
                    IdUserPrincipal = u.usInf_Id,
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
                    IdTipoIdentidad = u.tipIde_Id,
                    //TipoIdentidad = u.tipIde.tipIde_Descripcion,
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
                //RutaDeLaPaginaWeb = a.usInf_RutaPaginaWed,
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
                Id = a.hor_Id,
                Dia = a.hor_DiaNumero,
                HoraInicio = a.hor_HoraInicio,
                HoraFin = a.hor_HoraFin,
            });
            return dataResult;
        }

        public async Task<Dictionary<Guid, RolDTO[]>> GetRolesUsuario(IReadOnlyList<Guid> idsUsuarios)
        {
            var data = await _userRepository.GetRolesPorUsuarios(idsUsuarios);
            if(data is null)
                return idsUsuarios.ToDictionary(k => k, v => Array.Empty<RolDTO>());

            var dataDTO = data.ToDictionary(k => k.Key, d => d.Value.Select(a => new RolDTO
            {
                Id = a.rol_Id,
                Nombre = a.rol_Nombre,
                NombreNormalizado = a.rol_NombreNormalizado
            }).ToArray());
            return dataDTO;
            
        }

        public async Task<Dictionary<Guid,UsuariosClaimsDTO[]>> GetClaimsUsuario(IReadOnlyList<Guid> idsUsuarios)
        {
            var data = await _userRepository.ClaimsPorUsuarios(idsUsuarios);
            if (data is null)
                return [];

            var dataDTO = data.ToDictionary(k => k.Key, d => d.Value.Select(a => new UsuariosClaimsDTO
            {
                Tipo = a.Key,
                Valor = a.Value
            }).ToArray());
            return dataDTO??[];
        }

        public IQueryable<UserPrincipalDTO> GetUsuarioPrincipalQuery()
        {
            return _userRepository.GetUserAllQueryableAsync()
                .Select(u => new UserPrincipalDTO
                {
                    Id = u.usInf_Id,
                    Nombre = u.usInf_Nombre,
                    RutaDelLogo = u.usInf_RutaLogo,
                    //RutaDeLaPaginaWeb = u.usInf_RutaPaginaWed,
                    IdTipoUsuario = u.tipUs_Id,
                    UnicoUsuario = u.usInf_IgualSubInfo,
                });
        }

        public async Task<ServiceResult> CrearUsaurio(UserCreateRequest model)
        {
            try
            {
                ServiceResult result = new();
                //string confi = _iConfiguration.GetConnectionString("DefaultConnection");
                var cong = await _baseServices.GetConfiguracion("IdTipoUsuarioParticular");
                if (!Guid.TryParse(cong, out Guid idParticualar))
                    throw new Exception("No se pudo convertir la configuracion 'IdTipoUsuarioParticular' a Guid");

                var tipoRe = await _userRepository.GetTipoIdAsync(model.UserTypeId) 
                    ?? throw new Exception($"Al Crear Un usuario no se encontro Tipo Usuario con Id{model.UserTypeId}");

                var subLugar = await _subdivicionLugarRepository.GetByIdAsync(model.SubPlaceId) 
                    ?? throw new Exception($"Al crear un usuario no se encontro un regitro tbSubdivicionLugar con Id {model.SubPlaceId}");

                //await _userRepository.ValidarSiExisteCorreo(model.Correo);

                //if(model.Telefono.Count> 0)
                //    await _userRepository.ValidarSiExisteLosTelefonos(model.Telefono.Select(a => a.Telefono));

                //Crear contraseñas incriptadas
                string passwordSal = Guid.NewGuid().ToString();
                model.Password = EncryptPass.GeneratePassword(model.Password, passwordSal);
                //Ruta imagen
                var congTamLog = await _baseServices.GetConfiguracion("TamañoLogo");

                if (!int.TryParse(congTamLog, out int tamanoLogo))
                    throw new Exception("No se pudo convertir la configuracion 'TamañoLogo' a int");


                var congRutLog = await _baseServices.GetConfiguracion("SubRutaLogo");
                string rutaLogo = "";
                if (model.Logo != null)
                {
                    //var rutaLogo = await _baseServices.GuardarArchivo(tamanoLogo, congRutLog, model.Logo);
                    //model.RutaLogo = rutaLogo;
                    rutaLogo = "https://apicircular.blob.core.windows.net/logos/0fa7ca0c-a08b-435d-9002-587811bcc5c3.jpg";
                }

                var modelUbicacion = await _ubicacionRepository.AddAsync(new tbUbicacion
                {
                    subLug_Id = model.SubPlaceId,
                    ubc_Latitud = model.Latitud,
                    ubc_Longitub = model.Longitub
                });

                var usuario = new tbInfoUnicaUsuario
                {
                    usInf_Nombre = model.BusinessName,
                    usInf_RutaPaginaWed = model.WebsitePath,
                    tipUs_Id = model.UserTypeId,
                    usInf_RutaLogo = rutaLogo,
                    tbUsuarios = new List<tbUsuarios> {
                        new() {
                            user_Descripcion = model.Description,
                            user_Correo = model.Correo,
                            user_Facebook = model.Facebook,
                            user_WhatsApp = model.WhatsApp??false,
                            user_Password = model.Password,
                            user_PasswordSal = passwordSal,
                            user_NombreUsuario = model.UserName,
                            ubc_Id = modelUbicacion.ubc_Id,
                            user_Intagram = model.Instagram,
                            user_Envio = model.Shipping ?? false,
                            tipIde_Id = model.TypeOfIdentity,
                            user_Identificacion = model.Identity,
                            user_FechaCreacion = DateTime.Now,
                            user_UsuarioPrincipal = true,
                            tbHorario = [.. model.Schedule.Select(a => new tbHorario
                            {
                                hor_DiaNumero = a.DiaNumero,
                                hor_HoraInicio = a.HoraInicio,
                                hor_HoraFin = a.HoraFin
                            })],
                            tbCategoriaItem = [.. model.Category.Select(a=> new tbCategoriaItem {
                                catg_Id = a.catg_Id
                            })],
                            tbUsuarioTelefono = [.. model.Telephone.Select(a=> new tbUsuarioTelefono {
                                tipTel_Id = a.IdTipoTelefono,
                                usTel_Numero = a.Telefono
                            })],
                            tbUsuariosClaims =
                            [
                                new tbUsuariosClaims
                                {
                                    userClai_Tipo = "Permiso",
                                    userClai_Value = "EditarCorreo",
                                }
                            ]
                        }
                    }
                };

                var idUsuario = await _userRepository.CrearUsuarioPrincipal(usuario);
                //var idUsuario = Guid.Parse("5a4fdf62-62ff-4a6b-a06d-a6288eb550e1");
                //Generar Token Para Verificar Usuario

                var tokenModel = new CrearTokenModel()
                {
                    Configuration = _configuration,
                    IdUsuario = idUsuario.ToString(),
                    NombreUsuario = model.UserName,
                    Expira = DateTime.Now.AddMinutes(5),
                    Roles = []
                };
                var tokeValidar = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el Token para validar el usuario.");
                Guid idTipoTokenCorreo = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenVarificacionCorreo"));
                await _userRepository.GuardarToken(idUsuario, idTipoTokenCorreo, tokeValidar);

                var ruta = await _baseServices.GetConfiguracion("ApiRutaToken");
                var CorreoModel = new EmailDTO
                {
                    Asunto = "Verificacion Del token",
                    DestinoCorreo = model.Correo,
                    Cuerpo = $"{ruta}{tokeValidar}"
                };
                await _baseServices.Correo(CorreoModel);
                //Genera Token Por si Edita el Correo.
                var rolDB = await _userRepository.RolesUsuario(idUsuario);
                tokenModel.Roles = rolDB?? [];
                var claims = await _userRepository.ClaimsUsuario(idUsuario);
                tokenModel.Claims = claims;
                tokenModel.Expira = null;
                var token = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el Token para validar el usuario.");

                Guid idTipoTokenLogin = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenLogin"));
                await _userRepository.GuardarToken(idUsuario, idTipoTokenLogin, token);
                return new ServiceResult() { 
                    Data = new { token, CorreoEnviado = true}, 
                    Success = true, 
                    Type = ServiceResultType.Success, 
                    Message = $"Se envio el correo verificacion. al Correo {model.Correo}, Revise el Spam." 
                };
            }
            catch (Exception ex)
            {
                return new ServiceResult() { Success = false, Message = $"Error en el Servicio Usuario Al Crear un Usaurio: {ex.Message}", Type = ServiceResultType.Error };
            }
        }

        public async Task<IEnumerable<UserPrincipalDTO>> GetInfUsuarioPrincipal(IReadOnlyList<Guid> idUsuarioPrincipal)
        {
            var data = await _userRepository.GetInfUsuarioPrincipal(idUsuarioPrincipal);
            return data.Select(a => new UserPrincipalDTO
            {
                Id = a.usInf_Id,
                Nombre = a.usInf_Nombre,
                RutaDelLogo = a.usInf_RutaLogo,
                RutaDeLaPaginaWeb = a.usInf_RutaPaginaWed
            });
        }
    }
}
