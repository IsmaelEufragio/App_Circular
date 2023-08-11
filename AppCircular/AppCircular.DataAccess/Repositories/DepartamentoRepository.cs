using AppCircular.Common.Models;
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
    public class DepartamentoRepository : IDepartamentoRepository<tbDepartamento>
    {
        private static string nombre = "Departamento";
        public async Task<ServiceResult> InsertAsync(tbDepartamento item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult result = new ServiceResult();
                var depW = db.tbDepartamento.Any(a => (a.dept_Nombre.ToLower() == item.dept_Nombre.ToLower() && a.pais_Id == item.pais_Id) || (a.dept_NuIdentidad == item.dept_NuIdentidad && a.pais_Id == item.pais_Id));
                if (!depW)
                {
                    db.tbDepartamento.Add(item);
                    var rult = await db.SaveChangesAsync();
                    if (rult == 0)
                    {
                        result.Success = false;
                        result.Type = ServiceResultType.Error;
                        result.Message = $"No se pudo guardar el {nombre} a la base";
                    }
                    result.Type = ServiceResultType.NoContent;
                    result.Message = "Creado Exitosamente";
                    return result;
                }
                result.Success = false;
                result.Type = ServiceResultType.Error;
                result.Message = $"El nombre de ese {nombre} ya Existe, O la Identidad Del {nombre} Ya existe";
                return result;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var depart = await db.tbDepartamento.Include(a=> a.pais).ToListAsync();

                relt.Message = depart.Count > 0 ? $"Operacion Exitosa, Listada De {nombre}" : $"No se encontro Ningun {nombre}";
                relt.Type = depart.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = depart.Select(a => new DepartamentoViewModel
                {
                    Id = a.dept_Id,
                    Nombre = a.dept_Nombre,
                    NuIdentidad = a.dept_NuIdentidad,
                    pais_Id = a.pais_Id,
                    Pais = a.pais != null ? a.pais.pais_Nombre : string.Empty,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> UpdateAsync(int Id, DepartamentoModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var dep = await db.tbDepartamento.SingleOrDefaultAsync(a => a.dept_Id == Id);
                if (Id > 0 && dep != null)
                {
                    var depW = db.tbDepartamento.Where(e=> e.dept_Id != Id).Any(a => (a.dept_Nombre.ToLower() == item.Nombre.ToLower() && a.pais_Id == item.pais_Id) || (a.dept_NuIdentidad == item.NuIdentidad && a.pais_Id == item.pais_Id));
                    if (!depW)
                    {
                        dep.dept_Nombre = item.Nombre;
                        dep.dept_NuIdentidad = item.NuIdentidad;
                        dep.pais_Id = item.pais_Id;
                        await db.SaveChangesAsync();
                        relt.Message = $"{nombre} Actualizado Correctamente";
                        relt.Type = ServiceResultType.NoContent;
                        return relt;
                    }
                    relt.Success = false;
                    relt.Type = ServiceResultType.Error;
                    relt.Message = $"El nombre de ese {nombre} ya Existe, O la Identidad Del {nombre} Ya existe";
                    return relt;
                }
                relt.Message = $"El {nombre} que desa actualizar no existe";
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
