using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
using AppCircular.Common.Models.Municipio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IDepartamentoRepository<T>
    {
        public Task<ResultadoModel<PaisDepartamentoViewModel>> ListAsync();
        public Task<ResultadoModel<PaisDepartamentoViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<PaisDepartamentoViewModel>> UpdateAsync(int Id, DepartamentoModel item);
    }
}
