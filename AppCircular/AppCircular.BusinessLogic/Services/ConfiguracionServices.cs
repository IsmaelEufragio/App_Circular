using AppCircular.BusinessLogic.LibreriaClases;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.Services
{
    public class ConfiguracionServices:BaseServices
    {
        private static string nombre = "Configuracion";

        public ConfiguracionServices(   ConfiguracionRepository configuracionRepository,
                                        IOptions<JwtModel> jwtSettings,
                                        IConfiguration iConfiguration
            ) : base(configuracionRepository,jwtSettings, iConfiguration)
        {
        }
         
        public async Task<ServiceResult> listaConfiguarcion()
        {
            try
            {
                var repositorio = await _configuracionRepository.ListAsync();
                var resul = new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearConfiguarcion(ConfiguracionModel model)
        {
            var tb = new tbConfiguracion();
            tb.conf_Nombre = model.Nombre;
            tb.conf_Valor = model.Valor;
            tb.conf_Descripcion = model.Descripcion;
            var repositorio = await _configuracionRepository.InsertAsync(tb);
            return new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarConfiguracion(int id, ConfiguracionModel model)
        {
            var listado = await _configuracionRepository.UpdateAsync(id, model);
            return new Convertidor<TipoUsuarioViewModel>().mape(listado);
        }
    }
}
