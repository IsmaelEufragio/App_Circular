using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IDepartamentoRepository<T>
    {
        public Task<ServiceResult> ListAsync();
        public Task<ServiceResult> InsertAsync(T item);
        public Task<ServiceResult> UpdateAsync(int Id, DepartamentoModel item);
    }
}
