﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace ApiCircularGraphQL.Domain.Entities;

public partial class tbTipoCatalogo
{
    public Guid tipCatg_Id { get; set; }

    public string tipCatg_Descripcion { get; set; }

    public virtual ICollection<tbCatalogoPorUsuario> tbCatalogoPorUsuario { get; set; } = new List<tbCatalogoPorUsuario>();

    public virtual ICollection<tbFacturaDetalle> tbFacturaDetalle { get; set; } = new List<tbFacturaDetalle>();

    public virtual ICollection<tbFiltroCategoriaTipo> tbFiltroCategoriaTipo { get; set; } = new List<tbFiltroCategoriaTipo>();

    public virtual ICollection<tbPedidoDetalle> tbPedidoDetalle { get; set; } = new List<tbPedidoDetalle>();
}