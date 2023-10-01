using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using AppCircular.Common.Models.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ITipoTelefonoRepository<T>
    {
        public Task<ResultadoModel<TipoTelefonoViewModel>> ListAsync();
        public Task<ResultadoModel<TipoTelefonoViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TipoTelefonoViewModel>> UpdateAsync(int id, TipoTelefonoModel item);
    }
}
