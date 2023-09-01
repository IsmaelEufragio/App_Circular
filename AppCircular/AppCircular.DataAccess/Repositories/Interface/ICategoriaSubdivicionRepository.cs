using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.CategoriaSubdivicion;
using AppCircular.Common.Models.Configuracion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ICategoriaSubdivicionRepository<T>
    {
        public Task<ResultadoModel<CategoriaSubdivicionViewModel>> ListAsync();
        public Task<ResultadoModel<CategoriaSubdivicionViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<CategoriaSubdivicionViewModel>> UpdateAsync(int id, CategoriaSubdivicionModel item);
    }
}
