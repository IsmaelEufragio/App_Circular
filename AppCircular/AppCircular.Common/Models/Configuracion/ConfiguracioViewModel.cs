﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Configuracion
{
    public class ConfiguracioViewModel
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public string Valor { get; set; }
        public string Descripcion { get; set; }
    }
}
