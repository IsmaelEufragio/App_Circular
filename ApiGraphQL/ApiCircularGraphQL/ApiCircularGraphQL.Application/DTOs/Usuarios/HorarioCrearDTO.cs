using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs.Usuarios
{
    public class HorarioCrearDTO : IValidatableObject
    {
        [Required(ErrorMessage = "El número de día es requerido.")]
        [Range(1, 7, ErrorMessage = "El número de día debe estar entre 1 y 7.")]
        public int DiaNumero { get; set; }

        [Required(ErrorMessage = "La Hora de inicio es requerido.")]
        public TimeOnly HoraInicio { get; set; }

        [Required(ErrorMessage = "La Hora Fin es requerido.")]
        public TimeOnly HoraFin { get; set; }

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            if (HoraFin < HoraInicio)
            {
                yield return new ValidationResult("La hora fin deben ser posteriores a la hora inicio.");
            }
        }
    }
}
