using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class LugarController : ControllerBase
    {
        private readonly UbicacionServices _ubicacionServices;
        public LugarController(UbicacionServices ubicacionServices)
        {
            _ubicacionServices = ubicacionServices;
        }

        [HttpGet]
        [Authorize]
        [Route("LisLugar")]
        public async Task<IActionResult> ListaLugar()
        {
            var item = await _ubicacionServices.listaLugar();

            return Ok(item);
        }

        [HttpPost]
        [Authorize]
        [Route("InsertLugar")]
        public async Task<IActionResult> CrearLugar(LugarModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.CrearLugar(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Authorize]
        [Route("UpdateLugar/{Id}")]
        public async Task<IActionResult> ActulizarLugar(int Id, LugarModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.ActualizarLugar(Id, model);
            }
            return Ok(resul);
        }

    }
}
