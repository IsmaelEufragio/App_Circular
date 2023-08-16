using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories
{
    public class LugarRepository : ILugarRepository<tbLugar>
    {
        public Task<ResultadoModel<TipoUsuarioViewModel>> InsertAsync(tbLugar item)
        {
            throw new NotImplementedException();
        }

        public Task<ResultadoModel<TipoUsuarioViewModel>> ListAsync()
        {
            throw new NotImplementedException();
        }

        public Task<ResultadoModel<TipoUsuarioViewModel>> UpdateAsync(int Id, TipoUsuarioModel item)
        {
            throw new NotImplementedException();
        }
    }
}
