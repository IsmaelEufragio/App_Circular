using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Pais;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PaisController : ControllerBase
    {
        private readonly UbicacionServices _ubicacionServices;
        public PaisController(UbicacionServices ubicacionServices)
        {
            _ubicacionServices = ubicacionServices;
        }

        [HttpGet]
        //[Authorize]
        [Route("LisPais")]
        public async Task<IActionResult> ListaPais()
        {
            var item = await _ubicacionServices.listaPais();

            return Ok(item);
        }

        [HttpPost]
        [Route("InsertPais")]
        public async Task<IActionResult> CrearPais(PaisModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.CrearPais(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Route("UpdatePais/{Id}")]
        public async Task<IActionResult> ActulizarPais(int Id, PaisModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.ActualizarPais(Id, model);
            }
            return Ok(resul);
        }
    }
}
