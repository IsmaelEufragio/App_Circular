using Microsoft.Extensions.Logging;

namespace ApiCircularGraphQL.CrossCutting.Logging
{
    public class AuthLogger
    {
        private readonly ILogger<AuthLogger> _logger;

        public AuthLogger(ILogger<AuthLogger> logger)
        {
            _logger = logger;
        }

        public void LogAuthenticationAttempt(string username, bool success)
        {
            if (success)
            {
                _logger.LogInformation($"Autenticación exitosa para el usuario: {username}");
            }
            else
            {
                _logger.LogWarning($"Intento de autenticación fallido para el usuario: {username}");
            }
        }
    }
}
