using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class UbicacionUsuarioDTO
    {
        public Guid IdUbicacion { get; set; }
        public string Latitud { get; set; }
        public string Longitud { get; set; }
        public string ColoniaCacerio { get; set; }
        public string SubCategoria { get; set; }
        public string Lugar { get; set; }
        public string CategoriaLugar { get; set; }
        public string Municipio { get; set; }
        public string Departamento { get; set; }
        public string Pais { get; set; }
    }
}
