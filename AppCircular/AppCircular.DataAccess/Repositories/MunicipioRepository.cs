using AppCircular.Common.Models;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Municipio;
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
    public class MunicipioRepository : IMunicipioRepository<tbMunicipio>
    {
        public async Task<ServiceResult> InsertAsync(tbMunicipio item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult result = new ServiceResult();
                var paisW = db.tbMunicipio.Any(a => (a.muni_Nombre.ToLower() == item.muni_Nombre.ToLower() && a.dept_Id== item.dept_Id) || (a.muni_NuIdentidad == item.muni_NuIdentidad && a.dept_Id == item.dept_Id));
                if (!paisW)
                {
                    db.tbMunicipio.Add(item);
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
                result.Message = "El nombre de ese municipio ya Existe, O la Identidad Del municipio Ya existe";
                return result;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de Municipio, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                //var depart = await db.tbMunicipio.Include(a => a.dept).Include(e => e.psid ).ToListAsync();
                var depart = await db.tbMunicipio.Include(a => a.dept.pais).ToListAsync();
                relt.Message = depart.Count > 0 ? "Operacion Exitosa, Listada De Departamento" : "No se encontro Ningun Departamento";
                relt.Type = depart.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = depart.Select(a => new MunicipioViewModel
                {
                    muni_Id = a.muni_Id,
                    Nombre = a.muni_Nombre,
                    NuIdentidad = a.muni_NuIdentidad,
                    dept_Id = a.dept_Id,
                    Departamento = a.dept != null ? a.dept.dept_Nombre : string.Empty,
                    Pais_Id = a.dept != null ? a.dept.pais.pais_Id : 0,
                    Pais = a.dept != null ? a.dept.pais.pais_Nombre: string.Empty,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ServiceResult error = new ServiceResult() { Message = $"Lugar: Repositorio de Departamento, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ServiceResult> UpdateAsync(int Id, MunicipioModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                ServiceResult relt = new ServiceResult();
                var dep = await db.tbMunicipio.SingleOrDefaultAsync(a => a.muni_Id == Id);
                if (Id > 0 && dep != null)
                {
                    var depW = db.tbMunicipio.Where(e => e.muni_Id != Id).Any(a => (a.muni_Nombre.ToLower() == item.Nombre.ToLower() && a.dept_Id == item.dept_Id) || (a.muni_NuIdentidad == item.NuIdentidad && a.dept_Id == item.dept_Id));
                    if (!depW)
                    {
                        dep.muni_Nombre = item.Nombre;
                        dep.muni_NuIdentidad = item.NuIdentidad;
                        dep.dept_Id = item.dept_Id;
                        dep.muni_ValidaciosTelefono = item.ValidaciosTelefono;
                        dep.muni_ValidaciosTelefonoFijo = item.ValidaciosTelefonoFijo;
                        await db.SaveChangesAsync();
                        relt.Message = "Minicipio Actualizado Correctamente";
                        relt.Type = ServiceResultType.NoContent;
                        return relt;
                    }
                    relt.Success = false;
                    relt.Type = ServiceResultType.Error;
                    relt.Message = "El nombre de ese Municipio ya Existe, O la Identidad Del Municipio Ya existe";
                    return relt;
                }
                relt.Message = "El Municipio que desa actualizar no existe";
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
