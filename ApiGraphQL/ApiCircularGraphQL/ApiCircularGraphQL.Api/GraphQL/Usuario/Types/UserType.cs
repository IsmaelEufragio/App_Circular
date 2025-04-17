using ApiCircularGraphQL.Domain.Entities;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario.Types
{
    public class UserType
    {
        public Guid Id { get; set; }
        public string NombreUsuario { get; set; }
        public string Despcripcion { get; set; }
        public string Correo { get; set; }
        public string Fecebook { get; set; }
        public string Intragram { get; set; }
        public bool WhatsApp { get; set; }
        public bool Envio { get; set; }
        public bool UsuarioPrincipal { get; set; }
        public DateTime? FechaCreacion { get; set; }
        public string Identidad { get; set; }
        public Guid IdTipoIdentidad { get; set; }
        public bool Verificado { get; set; }

        [GraphQLNonNullType]
        public async Task<TipoIdentidadType> TipoIdentidad([Service] IIdentidadPorUsuarioDataLoader identidadPorUsuarioDataLoader)
        {
            var data = await identidadPorUsuarioDataLoader.LoadAsync(IdTipoIdentidad, CancellationToken.None);
            if (data is null)
                throw new GraphQLException($"No se encontró el tipo de Identificacion con ID {IdTipoIdentidad}");

            return new TipoIdentidadType()
            {
                Id = data.IdTipoIdentidad,
                Descripcion = data.Nombre
            };
        }
        [GraphQLNonNullType]
        public async Task<IEnumerable<TelefonosType>> Telefonos([Service] ITelefonosPorUsuariosDataLoader telefonosPorUsuariosDataLoader)
        {
            var data = await telefonosPorUsuariosDataLoader.LoadAsync(Id, CancellationToken.None);
            if (data is null)
                throw new GraphQLException($"No se encontraron Telefonos con IdUsuarios {Id}");

            return data.Select(a => new TelefonosType
            {
                Id = a.IdTipoTelefono,
                Telefono = a.Telefono
            });
        }

        [GraphQLNonNullType]
        public async Task<IEnumerable<HorarioTypes>> Horarios([Service] IHorarioPorUsuarioDataLoader horarioPorUsuarioDataLoader)
        {
            var data = await horarioPorUsuarioDataLoader.LoadAsync(Id, CancellationToken.None);
            if (data is null)
                throw new GraphQLException($"No se encontraron los Horarios con IdUsuarios {Id}");

            return data.Select(a => new HorarioTypes
            {
                Id = a.IdHorario,
                Dia = a.Dia,
                Abre = a.HoraInicio,
                Cierra = a.HoraFin,
            });
        }
    }
}
