using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class UbicacionDTO
    {
        public Guid IdUbicacion { get; set; }
        public string Latitud { get; set; }
        public string Longitud{ get; set; }

    }
}
