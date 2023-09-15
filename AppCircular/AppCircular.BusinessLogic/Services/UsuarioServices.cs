using AppCircular.Common.Models.Account;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories;
using AppCircular.Entities.Entities;
using System.Net.Mail;
using System.Net;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.Extensions.Options;
using AppCircular.Common.Models.Categoria;
using System.Data;
using AppCircular.BusinessLogic.LibreriaClases;
using Microsoft.AspNetCore.Http;
using MimeDetective;
using System.IO.Compression;

namespace AppCircular.BusinessLogic.Services
{
    public class UsuarioServices: BaseServices
    {
        private readonly TipoUsuarioRepository _tipoUsuarioRepository;
        private readonly InfoUnicaUsuarioRepository _infoUnicaUsuarioRepository;
        //private  IConfiguration _iConfiguration;
        //private readonly JwtModel _jwtSettings;
        private readonly CategoriaRepository _categoriaRepository;
        private readonly UsuarioRepository _usuarioRepository;
        private readonly SubdivicionLugarRepository _subdivicionLugarRepository;
        public UsuarioServices( TipoUsuarioRepository tipoUsuarioRepository,
                                InfoUnicaUsuarioRepository infoUnicaUsuarioRepository,
                                ConfiguracionRepository configuracionRepository,
                                IConfiguration iConfiguration,
                                IOptions<JwtModel> jwtSettings,
                                CategoriaRepository categoriaRepository,
                                UsuarioRepository usuarioRepository,
                                SubdivicionLugarRepository subdivicionLugarRepository): base(configuracionRepository,jwtSettings,iConfiguration)
        {
            _tipoUsuarioRepository = tipoUsuarioRepository;
            _infoUnicaUsuarioRepository = infoUnicaUsuarioRepository;
            //_iConfiguration = iConfiguration;
            //_jwtSettings = jwtSettings.Value;
            _categoriaRepository = categoriaRepository;
            _usuarioRepository = usuarioRepository;
            _subdivicionLugarRepository = subdivicionLugarRepository;
        }
         
        #region Tipo Usuario

        public async Task<ServiceResult> listaTipoUser()
        {
            try
            {
                var repositorio = await _tipoUsuarioRepository.ListAsync();
                var resul = new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Usaurio, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTipoUser(TipoUsuarioModel model)
        {
            var tbMuni = new tbTipoUsuario();
            tbMuni.tipUs_Descripcion = model.Descripcion;
            var repositorio = await _tipoUsuarioRepository.InsertAsync(tbMuni);
            return new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
        }
         
        public async Task<ServiceResult> ActualizarTipoUser( int id,TipoUsuarioModel model)
        {

            var listado = await _tipoUsuarioRepository.UpdateAsync(id,model);
            return new Convertidor<TipoUsuarioViewModel>().mape(listado);
        }
        
        #endregion

        #region Informacion De Usuario Unica

        public async Task<ServiceResult> listaInfoUsaurio()
        {
            var result = new ServiceResult();
            var listado = await _infoUnicaUsuarioRepository.ListAsync();
            var userInfo = listado.Select(item => new InfoUnicaUsuarioViewModel
            {
                Id = item.ipInf_Id,
                Nombre = item.tInf_Nombre,
                RutaLogo = item.tInf_RutaLogo,
                RutaPaginaWed = item.tInf_RutaPaginaWed,
                IgualSubInfo = item.tInf_IgualSubInfo,
                tipUs_Id = item.tipUs_Id,
            }).ToList();

            return result.Ok(userInfo);
        }

        public async Task<ServiceResult> CrearInfoUser(InfoUnicaUsuarioViewModel model)
        {
            var result = new ServiceResult();
            var tbUserUnico = new tbInfoUnicaUsuario();
            tbUserUnico.tInf_Nombre = model.Nombre;
            tbUserUnico.tInf_RutaLogo = model.RutaLogo;
            tbUserUnico.tInf_RutaPaginaWed = model.RutaPaginaWed;
            tbUserUnico.tInf_RutaLogo = model.RutaLogo;
            tbUserUnico.tipUs_Id = model.tipUs_Id;

            var listado = await _infoUnicaUsuarioRepository.InsertAsync(tbUserUnico);
            return result.Ok(listado);
        }

        public async Task<ServiceResult> ActualizarInfoUser(int id, InfoUnicaUsuarioViewModel model)
        {
            var result = new ServiceResult();
            var listado = await _infoUnicaUsuarioRepository.UpdateAsync(id, model);
            return result.Ok(listado);
        }

        #endregion

        #region Auntenticacion

        public async Task<ServiceResult> Correo(EmailModel emailModel)
        {
            var result = new ServiceResult();
            var smtpServCon = await _configuracionRepository.WhereAsync("smtpServer");
            if (!smtpServCon.Success) return result.Error("No se encontro la configuracion 'smtpServer'");
            string smtpServer = smtpServCon.Value; // Cambia esto al servidor SMTP que utilices

            var smtpPortCon = await _configuracionRepository.WhereAsync("smtpPort");
            if (!smtpPortCon.Success) return result.Error("No se encontro la configuracion 'smtpPort'");
            if (!(int.TryParse(smtpPortCon.Value, out int smtpPort))) return result.Error("La configuracion 'smtpPort' devolvio un string que no se puede convertir a numero");

            var senderEmailCon = await _configuracionRepository.WhereAsync("senderEmail");
            if (!senderEmailCon.Success) return result.Error("No se encontro la configuracion 'senderEmail'");
            string senderEmail = senderEmailCon.Value; // Tu dirección de correo electrónico

            var senderPasswordCon = await _configuracionRepository.WhereAsync("senderPassword");
            if (!senderPasswordCon.Success) return result.Error("No se encontro la configuracion 'senderPassword'");
            string senderPassword = senderPasswordCon.Value; // Tu contraseña de correo electrónico

            using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
            {
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);
                smtpClient.EnableSsl = true;

                MailMessage mailMessage = new MailMessage(senderEmail, emailModel.DestinoCorreo, emailModel.Asunto, emailModel.Cuerpo);
                mailMessage.IsBodyHtml = true; // Si deseas enviar un correo HTML
                try
                {
                    await smtpClient.SendMailAsync(mailMessage);
                    result.Type = ServiceResultType.NoContent;
                    result.Success = true;
                    result.Message = "Correo enviado exitosamente.";
                    return result;
                }
                catch (Exception ex)
                {
                    result.Type = ServiceResultType.Error;
                    result.Success = false;
                    result.Message = $"Error al enviar el correo: {ex.Message}";
                    return result;
                }
            }
        }

        public async Task<ServiceResult> Token(int tiempoExpiracion, int idUsario)
        {
            var resul = new ServiceResult();
            try
            {
                var jwt = _jwtSettings;
                var claims = new[]
                {
                new Claim(JwtRegisteredClaimNames.Sub, jwt.Subject),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
                new Claim("UserId", idUsario.ToString())
                };

                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwt.Key));
                var singIn = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                var token = new JwtSecurityToken(
                        jwt.Issuer,
                        jwt.Audience,
                        claims,
                        expires: DateTime.Now.AddMinutes(tiempoExpiracion),
                        signingCredentials: singIn);
                var resp = new JwtSecurityTokenHandler().WriteToken(token);
                resul.Success = true;
                resul.Type = ServiceResultType.NoContent;
                resul.Data = resp;
                resul.Message = $"Token Generado tiempo de Expiracion {tiempoExpiracion} minuto";
                return resul;
            }
            catch (Exception ex)
            {
                resul.Success = false;
                resul.Type = ServiceResultType.Error;
                resul.Message = $"TokenGenerado {ex.Message}";
                return resul;
            }
        }
        
