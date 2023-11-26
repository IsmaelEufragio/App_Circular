using AppCircular.BusinessLogic;
using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using AppCircular.Common.Models.Usuario;
using AppCircular.Entities.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Microsoft.VisualBasic.FileIO;
using MimeDetective.Storage;
using Newtonsoft.Json.Linq;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Timers;
//using static System.Net.Mime.MediaTypeNames;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly UsuarioServices _usuarioServices;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public UsuarioController(UsuarioServices usuarioServices, IWebHostEnvironment webHostEnvironment)
        {
            _usuarioServices = usuarioServices;
            _webHostEnvironment = webHostEnvironment;
        }
        #region Tipo de Usuario
        [HttpGet, Authorize, Route("TipoUsuarioLis")]
        public async Task<IActionResult> ListaTipoUsuario()
        {
            var item = await _usuarioServices.listaTipoUser();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TipoUsuarioInsert")]
        public async Task<IActionResult> CrearTipoUsuario(TipoUsuarioModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.CrearTipoUser(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TipoUsuarioUpdate/{Id}")]
        public async Task<IActionResult> ActulizarTipoUsuario(Guid Id, TipoUsuarioModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.ActualizarTipoUser(Id, model);
            }
            return Ok(resul);
        }
        #endregion

        #region Informacion de usuario Unica

        [HttpGet, Authorize, Route("InfoUsuarioLis")]
        public async Task<IActionResult> ListaInfoUsuario()
        {
            var item = await _usuarioServices.listaInfoUsaurio();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("InfoUsuarioInsert")]
        public async Task<IActionResult> CrearInfoUsuario(InfoUnicaUsuarioViewModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.CrearInfoUser(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("InfoUsuarioUpdate/{Id}")]
        public async Task<IActionResult> ActulizarInfoUsuario(Guid Id, InfoUnicaUsuarioViewModel model)
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
        [HttpPost, Route("Login")]
        public async Task<IActionResult> Login(LoginModel model)
        {
            var resul = await _usuarioServices.Varificar(model);
            return Ok(resul);

        }

        [HttpPost, Route("LoginValidarToken")]
        public async Task<IActionResult> LoginValiToken(LoginModel model)
        {
            var resul = await _usuarioServices.Varificar(model);
            return Ok(resul);
        }
        [HttpPost, Route("Verificacion")]
        public async Task<IActionResult> Verificacion(string Token)
        {
            var resul = new ServiceResult();
            string valiEspacio = Token.Replace(" ", "");
            if (valiEspacio == "" || valiEspacio.Length < 10) return BadRequest("No cumplo con las validaciones minimas");
            var userIdClaim = _usuarioServices.GetClaimsFromToken(Token);
            if (userIdClaim != null)
            {
                Guid userId = Guid.Parse(userIdClaim.FirstOrDefault(a => a.Type == "UserId").Value);
                // Ahora tienes el ID del usuario para usar en tu lógica
                var vali = await _usuarioServices.UsuarioVarificado(userId);
                return Ok(vali);
            }
            else return BadRequest();
        }

        [HttpPost, Route("ValidacionToken")]
        public async Task<IActionResult> ValiToken(string toke)
        {
            var resul = new ServiceResult();
            string valiEspc = toke.Replace(" ", "");
            if (valiEspc != "")
            {
                var resulT = _usuarioServices.TokeValido(toke);

                return Ok(resulT);
            }
            resul.Message = "Nos se ingreso nada";
            return Ok(resul);

        }

        [HttpPost, Route("CrearUsuario")]
        public async Task<IActionResult> CrearUsuario(IFormCollection form)
        {
            var modelo = _usuarioServices.convertirUsuario(form);
            if (!modelo.Success) return Ok(modelo);
            var validationContext = new ValidationContext(modelo.Value, null, null);
            var validationResults = new List<ValidationResult>();
            var isValid = Validator.TryValidateObject(modelo.Value, validationContext, validationResults, true);
            if (isValid)
            {
                var resul = await _usuarioServices.CrearUsaurio(modelo.Value);
                return Ok(resul);
            }
            else
            {
                var errores = validationResults.Select(result => result.ErrorMessage).ToList();
                return BadRequest(errores);
            }
        }

        [HttpPost, Route("LogoUsuario")]
        [Authorize]
        public async Task<ActionResult> subirDocumentos(IFormFile fichero)
        {
            try
            {
                var userIdClaim = ((ClaimsIdentity)User.Identity).FindFirst("UserId");

                if (userIdClaim != null)
                {
                    Guid userId = Guid.Parse(userIdClaim.Value);
                    // Ahora tienes el ID del usuario para usar en tu lógica
                    var vali = await _usuarioServices.SubirArchivoAsync(fichero, userId);
                    return Ok(vali);
                }
                else return BadRequest();
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }

        #endregion

        #region Telefono de Usuario
        [HttpGet, Authorize, Route("TelefonoUsuarioLis")]
        public async Task<IActionResult> ListaUsuarioTelefono()
        {
            var item = await _usuarioServices.listaTelefonoUsuario();
            return Ok(item);
        }

        [HttpPost, Authorize, Route("TelefonoUsuarioInsert")]
        public async Task<IActionResult> CrearUsuarioTelefono(TelefonoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.CrearTelefonoUsuario(model);
            }
            return Ok(resul);
        }

        [HttpPut, Authorize, Route("TelefonoUsuarioUpdate/{Id}")]
        public async Task<IActionResult> ActulizarUsuarioTelefono(Guid Id, TelefonoModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                resul = await _usuarioServices.ActualizarTelefonoUsuario(Id, model);
            }
            return Ok(resul);
        }

        #endregion
    }
}
