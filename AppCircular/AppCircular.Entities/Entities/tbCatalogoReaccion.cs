﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace AppCircular.Entities.Entities
{
    public partial class tbCatalogoReaccion
    {
        public Guid catRea_Id { get; set; }
        public Guid catg_Id { get; set; }
        public Guid user_Id { get; set; }

        public virtual tbCatalogo catg { get; set; }
        public virtual tbUsuarios user { get; set; }
    }
}