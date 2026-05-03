using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Application.DTOs
{
    public class ValidationCorreRequest
    {
        public string Correo { get; set; }
        public string Code { get; set; }
    }

    public class ValidationCorreoResponse
    {
        public bool Validation { get; set; }
    }
}