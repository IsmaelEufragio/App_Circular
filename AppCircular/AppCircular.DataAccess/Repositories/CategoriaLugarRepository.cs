using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
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
    public class CategoriaLugarRepository : ICategoriaLugarRepository<tbCategoriaLugar>
    {
        private static string nombre = "Categoria Lugar";
        public async Task<ServiceResult> InsertAsync(tbCategoriaLugar item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult result = new ServiceResult();
                var catLugW = db.tbCategoriaLugar.Any(a => a.catLug_Nombre.ToLower() == item.catLug_Nombre.ToLower());
                if (!catLugW)
                {
                    db.tbCategoriaLugar.Add(item);
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
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var cateLug = await db.tbCategoriaLugar.ToListAsync();

                relt.Message = cateLug.Count > 0 ? $"Operacion Exitosa, Listada de {nombre}" : $"No se encontro Ningun registro de {nombre}";
                relt.Type = cateLug.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = cateLug.Select(a => new CategoriaLugarViewModel
                {
                    Id = a.catLug_Id,
                    Nombre = a.catLug_Nombre,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> UpdateAsync(int id, CategoriaLugarModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var catLug = await db.tbCategoriaLugar.SingleOrDefaultAsync(a => a.catLug_Id== id);
                if (id > 0 && catLug != null)
                {
                    var depW = db.tbCategoriaLugar.Where(e => e.catLug_Id != id).Any(a => a.catLug_Nombre.ToLower() == item.Nombre.ToLower());
                    if (!depW)
                    {
                        catLug.catLug_Nombre = item.Nombre;
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
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
