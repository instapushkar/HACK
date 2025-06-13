using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

// Get JWT secret from configuration
var jwtSecret = builder.Configuration["Jwt:Secret"] 
    ?? throw new InvalidOperationException("JWT Secret not configured");

builder.Services.AddControllers();

var app = builder.Build();

app.MapGet("/", () => new { status = "ok" });

app.Run();
