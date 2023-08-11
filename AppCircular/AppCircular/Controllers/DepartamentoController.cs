using AppCircular.BusinessLogic;
using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class DepartamentoController : ControllerBase
    {
        private readonly UbicacionServices _ubicacionServices;
        public DepartamentoController(UbicacionServices ubicacionServices)
        {
            _ubicacionServices = ubicacionServices;
        }

        [HttpGet]
        //[Authorize]
        [Route("LisDepartamento")]
        public async Task<IActionResult> ListaDepartamento()
        {
            var item = await _ubicacionServices.listaDepartamento();

            return Ok(item);
        }

        [HttpPost]
        [Route("InsertDepartamento")]
        public async Task<IActionResult> CrearDepartamento(DepartamentoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.CrearDepartamento(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Route("UpdateDepartamento/{Id}")]
        public async Task<IActionResult> ActulizarDepartamento(int Id, DepartamentoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _ubicacionServices.ActualizarDepartamento(Id, model);
            }
            return Ok(resul);
        }

    }
}
