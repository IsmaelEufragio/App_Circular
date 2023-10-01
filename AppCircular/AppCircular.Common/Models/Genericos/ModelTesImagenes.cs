using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Genericos
{
    public class ModelTesImagenes
    {
        public int IdCliente { get; set; }
        public string Nombre { get; set; }
        public List<IFormFile> Ima { get; set; }
    }
}
