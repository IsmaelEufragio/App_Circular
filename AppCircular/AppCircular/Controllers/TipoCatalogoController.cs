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
    public class TipoCatalogoController : Controller
    {
        private readonly ConfiguracionServices _configuracionServices;
        public TipoCatalogoController(ConfiguracionServices configuracionServices)
        {
            _configuracionServices = configuracionServices;
        }
        [HttpGet, Authorize, Route("TipoCatalogoLis")]
        public async Task<IActionResult> ListaTipoCatalogo()
        {
            var item = await _configuracionServices.listaTipoCatalogo();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TipoCatalogoInsert")]
        public async Task<IActionResult> CrearTipoCatalogo(TipoCatalogoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.CrearTipoCatalogo(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TipoCatalogoUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoCatalogo(Guid Id, TipoCatalogoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.ActualizarTipoCatalogo(Id, model);
            }
            return Ok(resul);
        }
    }
}
