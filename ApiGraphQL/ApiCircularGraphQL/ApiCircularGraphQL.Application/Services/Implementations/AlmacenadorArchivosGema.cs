using ApiCircularGraphQL.Application.Services.Interfaces;
using CG.Web.MegaApiClient;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class AlmacenadorArchivosGema //: IAlmacenarArchivo
    {
        /*private readonly MegaApiClient _client;
        private readonly string _email = "JosueEufragio111@gmail.com";
        private readonly string _password = "Exp.2002-11";

        public AlmacenadorArchivosGema()
        {
            _client = new MegaApiClient();
            _client.Login(_email, _password);
        }

        public string Almacenar(IFormFile archivo, string contenedor)
        {
            var stream = archivo.OpenReadStream();

            var nodes = _client.GetNodes();
            var folderNode = nodes.FirstOrDefault(n => n.Type == NodeType.Directory && n.Name == contenedor);

            if (folderNode == null)
            {
                var root = nodes.Single(n => n.Type == NodeType.Root);
                folderNode = _client.CreateFolder(contenedor, root);
            }

            var extension = Path.GetExtension(archivo.FileName);
            var nombreArchivo = $"{Guid.NewGuid()}{extension}";

            var uploadedNode = _client.Upload(stream, nombreArchivo, folderNode);

            var link = _client.GetDownloadLink(uploadedNode);
            return link.ToString();
        }

        public void Borrar(string ruta, string contenedor)
        {
            var node = _client.GetNodeFromLink(new Uri(ruta));
            if (node != null)
                _client.Delete(node, false);
            throw new Exception("No se pudo borar el archivo. No se encontro.");
        }*/
    }
}
