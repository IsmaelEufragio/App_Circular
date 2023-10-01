using AppCircular.Common.Models.Catalogo;
using AppCircular.Common.Models.Categoria;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.Entities.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public class TipoCatalogoRepository : ITipoCatalogoRepository<tbTipoCatalogo>
    {
        private static string nombre = "Tipo de Catalogo";
        public async Task<ResultadoModel<TipoCatalogoViewModel>> InsertAsync(tbTipoCatalogo item)
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<TipoCatalogoViewModel> result = new();
                var W = db.tbTipoCatalogo.Any(a => a.tipCatg_Descripcion.ToLower() == item.tipCatg_Descripcion.ToLower());
                if (!W)
                {
                    db.tbTipoCatalogo.Add(item);
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
                ResultadoModel<TipoCatalogoViewModel> error = new() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoCatalogoViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoCatalogoViewModel>();
                var tb = await db.tbTipoCatalogo.ToListAsync();

                if (tb.Count == 0)
                {
                    relt.Type = ServiceResultType.NoContent;
                    relt.Message = $"No se encontro Ningun registro de {nombre}";
                    relt.Data = new List<TipoCatalogoViewModel>();
                    return relt;
                }
                relt.Message = $"Operacion Exitosa, Listada de {nombre}";
                relt.Type = ServiceResultType.Success;
                relt.Data = tb.Select(a => new TipoCatalogoViewModel
                {
                    Id = a.tipCatg_Id,
                    Descripcion = a.tipCatg_Descripcion
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ResultadoModel<TipoCatalogoViewModel> error = new() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoCatalogoViewModel>> UpdateAsync(int id, TipoCatalogoModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoCatalogoViewModel>();
                var tb = await db.tbTipoCatalogo.SingleOrDefaultAsync(a => a.tipCatg_Id == id);
                if (id > 0 && tb != null)
                {
                    var tipoW = db.tbTipoCatalogo.Where(e => e.tipCatg_Id != id).Any(a => a.tipCatg_Descripcion.ToLower() == item.Descripcion.ToLower());
                    if (!tipoW)
                    {
                        tb.tipCatg_Descripcion = item.Descripcion;
                        tb.tipCatg_Id = item.Id;
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
                var error = new ResultadoModel<TipoCatalogoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
