using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Usuario
{
    public class TelefonoViewModel:TelefonoModel
    {
        [JsonIgnore]
        public new int IdUsuario { get; set; }
    }
}
