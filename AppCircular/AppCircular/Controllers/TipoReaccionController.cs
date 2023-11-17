using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipoReaccionController : Controller
    {
        private readonly ConfiguracionServices _configuracionServices;
        public TipoReaccionController(ConfiguracionServices configuracionServices)
        {
            _configuracionServices = configuracionServices;
        }

        [HttpGet, Authorize, Route("TipoReaccionLis")]
        public async Task<IActionResult> ListaTipoReaccion()
        {
            var item = await _configuracionServices.listaTipoReaccion();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TipoReaccionInsert")]
        public async Task<IActionResult> CrearTipoTelefono(TipoReaccionModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.CrearTipoReaccion(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TipoReaccionUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoReaccion(int Id, TipoReaccionModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.ActualizarTipoReaccion(Id, model);
            }
            return Ok(resul);
        }
    }
}
