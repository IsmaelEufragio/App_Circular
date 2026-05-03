using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Infrastructure.Persistence.Repositories
{
    public class VerificationCodeRepository : IVerificationCodeRepository
    {
        private readonly IDistributedCache _cache;
        private readonly ILogger<VerificationCodeRepository> _logger;
        private bool _disposed = false;
        public VerificationCodeRepository(IDistributedCache cache, ILogger<VerificationCodeRepository> logger)
        {
            _cache = cache ?? throw new ArgumentNullException(nameof(cache));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public async Task<string> GenerarCodigo(string idUser, DateTimeOffset expiration)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(idUser))
                    throw new ArgumentException("El IdUser no puede estar vacío", nameof(idUser));

                string code = GenerarCodigoNumerico();
                var result = new
                {
                    id = idUser,
                    code
                };
                string jsonString = JsonSerializer.Serialize(result);

                var options = new DistributedCacheEntryOptions
                {
                    AbsoluteExpiration = expiration
                };

                await _cache.SetStringAsync($"usuario:verificacion:{idUser}", jsonString, options);

                return code;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al generar el codigo de verificacion, idUsuario{idUser}", idUser);
                return string.Empty;
            }
        }

        private static string GenerarCodigoNumerico(int longitud = 6)
        {
            Random random = new Random();
            string codigo = "";

            for (int i = 0; i < longitud; i++)
            {
                codigo += random.Next(0, 10).ToString();
            }

            return codigo;
        }


        public async Task<bool> ValidarCodigo(string idUser, string code)
        {
            try
            {
                string jsonString = await _cache.GetStringAsync("usuario:verificacion:" + idUser) ?? string.Empty;
                if (string.IsNullOrWhiteSpace(jsonString))
                    return false;

                var result = JsonSerializer.Deserialize<Dictionary<string, object>>(jsonString);
                string codeDb = result?["code"]?.ToString() ?? string.Empty;

                return codeDb == code;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al compobar el codigo de verificacion, idUsuario{idUser}", idUser);
                return false;
            }
        }
    }
}
