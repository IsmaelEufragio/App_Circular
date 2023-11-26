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
        public Task<ResultadoModel<Guid>> CrearUsuario(UsuarioCrearModel usuario);
        public Task<ResultadoModel<bool>> WhereAsync(string correo, List<TelefonoViewModel> telefono);
        public Task<ResultadoModel<bool>> ActualizarLogo(Guid idUsuario, string RutaImagen);
        public Task<ResultadoModel<tbUsuarios>> Login(string correo, bool login = true);
        public Task<ResultadoModel<bool>> UsuarioVarificado(Guid Id);
    }
}
