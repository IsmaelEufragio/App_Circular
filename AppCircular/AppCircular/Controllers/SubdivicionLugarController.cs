using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using AppCircular.Common.Models.SubdivicionLugar;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class SubdivicionLugarController : ControllerBase
    {
        private readonly UbicacionServices _ubicacionServices;
        public SubdivicionLugarController(UbicacionServices ubicacionServices)
        {
            _ubicacionServices = ubicacionServices;
        }
        [HttpGet]
        [Authorize]
        [Route("LisSubdivicionLugar")]
        public async Task<IActionResult> ListaSubdivicionLugar()
        {
            var item = await _ubicacionServices.listaSubdivicionLugar();

            return Ok(item);
        }

        [HttpPost]
        [Authorize]
        [Route("InsertSubdivicionLugar")]
        public async Task<IActionResult> CrearSubdivicionLugar(SubdivicionLugarModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.CrearSubdivicionLugar(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Authorize]
        [Route("UpdateSubdivicionLugar/{Id}")]
        public async Task<IActionResult> ActulizarSubdivicionLugar(Guid Id, SubdivicionLugarModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.ActualizarSubdivicionLugar(Id, model);
            }
            return Ok(resul);
        }
    }
}
