-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: proyectotiendadb
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20250617225620_InitialCreate','8.0.13'),('20250618011146_CarritoYItems','8.0.13'),('20250618011237_AddTablaProducto','8.0.13'),('20250618023332_CrearTablaProductos','8.0.13'),('20250618061443_CrearTablaPedidos','8.0.13'),('20250618171933_CrearTablaAdministrador','8.0.13');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administradores`
--

DROP TABLE IF EXISTS `administradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administradores` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Usuario` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Correo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Contrasena` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administradores`
--

LOCK TABLES `administradores` WRITE;
/*!40000 ALTER TABLE `administradores` DISABLE KEYS */;
INSERT INTO `administradores` VALUES (1,'admiHector','h@gmail.com','Michel1985#'),(2,'admiMarian','m@gmail.com','Michel1985#'),(3,'admiLucas','lc@gmail.com','Michel1985#'),(4,'admiLana','lanaR@gmail.com','Michel1985#');
/*!40000 ALTER TABLE `administradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carritos`
--

DROP TABLE IF EXISTS `carritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carritos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UsuarioId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Carritos_UsuarioId` (`UsuarioId`),
  CONSTRAINT `FK_Carritos_Usuarios_UsuarioId` FOREIGN KEY (`UsuarioId`) REFERENCES `usuarios` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carritos`
--

