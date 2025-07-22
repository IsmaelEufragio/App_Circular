using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class RolDTO
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public string NombreNormalizado { get; set; }
        public List<UsuarioRolesDTO> UsuarioRoles { get; set; }
    }
}
