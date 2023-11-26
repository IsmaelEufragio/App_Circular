using AppCircular.Common.Models.Municipio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Departamento
{
    public class DepartamentoViewModel
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public int NuIdentidad { get; set; }
    }
}
