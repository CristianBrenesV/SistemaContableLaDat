using Microsoft.AspNetCore.Authentication.Cookies;
using SistemaContableLaDat.Repository.Asientos;
using SistemaContableLaDat.Repository.Bitacora;
using SistemaContableLaDat.Repository.Cuentas;
using SistemaContableLaDat.Repository.Infrastructure;
using SistemaContableLaDat.Repository.Login;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Service.Bitacora;
using SistemaContableLaDat.Service.Cuentas;
using SistemaContableLaDat.Service.Encriptado;
using SistemaContableLaDat.Service.Login;
using SistemaContableLaDat.Service.Seguridad;

var builder = WebApplication.CreateBuilder(args);

// Razor Pages
builder.Services.AddRazorPages();

// Infraestructura
builder.Services.AddSingleton<IDbConnectionFactory, DbConnectionFactory>();

// Repositorios
builder.Services.AddScoped<UsuarioRepository>();
builder.Services.AddScoped<LoginRepository>();
builder.Services.AddScoped<BitacoraRepository>();
builder.Services.AddScoped<AsientoRepository>();
builder.Services.AddScoped<CuentaRepository>();
builder.Services.AddScoped<CuentaService>();

// Servicios
builder.Services.AddScoped<IUsuarioService, UsuarioService>();
builder.Services.AddScoped<IBitacoraService, BitacoraService>();
builder.Services.AddScoped<IEncriptadoService, EncriptadoService>();
builder.Services.AddScoped<ISeguridadService, SeguridadService>();

builder.Services.AddScoped<LoginService>();
builder.Services.AddScoped<EncriptadoService>();
builder.Services.AddScoped<AsientoService>();

// Autenticación
builder.Services.AddAuthentication("Cookies")
    .AddCookie("Cookies", options =>
    {
        options.LoginPath = "/Index";
        options.ExpireTimeSpan = TimeSpan.FromMinutes(5);
        options.SlidingExpiration = true;
    });

// Autorización
builder.Services.AddAuthorization();

builder.Services.AddRazorPages(options =>
{
    options.Conventions.AuthorizeFolder("/Usuarios");
    options.Conventions.AllowAnonymousToPage("/Index");
});

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.MapRazorPages();
app.Run();
