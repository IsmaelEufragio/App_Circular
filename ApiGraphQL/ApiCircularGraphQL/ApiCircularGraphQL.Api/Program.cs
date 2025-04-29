using ApiCircularGraphQL.Api.Configurations;
using ApiCircularGraphQL.Api.Middlewares;
using ApiCircularGraphQL.Application;
using ApiCircularGraphQL.Application.Services.Implementations;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Infrastructure;
using HotChocolate.Authorization;
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

app.UseAuthentication();
app.UseAuthorization();

//app.UseEndpoints(endpoints => endpoints.MapGraphQL());

//app.MapGraphQL();
app.UseWebSockets();
app.MapGraphQL();
app.MapControllers();

await app.RunWithGraphQLCommandsAsync(args);
//app.Run();

