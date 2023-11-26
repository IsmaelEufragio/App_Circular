using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Departamento
{
    public class PaisDepartamentoViewModel
    {
        public Guid Id { get; set; }
        public string Pais { get; set; }
        public string Abrebiatura { get; set; }
        public List<DepartamentoViewModel> Departamento { get; set; }
    }
}
