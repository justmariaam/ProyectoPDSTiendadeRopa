using System.ComponentModel.DataAnnotations;

namespace ProyectoTiendadeRopa.Models
{
    public class Administrador
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Usuario { get; set; }  // nombre o identificador del administrador

        [Required, EmailAddress]
        public string Correo { get; set; }

        [Required]
        public string Contrasena { get; set; }
    }
}
