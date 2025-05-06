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
        Task<ServiceResult> Login(string correo, string contraseña);
        Task<ServiceResult> VarificarUsuario(string token);
    }
}
