using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Usuario
{
    public class HorarioModel: IValidatableObject
    {
        [Required(ErrorMessage = "El número de día es requerido.")]
        [Range(1, 7, ErrorMessage = "El número de día debe estar entre 1 y 7.")]
        public int DiaNumero { get; set; }

        [Required(ErrorMessage = "La Hora de inicio es requerido.")]
        [Range(1, 24, ErrorMessage = "La Hora de inicio debe estar entre 1 y 24.")]
        public int HoraInicio { get; set; }

        [Required(ErrorMessage = "El minito de Inicio es requerido.")]
        [Range(1, 60, ErrorMessage = "El minuto de inicio debe estar entre 1 y 60.")]
        public int MinutoInicio { get; set; }

        [Required(ErrorMessage = "La Hora Fin es requerido.")]
        [Range(1, 24, ErrorMessage = "La Hora Fin debe estar entre 1 y 24.")]
        public int HoraFin { get; set; }

        [Required(ErrorMessage = "El minito Fin es requerido.")]
        [Range(1, 60, ErrorMessage = "El minuto Fin debe estar entre 1 y 60.")]
        public int MinutoFin { get; set; }

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            if (HoraFin < HoraInicio || (HoraFin == HoraInicio && MinutoFin <= MinutoInicio))
            {
                yield return new ValidationResult("La hora y minuto de fin deben ser posteriores a la hora y minuto de inicio.");
            }
        }
    }
}
