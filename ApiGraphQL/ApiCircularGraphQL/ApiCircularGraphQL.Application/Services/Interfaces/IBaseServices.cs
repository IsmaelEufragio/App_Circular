using ApiCircularGraphQL.Application.DTOs.Utilidades;
using Microsoft.AspNetCore.Http;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IBaseServices
    {
        Task Correo(EmailDTO email);
        string ExtencionesPermitidas(string extencion);
        Task<string> GetConfiguracion(string nombre);
        Task<string> GuardarArchivo(int ValiTamano, string pathDestino, IFormFile fichero);
    }
}