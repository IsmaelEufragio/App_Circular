using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.CategoriaSubdivicion;
using AppCircular.Common.Models.Configuracion;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories
{
    public class CategoriaSubdivicionRepository : ICategoriaSubdivicionRepository<tbCategoriaSubdivicion>
    {
        private static string nombre = "Categoria";
        public async Task<ResultadoModel<CategoriaSubdivicionViewModel>> InsertAsync(tbCategoriaSubdivicion item)
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<CategoriaSubdivicionViewModel> result = new();
                var W = db.tbCategoriaSubdivicion.Any(a => a.sub_Nombre.ToLower() == item.sub_Nombre.ToLower());
                if (!W)
                {
                    db.tbCategoriaSubdivicion.Add(item);
                    var rult = await db.SaveChangesAsync();
                    if (rult == 0)
                    {
                        result.Success = false;
                        result.Type = ServiceResultType.Error;
                        result.Message = $"No se pudo guardar el nuevo {nombre}";
                    }
                    result.Type = ServiceResultType.NoContent;
                    result.Message = $"{nombre} Creado Exitosamente";
                    return result;
                }
                result.Success = false;
                result.Type = ServiceResultType.Error;
                result.Message = $"El nombre de la {nombre} Ya existe";
                return result;
            }
            catch (Exception e)
            {
                ResultadoModel<CategoriaSubdivicionViewModel> error = new() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public Task<ResultadoModel<CategoriaSubdivicionViewModel>> ListAsync()
        {
            throw new NotImplementedException();
        }

        public Task<ResultadoModel<CategoriaSubdivicionViewModel>> UpdateAsync(int id, CategoriaSubdivicionModel item)
        {
            throw new NotImplementedException();
        }
    }
}
