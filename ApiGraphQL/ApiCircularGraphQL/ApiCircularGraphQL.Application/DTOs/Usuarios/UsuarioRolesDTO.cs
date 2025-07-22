using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class UsuarioRolesDTO
    {
        public Guid IdUsuario { get; set; }
        public UserDTO Usuario { get; set; }
        public Guid IdRol { get; set; }
        public RolDTO Rol { get; set; }
    }
}
