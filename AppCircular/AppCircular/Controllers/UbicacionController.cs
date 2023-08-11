using AppCircular.BusinessLogic;
using AppCircular.BusinessLogic.Services;
using AppCircular.Common.Models.Pais;
using Microsoft.AspNetCore.Mvc;

namespace AppCircular.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UbicacionController : ControllerBase
    {
        private readonly UbicacionServices _ubicacionServices;
        public UbicacionController(UbicacionServices ubicacionServices)
        {
            _ubicacionServices = ubicacionServices;
        }
        #region Pais

        #endregion

    }
}
