using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Domain.Interfaces
{
    public interface IVerificationCodeRepository
    {
        Task<string> GenerarCodigo(string idUser, DateTimeOffset expiration);
        Task<bool> ValidarCodigo(string idUser, string code);
    }
}
