using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IConfiguracionRepository<T>
    {
        public Task<ResultadoModel<ConfiguracioViewModel>> ListAsync();
        public Task<ResultadoModel<ConfiguracioViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<ConfiguracioViewModel>> UpdateAsync(Guid id, ConfiguracionModel item);
        public Task<ResultadoModel<string>> WhereAsync(string nombre);
    }
}
