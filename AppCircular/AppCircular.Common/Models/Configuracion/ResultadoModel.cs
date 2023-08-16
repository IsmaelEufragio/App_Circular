using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Configuracion
{
    public class ResultadoModel<T>
    {
        public string Message { get; set; }
        public bool Success { get; set; }
        public List<T> Data { get; set; }
        public ServiceResultType Type { get; set; }
        public T Value { get; set; }
    }

}
