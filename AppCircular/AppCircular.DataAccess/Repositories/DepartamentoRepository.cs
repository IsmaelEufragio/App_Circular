using AppCircular.Common.Models;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
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
    public class DepartamentoRepository : IDepartamentoRepository<tbDepartamento>
    {
        private static string nombre = "Departamento";
        public async Task<ResultadoModel<PaisDepartamentoViewModel>> InsertAsync(tbDepartamento item)
        {
            try
            {
                using var db = new AppCircularContext();
                var result = new ResultadoModel<PaisDepartamentoViewModel>();
                var depW = db.tbDepartamento.Any(a => (a.dept_Nombre.ToLower() == item.dept_Nombre.ToLower() && a.pais_Id == item.pais_Id) || (a.dept_NuIdentidad == item.dept_NuIdentidad && a.pais_Id == item.pais_Id));
                if (!depW)
                {
                    db.tbDepartamento.Add(item);
                    var rult = await db.SaveChangesAsync();
                    if (rult == 0)
                    {
                        result.Success = false;
                        result.Type = ServiceResultType.Error;
                        result.Data = new List<PaisDepartamentoViewModel>();
                        result.Message = $"No se pudo guardar el {nombre} a la base";
                    }
                    result.Type = ServiceResultType.NoContent;
                    result.Message = "Creado Exitosamente";
                    result.Data = new List<PaisDepartamentoViewModel>();
                    return result;
                }
                result.Success = false;
                result.Type = ServiceResultType.Error;
                result.Message = $"El nombre de ese {nombre} ya Existe, O la Identidad Del {nombre} Ya existe";
                result.Data = new List<PaisDepartamentoViewModel>();
                return result;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<PaisDepartamentoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<PaisDepartamentoViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<PaisDepartamentoViewModel>();
                var depart = await db.tbPais.Include(a=> a.tbDepartamento).ToListAsync();
                if (depart != null)
                {
                    var paisDepart = depart.Select(a => new PaisDepartamentoViewModel
                    {
                        Id = a.pais_Id,
                        Pais = a.pais_Nombre,
                        Abrebiatura = a.pais_Abrebiatura,
                        Departamento = a.tbDepartamento != null ? a.tbDepartamento.Select(e => new DepartamentoViewModel
                        {
                            Id = e.dept_Id,
                            Nombre = e.dept_Nombre,
                            NuIdentidad = e.dept_NuIdentidad
                        }).ToList() : new List<DepartamentoViewModel>()
                    }).ToList();
                    relt.Success = true;
                    relt.Message = "Operacion Exitosa";
                    relt.Type = ServiceResultType.Success;
                    relt.Data = paisDepart;
                    return relt;
                }
                relt.Success = false;
                relt.Message = "No existe ningun registro";
                relt.Type = ServiceResultType.NoContent;
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<PaisDepartamentoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<PaisDepartamentoViewModel>> UpdateAsync(int Id, DepartamentoModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<PaisDepartamentoViewModel>();
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
                var error = new ResultadoModel<PaisDepartamentoViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
