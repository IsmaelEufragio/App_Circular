﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace ApiCircularGraphQL.Domain.Entities;

public partial class tbCategoriaPorHabilidad
{
    public Guid subCat_Id { get; set; }

    public Guid hab_Id { get; set; }

    public bool principal { get; set; }

    public virtual tbHabilidad hab { get; set; }

    public virtual tbSubCategoria subCat { get; set; }
}