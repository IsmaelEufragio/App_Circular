using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class UserPrincipalDTO
    {
        public Guid Id { get; set; }
        public bool UnicoUsuario { get; set; }
        public string Nombre { get; set; }
        public string RutaDelLogo { get; set; }
        public string RutaDeLaPaginaWeb { get; set; }
        public Guid IdTipoUsuario { get; set; }
        public List<UserDTO> Usuarios { get; set; }
    }
}
