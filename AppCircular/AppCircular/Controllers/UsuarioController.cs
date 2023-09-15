using AppCircular.BusinessLogic;
using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Microsoft.VisualBasic.FileIO;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Timers;

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
        [HttpGet]
        [Authorize]
        [Route("TipoUsuarioLis")]
        public async Task<IActionResult> ListaTipoUsuario()
        {
            var item = await _usuarioServices.listaTipoUser();
            return Ok(item);
        }

        [HttpPost]
        [Authorize]
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
        [Authorize]
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
        [Authorize]
        [Route("InfoUsuarioLis")]
        public async Task<IActionResult> ListaInfoUsuario()
        {
            var item = await _usuarioServices.listaInfoUsaurio();
            return Ok(item);
        }

        [HttpPost]
        [Authorize]
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

        [HttpPut, Authorize, Route("InfoUsuarioUpdate/{Id}")]
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
        [HttpPost, Route("Login")]
        public async Task<IActionResult> Login(LoginModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                if (model.Usuario == "Hola" && model.Passsword == "1234")
                {
                    var resulT = await _usuarioServices.Token(5, 14);
                    return Ok(resulT);
                }
                resul.Message = "No chavalo la contraseña no perrin";
                return Ok(resul);
            }
            resul.Message = "Nos se ingreso nada";
            return Ok(resul);

        }

        [HttpPost, Route("Verificacion")]
        public async Task<IActionResult> Verificacion(LoginModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                if (model.Usuario == "josueeufragio93@gmail.com" && model.Passsword == "1234")
                {
                    var resulT = await _usuarioServices.Varificar(model);
                    return Ok(resulT);
                }
                resul.Message = "No chavalo la contraseña no perrin";
                return Ok(resul);
            }
            resul.Message = "Nos se ingreso nada";
            return Ok(resul);

        }

        [HttpPost, Route("ValidacionToken")]
        public async Task<IActionResult> ValiToken(string toke)
        {
            var resul = new ServiceResult();
            string valiEspc = toke.Replace(" ", "");
            if (valiEspc != "")
            {
                var resulT =  _usuarioServices.TokeValido(toke);
                
                return Ok(resulT);
            }
            resul.Message = "Nos se ingreso nada";
            return Ok(resul);

        }

        [HttpPost, Route("CrearUsuario")]
        public async Task<IActionResult> CrearUsuario(UsuarioCrearModel modelo)
        {
            //var resul = await _usuarioServices.CrearUsaurio(modelo, logo);
            //return Ok(resul);
            return Ok("Nada");
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
                    int userId = int.Parse(userIdClaim.Value);
                    // Ahora tienes el ID del usuario para usar en tu lógica
                    var vali = await _usuarioServices.SubirArchivoAsync(fichero, userId);
                        return Ok(vali);
                } else return BadRequest();
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }

        [HttpPost, Route("subirDocumentoBase64")]
        public ActionResult subirDocumentosBase64([FromForm] string base64, [FromForm] string nombreFichero)
        {
            try
            {
                //Obtener ruta de destino
                string rutaDestino = _webHostEnvironment.ContentRootPath + "\\FicherosSubidos";
                if (!Directory.Exists(rutaDestino)) Directory.CreateDirectory(rutaDestino);
                string rutaDestinoCompleta = Path.Combine(rutaDestino, nombreFichero);

                //Grabar base24 como fichero
                byte[] documento = Convert.FromBase64String(base64);
                System.IO.File.WriteAllBytes(rutaDestinoCompleta, documento);

                return Ok("El documento sa a Subido Correctamente");
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }
        #endregion 
    }
}
