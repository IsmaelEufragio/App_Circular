using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Usuario
{
    public class InfoUnicaUsuarioViewModel
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public string RutaLogo { get; set; }
        public string RutaPaginaWed { get; set; }
        public bool? IgualSubInfo { get; set; }
        public Guid tipUs_Id { get; set; }
    }
}
