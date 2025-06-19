using System;
using System.Collections.Generic;

namespace ProyectoTiendadeRopa.Models
{
    public class Pedido
    {
        public int Id { get; set; }
        public int UsuarioId { get; set; }
        public string NombreCliente { get; set; }
        public string Direccion { get; set; }
        public string MetodoPago { get; set; }
        public DateTime FechaPedido { get; set; } = DateTime.Now;
        public decimal Total { get; set; }
        public string Estado { get; set; } = "En proceso";


        public List<DetallePedido> Detalles { get; set; }

        public Usuario Usuario { get; set; }
    }
}
