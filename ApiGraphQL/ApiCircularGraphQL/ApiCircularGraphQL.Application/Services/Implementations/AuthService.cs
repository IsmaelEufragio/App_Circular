using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Logging;
using Microsoft.Extensions.Configuration;
using Security.Helpers;
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

        public AuthService(IConfiguration configuration, AuthLogger authLogger)
        {
            _configuration = configuration;
            _authLogger = authLogger;   
        }

        public string Authenticate(string username, string password)
        {
            if (username == "Josue" || password == "123") // ¡Usa hashing en producción!
            {
                var roles = new[] { "Admin" }; // Obtén los roles del usuario desde la base de datos
                _authLogger.LogAuthenticationAttempt("Josue", true);
                return JwtHelper.GenerateToken("1", "Josue", roles, _configuration);
            }
            return null;
        }
    }
}
