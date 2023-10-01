using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Configuracion
{
    public class LoginModel
    {
        [Required(ErrorMessage = "El Correo es requerido.")]
        public string Correo { get; set; }
        [Required(ErrorMessage = "La contraseña es requerido.")]
        public string Passsword { get; set; }
    }
}
