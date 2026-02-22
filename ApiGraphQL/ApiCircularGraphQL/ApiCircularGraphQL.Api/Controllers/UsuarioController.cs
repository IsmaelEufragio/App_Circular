using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace ApiCircularGraphQL.Api.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UsuarioController : ApiBaseController
    {
        private readonly IUserService _userService;
        private readonly IBaseServices _baseServices;

        public UsuarioController(IUserService userService, IBaseServices baseServices)
        {
            _userService = userService;
            _baseServices = baseServices;
        }

        [HttpPost, Route("CrearUsuario")]
        public async Task<IActionResult> CrearUsuario(UserCreateRequest request)
        {
            try
            {
                var resul = await _userService.CrearUsaurio(request);
                return ApiServiceResult(resul);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [Authorize ,HttpPost, Route("SubirFoto")]
        public IActionResult GuardarFoto(IFormCollection form)
        {
            IFormFile? formFile = form.Files["Logo"];
            if(formFile != null)
            {
                //string ruta = await _baseServices.GuardarArchivo(3,"prueba", formFile);
                return Ok();
            }
            return BadRequest();
        }
    }
}
