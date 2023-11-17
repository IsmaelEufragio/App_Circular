using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Genericos;
using AppCircular.Common.Models.Usuario;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace AppCircular.Controllers
{
    [Route("api/imagenes")]
    [ApiController]
    public class TestController : Controller
    {
        private readonly UsuarioServices _usuarioServices;
        public TestController(UsuarioServices usuarioServices)
        {
            _usuarioServices = usuarioServices;
        }
        [HttpPost, Route("imagen")]
        public async Task<IActionResult> SubirImagen([FromForm] ModelTesImagenes modelo)
        {
            // Aquí puedes acceder a los datos del modelo y la imagen.
            // Por ejemplo, puedes guardar la imagen en el servidor.

            if (modelo == null || modelo.Ima.Count == 0)
            {
                return BadRequest("Se debe proporcionar un modelo con una imagen.");
            }

            //// Ejemplo de cómo guardar la imagen en el servidor (puedes personalizar esto):
            //var rutaDeGuardado = "ruta/donde/guardar/imagen";
            //var nombreDeArchivo = modelo.Imagen.FileName;

            //using (var stream = new FileStream(Path.Combine(rutaDeGuardado, nombreDeArchivo), FileMode.Create))
            //{

            //    {

            //        await modelo.Imagen.CopyToAsync(stream);
            //    }

            //    // Puedes realizar otras operaciones con los datos del modelo aquí.

            return Ok("Imagen subida exitosamente.");
            //}
        }
        [HttpPost, Route("CrearUsuario")]
        public async Task<IActionResult> crearSu([FromForm] ModelTestCrearUsuario modelo)
        {
            //var resul = await _usuarioServices.CrearUsaurio(modelo);
            //return Ok(resul);
            return Ok("Tuanis");
        }

        [HttpPost, Route("TesListado")]
        public async Task<IActionResult> list(IFormCollection form)
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
                //return Ok("Tuanis");
            }
            else
            {
                // El modelo no es válido, muestra errores de validación.
                var errores = validationResults.Select(result => result.ErrorMessage).ToList();
                return BadRequest(errores);
            }
        }

    }
}
