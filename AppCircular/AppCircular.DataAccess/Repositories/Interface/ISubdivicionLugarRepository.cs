using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using AppCircular.Common.Models.SubdivicionLugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ISubdivicionLugarRepository<T>
    {
        public Task<ResultadoModel<SubdivicionLugarViewModel>> ListAsync();
        public Task<ResultadoModel<SubdivicionLugarViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<SubdivicionLugarViewModel>> UpdateAsync(Guid id, SubdivicionLugarModel item);
        public Task<ResultadoModel<bool>> WhereAsync(Guid idSubDivicionLugar);
    }
}
