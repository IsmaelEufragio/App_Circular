﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using AppCircular.Common.Models.Usuario;

namespace AppCircular.Common.Models.Genericos
{
    public class TipoTelefonoModel : TipoTelefonoViewModel
    {
        [JsonIgnore]
        public new int? IdTipoTelefono { get; set; }
    }
}
