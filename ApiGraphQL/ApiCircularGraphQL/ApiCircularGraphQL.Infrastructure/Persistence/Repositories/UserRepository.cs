using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices.Marshalling;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ApiCircularGraphQL.Infrastructure.Persistence.Repositories
{
    public class UserRepository : Repository<tbUsuarios>, IUserRepository
    {
        private readonly IDbContextFactory<AppECOContext> _contextFactory;
        private readonly ITokenBlacklistRepository _tokenBlacklistRepository;
        private readonly IConfiguration _configuration;
        public UserRepository(IDbContextFactory<AppECOContext> contextFactory,
            ITokenBlacklistRepository tokenBlacklistRepository,
            IConfiguration configuration
            ) : base(contextFactory)
        {
            _contextFactory = contextFactory;
            _tokenBlacklistRepository = tokenBlacklistRepository;
            _configuration = configuration;
        }

        public async Task<tbUsuarios> GetUserIdAsync(Guid idUser)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarios.FirstOrDefaultAsync(a => a.user_Id == idUser)
                ?? throw new Exception($"No se Contro informacion del usuario con Id {idUser}");
        }

        public async Task<List<tbInfoUnicaUsuario>> GetUserAllAsync()
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbInfoUnicaUsuario.OrderBy(a=> a.usInf_Id).ToListAsync();
        }

        public async Task<List<tbTipoUsuario>> GetTipoAllAsync()
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoUsuario.ToListAsync();
        }
        public async Task<tbTipoUsuario?> GetTipoIdAsync(Guid id)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoUsuario.AsNoTracking().FirstOrDefaultAsync(a=> a.tipUs_Id == id);
        }

        public async Task<IEnumerable<tbTipoUsuario>> GetManyByIds(IReadOnlyList<Guid> tiposUsuarioIds)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoUsuario.Where(a => tiposUsuarioIds.Contains(a.tipUs_Id)).ToListAsync();
        }

        public async Task<IEnumerable<tbUsuarios>> GetUsuariosByPrincipals(IReadOnlyList<Guid> idUsuarioPrincipal)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarios.Where(a => idUsuarioPrincipal.Contains(a.usInf_Id)).ToListAsync();
        }

        public async Task<IEnumerable<tbTipoIdentificacion>> GetIdentidadPorByIds(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbTipoIdentificacion.Where(a => ids.Contains(a.tipIde_Id)).ToListAsync();
        }
        public async Task<IEnumerable<tbUsuarioTelefono>> GetTelefonosPorUsuario(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarioTelefono.Where(a => ids.Contains(a.user_Id)).ToListAsync();
        }
        public async Task<IEnumerable<tbHorario>> GetHorarioPorUsuario(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbHorario.Where(a => ids.Contains(a.user_Id)).ToListAsync();
        }

        public IQueryable<tbInfoUnicaUsuario> GetUserAllQueryableAsync()
        {
            var context = _contextFactory.CreateDbContext();
            return context.tbInfoUnicaUsuario;
        }

        public async Task<bool> ValidarSiExisteLosTelefonos(IEnumerable<string> telefonos)
        {
            using var context = _contextFactory.CreateDbContext();
            if (!telefonos.Any())
                throw new Exception("Necesita almenos un numero de telefono para validar.");

            foreach (var item in telefonos)
            {
                string tel = item.Replace(" ", "");
                var vali = await context.tbUsuarioTelefono
                            .Include(e => e.user)
                            .AsNoTracking()
                            .AnyAsync(i => i.usTel_Numero == tel);

                if (vali) throw new Exception($"El numero de telefono {tel} ya existe.");
            }
            return false;
        }

        public async Task<bool> ValidarSiExisteCorreo(string correo)
        {
            if (string.IsNullOrWhiteSpace(correo))
                throw new Exception("Es necesario el Correo.");

            bool formatoCorreo = Regex.IsMatch(correo, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
            if (!formatoCorreo)
                throw new Exception("El Correo a validar no tiene el formato valido");

            using var context = _contextFactory.CreateDbContext();
            bool result = await context.tbUsuarios.AnyAsync(a => a.user_Correo.Equals(correo, StringComparison.CurrentCultureIgnoreCase));
            if (result)
                throw new Exception($"Ya existe el correo {correo}");

            return false;
        }

        public async Task<Guid> CrearUsuarioPrincipal(tbInfoUnicaUsuario usuario)
        {
            using var context = _contextFactory.CreateDbContext();
            context.tbInfoUnicaUsuario.Add(usuario);
            await context.SaveChangesAsync();
            Guid idRetorno = usuario.tbUsuarios.First().user_Id;
            return idRetorno;
        }

        public async Task GuardarToken(Guid idUsuario, Guid idTipoToken, string token)
        {
            using var context = _contextFactory.CreateDbContext();
            var usuario = await context.tbUsuarios.AnyAsync(a => a.user_Id == idUsuario);
            if (!usuario) throw new Exception($"No se pudo obtener el usuario con el id {idUsuario}, Para guardar el Token Verificacion.");
            var tipoToken = await context.tbTipoToken.AnyAsync(a => a.tipToke_Id == idTipoToken);
            if (!tipoToken) throw new Exception($"No se pudo obtener el tipo Token con el id {idTipoToken}, para guardar el token.");
            var tokenBD = await context.tbUsuariosTokens.FirstOrDefaultAsync(a => a.user_Id == idUsuario && a.tipToke_Id == idTipoToken);
            if(tokenBD == null)
            {
                context.tbUsuariosTokens.Add(new tbUsuariosTokens
                {
                    user_Id = idUsuario,
                    tipToke_Id = idTipoToken,
                    userToke_Token = token
                });
            }
            else
            {
                var validToken = JwtHelper.ValidateToken(tokenBD.userToke_Token, _configuration);
                if (validToken)
                {
                    var (Jti, Expiration) = JwtHelper.GetTokenInfo(tokenBD.userToke_Token);
                    if (Expiration > DateTime.UtcNow)//Agregar Token
                    {
                        await _tokenBlacklistRepository.AddToBlacklistAsync(Jti.ToString(), Expiration);
                    }
                }
                tokenBD.userToke_Token = token;
            }

            await context.SaveChangesAsync();
        }

        public async Task<List<string>> UsuarioVerificado(Guid idUsuario)
        {
            using var context = _contextFactory.CreateDbContext();
            var data = await context.tbUsuarios.Include(a=> a.tbUsuariosTokens).FirstOrDefaultAsync(a => a.user_Id == idUsuario)
                ?? throw new Exception($"No se pudo obtener el usuario con el id {idUsuario}, Para Cambiar el estado a verificado.");
            data.user_Verificado = true;

            var listaToken = new List<string>();

            if(data.tbUsuariosTokens.Count> 0)
            {
                listaToken = [.. data.tbUsuariosTokens.Select(a => a.userToke_Token)];
                context.tbUsuariosTokens.RemoveRange(data.tbUsuariosTokens);
            }

            await context.SaveChangesAsync();
            return listaToken;
        }

        public async Task<string[]> RolesUsuario(Guid idUsuario)
        {
            using var context = _contextFactory.CreateDbContext();
            var usuario = await context.tbUsuarios
                    .Include(a=> a.rol)
                    .FirstOrDefaultAsync(a => a.user_Id == idUsuario)
                ?? throw new Exception($"No se pudo obtener el usuario con el id {idUsuario}, Para obtener los roles.");

            return usuario.rol.Count > 0 ? [.. usuario.rol.Select(a => a.rol_NombreNormalizado)] : [];
        }

        public async Task<bool> TokesUsuarios(Guid idUsuario, Guid idTipoToken, string token)
        {
            using var context = _contextFactory.CreateDbContext();
            var usuario = await context.tbUsuarios
                            .Include(a => a.tbUsuariosTokens)
                            .FirstOrDefaultAsync(a=> a.user_Id == idUsuario) 
                        ?? throw new Exception("No se encontro un usuario para validar");

            var tokesDB = usuario.tbUsuariosTokens.FirstOrDefault(a => a.tipToke_Id == idTipoToken)?.userToke_Token 
                        ?? throw new Exception("No se encontro un token");

            return token == tokesDB;
        }
        
        public async Task<tbUsuarios?> UsuarioVerificado(string correo,string contraseña)
        {
            try
            {
                using var context = await _contextFactory.CreateDbContextAsync();

                var usuarios = await context.tbUsuarios.AsNoTracking().Where(a => a.user_Correo.ToUpper() == correo.ToUpper()).ToListAsync();
                if (usuarios.Count > 1)
                    throw new Exception("Existen mas de un usuario con el mismo correo.");

                var usuario = usuarios.FirstOrDefault() ?? throw new Exception($"No existe el Correo {correo}.");

                string paswordSal = EncryptPass.GeneratePassword(contraseña, usuario.user_PasswordSal);
                if (usuario.user_Password != paswordSal)
                    throw new Exception("Contraseña no validad.");

                return usuario;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public async Task<Dictionary<string, string>> ClaimsUsuario(Guid idUsuario)
        {
            var mapa = await ClaimsPorUsuarios([idUsuario]);
            return mapa.TryGetValue(idUsuario, out var claims) ? claims : [];
        }

        public async Task<Dictionary<Guid, tbRoles[]>?> GetRolesPorUsuarios(IReadOnlyList<Guid> ids)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbUsuarios.AsNoTracking()
                            .Where(a => ids.Contains(a.user_Id))
                            .Include(u => u.rol)
                            .ToDictionaryAsync(d => d.user_Id, d => d.rol.ToArray());
        }

        public async Task<Dictionary<Guid, Dictionary<string,string>>> ClaimsPorUsuarios(IReadOnlyList<Guid> idsUsuarios)
        {
            using var context = _contextFactory.CreateDbContext();

            var usuarios = await context.tbUsuarios
                            .AsNoTracking()
                            .Include(a => a.rol).ThenInclude(e => e.tbRolesClaims)
                            .Include(a => a.tbUsuariosClaims)
                            .Where(a => idsUsuarios.Contains(a.user_Id)).ToListAsync();
            var claimsUsuarios = new Dictionary<Guid, Dictionary<string, string>>();
            foreach (var id in idsUsuarios)
            {
                if(usuarios != null && usuarios.Any(a=> a.user_Id == id))
                {

                    Dictionary<string, string> Claims;
                    var usuario = usuarios.FirstOrDefault(a => a.user_Id == id);

                    Claims = usuario.rol?
                    .SelectMany(a => a.tbRolesClaims ?? [])
                    .ToDictionary(
                        a => a.rolClai_Tipo,
                        a => a.rolClai_Value
                    ) ?? [];

                    var usuarioClaims = usuario.tbUsuariosClaims?.ToDictionary(
                        a => a.userClai_Tipo,
                        a => a.userClai_Value) ?? [];

                    foreach (var item in usuarioClaims)
                    {
                        if (!Claims.ContainsKey(item.Key))
                        {
                            Claims[item.Key] = item.Value;
                        }
                    }
                    claimsUsuarios[id] = Claims;
                }
                else
                {
                    claimsUsuarios[id] = [];
                }
            }
            return claimsUsuarios;
        }

        public async Task<IEnumerable<tbInfoUnicaUsuario>> GetInfUsuarioPrincipal(IReadOnlyList<Guid> idUsuarioPrincipal)
        {
            using var context = _contextFactory.CreateDbContext();
            return await context.tbInfoUnicaUsuario.Where(a => idUsuarioPrincipal.Contains(a.usInf_Id)).ToListAsync();
        }
    }
}
