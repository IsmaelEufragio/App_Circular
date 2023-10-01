using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Lugar;
using AppCircular.Common.Models.SubdivicionLugar;
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
    public class SubdivicionLugarRepository : ISubdivicionLugarRepository<tbSubdivicionLugar>
    {
        private static string nombre = "Lugar";
        public async Task<ResultadoModel<SubdivicionLugarViewModel>> InsertAsync(tbSubdivicionLugar item)
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<SubdivicionLugarViewModel> result = new();
                var subLugW = db.tbSubdivicionLugar.Any(a => a.subLug_Nombre.ToLower() == item.subLug_Nombre.ToLower() && a.catSub_Id == item.catSub_Id && a.lug_Id == item.lug_Id);
                if (!subLugW)
                {
                    db.tbSubdivicionLugar.Add(item);
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
                ResultadoModel<SubdivicionLugarViewModel> error = new ResultadoModel<SubdivicionLugarViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<SubdivicionLugarViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<SubdivicionLugarViewModel>();
                var cateLug = await db.tbSubdivicionLugar.ToListAsync();

                relt.Message = cateLug.Count > 0 ? $"Operacion Exitosa, Listada de {nombre}" : $"No se encontro Ningun registro de {nombre}";
                relt.Type = cateLug.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = cateLug.Select(a => new SubdivicionLugarViewModel
                {
                    Id = a.subLug_Id,
                    Nombre = a.subLug_Nombre,
                    sub_Id = a.catSub_Id,
                    lug_Id = a.lug_Id,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ResultadoModel<SubdivicionLugarViewModel> error = new ResultadoModel<SubdivicionLugarViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<SubdivicionLugarViewModel>> UpdateAsync(int id, SubdivicionLugarModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<SubdivicionLugarViewModel>();
                var tbsubLug = await db.tbSubdivicionLugar.SingleOrDefaultAsync(a => a.subLug_Id == id);
                if (id > 0 && tbsubLug != null)
                {
                    var subLuW = db.tbSubdivicionLugar.Where(e => e.subLug_Id != id).Any(a => a.subLug_Nombre.ToLower() == item.Nombre.ToLower() && a.catSub_Id == item.catSub_Id && a.lug_Id == item.lug_Id);
                    if (!subLuW)
                    {
                        tbsubLug.subLug_Nombre = item.Nombre;
                        tbsubLug.catSub_Id = item.catSub_Id;
                        tbsubLug.lug_Id = item.lug_Id;
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
                var error = new ResultadoModel<SubdivicionLugarViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<bool>> WhereAsync(int idSubDivicionLugar)
        {
            var relt = new ResultadoModel<bool>();
            try
            {

                if (idSubDivicionLugar > 0)
                {
                    using var db = new AppCircularContext();
                    bool tb = await db.tbSubdivicionLugar.AnyAsync(a => a.subLug_Id == idSubDivicionLugar);
                    relt.Success = tb;
                    relt.Type = tb ? ServiceResultType.Success : ServiceResultType.Error;
                    relt.Message = tb ? $"Si se encontro el {nombre}" : $"No se encontro el {nombre}";
                    return relt;
                }
                relt.Success = false;
                relt.Type = ServiceResultType.Error;
                relt.Message = "No se se envio nada";
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<bool>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
