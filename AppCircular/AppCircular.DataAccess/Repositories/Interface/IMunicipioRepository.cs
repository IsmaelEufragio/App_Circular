using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Municipio;
using AppCircular.Common.Models.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IMunicipioRepository<T>
    {
        public Task<ResultadoModel<DeparmentoMunicipioViewModel>> ListAsync();
        public Task<ResultadoModel<DeparmentoMunicipioViewModel>> InsertAsync(T item);
        public Task<ResultadoModel<DeparmentoMunicipioViewModel>> UpdateAsync(Guid Id, MunicipioModel item);
    }
}
