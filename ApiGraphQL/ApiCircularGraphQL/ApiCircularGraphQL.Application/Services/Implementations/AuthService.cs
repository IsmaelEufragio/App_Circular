using ApiCircularGraphQL.Application.Configuracion;
using ApiCircularGraphQL.Application.DTOs.Utilidades;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.CrossCutting.Logging;
using ApiCircularGraphQL.CrossCutting.Model;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class AuthService : IAuthService
    {
        private readonly IConfiguration _configuration;
        private readonly AuthLogger _authLogger;
        private readonly IUserRepository _userRepository;
        private readonly IBaseServices _baseServices;
        private readonly ITokenBlacklistRepository _tokenBlacklistRepository;

        public AuthService(
            IConfiguration configuration,
            AuthLogger authLogger,
            IUserRepository userRepository,
            IBaseServices baseServices,
            ITokenBlacklistRepository tokenBlacklistRepository)
        {
            _configuration = configuration;
            _authLogger = authLogger;
            _userRepository = userRepository;
            _baseServices = baseServices;
            _tokenBlacklistRepository = tokenBlacklistRepository;
        }

        public async Task<ServiceResult> VarificarUsuario(string token)
        {
            try
            {
                Guid id = JwtHelper.IdUsuario(token, _configuration);
                Guid idTipoTokenVerificacion = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenVarificacionCorreo"));
                var verificarBD = await _userRepository.TokesUsuarios(id, idTipoTokenVerificacion, token);
                if (verificarBD)
                {
                    var tokenvalido = JwtHelper.ValidateToken(token, _configuration);
                    if(!tokenvalido) throw new Exception("Ya expiro el Toke.");
                }
                else
                {
                    throw new Exception("Este token nunca fue enviado al correo.");
                }

                var tokens = await _userRepository.UsuarioVerificado(id); //Lista de token se guardarn el una lista megra de tokes en redis.

                foreach (var item in tokens)
                {
                    var (Jti, Expiration) = JwtHelper.GetTokenInfo(item);
                    await _tokenBlacklistRepository.AddToBlacklistAsync(Jti.ToString(), Expiration);
                }

                var usuario = await _userRepository.GetUserIdAsync(id);
                var crearToken = new CrearTokenModel
                {
                    Configuration = _configuration,
                    IdUsuario = id.ToString(),
                    NombreUsuario = usuario.user_NombreUsuario,
                    Roles = []
                };
                string tokenLogeo = JwtHelper.GenerateToken(crearToken);
                Guid idTipoTokenLogeo = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenLogin"));
                await _userRepository.GuardarToken(id, idTipoTokenLogeo, tokenLogeo);
                return new ServiceResult { 
                    Success = true, 
                    Message = "Usuario Verificado", 
                    Type = ServiceResultType.Success,
                    Data = new { token = tokenLogeo}
                };
            }
            catch (Exception ex)
            {
                return new ServiceResult { Success = false, Message = ex.Message };
            }
        }

        public async Task<ServiceResult> Login(string correo, string contraseña)
        {
            try
            {
                var usuarioVerificado = await _userRepository.UsuarioVerificado(correo, contraseña);
                if(usuarioVerificado is null)
                {
                    return new ServiceResult() { 
                        Message = "Contraseña o Correo incorrecto.",
                        Success = false,
                        Type = ServiceResultType.Unauthorize
                    };
                }
                var roles = await _userRepository.RolesUsuario(usuarioVerificado.user_Id);
                var claims = await _userRepository.ClaimsUsuario(usuarioVerificado.user_Id);

                var tokenModel = new CrearTokenModel()
                {
                    Configuration = _configuration,
                    IdUsuario = usuarioVerificado.user_Id.ToString(),
                    NombreUsuario = usuarioVerificado.user_NombreUsuario,
                    Expira = DateTime.Now.AddMinutes(5),
                    Roles = []
                };

                if (!usuarioVerificado.user_Verificado)
                {
                    var tokeValidar = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el Token para validar el usuario.");
                    Guid idTipoTokenCorreo = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenVarificacionCorreo"));
                    await _userRepository.GuardarToken(usuarioVerificado.user_Id, idTipoTokenCorreo, tokeValidar);

                    var ruta = await _baseServices.GetConfiguracion("ApiRutaToken");
                    var CorreoModel = new EmailDTO
                    {
                        Asunto = "Verificacion Del token",
                        DestinoCorreo = usuarioVerificado.user_Correo,
                        Cuerpo = $"{ruta}{tokeValidar}"
                    };
                    await _baseServices.Correo(CorreoModel);
                }

                tokenModel.Roles = roles ?? [];
                tokenModel.Claims = claims;
                tokenModel.Expira = null;
                var token = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el Token para logear al usuario.");

                Guid idTipoTokenLogin = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenLogin"));
                await _userRepository.GuardarToken(usuarioVerificado.user_Id, idTipoTokenLogin, token);
                return new ServiceResult()
                {
                    Data = usuarioVerificado.user_Verificado ? new { token } : new { token, CorreoEnviado = true },
                    Success = true,
                    Type = ServiceResultType.Success,
                    Message = usuarioVerificado.user_Verificado ? "Todo Bien." : $"Se envio el correo verificacion. al Correo {usuarioVerificado.user_Correo}, Revise el Spam."
                };
            }
            catch (Exception ex)
            {
                return new ServiceResult() { Success = false, Message = ex.Message, Type = ServiceResultType.Error };
            }
        }

        public async Task<ServiceResult> ObtenerRefrescarToken(string correo, string contraseña)
        {
            try
            {
                var usuarioVerificado = await _userRepository.UsuarioVerificado(correo, contraseña);
                if (usuarioVerificado is null)
                {
                    return new ServiceResult()
                    {
                        Message = "Contraseña o Correo incorrecto.",
                        Success = false,
                        Type = ServiceResultType.Unauthorize
                    };
                }

                var expiraTokenVerificacion = DateTime.Now.AddMinutes(5);
                var expiraRefresToken = DateTime.Now.AddDays(1);

                var tokenModel = new CrearTokenModel()
                {
                    Configuration = _configuration,
                    IdUsuario = usuarioVerificado.user_Id.ToString(),
                    NombreUsuario = usuarioVerificado.user_NombreUsuario,
                    Expira = expiraTokenVerificacion,
                    Roles = []
                };

                if (!usuarioVerificado.user_Verificado)//Si no se a verificado el correo.
                {
                    var tokeValidar = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el Token para validar el usuario.");
                    Guid idTipoTokenCorreo = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenVarificacionCorreo"));
                    await _userRepository.GuardarToken(usuarioVerificado.user_Id, idTipoTokenCorreo, tokeValidar);

                    var ruta = await _baseServices.GetConfiguracion("ApiRutaToken");
                    var CorreoModel = new EmailDTO
                    {
                        Asunto = "Verificacion Del token",
                        DestinoCorreo = usuarioVerificado.user_Correo,
                        Cuerpo = $"{ruta}{tokeValidar}"
                    };
                    await _baseServices.Correo(CorreoModel);

                    var (id, Expi) = JwtHelper.GetTokenInfo(tokeValidar);//Asegurar de que nunca lo utilizaran para los controladores
                    await _tokenBlacklistRepository.AddToBlacklistAsync(id.ToString(), Expi);
                }

                tokenModel.Expira = expiraRefresToken;
                var token = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el RefresToken.");

                Guid idTipoTokenRefres = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenRefresToken"));
                await _userRepository.GuardarToken(usuarioVerificado.user_Id, idTipoTokenRefres, token);

                var (Jti, Expiration) = JwtHelper.GetTokenInfo(token);//Asegurar de que nunca lo utilizaran para los controladores
                await _tokenBlacklistRepository.AddToBlacklistAsync(Jti.ToString(), Expiration);

                return new ServiceResult()
                {
                    Data = usuarioVerificado.user_Verificado ?
                            new { RefresToken = token, Expira = expiraRefresToken, PendienteVerificar = false } :
                            new { RefresToken = token, Expira = expiraRefresToken, PendienteVerificar = true, ExtiracionTokenVerificacion = expiraTokenVerificacion },
                    Success = true,
                    Type = ServiceResultType.Success,
                    Message = usuarioVerificado.user_Verificado ? "Se creo el refres Token." : $"Se envio el correo verificacion. al Correo {usuarioVerificado.user_Correo}, Revise el Spam."
                };
            }
            catch (Exception ex)
            {
                return new ServiceResult() { Success = false, Message = ex.Message, Type = ServiceResultType.Error };
            }
        }

        public async Task<ServiceResult> ObtenerAccessToken(string refresToken)
        {
            try
            {
                if (string.IsNullOrEmpty(refresToken)) throw new Exception("El refresToken no puede ser nulo ni estar vacío.");
                if (!JwtHelper.ValidateToken(refresToken, _configuration)) throw new Exception("RefresToken Invalido");

                var idUsuario = JwtHelper.IdUsuario(refresToken, _configuration);

                Guid idTipoTokenRefres = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenRefresToken"));
                var tokenValido =await _userRepository.TokesUsuarios(idUsuario, idTipoTokenRefres, refresToken);
                if (!tokenValido) throw new Exception("RefresToken Invalido");
                var expira = DateTime.Now.AddMinutes(1);
                var usuario = await _userRepository.GetUserIdAsync(idUsuario);
                var roles = await _userRepository.RolesUsuario(usuario.user_Id);
                var claims = await _userRepository.ClaimsUsuario(usuario.user_Id);

                var tokenModel = new CrearTokenModel()
                {
                    Configuration = _configuration,
                    IdUsuario = usuario.user_Id.ToString(),
                    NombreUsuario = usuario.user_NombreUsuario,
                    Expira = expira,
                    Roles = roles ?? [],
                    Claims = claims
                };

                var token = JwtHelper.GenerateToken(tokenModel) ?? throw new Exception("No se pudo generar el token de logeo.");
                Guid idTipoTokenLogeo = Guid.Parse(await _baseServices.GetConfiguracion("IdTipoTokenLogin"));
                await _userRepository.GuardarToken(usuario.user_Id, idTipoTokenLogeo, token);
                return new ServiceResult() { 
                    Data = new {TokenAccess = token, Expira = expira},
                    Type = ServiceResultType.Success,
                    Success = true,
                    Message = "Se creo un nuevo AccessToken"
                };
            }
            catch (Exception ex)
            {
                return new ServiceResult() { Success = false, Message = ex.Message, Type = ServiceResultType.Unauthorize };
            }
        }
    }
}
