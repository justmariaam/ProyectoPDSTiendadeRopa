using ProyectoTiendadeRopa.Data;
using ProyectoTiendadeRopa.Models;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;


namespace ProyectoTiendadeRopa.Controllers;

public class AccountController : Controller
{
    private readonly ApplicationDbContext _context;

    public AccountController(ApplicationDbContext context)
    {
        _context = context;
    }

  
    [HttpPost]
    public IActionResult RegistrarCliente(Usuario usuario)
    {
        if (ModelState.IsValid)
        {
            // 1. Guardar usuario
            _context.Usuarios.Add(usuario);
            _context.SaveChanges();

            // 2. Crear carrito vacío vinculado al nuevo usuario
            var carrito = new Carrito { UsuarioId = usuario.Id };
            _context.Carritos.Add(carrito);
            _context.SaveChanges();

            // 3. Redirigir a login
            return RedirectToAction("LoginCliente");
        }

        return View(usuario);
    }


   [HttpPost]
    public IActionResult LoginCliente(string correo, string contrasena)
    {
        var usuario = _context.Usuarios.FirstOrDefault(u => u.Correo == correo && u.Contrasena == contrasena);

        if (usuario != null)
        {
            // Guardar datos en sesión
            HttpContext.Session.SetInt32("UsuarioId", usuario.Id);
            HttpContext.Session.SetString("UsuarioNombre", usuario.Nombre);

            return RedirectToAction("Index", "Home");
        }
        else
        {
            ViewBag.Mensaje = "Correo o contraseña incorrectos";
            return View();
        }
    }


    

    public IActionResult Logout()
    {
        HttpContext.Session.Clear();
        return RedirectToAction("Index", "Home");
    }




    public IActionResult Login()
    {
        return View(); // Debe haber una vista llamada Login.cshtml
    }

    public IActionResult LoginCliente()
    {
        return View();
    }

    [HttpGet]
    public IActionResult LoginAdmin()
    {
        return View();
    }

    [HttpPost]
    public IActionResult LoginAdmin(string usuario, string password)
    {
        var admin = _context.Administradores.FirstOrDefault(a => a.Usuario == usuario && a.Contrasena == password);
        if (admin != null)
        {
            HttpContext.Session.SetInt32("AdminId", admin.Id);
            HttpContext.Session.SetString("AdminUsuario", admin.Usuario);
            return RedirectToAction("AdminPanel", "Admin");
        }

        ViewBag.Error = "Usuario o contraseña incorrectos";
        return View();
    }
    
    
    public IActionResult RegistrarCliente()
    {
        return View();
    } 




}