        public async Task<ServiceResult> Varificar(LoginModel model)
        {
            var resul = new ServiceResult();
            //Aqui iria la validacion del usuario envez de controlador
            var rutaApi = await _configuracionRepository.WhereAsync("ApiRutaToken");
            if (!rutaApi.Success) return resul.Error("No se encontro la configuracion 'ApiRuta'");
            string ruta = rutaApi.Value;

            var tokeM = Token(1, 14);
            string token = tokeM.Result.Success ? tokeM.Result.Data : "";
            var email = new EmailModel() {
                DestinoCorreo = model.Usuario,
                Asunto = "Verificacion Del token",
                Cuerpo = $"{ruta}{token}"
            };
            var correo = Correo(email);
            return correo.Result;
        }

        public ServiceResult TokeValido(string token)
        {
            ServiceResult resul = new ServiceResult();
            var jwtSecret = _jwtSettings.Key; // Cambia esto por tu secreto real
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(jwtSecret);

            try
            {
                var validationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };

                var claimsPrincipal = tokenHandler.ValidateToken(token, validationParameters, out _);
                resul.Success = true;
                resul.Message = "Token válido";
                resul.Type = ServiceResultType.NoContent;
                return resul;
            }
            catch (Exception ex)
            {
                resul.Success = false;
                resul.Message = "Token Invalido";
                resul.Type = ServiceResultType.Forbidden;
                return resul;
            }
        }
        #endregion

        #region Categoria Del Ususario

        public async Task<ServiceResult> listaCategoria()
        {
            try
            {
                var repositorio = await _categoriaRepository.ListAsync();
                var resul = new Convertidor<CategoriaViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Usaurio, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearCategoria(CategoriaModel model)
        {
            var tbMuni = new tbCategoria();
            tbMuni.catg_Nombre = model.Nombre;
            var repositorio = await _categoriaRepository.InsertAsync(tbMuni);
            return new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarCategoria(int id, CategoriaModel model)
        {

            var listado = await _categoriaRepository.UpdateAsync(id, model);
            return new Convertidor<TipoUsuarioViewModel>().mape(listado);
        }


        #endregion

        #region Usuario

        public async Task<ServiceResult> CrearUsaurio(UsuarioCrearModel model)
        {
            try
            {
                ServiceResult result = new();
                //string confi = _iConfiguration.GetConnectionString("DefaultConnection");
                var cong = await _configuracionRepository.WhereAsync("IdTipoUsuarioParticular");
                if (cong.Success && (int.TryParse(cong.Value, out int idParticualar)))
                {
                    if (idParticualar != model.tipUs_Id)
                    {
                        if (model.Horario.Count > 0)
                        {
                            DataTable Horario = new DataTable();
                            Horario.Columns.Add("hor_DiaNumero", typeof(int));
                            Horario.Columns.Add("hor_HoraInicio", typeof(int));
                            Horario.Columns.Add("hor_MinutoInicio", typeof(int));
                            Horario.Columns.Add("hor_HoraFin", typeof(int));
                            Horario.Columns.Add("hor_MinutoFin", typeof(int));

                            foreach (var item in model.Horario)
                            {
                                Horario.Rows.Add(item.DiaNumero, item.HoraInicio, item.MinutoInicio, item.HoraFin, item.MinutoFin);
                            }
                            model.HorarioDate = Horario;
                        }
                        else return new ServiceResult() { Message = "tiene que tener alemnos un dia Abierto", Success = false, Type = ServiceResultType.Error };

                        if (model.Categoria.Count > 0)
                        {
                            DataTable categoriaData = new DataTable();
                            categoriaData.Columns.Add("aria_Id", typeof(int));

                            var cateoriaRep = await _categoriaRepository.ListAsync();
                            if (cateoriaRep.Success)
                            {
                                foreach (var item in model.Categoria)
                                {
                                    if (cateoriaRep.Data.Any(a => a.Id == item.catg_Id))
                                    {
                                        categoriaData.Rows.Add(item.catg_Id);
                                    }
                                    else return new ServiceResult() { Data = item, Message = "No existe esta Categoria", Success = false, Type = ServiceResultType.Error };
                                }
                                model.CategoriaDate = categoriaData;
                            }
                            else return new Convertidor<CategoriaViewModel>().mape(cateoriaRep);
                        }
                        else return new ServiceResult() { Message = "Tienee que tener al menos una categoria", Success = false, Type= ServiceResultType.Error};
                    }
                }
                var tipoRe = await _tipoUsuarioRepository.WhereAsync(model.tipUs_Id);
                if (!tipoRe.Success) return new Convertidor<bool>().mape(tipoRe);
                var subLugar = await _subdivicionLugarRepository.WhereAsync(model.subLug_Id);
                if (!subLugar.Success) return new Convertidor<bool>().mape(subLugar);
                var valiUsu = await _usuarioRepository.WhereAsync(model.Correo, model.PrimerTelefono);
                if (!valiUsu.Success) return new Convertidor<bool>().mape(valiUsu);
                //Crear contraseñas incriptadas
                model.PasswordSal = Guid.NewGuid().ToString();
                model.Password = EncryptPass.GeneratePassword(model.Password, model.PasswordSal);
                //
                model.RutaLogo = "N/A";
                var repositorio = await _usuarioRepository.CrearUsuario(model);
                if (repositorio.Success) {

                    ServiceResult token = await Token(2, repositorio.Value);
                    if (token.Success)
                    {
                        var rutaApi = await _configuracionRepository.WhereAsync("ApiRutaToken");
                        if (!rutaApi.Success) return new Convertidor<string>().mape(rutaApi);
                        string ruta = rutaApi.Value;

                        var email = new EmailModel()
                        {
                            DestinoCorreo = model.Correo,
                            Asunto = "Verificacion Del token",
                            Cuerpo = $"{ruta}{token.Data}"
                        };
                        var correo = Correo(email);
                    }else return token;
                } return new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
            }
            catch (Exception ex)
            {
                return new ServiceResult() { Success = false , Message = $"Error en el Servicio Usuario Al Creaar un Usaurio: {ex.Message}",Type= ServiceResultType.Error};
            }
        }

        public async Task<ServiceResult> SubirArchivoAsync(IFormFile fichero,int idUsuario)
        {
            ServiceResult resul = new();
            try
            {
                var rutaLogo = await _configuracionRepository.WhereAsync("SubRutaLogo");
                if (!rutaLogo.Success) return new Convertidor<string>().mape(rutaLogo);
                string subRutaDestino = rutaLogo.Value;
                var GuardarImagen = GurdarArchivo(3, subRutaDestino, fichero);
                if (!GuardarImagen.Success) return new Convertidor<string>().mape(GuardarImagen);
                var rutaguardar = await _usuarioRepository.ActualizarLogo(idUsuario, GuardarImagen.Value);
                if (!rutaguardar.Success) {
                    var borrarImagen = BorrarArchivo(GuardarImagen.Value);
                    if (!borrarImagen.Success) return new Convertidor<bool>().mape(borrarImagen);
                }
                return new Convertidor<bool>().mape(rutaguardar);
            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"Ocurrio un erro en UsuarioService el error es: {ex}.", Type = ServiceResultType.Error};
            }
        }




        #endregion
    }
}
