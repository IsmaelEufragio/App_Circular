using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class UserDTO
    {
        public Guid Id { get; set; }
        public Guid IdUserPrincipal { get; set; }
        public string NombreUsuario { get; set; }
        public string Despcripcion { get; set; }
        public string Correo { get; set; }
        public string Fecebook { get; set; }
        public string Intragram { get; set; }
        public bool WhatsApp { get; set; }
        public bool Envio { get; set; }
        public bool UsuarioPrincipal { get; set; }
        public DateTime? FechaCreacion { get; set; }
        public string Identidad { get; set; }
        public Guid IdTipoIdentidad { get; set; }
        public bool Verificado { get; set; }
        public UbicacionUsuarioDTO Ubicacion { get; set; }
        public InformacionUnicaUsuario InformacionUnica { get; set; }
        public List<TelefonosUsuarioDTO> Telefonos { get; set; }
        public TipoIdentidadDTO TipoIdentidad { get; set; }
        public List<HorarioDTO> Horarios { get; set; }
        public List<UsuarioRolesDTO> UsuarioRole { get; set; }
        public List<UsuariosClaimsDTO> Claims { get; set; }
    }
}
