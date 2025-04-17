using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class TipoUsuarioDTO
    {
        public Guid Id { get; set; }
        public string Descripcion { get; set; }
    }
}
