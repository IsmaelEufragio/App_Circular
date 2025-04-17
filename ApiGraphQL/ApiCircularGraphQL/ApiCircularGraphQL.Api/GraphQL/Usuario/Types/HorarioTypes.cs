using Microsoft.EntityFrameworkCore.Metadata;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario.Types
{
    public class HorarioTypes
    {
        public Guid Id { get; set; }
        public int Dia { get; set; }
        public TimeOnly Abre { get; set; }
        public TimeOnly Cierra { get; set; }
    }
}
