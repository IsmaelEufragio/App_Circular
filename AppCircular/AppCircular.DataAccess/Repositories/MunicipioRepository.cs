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
        public async Task<ResultadoModel<DeparmentoMunicipioViewModel>> InsertAsync(tbMunicipio item)
        {
            try
            {
                using var db = new AppCircularContext();
                var result = new ResultadoModel<DeparmentoMunicipioViewModel>();
                var paisW = db.tbMunicipio.Any(a => (a.muni_Nombre.ToLower() == item.muni_Nombre.ToLower() && a.dept_Id == item.dept_Id) || (a.muni_NuIdentidad == item.muni_NuIdentidad && a.dept_Id == item.dept_Id));
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
                var error = new ResultadoModel<DeparmentoMunicipioViewModel>() { Message = $"Lugar: Repositorio de Municipio, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<DeparmentoMunicipioViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<DeparmentoMunicipioViewModel> relt = new ResultadoModel<DeparmentoMunicipioViewModel>();
                //var depart = await db.tbMunicipio.Include(a => a.dept).Include(e => e.psid ).ToListAsync();
                var depart = await db.tbDepartamento.Include(a => a.tbMunicipio).ToListAsync();
                if (depart != null)
                {
                    var map = depart.Select(a => new DeparmentoMunicipioViewModel
                    {
                        Id = a.dept_Id,
                        Departamento = a.dept_Nombre,
                        NuIdentidad = a.dept_NuIdentidad,
                        Municipio = a.tbMunicipio != null ? a.tbMunicipio.Select(e => new MunicipioViewModel
                        {
                            Id = e.muni_Id,
                            Nombre = e.muni_Nombre,
                            NuIdentidad = e.muni_NuIdentidad,
                            ValidaciosTelefono = e.muni_ValidaciosTelefono,
                            ValidaciosTelefonoFijo = e.muni_ValidaciosTelefonoFijo
                        }).ToList() : new List<MunicipioViewModel>(),
                    }).ToList();
                    relt.Success = true;
                    relt.Message = "Operacion realizada con exito";
                    relt.Type = ServiceResultType.Success;
                    relt.Data = map;
                    return relt;
                }
                relt.Success = true;
                relt.Message = "No se encontro ningun resultado";
                relt.Type = ServiceResultType.NoContent;
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<DeparmentoMunicipioViewModel> { Message = $"Lugar: Repositorio de Departamento, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<DeparmentoMunicipioViewModel>> UpdateAsync(Guid Id, MunicipioModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<DeparmentoMunicipioViewModel>();
                var dep = await db.tbMunicipio.SingleOrDefaultAsync(a => a.muni_Id == Id);
                if (Id != Guid.Empty && dep != null)
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
                var error = new ResultadoModel<DeparmentoMunicipioViewModel> { Message = $"Lugar: Repositorio de Pais, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
}
