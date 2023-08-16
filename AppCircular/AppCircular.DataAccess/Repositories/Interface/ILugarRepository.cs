using AppCircular.Common.Models.Configuracion;
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
        public Task<ResultadoModel<TipoUsuarioViewModel>> ListAsync();
        public Task<ResultadoModel<TipoUsuarioViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<TipoUsuarioViewModel>> UpdateAsync(int Id, TipoUsuarioModel item);
    }
}
