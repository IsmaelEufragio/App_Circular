using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories
{
    public class TipoUsuarioRepository : ITipoUsuarioRepository<tbTipoUsuario>
    {
        private static string nombre = "Tipo Usuario";
        public async Task<ResultadoModel<TipoUsuarioViewModel>> InsertAsync(tbTipoUsuario item)
        {
            try
            {
                using var db = new AppCircularContext();
                ResultadoModel<TipoUsuarioViewModel> result = new ResultadoModel<TipoUsuarioViewModel>();
                var tipoUsaurioW = db.tbTipoUsuario.Any(a => a.tipUs_Descripcion.ToLower() == item.tipUs_Descripcion.ToLower()) ;
                if (!tipoUsaurioW)
                {
                    db.tbTipoUsuario.Add(item);
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
                ResultadoModel<TipoUsuarioViewModel> error = new ResultadoModel<TipoUsuarioViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoUsuarioViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoUsuarioViewModel>();
                var cateLug = await db.tbTipoUsuario.ToListAsync();

                relt.Message = cateLug.Count > 0 ? $"Operacion Exitosa, Listada de {nombre}" : $"No se encontro Ningun registro de {nombre}";
                relt.Type = cateLug.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                relt.Data = cateLug.Select(a => new TipoUsuarioViewModel
                {
                    Id = a.tipUs_Id,
                    Descripcion = a.tipUs_Descripcion,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                ResultadoModel<TipoUsuarioViewModel> error = new ResultadoModel<TipoUsuarioViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<TipoUsuarioViewModel>> UpdateAsync(int id, TipoUsuarioModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<TipoUsuarioViewModel>();
                var tbTipoUser = await db.tbTipoUsuario.SingleOrDefaultAsync(a => a.tipUs_Id == id);
                if (id > 0 && tbTipoUser != null)
                {
                    var tipoW = db.tbTipoUsuario.Where(e => e.tipUs_Id != id).Any(a => a.tipUs_Descripcion.ToLower() == item.Descripcion.ToLower());
                    if (!tipoW)
                    {
                        tbTipoUser.tipUs_Descripcion = item.Descripcion;
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
                var error = new ResultadoModel<TipoUsuarioViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<bool>> WhereAsync(int idTipoUsuario)
        {
            var relt = new ResultadoModel<bool>();
            try
            {
                
                if (idTipoUsuario > 0)
                {
                    using var db = new AppCircularContext();
                    bool tb = await db.tbTipoUsuario.AnyAsync(a => a.tipUs_Id== idTipoUsuario);
                    relt.Success = tb;
                    relt.Type = tb? ServiceResultType.Success: ServiceResultType.Error;
                    relt.Message =tb?"Si se encontro el Tipo de Usuario": "No se encontro el Tipo de Usuario";
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
