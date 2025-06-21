using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using ProyectoTiendadeRopa.Data;
using ProyectoTiendadeRopa.Models;
using System.Diagnostics;
using System.Linq;

namespace ProyectoTiendadeRopa.Controllers
{
    public class HomeController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<HomeController> _logger;

        public HomeController(ApplicationDbContext context, ILogger<HomeController> logger)
        {
            _context = context;
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Catalogo(string categoria)
        {
            var productos = string.IsNullOrEmpty(categoria)
                ? _context.Productos.ToList()
                : _context.Productos.Where(p => p.Categoria == categoria).ToList();

            ViewBag.CategoriaActual = categoria;
            ViewBag.Categorias = _context.Categorias.Select(c => c.Nombre).ToList();
            return View(productos);
        }



        public IActionResult Pedido()
        {
            if (HttpContext.Session.GetInt32("UsuarioId") == null)
                return RedirectToAction("LoginCliente", "Account");

            return View();
        }

        [HttpPost]
        public IActionResult Pedido(string contacto, string direccion, string metodoPago)
        {
            int? usuarioId = HttpContext.Session.GetInt32("UsuarioId");
            if (usuarioId == null)
                return RedirectToAction("LoginCliente", "Account");

            var carrito = _context.Carritos
                .Include(c => c.Items)
                .ThenInclude(i => i.Producto)
                .FirstOrDefault(c => c.UsuarioId == usuarioId);

            if (carrito == null || carrito.Items == null || !carrito.Items.Any())
                return RedirectToAction("VerCarrito", "Carrito");

            var pedido = new Pedido
            {
                UsuarioId = usuarioId.Value,
                NombreCliente = contacto,
                Direccion = direccion,
                MetodoPago = metodoPago,
                Total = carrito.Items.Sum(i => i.Cantidad * i.Producto.Precio),
                Estado = "Pendiente",
                Detalles = new List<DetallePedido>()
            };

            foreach (var item in carrito.Items)
            {
                pedido.Detalles.Add(new DetallePedido
                {
                    NombreProducto = item.Producto.Nombre,
                    Categoria = item.Producto.Categoria,
                    Cantidad = item.Cantidad,
                    PrecioUnitario = item.Producto.Precio
                });
            }

            _context.Pedidos.Add(pedido);
            _context.ItemsCarrito.RemoveRange(carrito.Items);
            _context.SaveChanges();

            return RedirectToAction("Pedidos");
        }

        public IActionResult Pedidos()
        {
            if (HttpContext.Session.GetInt32("UsuarioId") == null)
                return RedirectToAction("LoginCliente", "Account");

                var usuarioId = HttpContext.Session.GetInt32("UsuarioId").Value;
                var usuario = _context.Usuarios.FirstOrDefault(u => u.Id == usuarioId);


            ViewBag.PedidoExitoso = true;
            ViewBag.Domicilio = usuario?.Domicilio ?? "No registrado";
            return View();
        }


        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        
    }
}
