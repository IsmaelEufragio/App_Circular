using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using AppCircular.Common.Models.Usuario;
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
    public class LugarRepository : ILugarRepository<tbLugar>
    {
        private static string nombre = "Lugar";
        public async Task<ResultadoModel<LugarViewModel>> InsertAsync(tbLugar item)
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<LugarViewModel> result = new ResultadoModel<LugarViewModel>();
                var lugarW = db.tbLugar.Any(a => a.lug_Nombre.ToLower() == item.lug_Nombre.ToLower() && a.muni_Id == item.muni_Id);
                if (!lugarW)
                {
                    db.tbLugar.Add(item);
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
                ResultadoModel<LugarViewModel> error = new ResultadoModel<LugarViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<LugarViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<LugarViewModel>();
                var cateLug = await db.tbLugar.ToListAsync();

                relt.Message = cateLug.Count > 0 ? $"Operacion Exitosa, Listada de {nombre}" : $"No se encontro Ningun registro de {nombre}";
                relt.Type = cateLug.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = cateLug.Select(a => new LugarViewModel
                {
                    Id = a.lug_Id,
                    Nombre = a.lug_Nombre,
                    Muni_Id = a.muni_Id,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ResultadoModel<LugarViewModel> error = new ResultadoModel<LugarViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<LugarViewModel>> UpdateAsync(int id, LugarModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<LugarViewModel>();
                var tblugar = await db.tbLugar.SingleOrDefaultAsync(a => a.lug_Id == id);
                if (id > 0 && tblugar != null)
                {
                    var lugarW = db.tbLugar.Where(e => e.lug_Id != id).Any(a => a.lug_Nombre.ToLower() == item.Nombre.ToLower() && a.muni_Id == item.muni_Id);
                    if (!lugarW)
                    {
                        tblugar.catLug_Id = item.catLug_Id;
                        tblugar.lug_Nombre = item.Nombre;
                        tblugar.muni_Id = item.muni_Id;
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
                var error = new ResultadoModel<LugarViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
