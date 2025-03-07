using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class TelefonosUsuarioDTO
    {
        public Guid IdTipoTelefono { get; set; }
        public string TipoTelefono { get; set; }
        public string Telefono { get; set; }
    }
}
