using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class HorarioDTO
    {
        public Guid IdUsuario { get; set; }
        public Guid Id { get; set; }
        public int Dia { get; set; }
        public TimeOnly HoraInicio { get; set; }
        public TimeOnly HoraFin { get; set; }
    }
}
