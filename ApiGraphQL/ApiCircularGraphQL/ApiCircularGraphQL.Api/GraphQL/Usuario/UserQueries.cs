using ApiCircularGraphQL.Api.GraphQL.Usuario.Types;
using ApiCircularGraphQL.Api.Middlewares;
using ApiCircularGraphQL.Application.DTOs.Usuarios;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.Domain.Entities;
using ApiCircularGraphQL.Domain.Interfaces;
using GreenDonut.Data;
using HotChocolate.Authorization;
using HotChocolate.Execution.Processing;
using HotChocolate.Types.Pagination;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System.IdentityModel.Tokens.Jwt;
using System.Threading.Tasks;
//using Microsoft.AspNetCore.Authorization;

namespace ApiCircularGraphQL.Api.GraphQL.Usuario
{
    [QueryType]
    public static class UserQueries
    {
        public static string Message => "Error XD";

        [UsePaging]
        [UseFiltering]
        [UseSorting]
        public static IQueryable<UserDTO> GetUsuarios([Service] IUserService UsuarioService)
        {
            return UsuarioService.GetUsuarioQuery().OrderBy(a => a.Id);
        }

        [UsePaging]
        [UseFiltering]
        [UseSorting]
        [Authorize(Policy = "TokenValido")]
        public static IQueryable<UserPrincipalDTO> GetUsuariosPrincipalesAll(
            [Service] IUserService usuarioService,
            [Service] IHttpContextAccessor httpContextAccessor
        )
        {
            var token = httpContextAccessor.HttpContext?.Request.Headers["Authorization"].ToString();

            // Opcional: Quitar "Bearer "
            if (token?.StartsWith("Bearer ") == true)
            {
                token = token.Substring("Bearer ".Length);
            }

            return usuarioService.GetUsuarioPrincipalQuery()
                .OrderBy(u => u.Id);
        }

        [Authorize(Policy = "TokenValido")]
        public static async Task<UserDTO> GetUsuario(
            [Service] IUserService userService,
            [Service] IHttpContextAccessor httpContextAccessor,
            [Service] IConfiguration configuration
        )
        {
            var token = (httpContextAccessor.HttpContext?.Request.Headers["Authorization"].ToString()) 
                ?? throw new TokenRevokedException("No se pudo obtener el token desde el contexto.");

            if (token.StartsWith("Bearer ") == true)
            {
                token = token["Bearer ".Length..];
            }
            
            var idUsuario = JwtHelper.IdUsuario(token, configuration);
            return await userService.GetUsuarioQuery().FirstAsync(a => a.Id == idUsuario);
        }
    }
}

