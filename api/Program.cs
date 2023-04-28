using System.Runtime.InteropServices;
using api;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
  app.UseSwagger();
  app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

// call Pkg.envdir()
Julia.jl_eval_string("using Pkg");
IntPtr envdir = Julia.jl_eval_string("Pkg.envdir"); // the function
IntPtr p1 = Julia.jl_call0(envdir); // return jl_value_t*
IntPtr p2 = Julia.jl_string_ptr(p1); //get const char* from jl_value_t* since the true return is a string
string envdirRes = Marshal.PtrToStringAnsi(p2);  // const char* --> C# string
Console.WriteLine($"Pkg.envdir() -> {envdirRes}");

app.Run();

