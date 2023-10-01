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
using AppCircular.Common.Models.Genericos;

namespace AppCircular.BusinessLogic.Services
{
    public class UsuarioServices: BaseServices 
    {
        private readonly TipoUsuarioRepository _tipoUsuarioRepository;
        private readonly InfoUnicaUsuarioRepository _infoUnicaUsuarioRepository;
        private readonly CategoriaRepository _categoriaRepository;
        private readonly UsuarioRepository _usuarioRepository;
        private readonly SubdivicionLugarRepository _subdivicionLugarRepository;
        private readonly TelefonoRepository _telefonoRepository;
        public UsuarioServices( TipoUsuarioRepository tipoUsuarioRepository,
                                InfoUnicaUsuarioRepository infoUnicaUsuarioRepository,
                                IOptions<JwtModel> jwtSettings,
                                CategoriaRepository categoriaRepository,
                                UsuarioRepository usuarioRepository,
                                SubdivicionLugarRepository subdivicionLugarRepository,
                                TelefonoRepository telefonoRepository) : base(jwtSettings)
        {
            _tipoUsuarioRepository = tipoUsuarioRepository;
            _infoUnicaUsuarioRepository = infoUnicaUsuarioRepository;
            _categoriaRepository = categoriaRepository;
            _usuarioRepository = usuarioRepository;
            _subdivicionLugarRepository = subdivicionLugarRepository;
            _telefonoRepository = telefonoRepository;
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
                Id = item.usInf_Id,
                Nombre = item.usInf_Nombre,
                RutaLogo = item.usInf_RutaLogo,
                RutaPaginaWed = item.usInf_RutaPaginaWed,
                IgualSubInfo = item.usInf_IgualSubInfo,
                tipUs_Id = item.tipUs_Id,
            }).ToList();

