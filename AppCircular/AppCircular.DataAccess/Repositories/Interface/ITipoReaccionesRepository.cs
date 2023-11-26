using AppCircular.Common.Models.Catalogo;
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
    public interface ITipoReaccionesRepository<T>
    {
        public Task<ResultadoModel<TipoReaccionViewModel>> ListAsync();
        public Task<ResultadoModel<TipoReaccionViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TipoReaccionViewModel>> UpdateAsync(Guid id, TipoReaccionModel item);
    }
}
