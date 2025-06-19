using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProyectoTiendadeRopa.Data;
using ProyectoTiendadeRopa.Models;

namespace ProyectoTiendadeRopa.Controllers
{
    public class CarritoController : Controller
    {
        private readonly ApplicationDbContext _context;

        public CarritoController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpPost]
        public IActionResult Agregar(int productoId)
        {
            int? usuarioId = HttpContext.Session.GetInt32("UsuarioId");
            if (usuarioId == null)
                return Json(new { success = false, mensaje = "No autenticado" });

            var carrito = _context.Carritos
                .Include(c => c.Items)
                .FirstOrDefault(c => c.UsuarioId == usuarioId);

            if (carrito == null)
            {
                carrito = new Carrito { UsuarioId = usuarioId.Value };
                _context.Carritos.Add(carrito);
                _context.SaveChanges();
            }

            var item = _context.ItemsCarrito
                .FirstOrDefault(i => i.CarritoId == carrito.Id && i.ProductoId == productoId);

            if (item != null)
                item.Cantidad++;
            else
                _context.ItemsCarrito.Add(new ItemCarrito
                {
                    CarritoId = carrito.Id,
                    ProductoId = productoId,
                    Cantidad = 1
                });

            _context.SaveChanges();
            return Json(new { success = true });
        }

        public IActionResult VerCarrito()
        {
            int? usuarioId = HttpContext.Session.GetInt32("UsuarioId");
            if (usuarioId == null)
                return RedirectToAction("LoginCliente", "Account");

            var carrito = _context.Carritos
                .Include(c => c.Items)
                .ThenInclude(i => i.Producto)
                .FirstOrDefault(c => c.UsuarioId == usuarioId);

            if (carrito == null || carrito.Items == null)
                return View(new List<(int ItemId, string Nombre, int Precio, int Cantidad)>());

            var modelo = carrito.Items.Select(i => (
                i.Id,
                i.Producto.Nombre,
                i.Producto.Precio,
                i.Cantidad
            )).ToList();

            return View("Carrito", modelo);
        }



        [HttpPost]
        public IActionResult Eliminar(int itemId)
        {
            var item = _context.ItemsCarrito.Find(itemId);
            if (item != null)
            {
                _context.ItemsCarrito.Remove(item);
                _context.SaveChanges();
            }

            return RedirectToAction("VerCarrito");
        }
        

        [HttpPost]
        public IActionResult ModificarCantidad(int itemId, string operacion)
        {
            var item = _context.ItemsCarrito.Find(itemId);
            if (item != null)
            {
                if (operacion == "incrementar")
                {
                    item.Cantidad++;
                }
                else if (operacion == "disminuir")
                {
                    item.Cantidad--;
                    if (item.Cantidad <= 0)
                    {
                        _context.ItemsCarrito.Remove(item);
                    }
                }

                _context.SaveChanges();
            }

            return RedirectToAction("VerCarrito");
        }

    }
}
