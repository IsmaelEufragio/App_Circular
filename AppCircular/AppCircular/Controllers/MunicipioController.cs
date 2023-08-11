using AppCircular.BusinessLogic.Services;
using AppCircular.BusinessLogic;
using Microsoft.AspNetCore.Mvc;
using AppCircular.Common.Models.Municipio;
using AppCircular.Common.Models.Configuracion;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class MunicipioController : ControllerBase
    {
        private readonly UbicacionServices _ubicacionServices;
        public MunicipioController(UbicacionServices ubicacionServices) {
            _ubicacionServices = ubicacionServices;
        }

        [HttpGet]
        //[Authorize]
        [Route("LisMunicipio")]
        public async Task<IActionResult> ListaMunicipio()
        {
            var item = await _ubicacionServices.listaMunicipio();

            return Ok(item);
        }

        [HttpPost]
        [Route("InsertMunicipio")]
        public async Task<IActionResult> CrearMunicipio(MunicipioModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.CrearMunicipio(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Route("UpdateMunicipio/{Id}")]
        public async Task<IActionResult> ActulizarMunicipio(int Id, MunicipioModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.ActualizarMunicipio(Id, model);
            }
            return Ok(resul);
        }
    }
}
