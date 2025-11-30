using ApiCircularGraphQL.Application.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface ILugarService
    {
        Task<Dictionary<Guid, LugarDTO[]>> GetLugarPorMunicipio(IReadOnlyList<Guid> ids);
        Task<IEnumerable<LugarDTO>> GetLugarsAsync();
    }
}
