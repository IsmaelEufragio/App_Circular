﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.SubdivicionLugar
{
    public class SubdivicionLugarViewModel
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; }
        public Guid sub_Id { get; set; }
        public Guid lug_Id { get; set; }

    }
}
