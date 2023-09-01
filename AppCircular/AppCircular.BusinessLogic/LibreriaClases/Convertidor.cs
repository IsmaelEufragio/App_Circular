using AppCircular.Common.Models.Configuracion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.LibreriaClases
{
    public class Convertidor<A>
    {
        public ServiceResult mape<A>(ResultadoModel<A> item)
        {
            ServiceResult result = new ServiceResult();
            result.Success = item.Success;
            result.Data = item.Data;
            result.Message = item.Message;
            result.Type = item.Type;
            return result;
        }
    }
}
