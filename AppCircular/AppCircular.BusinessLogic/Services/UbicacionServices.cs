using AppCircular.BusinessLogic.LibreriaClases;
using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
using AppCircular.Common.Models.Lugar;
using AppCircular.Common.Models.Municipio;
using AppCircular.Common.Models.Pais;
using AppCircular.Common.Models.SubdivicionLugar;
using AppCircular.Common.Models.Usuario;
using AppCircular.DataAccess.Repositories;
using AppCircular.Entities.Entities;

namespace AppCircular.BusinessLogic.Services
{
    public class UbicacionServices
    {
        private readonly PaisRepository _paisRepository;
        private readonly DepartamentoRepository _departamentoRepository;
        private readonly MunicipioRepository _municipioRepository;
        private readonly CategoriaLugarRepository _categoriaLugarRepository;
        private readonly LugarRepository _lugarRepository;
        private readonly SubdivicionLugarRepository _subdivicionLugarRepository;

        public UbicacionServices(
            PaisRepository paisRepository, 
            DepartamentoRepository departamentoRepository, 
            MunicipioRepository municipioRepository,
            CategoriaLugarRepository categoriaLugarRepository,
            LugarRepository lugarRepository,
            SubdivicionLugarRepository subdivicionLugarRepository
            )
        {
            _paisRepository = paisRepository;
            _departamentoRepository = departamentoRepository;
            _municipioRepository = municipioRepository;
            _categoriaLugarRepository = categoriaLugarRepository;
            _lugarRepository = lugarRepository;
            _subdivicionLugarRepository = subdivicionLugarRepository;
        }

        #region pais

        public async Task<ServiceResult> listaPais()
        {
            try
            {
                var result = new ServiceResult();
                var resultado = await _paisRepository.ListAsync();
                result.Data = resultado.Data;
                if (!resultado.Success) {
                    return result.SetMessage($"{resultado.Message}", ServiceResultType.Info);
                }
                result.Data =  resultado.Data;
                return result.SetMessage(resultado.Message, resultado.Type);
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}"};
                return result;
            }
        }

        public async Task<ServiceResult> CrearPais(PaisModel model)
        {
            var result = new ServiceResult();
            var tpPais = new tbPais();
            tpPais.pais_Nombre = model.Nombre;
            tpPais.pais_Abrebiatura = model.Abrebiatura;
            return await _paisRepository.InsertAsync(tpPais);
        }

        public async Task<ServiceResult> ActualizarPais(int id, PaisModel model)
        {
            return await _paisRepository.UpdateAsync(id, model);
        }

        #endregion

        #region Departamento

        public async Task<ServiceResult> listaDepartamento()
        {
            try
            {
                var repositorio = await _departamentoRepository.ListAsync();
                var resul = new Convertidor<PaisDepartamentoViewModel>().mape(repositorio);
                return resul;

            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearDepartamento(DepartamentoModel model)
        {
            var tbdepartamento = new tbDepartamento();
            tbdepartamento.dept_Nombre = model.Nombre;
            tbdepartamento.dept_NuIdentidad = model.NuIdentidad;
            tbdepartamento.pais_Id = model.pais_Id;
            var repositorio = await _departamentoRepository.InsertAsync(tbdepartamento);
            var resul = new Convertidor<PaisDepartamentoViewModel>().mape(repositorio);
            return resul;
        }

        public async Task<ServiceResult> ActualizarDepartamento(int id, DepartamentoModel model)
        {
            var repositorio = await _departamentoRepository.UpdateAsync(id, model);
            var resul = new Convertidor<PaisDepartamentoViewModel>().mape(repositorio);
            return resul;
        }

        #endregion

        #region Municipio

        public async Task<ServiceResult> listaMunicipio()
        {
            try
            {
                var repositorio = await _municipioRepository.ListAsync();
                var resul = new Convertidor<DeparmentoMunicipioViewModel>().mape(repositorio);
                return resul;
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearMunicipio(MunicipioModel model)
        {
            var result = new ServiceResult();
            var tbMuni = new tbMunicipio();
            tbMuni.muni_Nombre = model.Nombre;
            tbMuni.muni_NuIdentidad = model.NuIdentidad;
            tbMuni.dept_Id = model.dept_Id;
            tbMuni.muni_ValidaciosTelefono = model.ValidaciosTelefono;
            tbMuni.muni_ValidaciosTelefonoFijo = model.ValidaciosTelefonoFijo;
            var repositorio = await _municipioRepository.InsertAsync(tbMuni);
            var resul = new Convertidor<DeparmentoMunicipioViewModel>().mape(repositorio);
            return resul;
        }

        public async Task<ServiceResult> ActualizarMunicipio(int id, MunicipioModel model)
        {
            var repositorio = await _municipioRepository.UpdateAsync(id, model);
            var resul = new Convertidor<DeparmentoMunicipioViewModel>().mape(repositorio);
            return resul;
        }

        #endregion

        #region Categoria Lugar

        public async Task<ServiceResult> listaCategoriaLugar()
        {
            try
            {
                var result = new ServiceResult();
                return await _categoriaLugarRepository.ListAsync();
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearCategoriaLugar(CategoriaLugarModel model)
        {
            var result = new ServiceResult();
            var tbMuni = new tbCategoriaLugar();
            tbMuni.catLug_Nombre = model.Nombre;
            return await _categoriaLugarRepository.InsertAsync(tbMuni);
        }

        public async Task<ServiceResult> ActualizarCategoriaLugar(int id, CategoriaLugarModel model)
        {
            return await _categoriaLugarRepository.UpdateAsync(id, model);
        }

        #endregion

        #region Lugar

        public async Task<ServiceResult> listaLugar()
        {
            try
            {
                var repositorio = await _lugarRepository.ListAsync();
                var resul = new Convertidor<LugarViewModel>().mape(repositorio);
                return resul;

            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearLugar(LugarModel model)
        {
            var tbLugar = new tbLugar();
            tbLugar.lug_Nombre = model.Nombre;
            tbLugar.catLug_Id = model.catLug_Id;
            tbLugar.muni_Id = model.muni_Id;
            var repositorio = await _lugarRepository.InsertAsync(tbLugar);
            var resul = new Convertidor<LugarViewModel>().mape(repositorio);
            return resul;
        }

        public async Task<ServiceResult> ActualizarLugar(int id, LugarModel model)
        {
            var repositorio = await _lugarRepository.UpdateAsync(id, model);
            var resul = new Convertidor<LugarViewModel>().mape(repositorio);
            return resul;
        }


        #endregion

        #region Subdivicion de Lugar

        public async Task<ServiceResult> listaSubdivicionLugar()
        {
            try
            {
                var repositorio = await _subdivicionLugarRepository.ListAsync();
                var resul = new Convertidor<SubdivicionLugarViewModel>().mape(repositorio);
                return resul;

            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearSubdivicionLugar(SubdivicionLugarModel model)
        {
            var tb = new tbSubdivicionLugar();
            tb.subLug_Nombre = model.Nombre;
            tb.sub_Id = model.sub_Id;
            tb.lug_Id = model.lug_Id;
            var repositorio = await _subdivicionLugarRepository.InsertAsync(tb);
            var resul = new Convertidor<SubdivicionLugarViewModel>().mape(repositorio);
            return resul;
        }

        public async Task<ServiceResult> ActualizarSubdivicionLugar(int id, SubdivicionLugarModel model)
        {
            var repositorio = await _subdivicionLugarRepository.UpdateAsync(id, model);
            var resul = new Convertidor<SubdivicionLugarViewModel>().mape(repositorio);
            return resul;
        }

        #endregion
    }
}
