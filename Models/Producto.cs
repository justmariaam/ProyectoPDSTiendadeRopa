using System.ComponentModel.DataAnnotations;

namespace ProyectoTiendadeRopa.Models
{
    public class Producto
    {
        public int Id { get; set; }

        [Required]
        public string Nombre { get; set; }

        [Required]
        [DataType(DataType.Currency)]
        public decimal Precio { get; set; }


        public string Categoria { get; set; } // Ej: "Hombre", "Mujer", "Niña"

        public string ImagenUrl { get; set; } // Ruta al archivo de imagen

        public int Cantidad { get; set; }
        // Otros campos que podrías querer:
        // public string Talla { get; set; }
        // public int Stock { get; set; }
        // public string Descripcion { get; set; }
    }
}
