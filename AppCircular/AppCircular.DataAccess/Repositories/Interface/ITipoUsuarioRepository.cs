using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface ITipoUsuarioRepository<T>
    {
        public Task<ResultadoModel<TipoUsuarioViewModel>> ListAsync();
        public Task<ResultadoModel<TipoUsuarioViewModel>> InsertAsync(tbTipoUsuario item);
        public Task<ResultadoModel<TipoUsuarioViewModel>> UpdateAsync(int Id, TipoUsuarioModel item);
    }
}
