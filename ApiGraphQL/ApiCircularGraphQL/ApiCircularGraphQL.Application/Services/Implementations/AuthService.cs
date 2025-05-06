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
                var verificarBD = await _userRepository.VerificarToke(id, idTipoTokenVerificacion, token);
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
    }
}
