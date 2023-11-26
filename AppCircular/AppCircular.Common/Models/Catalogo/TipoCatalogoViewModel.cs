using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Catalogo
{
    public class TipoCatalogoViewModel
    {
        [Required(ErrorMessage = "El id del tipo de catalogo es requerido")]
        public Guid Id { get; set; }
        [Required(ErrorMessage = "La descripcion es requerida")]
        public string Descripcion { get; set; }
    }
}
