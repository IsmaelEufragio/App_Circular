using AppCircular.Common.Models.CategoriaLugar;
using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Departamento;
using AppCircular.Common.Models.Municipio;
using AppCircular.Common.Models.Pais;
using AppCircular.DataAccess.Repositories;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.BusinessLogic.Services
{
    public class UbicacionServices
    {
        private readonly PaisRepository _paisRepository;
        private readonly DepartamentoRepository _departamentoRepository;
        private readonly MunicipioRepository _municipioRepository;
        private readonly CategoriaLugarRepository _categoriaLugarRepository;
        public UbicacionServices(
            PaisRepository paisRepository, 
            DepartamentoRepository departamentoRepository, 
            MunicipioRepository municipioRepository,
            CategoriaLugarRepository categoriaLugarRepository
            )
        {
            _paisRepository = paisRepository;
            _departamentoRepository = departamentoRepository;
            _municipioRepository = municipioRepository;
            _categoriaLugarRepository = categoriaLugarRepository;
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
                var result = new ServiceResult();
                return await _departamentoRepository.ListAsync();
            }
            catch (Exception e)
            {
                var result = new ServiceResult() { Success = false, Message = $"Lugar Error: Servicio Ubicacion, Mesaje {e.Message}" };
                return result;
            }
        }

        public async Task<ServiceResult> CrearDepartamento(DepartamentoModel model)
        {
            _ = new ServiceResult();
            var tbdepartamento = new tbDepartamento();
            tbdepartamento.dept_Nombre = model.Nombre;
            tbdepartamento.dept_NuIdentidad = model.NuIdentidad;
            tbdepartamento.pais_Id = model.pais_Id;
            return await _departamentoRepository.InsertAsync(tbdepartamento);
        }

        public async Task<ServiceResult> ActualizarDepartamento(int id, DepartamentoModel model)
        {
            return await _departamentoRepository.UpdateAsync(id, model);
        }

        #endregion

        #region Municipio

        public async Task<ServiceResult> listaMunicipio()
        {
            try
            {
                var result = new ServiceResult();
                return await _municipioRepository.ListAsync();
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
            return await _municipioRepository.InsertAsync(tbMuni);
        }

        public async Task<ServiceResult> ActualizarMunicipio(int id, MunicipioModel model)
        {
            return await _municipioRepository.UpdateAsync(id, model);
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
    }
}
