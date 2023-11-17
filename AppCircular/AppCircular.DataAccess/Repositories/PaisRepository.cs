using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Pais;
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
    public class PaisRepository : IPaisRepository<tbPais>
    {
        public async Task<ServiceResult> InsertAsync(tbPais item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult result = new ServiceResult();
                var paisW = db.tbPais.Any(a => a.pais_Nombre.ToLower() == item.pais_Nombre.ToLower() || a.pais_Abrebiatura.ToLower() == item.pais_Abrebiatura.ToLower());
                if (!paisW)
                {
                    db.tbPais.Add(item);
                    var rult = await db.SaveChangesAsync();
                    if (rult == 0)
                    {
                        result.Success = false;
                        result.Type = ServiceResultType.Error;
                        result.Message = "No se pudo guardar el pais a la base";
                    }
                    result.Type = ServiceResultType.NoContent;
                    result.Message = "Creado Exitosamente";
                    return result;
                }
                result.Success = false;
                result.Type = ServiceResultType.Error;
                result.Message = "Ya Existe este pais o Abrebiatura";
                return result;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de Pais, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var pais = await db.tbPais.ToListAsync();

                relt.Message = pais.Count > 0 ? "Operacion Exitosa, Listada De pais" : "No se encontro Ningun Pais";
                relt.Type = pais.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = pais.Select(a => new PaisViewModel
                {
                    Id = a.pais_Id,
                    Nombre = a.pais_Nombre,
                    Abrebiatura = a.pais_Abrebiatura
                }).ToList();

                return relt;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de Pais, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> UpdateAsync(int Id, PaisModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var pais = await db.tbPais.SingleOrDefaultAsync(a => a.pais_Id == Id);
                if (Id > 0 && pais != null)
                {
                    pais.pais_Nombre = item.Nombre;
                    pais.pais_Abrebiatura = item.Abrebiatura;
                    await db.SaveChangesAsync();
                    relt.Message = "Pais Actualizado Correctamente";
                    relt.Type = ServiceResultType.NoContent;
                    return relt;
                }
                relt.Message = "El pais que desa actualizar no existe";
                relt.Success = false;
                relt.Type = ServiceResultType.Error;
                return relt;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de Pais, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
