using ApiCircularGraphQL.Application.DTOs.Autenticacion;
using ApiCircularGraphQL.Application.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ApiCircularGraphQL.Api.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AutenticacionController : ApiBaseController
    {
        private readonly IAuthService _authService;

        public AutenticacionController(IAuthService authService)
        {
            _authService = authService;
        }
        [HttpPost, Route("Login")]
        public async Task<IActionResult> Login(LoginDTO model)
        {
            var data = await _authService.Login(model.Correo, model.Password);
            return ApiServiceResult(data);
        }
        [Authorize(Policy = "EditarCorreo"), HttpPatch, Route("VarificarCorreo")]
        public async Task<IActionResult> Verificar(string token)
        {
            var data = await _authService.VarificarUsuario(token);
            return ApiServiceResult(data);
        }

        [HttpPatch, Route("TokenRefres")]
        public async Task<IActionResult> RefresToken(LoginDTO model)
        {
            var data = await _authService.ObtenerRefrescarToken(model.Correo, model.Password);
            return ApiServiceResult(data);
        }

        [HttpPatch, Route("TokenDeAcceso")]
        public async Task<IActionResult> AccessToken(string refresToken)
        {
            var data = await _authService.ObtenerAccessToken(refresToken);
            return ApiServiceResult(data);
        }
    }
}
