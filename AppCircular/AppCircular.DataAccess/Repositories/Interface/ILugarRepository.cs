using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using AppCircular.Common.Models.Usuario;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ILugarRepository<T>
    {
        public Task<ResultadoModel<LugarViewModel>> ListAsync();
        public Task<ResultadoModel<LugarViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<LugarViewModel>> UpdateAsync(Guid id, LugarModel item);
    }
}
