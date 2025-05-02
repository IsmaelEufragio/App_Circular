using ApiCircularGraphQL.Api.Configurations;
using ApiCircularGraphQL.Api.Middlewares;
using ApiCircularGraphQL.Application;
using ApiCircularGraphQL.Application.Services.Implementations;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.CrossCutting.Helpers;
using ApiCircularGraphQL.Domain.Interfaces;
using ApiCircularGraphQL.Infrastructure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Text;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddConfigurationJWT(builder.Configuration);// JWT
builder.Services.AddGraphQLServices();// GraphQL
builder.Services.AddServiceExtensionsInfrastructure(builder.Configuration);// Infrastructure
builder.Services.AddServiceExtensionsApplication();// Application
builder.Services.AddSwagger();// Swagger
var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Mi API V1");
});

app.UseRouting();

app.Use(async (context, next) =>
{
    var endpoint = context.GetEndpoint();
    if (endpoint?.Metadata?.GetMetadata<AuthorizeAttribute>() != null)
    {
        var tokenBlacklistService = context.RequestServices
            .GetRequiredService<ITokenBlacklistRepository>();

        var token = context.Request.Headers["Authorization"]
            .FirstOrDefault()?.Split(" ").Last();

        if (token != null)
        {
            var (jti, _) = JwtHelper.GetTokenInfo(token);

            if (await tokenBlacklistService.IsTokenBlacklistedAsync(jti.ToString()))
            {
                context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                await context.Response.WriteAsync("El token ha sido revocado");
                return;
            }

            if (!JwtHelper.ValidateToken(token, builder.Configuration))
            {
                context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                await context.Response.WriteAsync("Token Invalido");
                return;
            }
        }
        else
        {
            context.Response.StatusCode = StatusCodes.Status401Unauthorized;
            await context.Response.WriteAsync("Es neceario un token");
            return;
        }
    }

    await next();
});
app.UseAuthentication();
app.UseAuthorization();

//app.UseEndpoints(endpoints => endpoints.MapGraphQL());

//app.MapGraphQL();
app.UseWebSockets();
app.MapGraphQL();
app.MapControllers();

await app.RunWithGraphQLCommandsAsync(args);
//app.Run();

