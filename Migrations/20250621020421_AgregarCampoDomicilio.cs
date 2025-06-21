using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProyectoTiendadeRopa.Migrations
{
    /// <inheritdoc />
    public partial class AgregarCampoDomicilio : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Domicilio",
                table: "Usuarios",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Domicilio",
                table: "Usuarios");
        }
    }
}
