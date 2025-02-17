using ApiCircularGraphQL.Api.Configurations;
using ApiCircularGraphQL.Api.GraphQL.Queries;
using ApiCircularGraphQL.Application.Services.Implementations;
using ApiCircularGraphQL.Application.Services.Interfaces;
using ApiCircularGraphQL.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddGraphQLServices();// GraphQL
builder.Services.AddServiceExtensionsInfrastructure(builder.Configuration);// Infrastructure
builder.Services.AddServiceExtensionsApplication();
builder.Services.AddScoped<IPaisService, PaisService>();

var app = builder.Build();

app.MapGraphQL();
app.UseWebSockets();
app.Run();

