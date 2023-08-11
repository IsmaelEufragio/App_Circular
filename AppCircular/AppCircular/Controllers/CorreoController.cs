using Microsoft.AspNetCore.Mvc;
using System.Net.Mail;
using System.Net;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class CorreoController : Controller
    {
        private string smtpServer = "smtp.gmail.com"; // Cambia esto al servidor SMTP que utilices
        private int smtpPort = 587; // Puerto SMTP seguro (TLS)

        private string senderEmail = "appcircular2023@gmail.com"; // Tu dirección de correo electrónico
        private string senderPassword = "lsbuahlrtdgpvdzv"; // Tu contraseña de correo electrónico

        [HttpPost]
        public async Task<IActionResult> SendEmail([FromBody] EmailModel emailModel)
        {
            using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
            {
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);
                smtpClient.EnableSsl = true;

                MailMessage mailMessage = new MailMessage(senderEmail, emailModel.RecipientEmail, emailModel.Subject, emailModel.Body);
                mailMessage.IsBodyHtml = true; // Si deseas enviar un correo HTML
                try
                {
                    await smtpClient.SendMailAsync(mailMessage);
                    return Ok("Correo enviado exitosamente.");
                }
                catch (Exception ex)
                {
                    return Ok("Error al enviar el correo: " + ex.Message);
                }
            }
        }

        public class EmailModel
        {
            //Destino de correo
            public string RecipientEmail { get; set; }
            //Asunto
            public string Subject { get; set; }
            //Cuarpo
            public string Body { get; set; }
        }
    }
}
