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

        public UsuarioCrearDTO ConvertirAUsuario(IFormCollection form)
        {
            try
            {
                UsuarioCrearDTO modelo = new();
                List<HorarioCrearDTO> horario = [];
                List<CategoriaPorUsuarioCrearDTO> categorias = [];
                List<TelefonosUsuariosCrearDTO> telefono = [];
                IFormFile formFile = form.Files["Logo"];
                if (formFile != null)
                {
                    modelo.Logo = formFile;
                }
                else modelo.RutaLogo = string.Empty;

                modelo.tipUs_Id = form.TryGetValue("tipUs_Id", out var tipUs_Id) ? Guid.TryParse(tipUs_Id, out Guid idTipoUs) ? idTipoUs : Guid.Empty : Guid.Empty;
                modelo.tipIde_Id = form.TryGetValue("tipIde_Id", out var tipIde_Id) ? Guid.TryParse(tipIde_Id, out Guid idTipoIde) ? idTipoIde : Guid.Empty : Guid.Empty;
                modelo.Identidad = form.TryGetValue("Identidad", out var Identidad) ? Identidad.ToString() : string.Empty;
                modelo.Nombre = form.TryGetValue("Nombre", out var nombreValue) ? nombreValue.ToString() : string.Empty;
                modelo.PaginaWed = form.TryGetValue("PaginaWed", out var PaginaWed) ? PaginaWed.ToString() : string.Empty;
                modelo.NombreUsuario = form.TryGetValue("NombreUsuario", out var NombreUsuario) ? NombreUsuario.ToString() : string.Empty;
                modelo.Password = form.TryGetValue("Password", out var Password) ? Password.ToString() : string.Empty;
                modelo.Descripcion = form.TryGetValue("Descripcion", out var Descripcion) ? Descripcion.ToString() : string.Empty;
                modelo.Facebook = form.TryGetValue("Facebook", out var Facebook) ? Facebook.ToString() : string.Empty;
                modelo.Intagram = form.TryGetValue("Intagram", out var Intagram) ? Intagram.ToString() : string.Empty;
                modelo.WhatsApp = form.TryGetValue("WhatsApp", out var WhatsApp) ? bool.TryParse(WhatsApp, out bool whats) ? whats : null : null;
                modelo.Envio = form.TryGetValue("Envio", out var Envio) ? bool.TryParse(Envio, out bool envi) ? envi : null : null;
                modelo.Correo = form.TryGetValue("Correo", out var Correo) ? Correo.ToString() : string.Empty;
                modelo.subLug_Id = form.TryGetValue("subLug_Id", out var subLug_Id) ? Guid.TryParse(subLug_Id, out Guid idSubLug) ? idSubLug : Guid.Empty : Guid.Empty;
                modelo.Latitud = form.TryGetValue("Latitud", out var Latitud) ? Latitud.ToString() : string.Empty;
                modelo.Longitub = form.TryGetValue("Longitub", out var Longitub) ? Longitub.ToString() : string.Empty;
                int idexHora = 0;
                while (true)
                {
                    var diaNumero = $"Horario[{idexHora}].DiaNumero";
                    var horaInicio = $"Horario[{idexHora}].HoraInicio";
                    var horaFin = $"Horario[{idexHora}].HoraFin";
                    if (!form.ContainsKey(diaNumero) || !form.ContainsKey(horaInicio) || !form.ContainsKey(horaFin))
                    {
                        break;
                    }
                    int iDiaNumero = form.TryGetValue(diaNumero, out var DiaNumero) ? int.TryParse(DiaNumero, out int diaN) ? diaN : 0 : 0;
                    var horaN = form[horaInicio];
                    var horaF = form[horaFin];
                    bool valHoraInicio = TimeOnly.TryParse(horaN, out TimeOnly iHoraInicio);
                    bool valHoraFin = TimeOnly.TryParse(horaF, out TimeOnly iHoraFin);

                    horario.Add(new HorarioCrearDTO
                    {
                        DiaNumero = iDiaNumero,
                        HoraInicio = iHoraInicio,
                        HoraFin = iHoraFin,
                    });
                    idexHora++;
                }
                modelo.Horario = horario;
                int indexCat = 0;
                while (true)
                {
                    var idCategoria = $"Categoria[{indexCat}].catg_Id";
                    if (!form.ContainsKey(idCategoria)) break;
                    Guid id = form.TryGetValue(idCategoria, out var catg_Id) ? Guid.TryParse(catg_Id, out Guid idC) ? idC : Guid.Empty : Guid.Empty;
                    categorias.Add(new CategoriaPorUsuarioCrearDTO { catg_Id = id });
                    indexCat++;
                }
                modelo.Categoria = categorias;
                int indexTel = 0;
                while (true)
                {
                    var idTipoTelefono = $"Telefono[{indexTel}].idTipoTelefono";
                    var Nutelefono = $"Telefono[{indexTel}].Telefono";
                    if (!form.ContainsKey(idTipoTelefono) || !form.ContainsKey(Nutelefono)) break;
                    Guid id = form.TryGetValue(idTipoTelefono, out var idTipo) ? Guid.TryParse(idTipo, out Guid idT) ? idT : Guid.Empty : Guid.Empty;
                    string numero = form.TryGetValue(Nutelefono, out var NumeTele) ? NumeTele.ToString() : string.Empty;

                    telefono.Add(new TelefonosUsuariosCrearDTO { idTipoTelefono = id, Telefono = numero });
                    indexTel++;
                }
                modelo.Telefono = telefono;
                return modelo;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public async Task<ServiceResult> CrearUsaurio(UsuarioCrearDTO model)
        {
            try
            {
                ServiceResult result = new();
                //string confi = _iConfiguration.GetConnectionString("DefaultConnection");
                var cong = await _baseServices.GetConfiguracion("IdTipoUsuarioParticular");
                if (!Guid.TryParse(cong, out Guid idParticualar))
                    throw new Exception("No se pudo convertir la configuracion 'IdTipoUsuarioParticular' a Guid");

                var tipoRe = await _userRepository.GetTipoIdAsync(model.tipUs_Id) 
                    ?? throw new Exception($"Al Crear Un usuario no se encontro Tipo Usuario con Id{model.tipUs_Id}");

                var subLugar = await _subdivicionLugarRepository.GetByIdAsync(model.subLug_Id) 
                    ?? throw new Exception($"Al crear un usuario no se encontro un regitro tbSubdivicionLugar con Id {model.subLug_Id}");

                //await _userRepository.ValidarSiExisteCorreo(model.Correo);

                //if(model.Telefono.Count> 0)
                //    await _userRepository.ValidarSiExisteLosTelefonos(model.Telefono.Select(a => a.Telefono));

                //Crear contraseñas incriptadas
                model.PasswordSal = Guid.NewGuid().ToString();
                model.Password = EncryptPass.GeneratePassword(model.Password, model.PasswordSal);
                //Ruta imagen
                var congTamLog = await _baseServices.GetConfiguracion("TamañoLogo");

                if (!int.TryParse(congTamLog, out int tamanoLogo))
                    throw new Exception("No se pudo convertir la configuracion 'TamañoLogo' a int");


                var congRutLog = await _baseServices.GetConfiguracion("SubRutaLogo");
                
                if (model.Logo != null)
                {
                    //var rutaLogo = await _baseServices.GuardarArchivo(tamanoLogo, congRutLog, model.Logo);
                    //model.RutaLogo = rutaLogo;
                    model.RutaLogo = "https://apicircular.blob.core.windows.net/logos/0fa7ca0c-a08b-435d-9002-587811bcc5c3.jpg";
                }

                var modelUbicacion = await _ubicacionRepository.AddAsync(new tbUbicacion
                {
                    subLug_Id = model.subLug_Id,
                    ubc_Latitud = model.Latitud,
                    ubc_Longitub = model.Longitub
                });

                var usuario = new tbInfoUnicaUsuario
                {
                    usInf_Nombre = model.Nombre,
                    usInf_RutaPaginaWed = model.PaginaWed,
                    tipUs_Id = model.tipUs_Id,
                    usInf_RutaLogo = model.RutaLogo,
                    tbUsuarios = new List<tbUsuarios> {
                        new() {
                            user_Descripcion = model.Descripcion,
                            user_Correo = model.Correo,
                            user_Facebook = model.Facebook,
                            user_WhatsApp = model.WhatsApp??false,
                            user_Password = model.Password,
                            user_PasswordSal = model.PasswordSal,
                            user_NombreUsuario = model.NombreUsuario,
                            ubc_Id = modelUbicacion.ubc_Id,
                            user_Intagram = model.Intagram,
                            user_Envio = model.Envio?? false,
                            tipIde_Id = model.tipIde_Id,
                            user_Identificacion = model.Identidad,
                            user_FechaCreacion = DateTime.Now,
                            user_UsuarioPrincipal = true,
                            tbHorario = [.. model.Horario.Select(a => new tbHorario
                            {
                                hor_DiaNumero = a.DiaNumero,
                                hor_HoraInicio = a.HoraInicio,
                                hor_HoraFin = a.HoraFin
                            })],
                            tbCategoriaItem = [.. model.Categoria.Select(a=> new tbCategoriaItem {
                                catg_Id = a.catg_Id
                            })],
                            tbUsuarioTelefono = [.. model.Telefono.Select(a=> new tbUsuarioTelefono {
                                tipTel_Id = a.idTipoTelefono,
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
                    NombreUsuario = model.NombreUsuario,
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
    }
}
