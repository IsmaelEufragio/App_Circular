using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class CategoriaController : ControllerBase
    {
        private readonly UsuarioServices _usuarioServices;
        public CategoriaController(UsuarioServices usuarioServices)
        {
            _usuarioServices = usuarioServices;
        }
        [HttpGet]
        [Route("LisCategoria")]
        public async Task<IActionResult> ListaCategoria()
        {
            var item = await _usuarioServices.listaCategoria();

            return Ok(item);
        }

        [HttpPost]
        [Authorize]
        [Route("InsertCategoria")]
        public async Task<IActionResult> CrearCategoria(CategoriaModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.CrearCategoria(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Authorize]
        [Route("UpdateCategoria/{Id}")]
        public async Task<IActionResult> ActulizarCategoria(Guid Id, CategoriaModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.ActualizarCategoria(Id, model);
            }
            return Ok(resul);
        }

    }
}
