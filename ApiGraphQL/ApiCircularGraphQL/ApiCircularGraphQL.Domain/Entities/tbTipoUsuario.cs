﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace ApiCircularGraphQL.Domain.Entities;

public partial class tbTipoUsuario
{
    public Guid tipUs_Id { get; set; }

    public string tipUs_Descripcion { get; set; }

    public virtual ICollection<tbCatalogoPorUsuario> tbCatalogoPorUsuario { get; set; } = new List<tbCatalogoPorUsuario>();

    public virtual ICollection<tbInfoUnicaUsuario> tbInfoUnicaUsuario { get; set; } = new List<tbInfoUnicaUsuario>();
}