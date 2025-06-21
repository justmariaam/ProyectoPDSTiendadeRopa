using System.ComponentModel.DataAnnotations;

namespace ProyectoTiendadeRopa.Models
{
    public class Usuario
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Nombre { get; set; }

        [Required]
        public string Correo { get; set; }

        [Required]
        public string Contrasena { get; set; }

        [Required]
        public string Domicilio { get; set; }  // Campo nuevo
    }
}
