using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ICategoriaRepository<T>
    {
        public Task<ResultadoModel<CategoriaViewModel>> ListAsync();
        public Task<ResultadoModel<CategoriaViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<CategoriaViewModel>> UpdateAsync(Guid id, CategoriaModel item);
    }
}
