using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.Services
{
    public class ConfiguracionServices
    {
        private readonly ConfiguracionRepository _configuracionRepository;
        private static string nombre = "Configuracion";
        public ConfiguracionServices(ConfiguracionRepository configuracionRepository)
        {
            _configuracionRepository = configuracionRepository;
        }

        public async Task<ServiceResult> listaConfiguarcion()
        {
            try
            {
                var repositorio = await _configuracionRepository.ListAsync();
                var resul = new Test<TipoUsuarioViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearlistaConfiguarcion(ConfiguracionModel model)
        {
            var tb = new tbConfiguracion();
            tb.conf_Nombre = nombre;
            tb.conf_Valor = nombre;
            tb.conf_Descripcion = model.Descripcion;
            var repositorio = await _configuracionRepository.InsertAsync(tb);
            return new Test<TipoUsuarioViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTipoUser(int id, ConfiguracionModel model)
        {
            var listado = await _configuracionRepository.UpdateAsync(id, model);
            return new Test<TipoUsuarioViewModel>().mape(listado);
        }
    }
}
