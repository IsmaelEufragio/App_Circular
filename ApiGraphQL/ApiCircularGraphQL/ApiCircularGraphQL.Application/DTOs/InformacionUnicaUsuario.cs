using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class InformacionUnicaUsuario
    {
        public Guid IdTipoUsuario { get; set; }
        public string TipoUsuario { get; set; }
        public bool IgualSubInfo { get; set; }
        public string Nombre { get; set; }
        public string Logo { get; set; }
        public string PaginaWeb { get; set; }
        public bool Varificado { get; set; }

    }
}
