using ApiCircularGraphQL.Application.DTOs;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class DepartamentoService: IDepartamentoService
    {
        private readonly IDepartamentoRepository _departamento;
        public DepartamentoService(IDepartamentoRepository departamento)
        {
            _departamento = departamento;
        }

        public async Task<IEnumerable<DepartamentoDTO>> GetDepartamentosAsync()
        {
            var departamento = await _departamento.GetAllAsync();
            return departamento.Select(a => new DepartamentoDTO
            {
                Id = a.dept_Id,
                Nombre = a.dept_Nombre
            });
        }

    }
}
