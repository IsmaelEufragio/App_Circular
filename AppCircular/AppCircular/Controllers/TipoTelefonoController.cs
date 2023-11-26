using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using AppCircular.Common.Models.Usuario;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipoTelefonoController : Controller
    {
        private readonly ConfiguracionServices _configuracionServices;
        public TipoTelefonoController(ConfiguracionServices configuracionServices)
        {
            _configuracionServices = configuracionServices;
        }

        [HttpGet, Authorize, Route("TipoTelefonoLis")]
        public async Task<IActionResult> ListaTipoTelefono()
        {
            var item = await _configuracionServices.listaTipoTelefono();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TipoTelefonoInsert")]
        public async Task<IActionResult> CrearTipoTelefono(TipoTelefonoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.CrearTipoTelefono(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TipoTelefonoUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoTelefono(Guid Id, TipoTelefonoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.ActualizarTipoTelefono(Id, model);
            }
            return Ok(resul);
        }

    }
}
