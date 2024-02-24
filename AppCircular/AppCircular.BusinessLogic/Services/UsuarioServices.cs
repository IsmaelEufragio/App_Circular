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
using System.Collections.Generic;

namespace AppCircular.BusinessLogic.Services
{
    public class UsuarioServices : BaseServices
    {
        private readonly TipoUsuarioRepository _tipoUsuarioRepository;
        private readonly InfoUnicaUsuarioRepository _infoUnicaUsuarioRepository;
        private readonly CategoriaRepository _categoriaRepository;
        private readonly UsuarioRepository _usuarioRepository;
        private readonly SubdivicionLugarRepository _subdivicionLugarRepository;
        private readonly TelefonoRepository _telefonoRepository;
        public UsuarioServices(TipoUsuarioRepository tipoUsuarioRepository,
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

        public async Task<ServiceResult> ActualizarTipoUser(Guid id, TipoUsuarioModel model)
        {

            var listado = await _tipoUsuarioRepository.UpdateAsync(id, model);
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

        public async Task<ServiceResult> ActualizarInfoUser(Guid id, InfoUnicaUsuarioViewModel model)
        {
            var result = new ServiceResult();
            var listado = await _infoUnicaUsuarioRepository.UpdateAsync(id, model);
            return result.Ok(listado);
        }

        #endregion

        #region Auntenticacion

        public async Task<ServiceResult> Varificar(LoginModel model)
        {
            var resul = new ResultadoModel<bool>();
            var usuario = await _usuarioRepository.Login(model.Correo);
            if (!usuario.Success) return new Convertidor<tbUsuarios>().mape(usuario);

            if (!EncryptPass.VerifyPassword(model.Passsword, usuario.Value.user_Password, usuario.Value.user_PasswordSal))
            {
                resul.Success = false;
                resul.Type = ServiceResultType.Forbidden;
                resul.Message = "Contraseña o correo incorrecto";
                return new Convertidor<bool>().mape(resul);
            }
            var tokeM = await Token(10, usuario.Value.user_Id);

            return tokeM;
        }
        public List<Claim> GetClaimsFromToken(string token)
        {
            var handler = new JwtSecurityTokenHandler();
            var tokenS = handler.ReadToken(token) as JwtSecurityToken;

            if (tokenS != null)
            {
                return tokenS.Claims.ToList();
            }

            return null;
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

        public async Task<ServiceResult> ActualizarCategoria(Guid id, CategoriaModel model)
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
                if (cong.Success && (Guid.TryParse(cong.Value, out Guid idParticualar)))
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
                            categoriaData.Columns.Add("aria_Id", typeof(Guid));

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
                        else return new ServiceResult() { Message = "Tienee que tener al menos una categoria", Success = false, Type = ServiceResultType.Error };

                        if (model.Telefono.Count > 0)
                        {
                            DataTable telefonoData = new DataTable();
                            telefonoData.Columns.Add("tipTel_Id", typeof(Guid));
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
                //Ruta imagen
                var congTamLog = await _configuracionRepository.WhereAsync("TamañoLogo");
                if (!congTamLog.Success) return new Convertidor<string>().mape(congTamLog);
                int idTamaLogo = int.TryParse(congTamLog.Value, out int tamLogoV) ? tamLogoV : 1;

                var congRutLog = await _configuracionRepository.WhereAsync("SubRutaLogo");
                if (!congRutLog.Success) return new Convertidor<string>().mape(congRutLog);

                if (model.Logo != null)
                {
                    var rutaLogo = ValidarArchivo(idTamaLogo, congRutLog.Value, model.Logo);
                    if (!rutaLogo.Success) return new Convertidor<string>().mape(rutaLogo);
                    model.RutaLogo = rutaLogo.Value;
                }
                var repositorio = await _usuarioRepository.CrearUsuario(model);
                if (repositorio.Success)
                {
                    if (model.Logo != null && model.RutaLogo != "")
                    {
                        var guardarImagenLogo = GurdarArchivo(model.RutaLogo, model.Logo);
                        if (!guardarImagenLogo.Success)
                        {
                            var actualizarRutaLogo = await _usuarioRepository.ActualizarLogo(repositorio.Value, "N/A");
                        }
                    }
                    ServiceResult token = await Token(2, repositorio.Value, true);
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
                    }
                    else return token;
                }
                return new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
            }
            catch (Exception ex)
            {
                return new ServiceResult() { Success = false, Message = $"Error en el Servicio Usuario Al Creaar un Usaurio: {ex.Message}", Type = ServiceResultType.Error };
            }
        }

        public async Task<ServiceResult> SubirArchivoAsync(IFormFile fichero, Guid idUsuario)
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
                if (rutaguardar.Success)
                {

                    var guarImagen = GurdarArchivo(GuardarImagen.Value, fichero);
                    if (!guarImagen.Success) return new Convertidor<bool>().mape(guarImagen);
                }
                return new Convertidor<bool>().mape(rutaguardar);
            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"Ocurrio un erro en UsuarioService el error es: {ex}.", Type = ServiceResultType.Error };
            }
        }

        public ResultadoModel<UsuarioCrearModel> convertirUsuario(IFormCollection form)
        {
            ResultadoModel<UsuarioCrearModel> resul = new();
            try
            {
                UsuarioCrearModel modelo = new UsuarioCrearModel();
                List<HorarioModel> horario = new List<HorarioModel>();
                List<CategoriaItemModel> categorias = new List<CategoriaItemModel>();
                List<TelefonoViewModel> telefono = new List<TelefonoViewModel>();
                IFormFile formFile = form.Files["Logo"];
                if (formFile != null)
                {
                    modelo.Logo = formFile;
                }
                else modelo.RutaLogo = string.Empty;

                modelo.tipUs_Id = form.TryGetValue("tipUs_Id", out var tipUs_Id) ? Guid.TryParse(tipUs_Id, out Guid idTipoUs) ? idTipoUs : Guid.Empty : Guid.Empty;
                modelo.tipIde_Id = form.TryGetValue("tipIde_Id", out var tipIde_Id) ? Guid.TryParse(tipIde_Id, out Guid idTipoIde) ? idTipoIde : Guid.Empty : Guid.Empty;
                modelo.Identidad = form.TryGetValue("Identidad", out var Identidad) ? Identidad.ToString() : string.Empty;
                modelo.Nombre = form.TryGetValue("Nombre", out var nombreValue) ? nombreValue.ToString() : string.Empty;
                modelo.PaginaWed = form.TryGetValue("PaginaWed", out var PaginaWed) ? PaginaWed.ToString() : string.Empty;
                modelo.NombreUsuario = form.TryGetValue("NombreUsuario", out var NombreUsuario) ? NombreUsuario.ToString() : string.Empty;
                modelo.Password = form.TryGetValue("Password", out var Password) ? Password.ToString() : string.Empty;
                modelo.Descripcion = form.TryGetValue("Descripcion", out var Descripcion) ? Descripcion.ToString() : string.Empty;
                modelo.Facebook = form.TryGetValue("Facebook", out var Facebook) ? Facebook.ToString() : string.Empty;
                modelo.Intagram = form.TryGetValue("Intagram", out var Intagram) ? Intagram.ToString() : string.Empty;
                modelo.WhatsApp = form.TryGetValue("WhatsApp", out var WhatsApp) ? bool.TryParse(WhatsApp, out bool whats) ? whats : null : null;
                modelo.Envio = form.TryGetValue("Envio", out var Envio) ? bool.TryParse(Envio, out bool envi) ? envi : null : null;
                modelo.Correo = form.TryGetValue("Correo", out var Correo) ? Correo.ToString() : string.Empty;
                modelo.subLug_Id = form.TryGetValue("subLug_Id", out var subLug_Id) ? Guid.TryParse(subLug_Id, out Guid idSubLug) ? idSubLug : Guid.Empty : Guid.Empty;
                modelo.Latitud = form.TryGetValue("Latitud", out var Latitud) ? Latitud.ToString() : string.Empty;
                modelo.Longitub = form.TryGetValue("Longitub", out var Longitub) ? Longitub.ToString() : string.Empty;
                int idexHora = 0;
                while (true)
                {
                    var diaNumero = $"Horario[{idexHora}].DiaNumero";
                    var horaInicio = $"Horario[{idexHora}].HoraInicio";
                    var minutoInicio = $"Horario[{idexHora}].MinutoInicio";
                    var horaFin = $"Horario[{idexHora}].HoraFin";
                    var minutoFin = $"Horario[{idexHora}].MinutoFin";
                    if (!form.ContainsKey(diaNumero) || !form.ContainsKey(horaInicio) || !form.ContainsKey(minutoInicio) || !form.ContainsKey(horaFin) || !form.ContainsKey(minutoFin))
                    {
                        break;
                    }
                    int iDiaNumero = form.TryGetValue(diaNumero, out var DiaNumero) ? int.TryParse(DiaNumero, out int diaN) ? diaN : 0 : 0;
                    int iHoraInicio = form.TryGetValue(horaInicio, out var HoraInicio) ? int.TryParse(HoraInicio, out int horIn) ? horIn : 0 : 0;
                    int iMinutoInicio = form.TryGetValue(minutoInicio, out var MinutoInicio) ? int.TryParse(MinutoInicio, out int minuIni) ? minuIni : 0 : 0;
                    int iHoraFin = form.TryGetValue(horaFin, out var HoraFin) ? int.TryParse(HoraFin, out int horF) ? horF : 0 : 0;
                    int iMinutoFin = form.TryGetValue(minutoFin, out var MinutoFin) ? int.TryParse(MinutoFin, out int minuF) ? minuF : 0 : 0;

                    horario.Add(new HorarioModel
                    {
                        DiaNumero = iDiaNumero,
                        HoraInicio = iHoraInicio,
                        MinutoInicio = iMinutoInicio,
                        HoraFin = iHoraFin,
                        MinutoFin = iMinutoFin
                    });
                    idexHora++;
                }
                modelo.Horario = horario;
                int indexCat = 0;
                while (true)
                {
                    var idCategoria = $"Categoria[{indexCat}].catg_Id";
                    if (!form.ContainsKey(idCategoria)) break;
                    Guid id = form.TryGetValue(idCategoria, out var catg_Id) ? Guid.TryParse(catg_Id, out Guid idC) ? idC : Guid.Empty : Guid.Empty;
                    categorias.Add(new CategoriaItemModel { catg_Id = id });
                    indexCat++;
                }
                modelo.Categoria = categorias;
                int indexTel = 0;
                while (true)
                {
                    var idTipoTelefono = $"Telefono[{indexTel}].idTipoTelefono";
                    var Nutelefono = $"Telefono[{indexTel}].Telefono";
                    if (!form.ContainsKey(idTipoTelefono) || !form.ContainsKey(Nutelefono)) break;
                    Guid id = form.TryGetValue(idTipoTelefono, out var idTipo) ? Guid.TryParse(idTipo, out Guid idT) ? idT : Guid.Empty : Guid.Empty;
                    string numero = form.TryGetValue(Nutelefono, out var NumeTele) ? NumeTele.ToString() : string.Empty;

                    telefono.Add(new TelefonoViewModel { idTipoTelefono = id, Telefono = numero });
                    indexTel++;
                }
                modelo.Telefono = telefono;

                return resul = new() { Message = "Conversien si errores", Value = modelo, Success = true, Type = ServiceResultType.Success };
            }
            catch (Exception ex)
            {
                return resul = new() { Success = false, Message = $"El error ocurrio al convertir al tipo de modelo{ex.Message}", Type = ServiceResultType.Error };
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

        public async Task<ServiceResult> ActualizarTelefonoUsuario(Guid id, TelefonoModel model)
        {
            var listado = await _telefonoRepository.UpdateAsync(id, model);
            return new Convertidor<TelefonoViewModel>().mape(listado);
        }

        public async Task<ServiceResult> UsuarioVarificado(Guid id)
        {
            var verificado = await _usuarioRepository.UsuarioVarificado(id);
            return new Convertidor<bool>().mape(verificado);
        }
        #endregion
    }
}
