using AppCircular.Common.Models.Configuracion;
using AppCircular.Common.Models.Usuario;
using AppCircular.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.DataAccess.Repositories.Interface
{
    public interface IUsuarioRepository
    {
        public Task<ResultadoModel<int>> CrearUsuario(UsuarioCrearModel usuario);
        public Task<ResultadoModel<bool>> WhereAsync(string correo, List<TelefonoViewModel> telefono);
        public Task<ResultadoModel<bool>> ActualizarLogo(int idUsuario, string RutaImagen);
        public Task<ResultadoModel<tbUsuarios>> Login(string correo); 
    }
}
