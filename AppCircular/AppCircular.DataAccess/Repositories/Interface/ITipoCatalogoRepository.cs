using AppCircular.Common.Models.Catalogo;
using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ITipoCatalogoRepository<T>
    {
        public Task<ResultadoModel<TipoCatalogoViewModel>> ListAsync();
        public Task<ResultadoModel<TipoCatalogoViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TipoCatalogoViewModel>> UpdateAsync(Guid id, TipoCatalogoModel item);
    }
}
