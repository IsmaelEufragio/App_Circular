using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class SubdivicionLugarDTO
    {
        public Guid IdSubdivicionLugar { get; set; }
        public string NombreSubdivicion { get; set; }
        public CategoriaSubdivicion Categoria { get; set; }

    }
}
