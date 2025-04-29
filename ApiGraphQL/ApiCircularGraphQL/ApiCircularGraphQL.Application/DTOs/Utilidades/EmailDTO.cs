using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Utilidades
{
    public class EmailDTO
    {
        public string DestinoCorreo { get; set; }
        public string Asunto { get; set; }
        public string Cuerpo { get; set; }
    }
}
