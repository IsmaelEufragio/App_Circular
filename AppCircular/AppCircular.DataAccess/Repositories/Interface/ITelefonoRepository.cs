using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ITelefonoRepository<T>
    {
        public Task<ResultadoModel<TelefonoModel>> ListAsync();
        public Task<ResultadoModel<TelefonoViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TelefonoViewModel>> UpdateAsync(Guid id, TelefonoModel item);
    }
}
