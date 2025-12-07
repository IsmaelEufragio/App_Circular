using ApiCircularGraphQL.Application.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface ISubdivicionLugarService
    {
        Task<IEnumerable<SubdivicionLugarDTO>> GetSubdivicionLugarAsync();
        Task<Dictionary<Guid, SubdivicionLugarDTO[]>> GetSubdivicionPorLugar(IReadOnlyList<Guid> idsLugar);
    }
}
