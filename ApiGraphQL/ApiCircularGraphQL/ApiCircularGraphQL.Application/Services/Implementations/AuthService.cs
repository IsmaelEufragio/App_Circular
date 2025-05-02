using ApiCircularGraphQL.Application.Configuracion;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.CrossCutting.Logging;
using ApiCircularGraphQL.CrossCutting.Model;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
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

        public string Authenticate(string username, string password)
        {
            if (username == "Josue" || password == "123") // ¡Usa hashing en producción!
            {
                var roles = new[] { "Admin" }; // Obtén los roles del usuario desde la base de datos
                _authLogger.LogAuthenticationAttempt("Josue", true);
                var tokenModel = new CrearTokenModel
                {
                    IdUsuario = "1",
                    NombreUsuario = "Josue",
                    Configuration = _configuration,
                    Roles = roles
                };
                return JwtHelper.GenerateToken(tokenModel);
            }
            return null;
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
    }
}
