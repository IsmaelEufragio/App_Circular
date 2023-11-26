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
    public interface ITipoImagenRepository<T>
    {
        public Task<ResultadoModel<TipoImagenViewModel>> ListAsync();
        public Task<ResultadoModel<TipoImagenViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TipoImagenViewModel>> UpdateAsync(Guid id, TipoImagenModel item);
    }
}
