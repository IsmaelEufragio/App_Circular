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
        
        [Required(ErrorMessage = "Tipo de telefono es requerido.")]
        public Guid IdTipoTelefono { get; set; }

        [Required(ErrorMessage = "Por lo menos un telefeno es requerido.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "El Primer telefono debe tener entre 2 y 50 caracteres.")]
        public string Telefono { get; set; }
    }
}
