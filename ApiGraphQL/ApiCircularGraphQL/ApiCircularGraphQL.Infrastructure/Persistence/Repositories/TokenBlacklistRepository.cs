using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.Extensions.Caching.Distributed;
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
        private readonly DistributedCacheEntryOptions _options;

        public TokenBlacklistRepository(IDistributedCache cache)
        {
            _cache = cache;
            _options = new DistributedCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(1)
            };
        }

        public async Task BlacklistTokenAsync(string tokenId)
        {
            await _cache.SetStringAsync(GetKey(tokenId), "blacklisted", _options);
        }

        public async Task<bool> IsTokenBlacklistedAsync(string tokenId)
        {
            try
            {
                var result = await _cache.GetStringAsync(GetKey(tokenId));
                return result != null;
            }
            catch (Exception ex)
            {
                return true;
            }
        }

        private static string GetKey(string tokenId) => $"blacklist:{tokenId}";
    }
}
