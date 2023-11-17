using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories
{
    public class UsuarioRepository : IUsuarioRepository
    {
        private static string nombre = "Usuario";

        public async Task<ResultadoModel<bool>> ActualizarLogo(int idUsuario, string RutaImagen)
        {
            try
            {
                string vali = RutaImagen.Replace(" ", "");
                if (vali != "" && idUsuario > 0)
                {
                    using var db = new AppCircularContext();
                    var usuaurio = await db.tbUsuarios
                                .Include(u => u.usInf)  // Cargar la propiedad de navegación ipInf desde Usuario
                                .FirstOrDefaultAsync(a => a.user_Id == idUsuario);
                    if (usuaurio == null) return new ResultadoModel<bool>() { Message = "No se encontro el usaurio al cual actualizar", Success = false, Type = ServiceResultType.BadRecuest };
                    if (!usuaurio.usInf.usInf_IgualSubInfo ?? false && !usuaurio.user_UsuarioPrincipal) return new ResultadoModel<bool>() { Message = "El usuario no tiene permisos para modificar la el logo", Success = false, Type = ServiceResultType.Unauthorize };
                    usuaurio.usInf.usInf_RutaLogo = RutaImagen;
                    await db.SaveChangesAsync();
                    return new ResultadoModel<bool>() { Message = "Se actualizo la imagen del logo", Success = true, Type = ServiceResultType.Success, Value = true };
                }
                else return new ResultadoModel<bool>() { Message = $"Error ocurrrio en el Repository {nombre} Error: No cumple con las condiciones", Success = false, Type = ServiceResultType.BadRecuest };
            }
            catch (Exception ex)
            {
                return new ResultadoModel<bool>() { Message = $"Error ocurrrio en el Repository {nombre} Error: {ex.Message}", Success = false, Type = ServiceResultType.Error };
            }
        }

        public async Task<ResultadoModel<int>> CrearUsuario(UsuarioCrearModel usuario)
        {
            ResultadoModel<int> resultado = new();
            try
            {
                using (SqlConnection connection = new SqlConnection(AppCircularContext.ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("dbo.sp_CrearUsuario", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 0;
                        // Agrega parámetros si es necesario
                        command.Parameters.AddWithValue("@tipUs_Id", usuario.tipUs_Id);
                        command.Parameters.AddWithValue("@Nombre", usuario.Nombre);
                        command.Parameters.AddWithValue("@RutaLogo", usuario.RutaLogo);
                        command.Parameters.AddWithValue("@RutaPaginaWed", usuario.PaginaWed);
                        command.Parameters.AddWithValue("@Descripcion", usuario.Descripcion);
                        command.Parameters.AddWithValue("@NombreUsuario", usuario.NombreUsuario);
                        command.Parameters.AddWithValue("@tipIde_Id", usuario.tipIde_Id);
                        command.Parameters.AddWithValue("@Identificacion", usuario.Identidad);
                        command.Parameters.AddWithValue("@Password", usuario.Password);
                        command.Parameters.AddWithValue("@PasswordSal", usuario.PasswordSal);
                        command.Parameters.AddWithValue("@Facebook", usuario.Facebook);
                        command.Parameters.AddWithValue("@Intagram", usuario.Intagram);
                        command.Parameters.AddWithValue("@WhatsApp", usuario.WhatsApp);
                        command.Parameters.AddWithValue("@Envio", usuario.Envio);
                        command.Parameters.AddWithValue("@Correo", usuario.Correo);
                        command.Parameters.AddWithValue("@SubdicionLugar", usuario.subLug_Id);
                        command.Parameters.AddWithValue("@Latitud", usuario.Latitud);
                        command.Parameters.AddWithValue("@Longitub", usuario.Longitub);
                        //Tabla Horario y de Categoria
                        command.Parameters.AddWithValue("@tbHorarios", usuario.HorarioDate);
                        command.Parameters.AddWithValue("@tbCategoriaItem", usuario.CategoriaDate);
                        command.Parameters.AddWithValue("@tbUsuarioTelefono", usuario.TelefonoDate);
                        //Parametros de salida
                        SqlParameter successParameter = new SqlParameter("@Success", SqlDbType.Bit);
                        successParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(successParameter);

                        SqlParameter messageParameter = new SqlParameter("@Message", SqlDbType.NVarChar, 1000);
                        messageParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(messageParameter);

                        SqlParameter idUsuarioParameter = new SqlParameter("@IdUsuario", SqlDbType.Int);
                        idUsuarioParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(idUsuarioParameter);
                        // Ejecuta el procedimiento almacenado
                        SqlDataReader reader = await command.ExecuteReaderAsync();

                        // Procesa los resultados si los hay
                        if (command.Parameters.Contains("@Success") && command.Parameters["@Success"].Value != DBNull.Value)
                        {
                            resultado.Success = (bool)command.Parameters["@Success"].Value;
                        }

                        if (command.Parameters.Contains("@Message") && command.Parameters["@Message"].Value != DBNull.Value)
                        {
                            resultado.Message = (string)command.Parameters["@Message"].Value;
                        }

                        if (command.Parameters.Contains("@IdUsuario") && command.Parameters["@IdUsuario"].Value != DBNull.Value)
                        {
                            resultado.Value = (int)command.Parameters["@IdUsuario"].Value;
                        }
                    }
                }
                return resultado;

            }
            catch (Exception e)
            {
                resultado.Success = false;
                resultado.Message = $"Lugar: Repositorio de {nombre} Lugar, Error: {e.Message}";
                resultado.Type = ServiceResultType.Error;
                return resultado;
            }
        }

        public async Task<ResultadoModel<tbUsuarios>> Login(string correo, bool login = true)
        {
            ResultadoModel<tbUsuarios> resultado = new();
            try
            {
                using (SqlConnection connection = new SqlConnection(AppCircularContext.ConnectionString))
                {
                    await connection.OpenAsync();
                    using (SqlCommand command = new SqlCommand("dbo.sp_Login", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandTimeout = 0;
                        // Agrega parámetros si es necesario
                        command.Parameters.AddWithValue("@Correo", correo);
                        command.Parameters.AddWithValue("@Login", login);

                        SqlParameter successParameter = new SqlParameter("@Success", SqlDbType.Bit);
                        successParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(successParameter);

                        SqlParameter messageParameter = new SqlParameter("@Message", SqlDbType.NVarChar, 1000);
                        messageParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(messageParameter);

                        SqlParameter idUsuarioParameter = new SqlParameter("@IdUsuario", SqlDbType.Int);
                        idUsuarioParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(idUsuarioParameter);

                        SqlParameter passwordSal = new SqlParameter("@PasswordSal", SqlDbType.NVarChar, 1000);
                        passwordSal.Direction = ParameterDirection.Output;
                        command.Parameters.Add(passwordSal);

                        SqlParameter password = new SqlParameter("@Password", SqlDbType.NVarChar, 1000);
                        password.Direction = ParameterDirection.Output;
                        command.Parameters.Add(password);

                        // Ejecuta el procedimiento almacenado
                        SqlDataReader reader = await command.ExecuteReaderAsync();
                        tbUsuarios us = new tbUsuarios();
                        // Procesa los resultados si los hay
                        if (command.Parameters.Contains("@Success") && command.Parameters["@Success"].Value != DBNull.Value)
                        {
                            resultado.Success = (bool)command.Parameters["@Success"].Value;
                        }
                        if (command.Parameters.Contains("@Message") && command.Parameters["@Message"].Value != DBNull.Value)
                        {
                            resultado.Message = (string)command.Parameters["@Message"].Value;
                        }
                        if (command.Parameters.Contains("@IdUsuario") && command.Parameters["@IdUsuario"].Value != DBNull.Value)
                        {
                            us.user_Id = (int)command.Parameters["@IdUsuario"].Value;
                        }
                        else return new ResultadoModel<tbUsuarios>() { Message = "El Id del usuario no pudo ser octenido", Success = false };
                        if (command.Parameters.Contains("@PasswordSal") && command.Parameters["@PasswordSal"].Value != DBNull.Value)
                        {
                            us.user_PasswordSal = (string)command.Parameters["@PasswordSal"].Value;
                        }
                        else return new ResultadoModel<tbUsuarios>() { Message = "Unas de las contraseñas no pudo ser optenidaS", Success = false };
                        if (command.Parameters.Contains("@Password") && command.Parameters["@Password"].Value != DBNull.Value)
                        {
                            us.user_Password = (string)command.Parameters["@Password"].Value;
                        }
                        else return new ResultadoModel<tbUsuarios>() { Message = "Unas de las contraseñas no pudo ser optenida", Success = false };
                        resultado.Value = us;
                        return resultado;
                    }

                }
            }
            catch (Exception e)
            {
                return new ResultadoModel<tbUsuarios>() { Success = false, Message = $"Lugar: Repositorio de {nombre}, Error: {e.Message}", Type = ServiceResultType.Error };
            }
        }

        public async Task<ResultadoModel<bool>> UsuarioVarificado(int Id)
        {
            try
            {
                if (Id < 1) return new ResultadoModel<bool>() { Message = "El Id no complio con lo necesario", Success = false, Type = ServiceResultType.BadRecuest, Value = false };
                using var db = new AppCircularContext();
                var data = await db.tbUsuarios.Where(a => a.user_Id == Id).FirstOrDefaultAsync();
                if (data == null) return new ResultadoModel<bool>() { Message = "No se encontro lo que se buscaba", Success = false, Type = ServiceResultType.BadRecuest, Value = false };
                data.user_Verificado = true;
                if (await db.SaveChangesAsync() == 1)
                {
                    return new ResultadoModel<bool>() { Message = "Se a podido verificar su usuario", Success = true, Type = ServiceResultType.Success, Value = true };
                }
                return new ResultadoModel<bool>() { Message = "No se puedo verificar su usuario", Success = false, Type = ServiceResultType.Error, Value = false };
            }
            catch (Exception ex)
            {
                return new ResultadoModel<bool>() { Message = $"Error ocurrrio en el Repository {nombre} Error: {ex.Message}", Success = false, Type = ServiceResultType.Error };
            }
        }

        public async Task<ResultadoModel<bool>> WhereAsync(string correo, List<TelefonoViewModel> telefono)
        {
            var relt = new ResultadoModel<bool>();
            try
            {
                using (AppCircularContext db = new AppCircularContext())
                {
                    if (telefono.Count > 0)
                    {
                        foreach (var item in telefono)
                        {
                            var vali = db.tbUsuarioTelefono.Include(e => e.user).ToList().Where(a => a.user.user_Verificado).Any(i => i.usTel_Numero == item.Telefono);
                            if (vali)
                            {
                                relt.Success = false;
                                relt.Message = $"El numero de telefono {item.Telefono} ya existe.";
                                relt.Type = ServiceResultType.Error;

                                break;
                            }
                        }
                    }
                    else
                    {
                        relt.Success = false;
                        relt.Message = "Necesita almenos un numero de telefono.";
                        relt.Type = ServiceResultType.Error;
                    }

                    string correoV = correo.Replace(" ", "");
                    if (correoV != "")
                    {
                        bool tb = await db.tbUsuarios.AnyAsync(a => a.user_Correo.ToLower() == correo.ToLower() && a.user_Verificado);
                        relt.Success = !tb;
                        relt.Type = !tb ? ServiceResultType.Success : ServiceResultType.Error;
                        relt.Message += !tb ? $"El usuario con este correo no existe" : $" El correo {correo} Ya existe.";
                    }
                    else
                    {
                        relt.Success = false;
                        relt.Type = ServiceResultType.Error;
                        relt.Message += " Es necesario un correo.";
                    }

                }

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
