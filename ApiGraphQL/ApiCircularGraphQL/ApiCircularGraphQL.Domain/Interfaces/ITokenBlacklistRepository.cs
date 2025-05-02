using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Domain.Interfaces
{
    public interface ITokenBlacklistRepository
    {
        Task AddToBlacklistAsync(string tokenId, DateTimeOffset expiration);
        void Dispose();
        Task<bool> IsTokenBlacklistedAsync(string tokenId);
    }
}
