using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace AppCircular.Common.Models.Usuario
{
    public class UsuarioCrearModel
    {
        [Required(ErrorMessage = "El tipo de Usuario es requerido.")]
        public int tipUs_Id { get; set; }

        [Required(ErrorMessage = "El Nombre es requerido.")]
        [StringLength(300, MinimumLength = 2, ErrorMessage = "El Nombre debe tener entre 2 y 300 caracteres.")]
        public string Nombre { get; set; }

        [JsonIgnore]
        public string? RutaLogo { get; set; }

        public string PaginaWed { get; set; }

        [Required(ErrorMessage = "El Nombre Usuario es requerido.")]
        [StringLength(150, MinimumLength = 2, ErrorMessage = "La Nombre Usuario debe tener entre 2 y 150 caracteres.")]
        public string NombreUsuario { get; set; }

        [Required(ErrorMessage = "El Contraseña es requerido.")]
        [RegularExpression(@"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
        ErrorMessage = "La contraseña debe tener al menos 8 caracteres y contener letras, números y caracteres especiales.")]
        public string Password { get; set; }

        [JsonIgnore]
        public string? PasswordSal { get; set; }

        [Required(ErrorMessage = "El Descripcion es requerido.")]
        [StringLength(500, MinimumLength = 2, ErrorMessage = "La Descripcion debe tener entre 2 y 500 caracteres.")]
        public string Descripcion { get; set; }

        [Required(ErrorMessage = "Por lo menos un telefeno es requerido.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "El Primer telefono debe tener entre 2 y 50 caracteres.")]
        public string PrimerTelefono { get; set; }

        [StringLength(50,ErrorMessage = "No puede exeder los 50 caracteres.")]
        public string SegundoTelefono { get; set; }

        [StringLength(100, ErrorMessage = "No puede exeder los 100 caracteres.")]
        public string Facebook { get; set; }

        [StringLength(100, ErrorMessage = "No puede exeder los 100 caracteres.")]
        public string Intagram { get; set; }
        public bool WhatsApp { get; set; }
        public bool Envio { get; set; }
        public DateTime FechaFundacion { get; set; }
        [Required(ErrorMessage = "El Correo es requerido.")]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "El Correo debe tener entre 2 y 100 caracteres.")]
        [EmailAddress(ErrorMessage = "Ingrese una dirección de correo electrónico válida.")]
        public string Correo { get; set; }
        [Required(ErrorMessage = "El Sub Lugar es requerido.")]
        public int subLug_Id { get; set; }

        [Required(ErrorMessage = "La Latitud es requerida.")]
        [RegularExpression(@"^-?([1-8]?\d(?:\.\d{1,18})?|90(?:\.0{1,18})?)$", ErrorMessage = "Ingrese una latitud válida.")]
        public string Latitud { get; set; }

        [Required(ErrorMessage = "La Longitud es requerida.")]
        [RegularExpression(@"^-?((?:1[0-7]|[1-9])?\d(?:\.\d{1,18})?|180(?:\.0{1,18})?)$", ErrorMessage = "Ingrese una longitud válida.")]
        public string Longitub { get; set; }

        [Required(ErrorMessage = "La lista de Horarios es requerida.")]
        [MinLength(1, ErrorMessage = "Debe haber al menos un elemento en la lista de Horarios.")]
        public List<HorarioModel> Horario { get; set; }

        [Required(ErrorMessage = "La lista de Categorías es requerida.")]
        [MinLength(1, ErrorMessage = "Debe haber al menos un elemento en la lista de Categorías.")]
        public List<CategoriaItemModel> Categoria { get; set; }

        [JsonIgnore]
        public DataTable? HorarioDate { get; set; }
        [JsonIgnore]
        public DataTable? CategoriaDate { get; set; }
    }
}
