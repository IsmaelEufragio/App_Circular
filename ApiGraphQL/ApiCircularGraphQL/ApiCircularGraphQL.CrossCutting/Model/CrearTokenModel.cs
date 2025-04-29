using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.CrossCutting.Model
{
    public class CrearTokenModel
    {
        public string IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public DateTime? Expira { get; set; }
        public string[] Roles { get; set; } = [];
        public IConfiguration Configuration { get; set; }
        public Dictionary<string, string> Claims { get; set; } = [];
    }
}
