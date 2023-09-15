using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IUsuarioRepository
    {
        public Task<ResultadoModel<int>> CrearUsuario(UsuarioCrearModel usuario);
        public Task<ResultadoModel<bool>> WhereAsync(string correo, string telefonoP);
        public Task<ResultadoModel<bool>> ActualizarLogo(int idUsuario, string RutaImagen);
    }
}
