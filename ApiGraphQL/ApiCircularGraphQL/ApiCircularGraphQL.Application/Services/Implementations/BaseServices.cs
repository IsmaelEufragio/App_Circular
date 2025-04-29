using ApiCircularGraphQL.Application.Configuracion;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.AspNetCore.Http;
using MimeDetective;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using ApiCircularGraphQL.Application.DTOs.Utilidades;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class BaseServices : IBaseServices
    {
        private readonly IConfiguracionRepository _configuracionRepository;
        private readonly IAlmacenarArchivo _almacenarArchivo;
        public BaseServices(IConfiguracionRepository configuracionRepository, IAlmacenarArchivo almacenarArchivo)
        {
            _configuracionRepository = configuracionRepository;
            _almacenarArchivo = almacenarArchivo;
        }

        public async Task<string> GuardarArchivo(int ValiTamano, string pathDestino, IFormFile fichero)
        {
            if (fichero == null || fichero.Length == 0)
                throw new Exception("Tiene que existir algun Archivo para poder validar su tipo.");

            if (fichero.Length > ValiTamano * 1024 * 1024)
                throw new Exception($"El Archivo es demaciado grande que {ValiTamano} mega byte");

            var Inspector = new ContentInspectorBuilder()
            {
                Definitions = MimeDetective.Definitions.DefaultDefinitions.All()
            }.Build();

            var Results = Inspector.Inspect(fichero.OpenReadStream());
            var ResultsByFileExtension = Results.ByFileExtension();
            var ResultsByMimeType = Results.ByMimeType();
            if (ResultsByFileExtension.Length < 1)
                throw new Exception("Es tipo de archivo no encontrado");

            string nombreExtencion = ResultsByFileExtension[0].Extension;
            string mameArchivo = ExtencionesPermitidas(nombreExtencion);
            if (mameArchivo == "")
                throw new Exception($"Estan intentado ingresar una extencion de archivo no permitido {nombreExtencion}");

            return await _almacenarArchivo.Almacenar(fichero, pathDestino);
        }

        public string ExtencionesPermitidas(string extencion)
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

        public async Task<string> GetConfiguracion(string nombre)
        {
            return await _configuracionRepository.GetConfiguracion(nombre);
        }

        public async Task Correo(EmailDTO email)
        {
            var smtpServer = await GetConfiguracion("smtpServer"); // Cambia esto al servidor SMTP que utilices

            var smtpPortCon = await GetConfiguracion("smtpPort");
            if (!(int.TryParse(smtpPortCon, out int smtpPort))) throw new Exception("La configuracion 'smtpPort' devolvio un string que no se puede convertir a numero");

            var senderEmail = await GetConfiguracion("senderEmail");

            var senderPassword = await GetConfiguracion("senderPassword");

            using SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort);

            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);
            smtpClient.EnableSsl = true;

            MailMessage mailMessage = new MailMessage(senderEmail, email.DestinoCorreo, email.Asunto, email.Cuerpo);
            mailMessage.IsBodyHtml = true; // Si deseas enviar un correo HTML
            try
            {
                await smtpClient.SendMailAsync(mailMessage);
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al enviar el correo: {ex.Message}");
            }
        }
    }
}
