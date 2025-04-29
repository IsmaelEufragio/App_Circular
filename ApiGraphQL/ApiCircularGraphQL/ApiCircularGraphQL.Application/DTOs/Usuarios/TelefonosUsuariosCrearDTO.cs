using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class TelefonosUsuariosCrearDTO
    {
        [Required(ErrorMessage = "El Id Del usuario es Requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "El valor de IdUsuario debe ser mayor que 0.")]
        public Guid IdUsuario { get; set; }

        [Required(ErrorMessage = "Tipo de telefono es requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "El valor de idTipoTelefono debe ser mayor que 0.")]
        public Guid idTipoTelefono { get; set; }

        [Required(ErrorMessage = "Por lo menos un telefeno es requerido.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "El Primer telefono debe tener entre 2 y 50 caracteres.")]
        public string Telefono { get; set; }
    }
}
