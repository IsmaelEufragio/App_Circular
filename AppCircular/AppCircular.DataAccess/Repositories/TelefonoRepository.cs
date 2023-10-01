using AppCircular.Common.Models.Configuracion;
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
    public class TelefonoRepository : ITelefonoRepository<tbUsuarioTelefono>
    {
        private static string nombre = "Telefono";
        public async Task<ResultadoModel<TelefonoViewModel>> InsertAsync(tbUsuarioTelefono item)
        {
            try
            {
                using var db = new AppCircularContext();
                var result = new ResultadoModel<TelefonoViewModel>();
                var tb = db.tbUsuarioTelefono.Any(a => a.usTel_Numero.ToLower() == item.usTel_Numero.ToLower());
                if (!tb)
                {
                    db.tbUsuarioTelefono.Add(item);
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
                var error = new ResultadoModel<TelefonoViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TelefonoModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TelefonoModel>();
                var tb = await db.tbUsuarioTelefono.ToListAsync();
   
                if (tb.Count == 0)
                {
                    relt.Type = ServiceResultType.NoContent;
                    relt.Message = $"No se encontro Ningun registro de {nombre}";
                    relt.Data = new List<TelefonoModel>();
                    return relt;
                }
                relt.Message = $"Operacion Exitosa, Listada de {nombre}";
                relt.Type = ServiceResultType.Success;
                relt.Data = tb.Select(a => new TelefonoModel
                {
                    IdUsuario = a.usTel_Id,
                    Telefono = a.usTel_Numero,
                    idTipoTelefono = a.tipTel_Id
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<TelefonoModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TelefonoViewModel>> UpdateAsync(int id, TelefonoModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TelefonoViewModel>();
                var tb = await db.tbUsuarioTelefono.SingleOrDefaultAsync(a => a.usTel_Id == id);
                if (id > 0 && tb != null)
                {
                    var tipoW = db.tbUsuarioTelefono.Where(e => e.usTel_Id != id).Any(a => a.usTel_Numero.ToLower() == item.Telefono.ToLower());
                    if (!tipoW)
                    {
                        tb.usTel_Numero = item.Telefono;
                        tb.usTel_Id = item.IdUsuario;
                        tb.tipTel_Id = item.idTipoTelefono;
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
                var error = new ResultadoModel<TelefonoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

    }
}
