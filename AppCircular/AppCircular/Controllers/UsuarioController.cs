using AppCircular.BusinessLogic;
using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly UsuarioServices _usuarioServices;
        private IConfiguration _iConfiguration;
        public UsuarioController(UsuarioServices usuarioServices, IConfiguration iConfiguration)
        {
            _usuarioServices = usuarioServices;
            _iConfiguration = iConfiguration;
        }
        #region Tipo de Usuario
        [HttpGet]
        //[Authorize]
        [Route("TipoUsuarioLis")]
        public async Task<IActionResult> ListaTipoUsuario()
        {
            var item = await _usuarioServices.listaTipoUser();
            return Ok(item);
        }

        [HttpPost]
        [Route("TipoUsuarioInsert")]
        public async Task<IActionResult> CrearTipoUsuario(TipoUsuarioModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.CrearTipoUser(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Route("TipoUsuarioUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoUsuario(int Id, TipoUsuarioModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul =await _usuarioServices.ActualizarTipoUser(Id, model);
            }
            return Ok(resul);
        }
        #endregion

        #region Informacion de usuario Unica

        [HttpGet]
        //[Authorize]
        [Route("InfoUsuarioLis")]
        public async Task<IActionResult> ListaInfoUsuario()
        {
            var item = await _usuarioServices.listaInfoUsaurio();
            return Ok(item);
        }

        [HttpPost]
        [Route("InfoUsuarioInsert")]
        public async Task<IActionResult> CrearInfoUsuario(InfoUnicaUsuarioViewModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.CrearInfoUser(model);
            }
            return Ok(resul);
        }

        [HttpPut]
        [Route("InfoUsuarioUpdate/{Id}")]
        public async Task<IActionResult> ActulizarInfoUsuario(int Id, InfoUnicaUsuarioViewModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.ActualizarInfoUser(Id, model);
            }
            return Ok(resul);
        }

        #endregion

        #region Login 
        [HttpPost]
        [Route("Login")]
        public IActionResult Login(LoginModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                if (model.Usuario == "Hola" && model.Passsword == "1234")
                {
                    var jwt = _iConfiguration.GetSection("Jwt").Get<JwtModel>();
                    var claims = new[]
                    {
                        new Claim(JwtRegisteredClaimNames.Sub, jwt.Subject),
                        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                        new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
                        new Claim("usuario", model.Usuario)
                    };

                    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwt.Key));
                    var singIn = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                    var token = new JwtSecurityToken(
                            jwt.Issuer,
                            jwt.Audience,
                            claims,
                            expires: DateTime.Now.AddMinutes(15),
                            signingCredentials: singIn);
                    var resp = new JwtSecurityTokenHandler().WriteToken(token);
                    resul.Data = resp;
                    return Ok(resul);
                }
                resul.Message = "No chavalo la contraseña no perrin";
                return Ok(resul);
            }
            resul.Message = "Nos se ingreso nada";
            return Ok(resul);

        }
        #endregion 
    }
}
