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
        private static string nombre = "Categoria";
        public async Task<ResultadoModel<int>> CrearUsuario(UsuarioCrearModel usuario, string Coneccion)
        {
            ResultadoModel<int> resultado = new();
            try
            {
                using (SqlConnection connection = new SqlConnection(Coneccion))
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
                        command.Parameters.AddWithValue("@FechaFundacion", usuario.FechaFundacion);
                        command.Parameters.AddWithValue("@NombreUsuario", usuario.NombreUsuario);
                        command.Parameters.AddWithValue("@Password", usuario.Password);
                        command.Parameters.AddWithValue("@PasswordSal", usuario.PasswordSal);
                        command.Parameters.AddWithValue("@TelefonoPricipal", usuario.PrimerTelefono);
                        command.Parameters.AddWithValue("@TelefonoSecundario", usuario.SegundoTelefono);
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

        public async Task<ResultadoModel<bool>> WhereAsync(string correo, string telefonoP)
        {
            var relt = new ResultadoModel<bool>();
            try
            {
                string correoV = correo.Replace(" ", "");
                string telefonoV = telefonoP.Replace(" ", "");
                if (!(correoV == ""  || telefonoV == ""))
                {
                    using var db = new AppCircularContext();
                    bool tb = await db.tbUsuarios.AnyAsync(a => a.user_Correo.ToLower() == correo.ToLower() || a.user_TelefonoPrincipal == telefonoP);
                    relt.Success = !tb;
                    relt.Type = !tb ? ServiceResultType.Success : ServiceResultType.Error;
                    relt.Message = !tb ? $"El usuario con ese correo no existe" : $"Ya existe Es correo";
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
