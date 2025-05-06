using ApiCircularGraphQL.Application.DTOs.Autenticacion;
using ApiCircularGraphQL.Application.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ApiCircularGraphQL.Api.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AutenticacionController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AutenticacionController(IAuthService authService)
        {
            _authService = authService;
        }
        [HttpPost, Route("Login")]
        public async Task<IActionResult> Login(LoginDTO model)
        {
            var data = await _authService.Login(model.Correo, model.Passsword);
            return Ok(data);
        }
        [Authorize(Policy = "EditarCorreo"), HttpPatch, Route("VarificarCorreo")]
        public async Task<IActionResult> Verificar(string token)
        {
            var data = await _authService.VarificarUsuario(token);
            return Ok(data);
        }
    }
}
