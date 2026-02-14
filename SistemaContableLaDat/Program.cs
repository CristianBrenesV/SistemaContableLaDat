using Microsoft.AspNetCore.Authentication.Cookies;
using SistemaContableLaDat.Repository.Asientos;
using SistemaContableLaDat.Repository.Bitacora;
using SistemaContableLaDat.Repository.Cierres;
using SistemaContableLaDat.Repository.CuentasContables;
using SistemaContableLaDat.Repository.Cuentas;
using SistemaContableLaDat.Repository.EstadosAsientosContables;
using SistemaContableLaDat.Repository.Infrastructure;
using SistemaContableLaDat.Repository.Login;
using SistemaContableLaDat.Repository.Pantallas;
using SistemaContableLaDat.Repository.Periodos;
using SistemaContableLaDat.Repository.Usuarios;
using SistemaContableLaDat.Repository.Roles;
using SistemaContableLaDat.Repository.RolesPantallas;
using SistemaContableLaDat.Repository.UsuariosRoles;
using SistemaContableLaDat.Repository.PeriodosContables;
using SistemaContableLaDat.Service.Abstract;
using SistemaContableLaDat.Service.Asientos;
using SistemaContableLaDat.Service.Bitacora;
using SistemaContableLaDat.Service.Cierres;
using SistemaContableLaDat.Service.CuentasContables;
using SistemaContableLaDat.Service.Cuentas;
using SistemaContableLaDat.Service.Encriptado;
using SistemaContableLaDat.Service.EstadosAsientosContables;
using SistemaContableLaDat.Service.Login;
using SistemaContableLaDat.Service.Pantallas;
using SistemaContableLaDat.Service.Periodos;
using SistemaContableLaDat.Service.Seguridad;
using SistemaContableLaDat.Service.Roles;
using SistemaContableLaDat.Service.RolesPantallas;
using SistemaContableLaDat.Service.UsuariosRoles;
using SistemaContableLaDat.Service.PeriodosContables;

var builder = WebApplication.CreateBuilder(args);

// Configuración de sesión
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
    options.Cookie.Name = ".SistemaContable.Session";
});

// Razor Pages
builder.Services.AddRazorPages();
// 1. Configuración de Razor Pages
builder.Services.AddRazorPages(options =>
{
    options.Conventions.AuthorizeFolder("/Usuarios");
    options.Conventions.AllowAnonymousToPage("/Index");
});

// 2. Infraestructura
builder.Services.AddSingleton<IDbConnectionFactory, DbConnectionFactory>();

// 3. Repositorios
builder.Services.AddScoped<UsuarioRepository>();
builder.Services.AddScoped<LoginRepository>();
builder.Services.AddScoped<BitacoraRepository>();
builder.Services.AddScoped<AsientoRepository>();
builder.Services.AddScoped<CuentaRepository>();
builder.Services.AddScoped<PeriodoRepository>();
builder.Services.AddScoped<RolRepository>();
builder.Services.AddScoped<RolPantallaRepository>();
builder.Services.AddScoped<UsuarioRolRepository>();
builder.Services.AddScoped<PantallaRepository>();
builder.Services.AddScoped<CuentasContablesRepository>();
builder.Services.AddScoped<EstadoAsientoContableRepository>();
builder.Services.AddScoped<PeriodoContableRepository>();
// 4. Servicios
builder.Services.AddScoped<IUsuarioService, UsuarioService>();
builder.Services.AddScoped<IBitacoraService, BitacoraService>();
builder.Services.AddScoped<ISeguridadService, SeguridadService>();
builder.Services.AddScoped<CuentaService>();
builder.Services.AddScoped<PeriodoService>();
builder.Services.AddScoped<AsientoService>();
builder.Services.AddScoped<IRolPantallaService, RolPantallaService>();
builder.Services.AddScoped<IRolService, RolService>();
builder.Services.AddScoped<IPantallaService, PantallaService>();
builder.Services.AddScoped<IUsuarioRolService, UsuarioRolService>();
builder.Services.AddScoped<IEstadosAsientosContablesService, EstadosAsientosContablesService>();
builder.Services.AddScoped<ICuentasContablesService, CuentasContablesService>();
builder.Services.AddScoped<IPeriodosContablesService, PeriodosContablesService>();

builder.Services.AddScoped<CierreRepository>();
builder.Services.AddScoped<ICierreService, CierreService>();

// Autenticación
builder.Services.AddScoped<IEncriptadoService, EncriptadoService>();
builder.Services.AddScoped<EncriptadoService>();

builder.Services.AddScoped<LoginService>();

builder.Services.AddAuthentication("Cookies")
    .AddCookie("Cookies", options =>
    {
        options.LoginPath = "/Index";
        options.ExpireTimeSpan = TimeSpan.FromMinutes(5);
        options.SlidingExpiration = true;
    });

builder.Services.AddAuthorization();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseSession();
app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();

app.Run();