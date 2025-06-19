using ProyectoTiendadeRopa.Models;
namespace ProyectoTiendadeRopa.Models;

public class Carrito
{
    public int Id { get; set; }

    public int UsuarioId { get; set; } // FK

    // navegación
    public Usuario Usuario { get; set; }
    public List<ItemCarrito> Items { get; set; }
}
