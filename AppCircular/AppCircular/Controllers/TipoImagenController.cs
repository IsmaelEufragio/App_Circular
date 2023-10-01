using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TipoImagenController : Controller
    {
        private readonly ConfiguracionServices _configuracionServices;
        public TipoImagenController(ConfiguracionServices configuracionServices)
        {
            _configuracionServices = configuracionServices;
        }
        [HttpGet, Authorize, Route("TipoImagenLis")]
        public async Task<IActionResult> ListaTipoImagen()
        {
            var item = await _configuracionServices.listaTipoImagenes();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TipoImagenInsert")]
        public async Task<IActionResult> CrearTipoTelefono(TipoImagenModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.CrearTipoImagen(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TipoImagenUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoImagen(int Id, TipoImagenModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _configuracionServices.ActualizarTipoImagen(Id, model);
            }
            return Ok(resul);
        }

    }
}
