using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Autenticacion
{
    public class LoginDTO
    {
        public string Correo { get; set; }
        public string Passsword { get; set; }
    }
}
