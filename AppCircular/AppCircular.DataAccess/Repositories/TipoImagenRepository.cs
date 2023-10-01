using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
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
    public class TipoImagenRepository : ITipoImagenRepository<tbTipoImagen>
    {
        private static string nombre = "Tipo de Imagen";
        public async Task<ResultadoModel<TipoImagenViewModel>> InsertAsync(tbTipoImagen item)
        {
            try
            {
                using var db = new AppCircularContext();
                var result = new ResultadoModel<TipoImagenViewModel>();
                var tb = db.tbTipoImagen.Any(a => a.tipImg_Descripcion.ToLower() == item.tipImg_Descripcion.ToLower());
                if (!tb)
                {
                    db.tbTipoImagen.Add(item);
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
                var error = new ResultadoModel<TipoImagenViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoImagenViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoImagenViewModel>();
                var tb = await db.tbTipoImagen.ToListAsync();

                if (tb.Count == 0)
                {
                    relt.Type = ServiceResultType.NoContent;
                    relt.Message = $"No se encontro Ningun registro de {nombre}";
                    relt.Data = new List<TipoImagenViewModel>();
                    return relt;
                }
                relt.Message = $"Operacion Exitosa, Listada de {nombre}";
                relt.Type = ServiceResultType.Success;
                relt.Data = tb.Select(a => new TipoImagenViewModel
                {
                    IdTipImagen = a.tipImg_Id,
                    Descripcion = a.tipImg_Descripcion
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<TipoImagenViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoImagenViewModel>> UpdateAsync(int id, TipoImagenModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoImagenViewModel>();
                var tb = await db.tbTipoImagen.SingleOrDefaultAsync(a => a.tipImg_Id == id);
                if (id > 0 && tb != null)
                {
                    var tipoW = db.tbTipoImagen.Where(e => e.tipImg_Id != id).Any(a => a.tipImg_Descripcion.ToLower() == item.Descripcion.ToLower());
                    if (!tipoW)
                    {
                        tb.tipImg_Descripcion = item.Descripcion;
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
                var error = new ResultadoModel<TipoImagenViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
