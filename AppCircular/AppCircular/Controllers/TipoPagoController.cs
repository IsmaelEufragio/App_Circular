using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipoPagoController : Controller
    {
        private readonly ConfiguracionServices _configuracionServices;
        public TipoPagoController(ConfiguracionServices configuracionServices)
        {
            _configuracionServices = configuracionServices;
        }
        [HttpGet, Authorize, Route("TipoPagoLis")]
        public async Task<IActionResult> ListaTipoPago()
        {
            var item = await _configuracionServices.listaTipoPago();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TipoPagoInsert")]
        public async Task<IActionResult> CrearTipoPago(TipoDePagoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.CrearTipoPago(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TipoPagoUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoPago(int Id, TipoDePagoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.ActualizarTipoPago(Id, model);
            }
            return Ok(resul);
        }
    }
}
