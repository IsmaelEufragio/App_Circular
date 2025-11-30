using ApiCircularGraphQL.Application.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IMunicipioService
    {
        Task<IEnumerable<MunicipioDTO>> GetMunicipios();
        Task<Dictionary<Guid, MunicipioDTO[]>> GetMunicipiosPorDepartamento(IReadOnlyList<Guid> ids);
    }
}
