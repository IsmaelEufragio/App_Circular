﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace ApiCircularGraphQL.Domain.Entities;

public partial class tbCategoriaSubdivicion
{
    public Guid catSub_Id { get; set; }

    public string catSub_Nombre { get; set; }

    public virtual ICollection<tbSubdivicionLugar> tbSubdivicionLugar { get; set; } = new List<tbSubdivicionLugar>();
}