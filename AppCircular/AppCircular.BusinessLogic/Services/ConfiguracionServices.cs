using AppCircular.BusinessLogic.LibreriaClases;
using AppCircular.Common.Models.Catalogo;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Genericos;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories;
using AppCircular.Entities.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.Services
{
    public class ConfiguracionServices : BaseServices
    {
        private static string nombre = "Configuracion";
        private readonly TipoTelefonoRepository _tipoTelefonoRepository;
        private readonly TipoCatalogoRepository _tipoCatalogoRepository;
        private readonly TipoImagenRepository _tipoImagenRepository;
        private readonly TipoReaccionesRepository _tipoReaccionesRepository;
        private readonly TipoDePagoRepository _tipoDePagoRepository;
        public ConfiguracionServices(IOptions<JwtModel> jwtSettings,
                                        TipoTelefonoRepository tipoTelefonoRepository,
                                        TipoCatalogoRepository tipoCatalogoRepository,
                                        TipoImagenRepository tipoImagenRepository,
                                        TipoReaccionesRepository tipoReaccionesRepository,
                                        TipoDePagoRepository tipoDePagoRepository
            ) : base(jwtSettings)
        {
            _tipoTelefonoRepository = tipoTelefonoRepository;
            _tipoCatalogoRepository = tipoCatalogoRepository;
            _tipoImagenRepository = tipoImagenRepository;
            _tipoReaccionesRepository = tipoReaccionesRepository;
            _tipoDePagoRepository = tipoDePagoRepository;
        }
        #region Configuracion
        public async Task<ServiceResult> listaConfiguarcion()
        {
            try
            {
                var repositorio = await _configuracionRepository.ListAsync();
                var resul = new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearConfiguarcion(ConfiguracionModel model)
        {
            var tb = new tbConfiguracion();
            tb.conf_Nombre = model.Nombre;
            tb.conf_Valor = model.Valor;
            tb.conf_Descripcion = model.Descripcion;
            var repositorio = await _configuracionRepository.InsertAsync(tb);
            return new Convertidor<TipoUsuarioViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarConfiguracion(int id, ConfiguracionModel model)
        {
            var listado = await _configuracionRepository.UpdateAsync(id, model);
            return new Convertidor<TipoUsuarioViewModel>().mape(listado);
        }
        #endregion

        #region Tipo de Telefono
        public async Task<ServiceResult> listaTipoTelefono()
        {
            try
            {
                var repositorio = await _tipoTelefonoRepository.ListAsync();
                var resul = new Convertidor<TipoTelefonoViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTipoTelefono(TipoTelefonoModel model)
        {
            var tb = new tbTipoTelefono();
            tb.tipTel_Descripcion = model.Descripcion;
            var repositorio = await _tipoTelefonoRepository.InsertAsync(tb);
            return new Convertidor<TipoTelefonoViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTipoTelefono(int id, TipoTelefonoModel model)
        {
            var listado = await _tipoTelefonoRepository.UpdateAsync(id, model);
            return new Convertidor<TipoTelefonoViewModel>().mape(listado);
        }
        #endregion

        #region Tipo de catalogo
        public async Task<ServiceResult> listaTipoCatalogo()
        {
            try
            {
                var repositorio = await _tipoCatalogoRepository.ListAsync();
                var resul = new Convertidor<TipoCatalogoViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTipoCatalogo(TipoCatalogoModel model)
        {
            var tb = new tbTipoCatalogo();
            tb.tipCatg_Descripcion = model.Descripcion;
            var repositorio = await _tipoCatalogoRepository.InsertAsync(tb);
            return new Convertidor<TipoCatalogoViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTipoCatalogo(int id, TipoCatalogoModel model)
        {
            var listado = await _tipoCatalogoRepository.UpdateAsync(id, model);
            return new Convertidor<TipoCatalogoViewModel>().mape(listado);
        }

        #endregion

        #region Tipo Imegen

        public async Task<ServiceResult> listaTipoImagenes()
        {
            try
            {
                var repositorio = await _tipoImagenRepository.ListAsync();
                var resul = new Convertidor<TipoImagenViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTipoImagen(TipoImagenModel model)
        {
            var tb = new tbTipoImagen();
            tb.tipImg_Descripcion = model.Descripcion;
            var repositorio = await _tipoImagenRepository.InsertAsync(tb);
            return new Convertidor<TipoImagenViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTipoImagen(int id, TipoImagenModel model)
        {
            var listado = await _tipoImagenRepository.UpdateAsync(id, model);
            return new Convertidor<TipoImagenViewModel>().mape(listado);
        }

        #endregion

        #region Tipo de Reaccion

        public async Task<ServiceResult> listaTipoReaccion()
        {
            try
            {
                var repositorio = await _tipoReaccionesRepository.ListAsync();
                var resul = new Convertidor<TipoReaccionViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTipoReaccion(TipoReaccionModel model)
        {
            var tb = new tbTipoReaccion();
            tb.tipRea_Descripcion = model.Descripcion;
            var repositorio = await _tipoReaccionesRepository.InsertAsync(tb);
            return new Convertidor<TipoReaccionViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTipoReaccion(int id, TipoReaccionModel model)
        {
            var listado = await _tipoReaccionesRepository.UpdateAsync(id, model);
            return new Convertidor<TipoReaccionViewModel>().mape(listado);
        }

        #endregion

        #region Tipo de Pago

        public async Task<ServiceResult> listaTipoPago()
        {
            try
            {
                var repositorio = await _tipoDePagoRepository.ListAsync();
                var resul = new Convertidor<TipoDePagoViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio {nombre}, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearTipoPago(TipoDePagoModel model)
        {
            var tb = new tbTipoPago();
            tb.tipPag_Descripcion = model.Descripcion;
            var repositorio = await _tipoDePagoRepository.InsertAsync(tb);
            return new Convertidor<TipoDePagoViewModel>().mape(repositorio);
        }

        public async Task<ServiceResult> ActualizarTipoPago(int id, TipoDePagoModel model)
        {
            var listado = await _tipoDePagoRepository.UpdateAsync(id, model);
            return new Convertidor<TipoDePagoViewModel>().mape(listado);
        }

        #endregion
    }
}
