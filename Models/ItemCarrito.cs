using ProyectoTiendadeRopa.Models;
namespace ProyectoTiendadeRopa.Models;


public class ItemCarrito
{
    public int Id { get; set; }

    public int CarritoId { get; set; } 
    public int ProductoId { get; set; } 

    public int Cantidad { get; set; }

    // navegación
    public Producto Producto { get; set; }
    public Carrito Carrito { get; set; }
}