            return result.Ok(userInfo);
        }

        public async Task<ServiceResult> CrearInfoUser(InfoUnicaUsuarioViewModel model)
        {
            var result = new ServiceResult();
            var tbUserUnico = new tbInfoUnicaUsuario();
            tbUserUnico.usInf_Nombre = model.Nombre;
            tbUserUnico.usInf_RutaLogo = model.RutaLogo;
            tbUserUnico.usInf_RutaPaginaWed = model.RutaPaginaWed;
            tbUserUnico.usInf_RutaLogo = model.RutaLogo;
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
        //Pasar al Base Service
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
        //Pasar al Base Service
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
            var resul = new ResultadoModel<bool>();
            var usuario = await _usuarioRepository.Login(model.Correo);
            if (!usuario.Success) return new Convertidor<tbUsuarios>().mape(usuario);

            if(!EncryptPass.VerifyPassword(model.Passsword,usuario.Value.user_Password, usuario.Value.user_PasswordSal))
            {
                resul.Success=false;
                resul.Type = ServiceResultType.Forbidden;
                resul.Message = "Contraseña o correo incorrecto";
                return new Convertidor<bool>().mape(resul);
            }
            var tokeM = await Token(10, usuario.Value.user_Id);

            return tokeM;
        }
        //Pasar al base Service
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
                        
                        if(model.Telefono.Count > 0)
                        {
                            DataTable telefonoData = new DataTable();
                            telefonoData.Columns.Add("tipTel_Id", typeof(int));
                            telefonoData.Columns.Add("tipTel_Descripcion", typeof(string));
                            foreach (var item in model.Telefono)
                            {
                                telefonoData.Rows.Add(item.idTipoTelefono, item.Telefono);
                            }
                            model.TelefonoDate = telefonoData;
                        }
                    }
                }
                var tipoRe = await _tipoUsuarioRepository.WhereAsync(model.tipUs_Id);
                if (!tipoRe.Success) return new Convertidor<bool>().mape(tipoRe);
                var subLugar = await _subdivicionLugarRepository.WhereAsync(model.subLug_Id);
                if (!subLugar.Success) return new Convertidor<bool>().mape(subLugar);
                var valiUsu = await _usuarioRepository.WhereAsync(model.Correo, model.Telefono);
                if (!valiUsu.Success) return new Convertidor<bool>().mape(valiUsu);
                //Crear contraseñas incriptadas
                model.PasswordSal = Guid.NewGuid().ToString();
                model.Password = EncryptPass.GeneratePassword(model.Password, model.PasswordSal);
                //
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
                var GuardarImagen = ValidarArchivo(3, subRutaDestino, fichero);
                if (!GuardarImagen.Success) return new Convertidor<string>().mape(GuardarImagen);
                var rutaguardar = await _usuarioRepository.ActualizarLogo(idUsuario, GuardarImagen.Value);
                if (rutaguardar.Success) {

                    var guarImagen = GurdarArchivo(GuardarImagen.Value, fichero);
                    if (!guarImagen.Success) return new Convertidor<bool>().mape(guarImagen);
                }
                return new Convertidor<bool>().mape(rutaguardar);
            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"Ocurrio un erro en UsuarioService el error es: {ex}.", Type = ServiceResultType.Error};
            }
        }

        public UsuarioCrearModel convertirUsuario(IFormCollection form)
        {
            try
            {
                UsuarioCrearModel modelo = new UsuarioCrearModel();
                if (form.TryGetValue("Logo", out var logo))
                {
                    IFormFile formFile = form.Files["Logo"];
                    if (formFile != null)
                    {
                        modelo.Logo = formFile;
                    }
                }
                modelo.tipUs_Id = form.TryGetValue("tipUs_Id", out var tipUs_Id) ? int.TryParse(tipUs_Id, out int idTipoUs) ? idTipoUs : 0 : 0;
                modelo.tipIde_Id = form.TryGetValue("tipIde_Id", out var tipIde_Id) ? int.TryParse(tipIde_Id, out int idTipoIde) ? idTipoIde : 0 : 0;
                modelo.Identidad = form.TryGetValue("Identidad", out var Identidad) ? Identidad.ToString(): string.Empty;
                modelo.Nombre = form.TryGetValue("Nombre", out var nombreValue) ? nombreValue.ToString(): string.Empty;
                modelo.PaginaWed = form.TryGetValue("PaginaWed",out var PaginaWed)? PaginaWed.ToString(): string.Empty;
                modelo.NombreUsuario = form.TryGetValue("NombreUsuario", out var NombreUsuario)? NombreUsuario.ToString(): string.Empty;
                modelo.Password = form.TryGetValue("Password", out var Password)? Password.ToString(): string.Empty;
                modelo.Descripcion = form.TryGetValue("Descripcion", out var Descripcion)? Descripcion.ToString(): string.Empty;
                modelo.Facebook = form.TryGetValue("Facebook", out var Facebook)? Facebook.ToString(): string.Empty;
                modelo.Intagram = form.TryGetValue("Intagram",, out var Intagram)? Intagram.ToString(): string.Empty;
                modelo.WhatsApp = form.TryGetValue("WhatsApp", out var WhatsApp) ? bool.TryParse(WhatsApp, out bool whats) ? whats : null : null;
                return modelo; 
            }
            catch (Exception)
            {

                throw;
            }

        }

        #endregion

        #region Telefono de Usuario
        public async Task<ServiceResult> listaTelefonoUsuario()
        {
            try
            {
                var repositorio = await _telefonoRepository.ListAsync();
                var resul = new Convertidor<TelefonoModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Usaurio, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTelefonoUsuario(TelefonoModel model)
        {
            var tb = new tbUsuarioTelefono();
            tb.tipTel_Id = model.idTipoTelefono;
            tb.usTel_Id = model.IdUsuario;
            tb.usTel_Numero = model.Telefono;
            var repositorio = await _telefonoRepository.InsertAsync(tb);
            return new Convertidor<TelefonoViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTelefonoUsuario(int id, TelefonoModel model)
        {

            var listado = await _telefonoRepository.UpdateAsync(id, model);
            return new Convertidor<TelefonoViewModel>().mape(listado);
        }

        #endregion
    }
}
