using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class SubdivicionLugarDTO
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public CategoriaSubdivicion Categoria { get; set; }

    }
}
