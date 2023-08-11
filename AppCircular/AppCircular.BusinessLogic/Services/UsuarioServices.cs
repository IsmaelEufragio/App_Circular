using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories;
using AppCircular.DataAccess.Repositories.Interface;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.Services
{
    public class UsuarioServices
    {
        private readonly TipoUsuarioRepository _tipoUsuarioRepository;
        private readonly InfoUnicaUsuarioRepository _infoUnicaUsuarioRepository;

        public UsuarioServices(TipoUsuarioRepository tipoUsuarioRepository, InfoUnicaUsuarioRepository infoUnicaUsuarioRepository)
        {
            _tipoUsuarioRepository = tipoUsuarioRepository;
            _infoUnicaUsuarioRepository = infoUnicaUsuarioRepository;
        }

        #region Tipo Usuario

        public async Task<ServiceResult> listaTipoUser()
        {
            try
            {
                var repositorio = await _tipoUsuarioRepository.ListAsync();
                var resul = new Test<TipoUsuarioViewModel>().mape(repositorio);
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
            return new Test<TipoUsuarioViewModel>().mape(repositorio);
        }
         
        public async Task<ServiceResult> ActualizarTipoUser( int id,TipoUsuarioModel model)
        {

            var listado = await _tipoUsuarioRepository.UpdateAsync(id,model);
            return new Test<TipoUsuarioViewModel>().mape(listado);
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
    }
}
