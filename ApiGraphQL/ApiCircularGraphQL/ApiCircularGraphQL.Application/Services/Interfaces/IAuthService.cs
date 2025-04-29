using ApiCircularGraphQL.Application.Configuracion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IAuthService
    {
        string Authenticate(string username, string password);
        Task<ServiceResult> VarificarUsuario(string token);
    }
}
