﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace AppCircular.Entities.Entities
{
    public partial class tbCategoria
    {
        public tbCategoria()
        {
            tbCatalogo = new HashSet<tbCatalogo>();
            tbCategoriaItem = new HashSet<tbCategoriaItem>();
            tbFiltroCategoriaTipo = new HashSet<tbFiltroCategoriaTipo>();
        }

        public Guid catg_Id { get; set; }
        public string catg_Nombre { get; set; }

        public virtual ICollection<tbCatalogo> tbCatalogo { get; set; }
        public virtual ICollection<tbCategoriaItem> tbCategoriaItem { get; set; }
        public virtual ICollection<tbFiltroCategoriaTipo> tbFiltroCategoriaTipo { get; set; }
    }
}