using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Municipio
{
    public class MunicipioModel
    {
        public string Nombre { get; set; }
        public Guid dept_Id { get; set; }
        public int NuIdentidad { get; set; }
        public string ValidaciosTelefono { get; set; }
        public string ValidaciosTelefonoFijo { get; set; }
    }
}
