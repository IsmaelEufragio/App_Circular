﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace AppCircular.Entities.Entities
{
    public partial class tbLugar
    {
        public tbLugar()
        {
            tbSubdivicionLugar = new HashSet<tbSubdivicionLugar>();
        }

        public Guid lug_Id { get; set; }
        public string lug_Nombre { get; set; }
        public Guid catLug_Id { get; set; }
        public Guid muni_Id { get; set; }

        public virtual tbCategoriaLugar catLug { get; set; }
        public virtual tbMunicipio muni { get; set; }
        public virtual ICollection<tbSubdivicionLugar> tbSubdivicionLugar { get; set; }
    }
}