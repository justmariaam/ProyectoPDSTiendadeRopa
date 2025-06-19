using Microsoft.AspNetCore.Mvc; 
using ProyectoTiendadeRopa.Data;
using ProyectoTiendadeRopa.Models;
using System.Linq;
using System.IO;
using System.Threading.Tasks;

namespace ProyectoTiendadeRopa.Controllers
{
    public class AdminController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AdminController(ApplicationDbContext context)
        {
            _context = context;
        }

        public IActionResult AdminPanel()
        {
            return View();
        }

        // GET: ControlStock (inicial)
        [HttpGet]
        public IActionResult ControlStock()
        {
            return View();
        }

        // POST: Ver productos en stock
        [HttpPost]
        public IActionResult ControlStockPost()
        {
            var productos = _context.Productos.ToList();
            ViewBag.Productos = productos;
            return View("ControlStock");
        }


        public IActionResult Reportes()
        {
            // Producto más vendido por nombre
            var productoMasVendido = _context.DetallesPedido
                .GroupBy(d => d.NombreProducto)
                .Select(g => new
                {
                    Nombre = g.Key,
                    TotalVentas = g.Sum(d => d.Cantidad)
                })
                .OrderByDescending(g => g.TotalVentas)
                .FirstOrDefault();

            // Buscar imagen del producto en la tabla Producto
            string imagen = _context.Productos
                .Where(p => p.Nombre == productoMasVendido.Nombre)
                .Select(p => p.ImagenUrl)
                .FirstOrDefault();

            ViewBag.ProductoMasVendido = productoMasVendido;
            ViewBag.ImagenProducto = imagen;

            // Ventas por mes (ingresos)
            var ventasMensuales = _context.Pedidos
                .GroupBy(p => p.FechaPedido.Month)
                .Select(g => new
                {
                    Mes = g.Key,
                    Total = g.Sum(p => p.Total)
                })
                .OrderBy(g => g.Mes)
                .ToList();

            ViewBag.VentasMensuales = ventasMensuales;

            return View();
        }




        public IActionResult Usuarios()
        {
            var admin = _context.Administradores.FirstOrDefault();
            return View(admin ?? new Administrador());
        }

        [HttpPost]
        public IActionResult Usuarios(Administrador admin)
        {
            if (!ModelState.IsValid)
                return View(admin);

            // Siempre agregar como nuevo registro
            _context.Administradores.Add(admin);
            _context.SaveChanges();

            ViewBag.Mensaje = "Administrador agregado correctamente.";
            return RedirectToAction("VerAdministradores");
        }

        public IActionResult VerAdministradores()
        {
            var admins = _context.Administradores.ToList();
            ViewBag.Administradores = admins;
            return View("Usuarios", new Administrador()); // Vista compartida
        }



        [HttpPost]
        public async Task<IActionResult> AgregarProducto(string Nombre, string Categoria, decimal Precio, int Cantidad, IFormFile Imagen)
        {
            string nombreArchivo = null;

            if (Imagen != null && Imagen.Length > 0)
            {
                string carpetaDestino = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images");
                nombreArchivo = Guid.NewGuid().ToString() + Path.GetExtension(Imagen.FileName);
                string rutaCompleta = Path.Combine(carpetaDestino, nombreArchivo);

                using (var stream = new FileStream(rutaCompleta, FileMode.Create))
                {
                    await Imagen.CopyToAsync(stream);
                }
            }

            var producto = new Producto
            {
                Nombre = Nombre,
                Categoria = Categoria,
                Precio = Precio,
                Cantidad = Cantidad,
                ImagenUrl = nombreArchivo
            };

            _context.Productos.Add(producto);
            await _context.SaveChangesAsync();

            return RedirectToAction("Productos", new { seccion = "agregar" });
        }

        [HttpPost]
        public IActionResult BuscarEnProductos(string buscarId)
        {
            if (!string.IsNullOrEmpty(buscarId))
            {
                TempData["ProductoId"] = buscarId;
            }

            return RedirectToAction("Productos", new { seccion = "buscar" });
        }

        [HttpPost]
        public IActionResult BuscarProducto(int id)
        {
            var producto = _context.Productos.FirstOrDefault(p => p.Id == id);
            if (producto != null)
            {
                ViewBag.Seccion = "editar";
                ViewBag.Producto = producto;
            }
            else
            {
                ViewBag.Seccion = "editar";
                ViewBag.Mensaje = "Producto no encontrado.";
            }
            return View("Productos");
        }

        [HttpPost]
        public IActionResult EditarProducto(int Id, string Nombre, decimal Precio, int Cantidad)
        {
            var producto = _context.Productos.FirstOrDefault(p => p.Id == Id);
            if (producto != null)
            {
                producto.Nombre = Nombre;
                producto.Precio = Precio;
                producto.Cantidad = Cantidad;
                _context.SaveChanges();
            }
            return RedirectToAction("Productos", new { seccion = "editar" });
        }

        [HttpGet]
        public IActionResult Productos(string seccion)
        {
            ViewBag.Seccion = seccion ?? "agregar";

            if (TempData["ProductoId"] != null)
            {
                int id;
                if (int.TryParse(TempData["ProductoId"].ToString().Replace("#", ""), out id))
                {
                    var producto = _context.Productos.FirstOrDefault(p => p.Id == id);
                    ViewBag.ProductoBuscado = producto;
                }
            }

            return View();
        }

        [HttpPost]
        public IActionResult EliminarProducto(int id)
        {
            var producto = _context.Productos.FirstOrDefault(p => p.Id == id);
            if (producto != null)
            {
                _context.Productos.Remove(producto);
                _context.SaveChanges();
                TempData["MensajeEliminar"] = "Producto eliminado correctamente.";
            }
            else
            {
                TempData["MensajeEliminar"] = "Producto no encontrado.";
            }

            return RedirectToAction("Productos", new { seccion = "eliminar" });
        }
        

        
        
    }
}
