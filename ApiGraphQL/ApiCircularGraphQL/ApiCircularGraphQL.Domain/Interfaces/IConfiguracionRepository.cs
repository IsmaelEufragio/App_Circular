using ApiCircularGraphQL.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Domain.Interfaces
{
    public interface IConfiguracionRepository : IRepository<tbConfiguracion>
    {
        Task<string> GetConfiguracion(string nombre);
    }
}
