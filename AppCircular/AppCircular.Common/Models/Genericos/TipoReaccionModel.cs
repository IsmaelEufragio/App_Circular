using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Genericos
{
    public class TipoReaccionModel : TipoReaccionViewModel
    {
        [JsonIgnore]
        public new int idTipoReaccion { get; set; }
    }
}
