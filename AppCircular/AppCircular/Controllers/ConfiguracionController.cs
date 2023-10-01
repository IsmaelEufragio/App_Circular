using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ConfiguracionController : ControllerBase
    {
        private readonly ConfiguracionServices _configuracionServices;
        public ConfiguracionController(ConfiguracionServices configuracionServices)
        {
            _configuracionServices = configuracionServices;
        }

        [HttpGet]
        //[Authorize]
        [Route("LisConfiguracion")]
        public async Task<IActionResult> ListaConfig()
        {
            var item = await _configuracionServices.listaConfiguarcion();

            return Ok(item);
        }


        [HttpPost]
        [Authorize]
        [Route("InsertConfiguracion")]
        public async Task<IActionResult> CrearConfig(ConfiguracionModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.CrearConfiguarcion(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Authorize]
        [Route("UpdateConfiguracion/{Id}")]
        public async Task<IActionResult> ActulizarConfig(int Id, ConfiguracionModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.ActualizarConfiguracion(Id, model);
            }
            return Ok(resul);
        }
    }
}
