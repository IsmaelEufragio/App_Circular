using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Formatters.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Interfaces
{
    public interface IAlmacenarArchivo
    {
        Task Borrar(string ruta, string contenedor);
        Task<string> Almacenar(IFormFile archivo, string contenedor);
        async Task<string> Editar(string ruta,IFormFile archivo, string contenedor)
        {
            await Borrar(ruta, contenedor);
            return await Almacenar( archivo, contenedor);
        }
    }
}
