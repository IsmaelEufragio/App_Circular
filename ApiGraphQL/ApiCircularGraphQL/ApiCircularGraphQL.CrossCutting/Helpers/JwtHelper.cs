// Security/Helpers/JwtHelper.cs
using ApiCircularGraphQL.CrossCutting.Model;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace ApiCircularGraphQL.CrossCutting.Helpers
{
    public static class JwtHelper
    {
        public static string GenerateToken(CrearTokenModel tokenModel)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(tokenModel.Configuration["Jwt:Key"] ?? string.Empty));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
            var tiempoExp = tokenModel.Expira ?? DateTime.Now.AddMinutes(Convert.ToDouble(tokenModel.Configuration["Jwt:ExpirationMinutes"]));

            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, tokenModel.IdUsuario),
                new Claim(JwtRegisteredClaimNames.Name, tokenModel.NombreUsuario),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            // Agregar roles como claims
            foreach (var role in tokenModel.Roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role));
            }

            // Agregar Claims Personalizados
            foreach (var item in tokenModel.Claims)
            {
                claims.Add(new Claim(item.Key, item.Value));
            }

            var token = new JwtSecurityToken(
                issuer: tokenModel.Configuration["Jwt:Issuer"],
                audience: tokenModel.Configuration["Jwt:Audience"],
                claims: claims,
                expires: tiempoExp,
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public static bool ValidateToken(string token, IConfiguration configuration)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(configuration["Jwt:Key"] ?? string.Empty);

            try
            {
                // Configura los parámetros de validación
                var validationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = configuration["Jwt:Issuer"],
                    ValidAudience = configuration["Jwt:Audience"],
                    IssuerSigningKey = new SymmetricSecurityKey(key)
                };

                // Valida el token
                tokenHandler.ValidateToken(token, validationParameters, out SecurityToken validatedToken);

                // Si no hay excepciones, el token es válido
                return true;
            }
            catch
            {
                // Si hay una excepción, el token no es válido
                return false;
            }
        }

        public static List<string> GetRolesFromToken(string token)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtToken = tokenHandler.ReadJwtToken(token);

            // Extraer los roles del token
            var roles = jwtToken.Claims
                .Where(c => c.Type == ClaimTypes.Role)
                .Select(c => c.Value)
                .ToList();

            return roles;
        }

        public static Guid IdUsuario(string token, IConfiguration configuration)
        {
            var principal = GetClaimsFromToken(token, configuration);
            if (principal != null)
            {
                var sensitiveClaimsIdentity = principal.Identity as CaseSensitiveClaimsIdentity ??
                    throw new Exception("No se pudo convertir a otra clase.");

                var idUsuario = ((JwtSecurityToken)sensitiveClaimsIdentity.SecurityToken).Claims.FirstOrDefault(a => a.Type == JwtRegisteredClaimNames.Sub)?.Value
                     ?? throw new Exception("No se pudo obtener la informacion del token.");
                
                return Guid.Parse(idUsuario);
            } throw new Exception("Token Invalido.");
        }

        public static ClaimsPrincipal? GetClaimsFromToken(string token, IConfiguration configuration)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(configuration["Jwt:Key"] ?? string.Empty);

            try
            {
                // Configura los parámetros de validación
                var validationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = false,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = configuration["Jwt:Issuer"],
                    ValidAudience = configuration["Jwt:Audience"],
                    IssuerSigningKey = new SymmetricSecurityKey(key)
                };

                var principal = tokenHandler.ValidateToken(token, validationParameters, out SecurityToken validatedToken);
                return principal;
            }
            catch
            {
                return null;
            }
        }
    }
}