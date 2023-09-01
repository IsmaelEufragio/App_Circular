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
    public class ConfiguracionRepository : IConfiguracionRepository<tbConfiguracion>
    {
        private static string nombre = "Configuracion";
        public async Task<ResultadoModel<ConfiguracioViewModel>> InsertAsync(tbConfiguracion item)
        {
            try
            {
                using var db = new AppCircularContext();
                var result = new ResultadoModel<ConfiguracioViewModel>();
                var confW = db.tbConfiguracion.Any(a => a.conf_Nombre.ToLower() == item.conf_Nombre.ToLower());
                if (!confW)
                {
                    db.tbConfiguracion.Add(item);
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
                var error = new ResultadoModel<ConfiguracioViewModel>() { Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}", Success = true, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<ConfiguracioViewModel>> ListAsync()
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<ConfiguracioViewModel>();
                var conf = await db.tbConfiguracion.ToListAsync();
                relt.Message = conf.Count > 0 ? $"Operacion Exitosa, Listada de {nombre}" : $"No se encontro Ningun registro de {nombre}";
                relt.Type = conf.Count > 0 ? ServiceResultType.Success : ServiceResultType.NoContent;
                if (conf.Count == 0)
                {
                    relt.Data = new List<ConfiguracioViewModel>(); 
                    return relt;
                }
                relt.Data = conf.Select(a => new ConfiguracioViewModel
                {
                    Id = a.conf_Id,
                    Nombre = a.conf_Nombre,
                    Valor = a.conf_Valor,
                    Descripcion = a.conf_Descripcion,
                }).ToList();
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<ConfiguracioViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<ConfiguracioViewModel>> UpdateAsync(int id, ConfiguracionModel item)
        {
            try
            {
                using var db = new AppCircularContext();
                var relt = new ResultadoModel<ConfiguracioViewModel>();
                var tbConfi = await db.tbConfiguracion.SingleOrDefaultAsync(a => a.conf_Id == id);
                if (id > 0 && tbConfi != null)
                {
                    var tipoW = db.tbTipoUsuario.Where(e => e.tipUs_Id != id).Any(a => a.tipUs_Descripcion.ToLower() == item.Descripcion.ToLower());
                    if (!tipoW)
                    {
                        tbConfi.conf_Nombre = item.Nombre;
                        tbConfi.conf_Valor = item.Valor;
                        tbConfi.conf_Descripcion = item.Descripcion;
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
                var error = new ResultadoModel<ConfiguracioViewModel>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }

        public async Task<ResultadoModel<string>> WhereAsync(string nombre)
        {
            var relt = new ResultadoModel<string>();
            try
            {
                string strigVa = nombre.Replace(" ", "");
                if (strigVa != "")
                {
                    using var db = new AppCircularContext();
                    var tbConfi = await db.tbConfiguracion.SingleOrDefaultAsync(a => a.conf_Nombre.ToLower() == nombre.ToLower());
                    if (tbConfi != null)
                    {
                        relt.Success = true;
                        relt.Type = ServiceResultType.NoContent;
                        relt.Message = "Todo Correcmente";
                        relt.Value = tbConfi.conf_Valor;
                        return relt;
                    }
                    relt.Success = false;
                    relt.Type = ServiceResultType.Error;
                    relt.Message = "No se encontro la configuracion";
                    return relt;
                }
                relt.Success = false;
                relt.Type = ServiceResultType.Error;
                relt.Message = "No se se envio nada";
                return relt;
            }
            catch (Exception e)
            {
                var error = new ResultadoModel<string>() { Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Success = false, Type = ServiceResultType.Error };
                return error;
            }
        }
    }
} 
