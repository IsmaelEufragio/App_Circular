﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace AppCircular.Entities.Entities
{
    public partial class tbCatalogoImagen
    {
        public Guid catImg_Id { get; set; }
        public Guid catg_Id { get; set; }
        public Guid tipImg_Id { get; set; }
        public string catImg_RutaImagen { get; set; }

        public virtual tbCatalogo catg { get; set; }
        public virtual tbTipoImagen tipImg { get; set; }
    }
}