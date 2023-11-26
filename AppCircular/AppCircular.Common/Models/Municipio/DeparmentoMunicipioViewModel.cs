using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Municipio
{
    public class DeparmentoMunicipioViewModel
    {
        public Guid Id { get; set; }
        public string Departamento { get; set; }
        public int NuIdentidad { get; set; }
        public List<MunicipioViewModel> Municipio { get; set; }
    }
}
