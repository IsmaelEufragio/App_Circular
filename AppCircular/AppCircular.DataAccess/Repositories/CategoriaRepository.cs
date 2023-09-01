using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories
{
    public class CategoriaRepository : ICategoriaRepository<tbCategoria>
    {
        private static string nombre = "Categoria";
        public async Task<ResultadoModel<CategoriaViewModel>> InsertAsync(tbCategoria item)
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<CategoriaViewModel> result = new();
                var W = db.tbCategoria.Any(a => a.catg_Nombre.ToLower() == item.catg_Nombre.ToLower());
                if (!W)
                {
                    db.tbCategoria.Add(item);
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
                ResultadoModel<CategoriaViewModel> error = new() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<CategoriaViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<CategoriaViewModel> relt = new();
                var cate = await db.tbCategoria.ToListAsync();

                relt.Message = cate.Count > 0 ? $"Operacion Exitosa, Listada de {nombre}" : $"No se encontro Ningun registro de {nombre}";
                relt.Type = cate.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Success = cate.Count > 0;
                relt.Data = cate.Select(a => new CategoriaViewModel
                {
                    Id = a.catg_Id,
                    Nombre = a.catg_Nombre,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ResultadoModel<CategoriaViewModel> error = new() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<CategoriaViewModel>> UpdateAsync(int id, CategoriaModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<CategoriaViewModel>();
                var tb = await db.tbCategoria.SingleOrDefaultAsync(a => a.catg_Id == id);
                if (id > 0 && tb!= null)
                {
                    var W = db.tbCategoria.Where(e => e.catg_Id != id).Any(a => a.catg_Nombre.ToLower() == item.Nombre.ToLower());
                    if (!W)
                    {
                        tb.catg_Nombre = item.Nombre;
                        await db.SaveChangesAsync();
                        relt.Message = $"{nombre} Actualizado Correctamente";
                        relt.Type = ServiceResultType.NoContent;
                        return relt;
                    }
                    relt.Success = false;
                    relt.Type = ServiceResultType.Error;
                    relt.Message = $"El nombre de ese {nombre} ya Existe";
                    return relt;
                }
                relt.Message = $"la {nombre} que desa actualizar no existe";
                relt.Success = false;
                relt.Type = ServiceResultType.Error;
                return relt;
            }
            catch (Exception e)
            {
                ResultadoModel<CategoriaViewModel> error = new() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
