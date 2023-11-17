using AppCircular.Common.Models.Account;
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
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Newtonsoft.Json.Linq;

namespace AppCircular.BusinessLogic.Services
{
    public class BaseServices
    {
        protected readonly ConfiguracionRepository _configuracionRepository;
        protected readonly JwtModel _jwtSettings;
        public BaseServices(IOptions<JwtModel> jwtSettingsOptions)
        {
            _configuracionRepository = new ConfiguracionRepository();
            _jwtSettings = jwtSettingsOptions.Value;
        }

        public ResultadoModel<string> ValidarArchivo(int ValiTamano, string pathDestino, IFormFile fichero)
        {
            ResultadoModel<string> resul = new();
            try
            {
                if (fichero == null || fichero.Length == 0) return resul = new() { Success = false, Message = "Tiene que existir algun Archivo", Type = ServiceResultType.BadRecuest };
                if (ValiTamano <= 0 || pathDestino == "") return resul = new() { Success = false, Message = "Es necesario que se envie los parametro", Type = ServiceResultType.BadRecuest };
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
                    string mameArchivo = ValiArchivoExtencio(nombreExtencion);
                    if (mameArchivo != "")
                    {
                        string nombreImagenUnico = Guid.NewGuid().ToString() + "." + nombreExtencion;

                        string rutaDestino = Path.Combine(Directory.GetCurrentDirectory(), pathDestino);
                        if (!Directory.Exists(rutaDestino)) Directory.CreateDirectory(rutaDestino);
                        string rutaDestinoCompleta = Path.Combine(rutaDestino, nombreImagenUnico);
                        return resul = new() { Success = true, Message = "El archivo cumplio con todo lo requerido se debuelve la ruta", Value = rutaDestinoCompleta, Type = ServiceResultType.Success };
                    }
                    else return resul = new() { Success = false, Message = "Es tipo de archivo no encontrado", Type = ServiceResultType.BadRecuest };
                }
                else return resul = new() { Success = false, Message = "Es tipo de archivo no encontrado", Type = ServiceResultType.BadRecuest };

            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"Ocurrio un erro en BaseService, Error es: {ex}.", Type = ServiceResultType.Error };
            }
        }

        public ResultadoModel<bool> GurdarArchivo(string pathCompleto, IFormFile fichero)
        {
            ResultadoModel<bool> resul = new();
            try
            {
                using (var stream = new FileStream(pathCompleto, FileMode.Create))
                {
                    fichero.CopyTo(stream);
                }
                return resul = new() { Value = true, Success = true, Message = "Archivo Creado Exitosamente", Type = ServiceResultType.Success };
            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"Ocurrio un erro en BaseService, Error es: {ex}.", Type = ServiceResultType.Error };
            }
        }

        public string ValiArchivoExtencio(string extencion)
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

        public async Task<ServiceResult> Correo(EmailModel emailModel)
        {
            var result = new ServiceResult();
            var smtpServCon = await _configuracionRepository.WhereAsync("smtpServer");
            if (!smtpServCon.Success) return result.Error("No se encontro la configuracion 'smtpServer'");
            string smtpServer = smtpServCon.Value; // Cambia esto al servidor SMTP que utilices

            var smtpPortCon = await _configuracionRepository.WhereAsync("smtpPort");
            if (!smtpPortCon.Success) return result.Error("No se encontro la configuracion 'smtpPort'");
            if (!(int.TryParse(smtpPortCon.Value, out int smtpPort))) return result.Error("La configuracion 'smtpPort' devolvio un string que no se puede convertir a numero");

            var senderEmailCon = await _configuracionRepository.WhereAsync("senderEmail");
            if (!senderEmailCon.Success) return result.Error("No se encontro la configuracion 'senderEmail'");
            string senderEmail = senderEmailCon.Value; // Tu dirección de correo electrónico

            var senderPasswordCon = await _configuracionRepository.WhereAsync("senderPassword");
            if (!senderPasswordCon.Success) return result.Error("No se encontro la configuracion 'senderPassword'");
            string senderPassword = senderPasswordCon.Value; // Tu contraseña de correo electrónico

            using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
            {
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);
                smtpClient.EnableSsl = true;

                MailMessage mailMessage = new MailMessage(senderEmail, emailModel.DestinoCorreo, emailModel.Asunto, emailModel.Cuerpo);
                mailMessage.IsBodyHtml = true; // Si deseas enviar un correo HTML
                try
                {
                    await smtpClient.SendMailAsync(mailMessage);
                    result.Type = ServiceResultType.NoContent;
                    result.Success = true;
                    result.Message = "Correo enviado exitosamente.";
                    return result;
                }
                catch (Exception ex)
                {
                    result.Type = ServiceResultType.Error;
                    result.Success = false;
                    result.Message = $"Error al enviar el correo: {ex.Message}";
                    return result;
                }
            }
        }

        public async Task<ServiceResult> Token(int tiempoExpiracion, int idUsario, bool Varificacion = false)
        {
            var resul = new ServiceResult();
            try
            {
                var jwt = _jwtSettings;
                var claims = new[]
                {
                new Claim(JwtRegisteredClaimNames.Sub, jwt.Subject),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
                new Claim("UserId", idUsario.ToString())
                };

                var verifi = new[]
                {
                new Claim("UserId", idUsario.ToString())
                };
                claims = Varificacion ? verifi : claims;
                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwt.Key));
                var singIn = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                var token = new JwtSecurityToken(
                        jwt.Issuer,
                        jwt.Audience,
                        claims,
                        expires: DateTime.Now.AddMinutes(tiempoExpiracion),
                        signingCredentials: singIn);
                var resp = new JwtSecurityTokenHandler().WriteToken(token);
                resul.Success = true;
                resul.Type = ServiceResultType.NoContent;
                resul.Data = resp;
                resul.Message = $"Token Generado tiempo de Expiracion {tiempoExpiracion} minuto";
                return resul;
            }
            catch (Exception ex)
            {
                resul.Success = false;
                resul.Type = ServiceResultType.Error;
                resul.Message = $"TokenGenerado {ex.Message}";
                return resul;
            }
        }

        public ResultadoModel<bool> ValidarToken(string token)
        {
            ResultadoModel<bool> resul = new ResultadoModel<bool>();
            var jwtSecret = _jwtSettings.Key; // Cambia esto por tu secreto real
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(jwtSecret);

            try
            {
                var validationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };

                var claimsPrincipal = tokenHandler.ValidateToken(token, validationParameters, out _);
                resul.Success = true;
                resul.Message = "Token válido";
                resul.Type = ServiceResultType.NoContent;
                return resul;
            }
            catch (Exception ex)
            {
                resul.Success = false;
                resul.Message = "Token Invalido";
                resul.Type = ServiceResultType.Forbidden;
                return resul;
            }
        }
    }
}
