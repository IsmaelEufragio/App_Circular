using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class LugarDTO
    {
        public Guid Id { get; set; }
        public string Descripcion { get; set; }
        public List<SubdivicionLugarDTO> Colonia { get; set; }
    }
}
