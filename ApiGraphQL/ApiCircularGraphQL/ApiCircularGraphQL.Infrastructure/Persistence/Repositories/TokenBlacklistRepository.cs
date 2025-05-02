using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Infrastructure.Persistence.Repositories
{
    public class TokenBlacklistRepository : ITokenBlacklistRepository
    {
        private readonly IDistributedCache _cache;
        private readonly ILogger<TokenBlacklistRepository> _logger;
        private bool _disposed = false;
        public TokenBlacklistRepository(IDistributedCache cache, ILogger<TokenBlacklistRepository> logger)
        {
            _cache = cache ?? throw new ArgumentNullException(nameof(cache));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public async Task AddToBlacklistAsync(string tokenId, DateTimeOffset expiration)
        {
            if (string.IsNullOrWhiteSpace(tokenId))
                throw new ArgumentException("El ID de token no puede estar vacío", nameof(tokenId));

            try
            {
                var options = new DistributedCacheEntryOptions
                {
                    AbsoluteExpiration = expiration
                };

                await _cache.SetStringAsync(
                    GetCacheKey(tokenId),
                    "blacklisted",
                    options);

                _logger.LogInformation("Token {TokenId} añadido a la lista negra hasta que {Expiration}",
                    tokenId, expiration);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al agregar el token {TokenId} a la lista negra", tokenId);
                throw;
            }
        }

        public async Task<bool> IsTokenBlacklistedAsync(string tokenId)
        {
            if (string.IsNullOrWhiteSpace(tokenId))
                return false;

            try
            {
                var cachedValue = await _cache.GetStringAsync(GetCacheKey(tokenId));
                return cachedValue != null;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Comprobación de errores si el token {TokenId} está en la lista negra", tokenId);
                // Fail secure: assume token is blacklisted if we can't verify
                return true;
            }
        }

        private static string GetCacheKey(string tokenId) => $"blacklist:{tokenId}";

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    // Cleanup if needed
                }
                _disposed = true;
            }
        }
    }
}
