using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class TelefonosUsuarioDTO
    {
        public Guid IdUsuario { get; set; }
        public Guid IdTipoTelefono { get; set; }
        public string Telefono { get; set; }
    }
}
