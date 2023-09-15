using AppCircular.Common.Models.Configuracion;
using AppCircular.DataAccess.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using MimeDetective;
using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.Services
{
    public class BaseServices
    {
        protected readonly ConfiguracionRepository _configuracionRepository;
        protected readonly JwtModel _jwtSettings;
        protected IConfiguration _iConfiguration;
        public BaseServices(ConfiguracionRepository configuracionRepository,
                            IOptions<JwtModel> jwtSettings,
                             IConfiguration iConfiguration)
        {
            _configuracionRepository = configuracionRepository;
            _jwtSettings = jwtSettings.Value;
            _iConfiguration = iConfiguration;
        }

        public ResultadoModel<string> GurdarArchivo(int ValiTamano, string subrutaDestino, IFormFile fichero)
        {
            ResultadoModel<string> resul = new();
            try
            {
                if (fichero == null || fichero.Length == 0) return resul = new() { Success = false, Message = "Tiene que existir algun Archivo", Type = ServiceResultType.BadRecuest };
                if (fichero.Length > ValiTamano * 1024 * 1024) return resul = new() { Success = false, Message = $"El Archivo es demaciado grande que {ValiTamano} mega byte", Type = ServiceResultType.BadRecuest };

                var Inspector = new ContentInspectorBuilder()
                {
                    Definitions = MimeDetective.Definitions.Default.All()
                }.Build();

                var Results = Inspector.Inspect(fichero.OpenReadStream());

                var ResultsByFileExtension = Results.ByFileExtension();
                var ResultsByMimeType = Results.ByMimeType();

                if (ResultsByFileExtension.Length > 0)
                {
                    string nombreExtencion = ResultsByFileExtension[0].Extension;
                    string mameArchivo = ValiArchivo(nombreExtencion);

                    if (mameArchivo != "")
                    {
                        string nombreImagenUnico = Guid.NewGuid().ToString() + "." + nombreExtencion;

                        string rutaDestino = Path.Combine(Directory.GetCurrentDirectory(), subrutaDestino);
                        if (!Directory.Exists(rutaDestino)) Directory.CreateDirectory(rutaDestino);
                        string rutaDestinoCompleta = Path.Combine(rutaDestino, nombreImagenUnico);
                        using (var stream = new FileStream(rutaDestinoCompleta, FileMode.Create))
                        {
                            fichero.CopyTo(stream);
                        }
                        return resul = new() { Value = rutaDestinoCompleta, Success = true, Message = "Archivo Creado Exitosamente", Type = ServiceResultType.Success };
                    }else return resul = new() { Success = false, Message = "Es tipo de archivo no encontrado", Type = ServiceResultType.BadRecuest };
                }else return resul = new() { Success = false, Message = "Es tipo de archivo no encontrado", Type = ServiceResultType.BadRecuest };
            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"Ocurrio un erro en BaseService, Error es: {ex}.", Type = ServiceResultType.Error };
            }
        }

        public string ValiArchivo(string extencion)
        {
            Dictionary<string, string> tiposArchivoImagen = new Dictionary<string, string>
            {
                {"bmp", "bmp"},
                {"gif", "gif"},
                {"ico", "x-icon"},
                {"jpeg", "jpeg"},
                {"jpg", "jpeg"},
                {"png", "png"},
                {"psd", "vnd.adobe.photoshop"},
                {"tiff", "tiff"},
            };
            string nombre;
            if (tiposArchivoImagen.TryGetValue(extencion, out nombre))
                return nombre;

            return "";
        }

        public ResultadoModel<bool> BorrarArchivo(string subrutaDestino)
        {
            ResultadoModel<bool> resul = new();
            try
            {
                string valiRuta = subrutaDestino.Replace(" ", "");
                if (valiRuta == "") return resul = new() { Message = "Es requerido una ruta de archivo que borrar", Success = false, Type = ServiceResultType.Error };
                if (!File.Exists(subrutaDestino)) return resul = new() { Message = "El archivo no existe en la ubicación especificada.", Success = false, Type = ServiceResultType.Error };

                File.Delete(subrutaDestino);
                return resul = new() { Message = "Se Borro Correctamente", Success = true, Type = ServiceResultType.Success };
            }
            catch (Exception ex)
            {
                return resul = new() { Message = $"Error al borrar el archivo: {ex.Message}", Success = false, Type = ServiceResultType.Error };
            }
        }


        static void ComprimirArchivo(IFormFile archivoOrigen, string archivoDestino)
        {
            using (FileStream archivoComprimido = File.Create(archivoDestino))
            {
                using (Stream archivoFuente = archivoOrigen.OpenReadStream())
                {
                    using (var archivoZip = new ZipArchive(archivoComprimido, ZipArchiveMode.Create))
                    {
                        var archivoEntrada = archivoZip.CreateEntry(Path.GetFileName(archivoOrigen.FileName), CompressionLevel.Optimal);
                        using (Stream archivoSalida = archivoEntrada.Open())
                        {
                            archivoFuente.CopyTo(archivoSalida);
                        }
                    }
                }
            }
        }
    }
}
