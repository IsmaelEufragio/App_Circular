using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class CategoriaLugarController : Controller
    {
        private readonly UbicacionServices _ubicacionServices;
        public CategoriaLugarController(UbicacionServices ubicacionServices)
        {
            _ubicacionServices = ubicacionServices;
        }

        [HttpGet]
        [Authorize]
        [Route("LisCategoriaLugar")]
        public async Task<IActionResult> ListaCategoriaLugar()
        {
            var item = await _ubicacionServices.listaCategoriaLugar();

            return Ok(item);
        }

        [HttpPost]
        [Authorize]
        [Route("InsertCategoriaLugar")]
        public async Task<IActionResult> CrearCategoriaLugar(CategoriaLugarModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.CrearCategoriaLugar(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Authorize]
        [Route("UpdateCategoriaLugar/{Id}")]
        public async Task<IActionResult> ActulizarCategoriaLugar(int Id, CategoriaLugarModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.ActualizarCategoriaLugar(Id, model);
            }
            return Ok(resul);
        }

    }
}
