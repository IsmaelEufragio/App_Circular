﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace ApiCircularGraphQL.Domain.Entities;

public partial class tbTipoContrato
{
    public Guid tipC_Id { get; set; }

    public string tipC_Descripcion { get; set; }

    public virtual ICollection<tbVacante> tbVacante { get; set; } = new List<tbVacante>();
}