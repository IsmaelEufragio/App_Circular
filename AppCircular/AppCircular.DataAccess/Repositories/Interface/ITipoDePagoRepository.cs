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
    public interface ITipoDePagoRepository<T>
    {
        public Task<ResultadoModel<TipoDePagoViewModel>> ListAsync();
        public Task<ResultadoModel<TipoDePagoViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TipoDePagoViewModel>> UpdateAsync(Guid id, TipoDePagoModel item);
    }
}
