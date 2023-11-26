using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Lugar
{
    public class LugarModel
    {
        public string Nombre { get; set; }
        public Guid catLug_Id { get; set; }
        public Guid muni_Id { get; set; }
    }
}