LOCK TABLES `carritos` WRITE;
/*!40000 ALTER TABLE `carritos` DISABLE KEYS */;
INSERT INTO `carritos` VALUES (1,1),(4,4);
/*!40000 ALTER TABLE `carritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallespedido`
--

DROP TABLE IF EXISTS `detallespedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallespedido` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `PedidoId` int NOT NULL,
  `NombreProducto` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Categoria` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Cantidad` int NOT NULL,
  `PrecioUnitario` decimal(65,30) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_DetallesPedido_PedidoId` (`PedidoId`),
  CONSTRAINT `FK_DetallesPedido_Pedidos_PedidoId` FOREIGN KEY (`PedidoId`) REFERENCES `pedidos` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallespedido`
--

LOCK TABLES `detallespedido` WRITE;
/*!40000 ALTER TABLE `detallespedido` DISABLE KEYS */;
INSERT INTO `detallespedido` VALUES (1,1,'Blusa con cuello en V, color verde','Mujer',2,450.000000000000000000000000000000),(2,1,'Pijama color vino para Mujer','Mujer',1,450.000000000000000000000000000000),(3,1,'Bolso clásico Chanel','Mujer',2,5550.000000000000000000000000000000),(4,1,'Sudadera con Capucha Puma','Hombre',1,350.000000000000000000000000000000),(5,2,'Blusa con cuello en V, color verde','Mujer',3,450.000000000000000000000000000000),(6,2,'Overol de verano color verde','Bebes',3,187.000000000000000000000000000000),(7,2,'Sudadera con Capucha Puma','Hombre',1,350.000000000000000000000000000000),(8,2,'Vestido de Princesa ','Niña',1,780.000000000000000000000000000000),(9,2,'Traje de Monster Inc','Bebes',2,500.000000000000000000000000000000),(10,2,'Chamarra Vaquera casual','Mujer',1,295.000000000000000000000000000000),(11,2,'Camisa de hombre marga larga','Hombre',3,645.000000000000000000000000000000),(15,4,'Blusa con cuello en V, color verde','Mujer',3,450.000000000000000000000000000000),(16,4,'Vestido de Fiesta sin Mangas de Tul con Lentejuela color morado','Niña',1,1000.000000000000000000000000000000),(17,4,'Traje de Monster Inc','Bebes',1,500.000000000000000000000000000000),(18,4,'Sueter de fresas','Mujer',3,278.000000000000000000000000000000),(19,4,'Chaqueta de protección solar editado','Hombre',2,220.000000000000000000000000000000),(20,5,'Chaqueta de protección solar editado','Hombre',1,220.000000000000000000000000000000),(21,5,'Pantalones de mezclilla holgados','Hombre',2,400.000000000000000000000000000000),(22,5,'Camisa de Golf ','Hombre',1,130.000000000000000000000000000000);
/*!40000 ALTER TABLE `detallespedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemscarrito`
--

DROP TABLE IF EXISTS `itemscarrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemscarrito` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `CarritoId` int NOT NULL,
  `ProductoId` int NOT NULL,
  `Cantidad` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_ItemsCarrito_CarritoId` (`CarritoId`),
  KEY `IX_ItemsCarrito_ProductoId` (`ProductoId`),
  CONSTRAINT `FK_ItemsCarrito_Carritos_CarritoId` FOREIGN KEY (`CarritoId`) REFERENCES `carritos` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ItemsCarrito_Productos_ProductoId` FOREIGN KEY (`ProductoId`) REFERENCES `productos` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemscarrito`
--

LOCK TABLES `itemscarrito` WRITE;
/*!40000 ALTER TABLE `itemscarrito` DISABLE KEYS */;
INSERT INTO `itemscarrito` VALUES (39,1,206,1),(40,1,207,1),(41,1,210,1);
/*!40000 ALTER TABLE `itemscarrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UsuarioId` int NOT NULL,
  `NombreCliente` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Direccion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MetodoPago` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FechaPedido` datetime(6) NOT NULL,
  `Total` decimal(65,30) NOT NULL,
  `Estado` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Pedidos_UsuarioId` (`UsuarioId`),
  CONSTRAINT `FK_Pedidos_Usuarios_UsuarioId` FOREIGN KEY (`UsuarioId`) REFERENCES `usuarios` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,'Marian Colorado','Xalapa Veracruz, CP 91170 #120','Efectivo','2025-06-18 00:17:30.474230',12800.000000000000000000000000000000,'Pendiente'),(2,1,'Mariana Hernández','Xalapa Veracruz, CP 91170, #67','Tarjeta','2025-06-18 16:23:51.817657',6271.000000000000000000000000000000,'Pendiente'),(4,1,'Marian Colorado','Xalapa Veracruz, Cp 91170, #120','Efectivo','2025-06-18 16:36:45.713768',4124.000000000000000000000000000000,'Pendiente'),(5,4,'Lucas Chivis','Xalapa Veracruz, CP 7890, #67','Otro','2025-06-18 16:38:37.544582',1150.000000000000000000000000000000,'Pendiente');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  `Categoria` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ImagenUrl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Cantidad` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (205,'Sudadera con Capucha Puma',350.00,'Hombre','sudaderapuma.png',100),(206,'Blusa con cuello en V, color verde',450.00,'Mujer','blusacuelloV.png',50),(207,'Vestido floreado corto',550.00,'Mujer','vestidof.png',100),(208,'Jeans MidBlue',250.00,'Mujer','MidBlue.png',34),(209,'Traje de Fiesta',550.00,'Bebes','TrajeBB.png',87),(210,'Conjunto de Verano para bebé',550.00,'Bebes','TrajeBBC.png',10),(211,'BodySuit con gorro de Monster Inc',550.00,'Bebes','TrajeBBV.png',89),(212,'BodySuit con gorro de Toy Story',500.00,'Bebes','TrajeBBW.png',78),(213,'BodySuit con gorro de Cars',500.00,'Bebes','TrajeBBCa.png',65),(214,'Traje de Monster Inc',500.00,'Bebes','TrajeBBMI.png',37),(215,'Overol de verano',347.00,'Bebes','TrajeBBOV.png',86),(216,'Overol de verano color verde',187.00,'Bebes','TrajeBBON.png',67),(217,'Mameluco tipo kimono',640.00,'Bebes','TrajeBBK.png',43),(218,'Vestido básico de Manga Corta Vestido para Niñas Color Rojo',780.00,'Niña','VestidoRN.png',23),(219,'Vestido básico de Manga Corta Vestido para Niñas Color Morado',780.00,'Niña','VestidMN.png',24),(220,'Vestido de Fiesta sin Mangas de Tul con Lentejuela color morado',1000.00,'Niña','VestidoFiestaMN.png',19),(221,'Vestido de Fiesta sin Mangas de Tul con Lentejuela color azul',780.00,'Niña','VestidoFiestaAN.png',23),(222,'Vestido de verano para niñas ',670.00,'Niña','VestidoVeranoAN.png',67),(223,'Vestido de Princesa de Lujo',1780.00,'Niña','VestidoPrincess.png',23),(224,'Vestido Vintage color amarillo',980.00,'Niña','VestidoVintageA.png',87),(225,'Vestido de Princesa ',780.00,'Niña','VestidoPrincess2.png',13),(226,'Vestido de verano para niñas color Vino',780.00,'Niña','VestidoVeranoMN.png',23),(227,'Falda color negro corto',377.00,'Mujer','FaldaM.png',12),(228,'Blusa casual de Manga larga',634.00,'Mujer','BlusaM.png',90),(229,'Chamarra Vaquera casual',295.00,'Mujer','ChamarraM.png',100),(230,'Pantalones de vestir',377.00,'Mujer','PantalonM.png',16),(231,'Sueter de fresas',278.00,'Mujer','SueterM.png',35),(232,'Playera corta básica',294.00,'Mujer','Blusa2M.png',79),(233,'Camisa de hombre marga larga',645.00,'Hombre','CamisaH.png',60),(234,'Camisa de hombre marga larga',434.00,'Hombre','CamisaMangaLH.png',267),(235,'Camisa de Golf ',130.00,'Hombre','CamisaGH.png',100),(236,'Pantalones de mezclilla holgados',400.00,'Hombre','PantalonesH.png',50),(237,'Chaqueta de protección solar editado',220.00,'Hombre','Chaqueta2H.png',98),(238,'Conjunto de 2 piezas de camisa y pantalones cortos',231.00,'Hombre','CMH.png',80),(239,'Bolso clásico Chanel',5550.00,'Mujer','chanel.png',456),(240,'Chaquetas clásico de lana para hombre',700.00,'Hombre','ChaquetaH.png',19),(241,'Suéter de manga larga con cuello redondo para hombre',500.00,'Hombre','SueterH.png',10),(242,'Marvel Casual Conjunto de Pijama',300.00,'Niña','PijamaM.png',23),(243,'Pijama color vino para Mujer',450.00,'Mujer','PijamaA.png',189),(248,'Bolsa Birkin de mano',39999.00,'Mujer','4ef243eb-b31e-49c9-8d9a-acdb4d660417.png',90),(250,'Pijama Rosa Palo de Mujer',500.00,'Mujer','d3e611f2-38e8-4627-be3f-540b4c64dcaf.png',90);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Correo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Contrasena` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Marian','mhdez914@gmail.com','Michel1985#'),(4,'Lucas Chivis','l@gmail.com','Michel1985#');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-18 21:46:25
