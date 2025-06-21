using Microsoft.EntityFrameworkCore;
using ProyectoTiendadeRopa.Models;

namespace ProyectoTiendadeRopa.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Usuario> Usuarios { get; set; }

        public DbSet<Carrito> Carritos { get; set; }

        public DbSet<ItemCarrito> ItemsCarrito { get; set; }

        public DbSet<Producto> Productos { get; set; }

        public DbSet<Pedido> Pedidos { get; set; }
        public DbSet<DetallePedido> DetallesPedido { get; set; }

        public DbSet<Administrador> Administradores { get; set; }

        public DbSet<Categoria> Categorias { get; set; }






    }
    
}
