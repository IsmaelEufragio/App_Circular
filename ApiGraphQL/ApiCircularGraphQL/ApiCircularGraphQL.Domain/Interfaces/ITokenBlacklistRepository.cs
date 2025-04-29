using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Domain.Interfaces
{
    public interface ITokenBlacklistRepository
    {
        Task BlacklistTokenAsync(string tokenId);
        Task<bool> IsTokenBlacklistedAsync(string tokenId);
    }
}
