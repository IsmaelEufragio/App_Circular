using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Lugar
{
    public class LugarViewModel
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public Guid CatLug_Id { get; set; }
        public string CategoriaLugar { get; set; }
        public Guid Muni_Id { get; set; }
        public string Municipio { get; set; }

    }
}
