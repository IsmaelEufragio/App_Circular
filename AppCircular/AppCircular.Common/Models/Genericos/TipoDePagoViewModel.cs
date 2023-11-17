using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Genericos
{
    public class TipoDePagoViewModel
    {
        public int idTipoPago { get; set; }

        [Required(ErrorMessage = "La descripcion es requerido.")]
        [StringLength(300, MinimumLength = 2, ErrorMessage = "El descripcion debe tener entre 2 y 300 caracteres.")]
        public string Descripcion { get; set; }
    }
}
