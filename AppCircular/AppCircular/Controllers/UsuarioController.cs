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
            var resul = await _usuarioServices.Varificar(model);
            return Ok(resul);

        }

        [HttpPost, Route("Verificacion")]
        public async Task<IActionResult> Verificacion(LoginModel model)
        {
            var resul = new ServiceResult();
            if (model != null)
            {
                if (model.Correo == "josueeufragio93@gmail.com" && model.Passsword == "1234")
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
        public async Task<IActionResult> CrearUsuario([FromForm] ModelTestCrearUsuario modelo)
        {
            UsuarioCrearModel model = new()
            {
                Logo = modelo.Logo,
                tipUs_Id = modelo.tipUs_Id,
                tipIde_Id = modelo.tipIde_Id,
                Identidad = modelo.Identidad,
                Nombre = modelo.Nombre,
                PaginaWed = modelo.PaginaWed,
                NombreUsuario = modelo.NombreUsuario,
                Password = modelo.Password,
                Descripcion = modelo.Descripcion,
                Facebook = modelo.Facebook,
                Intagram = modelo.Intagram,
                WhatsApp = modelo.WhatsApp,
                Envio = modelo.Envio,
                Correo = modelo.Correo,
                subLug_Id = modelo.subLug_Id,
                Latitud = modelo.Latitud,
                Longitub = modelo.Longitub,
                Horario = modelo.Horario,
                Categoria = modelo.Categoria,
                Telefono = modelo.Telefono,
            };
            var resul = await _usuarioServices.CrearUsaurio(model);
            return Ok(resul);
            //return Ok("Todo tuanis");    
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

        #endregion

        #region Telefono de Usuario
        [HttpGet,Authorize, Route("TelefonoUsuarioLis")]
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
        public async Task<IActionResult> ActulizarUsuarioTelefono(int Id, TelefonoModel model)
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
