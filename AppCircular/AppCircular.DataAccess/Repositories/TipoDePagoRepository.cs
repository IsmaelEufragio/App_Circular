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
    public class TipoDePagoRepository : ITipoDePagoRepository<tbTipoPago>
    {
        private static string nombre = "Tipo de Pago";
        public async Task<ResultadoModel<TipoDePagoViewModel>> InsertAsync(tbTipoPago item)
        {
            try
            {
                using var db = new AppCircularContext();
                var result = new ResultadoModel<TipoDePagoViewModel>();
                var tb = db.tbTipoPago.Any(a => a.tipPag_Descripcion.ToLower() == item.tipPag_Descripcion.ToLower());
                if (!tb)
                {
                    db.tbTipoPago.Add(item);
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
                var error = new ResultadoModel<TipoDePagoViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoDePagoViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoDePagoViewModel>();
                var tb = await db.tbTipoPago.ToListAsync();

                if (tb.Count == 0)
                {
                    relt.Type = ServiceResultType.NoContent;
                    relt.Message = $"No se encontro Ningun registro de {nombre}";
                    relt.Data = new List<TipoDePagoViewModel>();
                    return relt;
                }
                relt.Message = $"Operacion Exitosa, Listada de {nombre}";
                relt.Type = ServiceResultType.Success;
                relt.Data = tb.Select(a => new TipoDePagoViewModel
                {
                    idTipoPago = a.tipPag_Id,
                    Descripcion = a.tipPag_Descripcion
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<TipoDePagoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoDePagoViewModel>> UpdateAsync(int id, TipoDePagoModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoDePagoViewModel>();
                var tb = await db.tbTipoPago.SingleOrDefaultAsync(a => a.tipPag_Id == id);
                if (id > 0 && tb != null)
                {
                    var tipoW = db.tbTipoPago.Where(e => e.tipPag_Id != id).Any(a => a.tipPag_Descripcion.ToLower() == item.Descripcion.ToLower());
                    if (!tipoW)
                    {
                        tb.tipPag_Descripcion = item.Descripcion;
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
                var error = new ResultadoModel<TipoDePagoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
