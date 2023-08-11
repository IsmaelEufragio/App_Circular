using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Municipio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IMunicipioRepository<T>
    {
        public Task<ServiceResult> ListAsync();
        public Task<ServiceResult> InsertAsync(T item);
        public Task<ServiceResult> UpdateAsync(int Id, MunicipioModel item);
    }
}
