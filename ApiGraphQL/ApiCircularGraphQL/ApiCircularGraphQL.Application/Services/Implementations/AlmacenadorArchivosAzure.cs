using ApiCircularGraphQL.Application.Services.Interfaces;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.Services.Implementations
{
    public class AlmacenadorArchivosAzure : IAlmacenarArchivo
    {
        private string conectionString;

        public AlmacenadorArchivosAzure(IConfiguration configuration)
        {
            conectionString = configuration.GetConnectionString("AzureStorage")!;
        }
        public async Task<string> Almacenar(IFormFile archivo, string contenedor)
        {
            try
            {
                var cliente = new BlobContainerClient(conectionString, contenedor);
                await cliente.CreateIfNotExistsAsync();
                cliente.SetAccessPolicy(PublicAccessType.Blob);

                var extension = Path.GetExtension(archivo.FileName);
                var nombreArchivo = $"{Guid.NewGuid()}{extension}";
                var blob = cliente.GetBlobClient(nombreArchivo);
                var blobHttpHeaders = new BlobHttpHeaders();
                blobHttpHeaders.ContentType = archivo.ContentType;
                await blob.UploadAsync(archivo.OpenReadStream(), blobHttpHeaders);
                return blob.Uri.ToString();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public async Task Borrar(string ruta, string contenedor)
        {
            if (string.IsNullOrEmpty(ruta))
                return;

            var cliente = new BlobContainerClient(conectionString, contenedor);
            await cliente.CreateIfNotExistsAsync();
            var nombreArchivo = Path.GetFileName(ruta);
            var blob = cliente.GetBlobClient(nombreArchivo);
            await blob.DeleteIfExistsAsync();
        }
    }
}
