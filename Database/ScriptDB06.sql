-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: sistemacontable
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'f22385ab-f597-11f0-8758-2111f188d389:1-266';

--
-- Table structure for table `asientocontabledetalle`
--

DROP TABLE IF EXISTS `asientocontabledetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asientocontabledetalle` (
  `IdAsientoDetalle` int NOT NULL AUTO_INCREMENT,
  `IdAsiento` int NOT NULL,
  `IdCuentaContable` int NOT NULL,
  `TipoMovimiento` char(1) NOT NULL,
  `Monto` decimal(18,2) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IdAsientoDetalle`),
  KEY `fk_detalle_asiento` (`IdAsiento`),
  KEY `fk_detalle_cuenta` (`IdCuentaContable`),
  CONSTRAINT `fk_detalle_asiento` FOREIGN KEY (`IdAsiento`) REFERENCES `asientocontableencabezado` (`IdAsiento`),
  CONSTRAINT `fk_detalle_cuenta` FOREIGN KEY (`IdCuentaContable`) REFERENCES `cuentascontables` (`IdCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientocontabledetalle`
--

LOCK TABLES `asientocontabledetalle` WRITE;
/*!40000 ALTER TABLE `asientocontabledetalle` DISABLE KEYS */;
INSERT INTO `asientocontabledetalle` VALUES (1,5,1,'D',100.00,'Ingreso en efectivo'),(2,5,2,'C',100.00,'Servicio dado'),(3,6,1,'D',2000.00,'Ingreso en efectivo'),(4,6,2,'D',2000.00,'Cobro por servicio de mudanza');
/*!40000 ALTER TABLE `asientocontabledetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asientocontableencabezado`
--

DROP TABLE IF EXISTS `asientocontableencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asientocontableencabezado` (
  `IdAsiento` int NOT NULL AUTO_INCREMENT,
  `Consecutivo` int NOT NULL,
  `Fecha` date NOT NULL,
  `Codigo` varchar(50) NOT NULL,
  `Referencia` varchar(200) DEFAULT NULL,
  `IdPeriodo` int NOT NULL,
  `IdEstadoAsiento` int NOT NULL,
  `IdUsuario` int NOT NULL,
  PRIMARY KEY (`IdAsiento`),
  KEY `IdPeriodo` (`IdPeriodo`),
  KEY `IdEstadoAsiento` (`IdEstadoAsiento`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `asientocontableencabezado_ibfk_1` FOREIGN KEY (`IdPeriodo`) REFERENCES `periodocontable` (`IdPeriodo`),
  CONSTRAINT `asientocontableencabezado_ibfk_2` FOREIGN KEY (`IdEstadoAsiento`) REFERENCES `estadoasientocontable` (`IdEstadoAsiento`),
  CONSTRAINT `asientocontableencabezado_ibfk_3` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientocontableencabezado`
--

LOCK TABLES `asientocontableencabezado` WRITE;
/*!40000 ALTER TABLE `asientocontableencabezado` DISABLE KEYS */;
INSERT INTO `asientocontableencabezado` VALUES (1,1,'2026-01-31','','PRUEBA',1,5,1),(5,2,'2026-01-31','AS-0001','Prueba asiento caja vs ingresos',1,2,1),(6,3,'2026-02-02','AS-0001','Servicio de mudanza',1,1,1);
/*!40000 ALTER TABLE `asientocontableencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `IdBitacora` int NOT NULL AUTO_INCREMENT,
  `IdUsuarioAccion` int NOT NULL,
  `FechaBitacora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DescripcionAccion` varchar(300) NOT NULL,
  `ListadoAccion` json NOT NULL,
  PRIMARY KEY (`IdBitacora`),
  KEY `IdUsuarioAccion` (`IdUsuarioAccion`),
  CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`IdUsuarioAccion`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,1,'2026-01-27 10:30:00','Inicio de sesiÃƒÂ³n del usuario administrador','{\"accion\": \"login\", \"resultado\": \"exitoso\"}'),(2,1,'2026-01-28 13:48:56','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T19:48:55.9608118Z\", \"NombreUsuario\": \"Admin\"}'),(3,1,'2026-01-28 13:50:14','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T19:50:14.4146644Z\", \"NombreUsuario\": \"Admin\"}'),(4,1,'2026-01-28 14:04:54','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:04:54.5022614Z\", \"NombreUsuario\": \"Admin\"}'),(5,1,'2026-01-28 14:07:14','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:07:13.8706176Z\", \"NombreUsuario\": \"Admin\"}'),(6,1,'2026-01-28 14:10:45','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:10:45.1228141Z\", \"NombreUsuario\": \"Admin\"}'),(7,1,'2026-01-28 14:11:38','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:11:38.6245016Z\", \"NombreUsuario\": \"Admin\"}'),(8,1,'2026-01-28 14:12:03','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:12:02.8516398Z\", \"NombreUsuario\": \"Admin\"}'),(9,1,'2026-01-28 14:16:16','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:16:16.0510545Z\", \"NombreUsuario\": \"Admin\"}'),(10,1,'2026-01-28 14:20:11','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:20:11.5871789Z\", \"NombreUsuario\": \"Admin\"}'),(11,1,'2026-01-28 14:21:21','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:21:21.9405068Z\", \"NombreUsuario\": \"Admin\"}'),(12,1,'2026-01-28 14:23:32','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:23:32.239957Z\", \"NombreUsuario\": \"Admin\"}'),(13,1,'2026-01-28 14:25:54','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:25:54.2598528Z\", \"NombreUsuario\": \"Admin\"}'),(14,1,'2026-01-28 14:27:32','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:27:32.1829747Z\", \"NombreUsuario\": \"Admin\"}'),(15,1,'2026-01-28 14:27:41','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:27:41.1563772Z\", \"NombreUsuario\": \"Admin\"}'),(16,1,'2026-01-28 14:27:47','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:27:47.2299847Z\", \"NombreUsuario\": \"Admin\"}'),(17,1,'2026-01-28 14:35:23','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:35:23.3748054Z\", \"NombreUsuario\": \"Admin\"}'),(18,1,'2026-01-28 14:38:01','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:38:01.6933932Z\", \"NombreUsuario\": \"Admin\"}'),(19,1,'2026-01-28 14:39:29','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:39:29.0432969Z\", \"NombreUsuario\": \"Admin\"}'),(20,1,'2026-01-28 14:40:53','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:40:53.1694739Z\", \"NombreUsuario\": \"Admin\"}'),(21,1,'2026-01-28 14:44:08','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:44:08.3451385Z\", \"NombreUsuario\": \"Admin\"}'),(22,1,'2026-01-28 14:44:54','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:44:54.2925148Z\", \"NombreUsuario\": \"Admin\"}'),(23,1,'2026-01-28 14:45:23','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:45:23.2549058Z\", \"NombreUsuario\": \"Admin\"}'),(24,1,'2026-01-28 14:46:56','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:46:55.9901283Z\", \"NombreUsuario\": \"Admin\"}'),(25,1,'2026-01-28 14:47:49','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:47:49.2615955Z\", \"NombreUsuario\": \"Admin\"}'),(26,1,'2026-01-28 14:49:20','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:49:20.0566394Z\", \"NombreUsuario\": \"Admin\"}'),(27,1,'2026-01-28 14:50:11','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:50:11.2033068Z\", \"NombreUsuario\": \"Admin\"}'),(28,1,'2026-01-28 14:52:38','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T20:52:37.9025551Z\", \"NombreUsuario\": \"Admin\"}'),(29,1,'2026-01-28 14:52:39','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(30,1,'2026-01-28 15:01:49','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:01:49.1496137Z\", \"NombreUsuario\": \"Admin\"}'),(31,1,'2026-01-28 15:01:50','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(32,1,'2026-01-28 15:02:52','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:02:52.3223102Z\", \"NombreUsuario\": \"Admin\"}'),(33,1,'2026-01-28 15:02:54','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(34,1,'2026-01-28 15:04:51','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:04:50.9824307Z\", \"NombreUsuario\": \"Admin\"}'),(35,1,'2026-01-28 15:04:52','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(36,1,'2026-01-28 15:08:28','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:08:28.303243Z\", \"NombreUsuario\": \"Admin\"}'),(37,1,'2026-01-28 15:08:31','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(38,1,'2026-01-28 15:11:11','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:11:11.7216559Z\", \"NombreUsuario\": \"Admin\"}'),(39,1,'2026-01-28 15:11:13','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(40,1,'2026-01-28 15:13:37','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:13:37.0999748Z\", \"NombreUsuario\": \"Admin\"}'),(41,1,'2026-01-28 15:13:38','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(42,1,'2026-01-28 15:15:09','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:15:08.9597184Z\", \"NombreUsuario\": \"Admin\"}'),(43,1,'2026-01-28 15:15:10','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(44,1,'2026-01-28 15:16:36','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:16:36.1029688Z\", \"NombreUsuario\": \"Admin\"}'),(45,1,'2026-01-28 15:16:37','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(46,1,'2026-01-28 15:18:53','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:18:53.2598455Z\", \"NombreUsuario\": \"Admin\"}'),(47,1,'2026-01-28 15:18:55','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(48,1,'2026-01-28 15:19:20','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(49,1,'2026-01-28 15:29:55','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:29:55.4838624Z\", \"NombreUsuario\": \"Admin\"}'),(50,1,'2026-01-28 15:29:58','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(51,1,'2026-01-28 15:30:30','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(52,1,'2026-01-28 15:39:40','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:39:39.9115714Z\", \"NombreUsuario\": \"Admin\"}'),(53,1,'2026-01-28 15:39:46','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(54,1,'2026-01-28 15:39:57','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(55,1,'2026-01-28 15:50:44','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:50:44.3212586Z\", \"NombreUsuario\": \"Admin\"}'),(56,1,'2026-01-28 15:51:42','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:51:42.2861806Z\", \"NombreUsuario\": \"Admin\"}'),(57,1,'2026-01-28 15:53:01','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:53:01.1308968Z\", \"NombreUsuario\": \"Admin\"}'),(58,1,'2026-01-28 15:53:03','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(59,1,'2026-01-28 15:53:07','Consulta paginada de usuarios','{\"Pagina\": 1, \"UsuariosMostrados\": 1}'),(60,1,'2026-01-28 15:53:13','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T21:53:13.8845109Z\", \"NombreUsuario\": \"Admin\"}'),(61,1,'2026-01-28 16:09:14','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T22:09:14.0365815Z\", \"NombreUsuario\": \"Admin\"}'),(62,1,'2026-01-28 16:11:46','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T22:11:45.8491927Z\", \"NombreUsuario\": \"Admin\"}'),(63,1,'2026-01-28 16:11:50','Inicio de sesiÃƒÂ³n','{\"Fecha\": \"2026-01-28T22:11:50.0454082Z\", \"NombreUsuario\": \"Admin\"}');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentascontables`
--

DROP TABLE IF EXISTS `cuentascontables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentascontables` (
  `IdCuenta` int NOT NULL AUTO_INCREMENT,
  `CodigoCuenta` varchar(20) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Tipo` enum('Activo','Pasivo','Capital','Gasto','Ingreso') NOT NULL,
  `CuentaPadre` int DEFAULT NULL,
  `TipoSaldo` enum('Deudor','Acreedor') NOT NULL,
  `AceptaMovimiento` tinyint(1) NOT NULL,
  `Estado` enum('Activa','Inactiva') NOT NULL,
  PRIMARY KEY (`IdCuenta`),
  UNIQUE KEY `CodigoCuenta` (`CodigoCuenta`),
  KEY `CuentaPadre` (`CuentaPadre`),
  CONSTRAINT `cuentascontables_ibfk_1` FOREIGN KEY (`CuentaPadre`) REFERENCES `cuentascontables` (`IdCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentascontables`
--

LOCK TABLES `cuentascontables` WRITE;
/*!40000 ALTER TABLE `cuentascontables` DISABLE KEYS */;
INSERT INTO `cuentascontables` VALUES (1,'1.01.01','Caja General','Activo',NULL,'Deudor',1,'Activa'),(2,'4.01.01','Ingresos por Servicios','Ingreso',NULL,'Acreedor',1,'Activa');
/*!40000 ALTER TABLE `cuentascontables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoasientocontable`
--

DROP TABLE IF EXISTS `estadoasientocontable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadoasientocontable` (
  `IdEstadoAsiento` int NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(20) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Estado` enum('Activo','Inactivo') NOT NULL,
  PRIMARY KEY (`IdEstadoAsiento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoasientocontable`
--

LOCK TABLES `estadoasientocontable` WRITE;
/*!40000 ALTER TABLE `estadoasientocontable` DISABLE KEYS */;
INSERT INTO `estadoasientocontable` VALUES (1,'BOR','Borrador','Asiento no balanceado','Activo'),(2,'PEN','Pendiente de aprobacion','Asiento balanceado pendiente','Activo'),(3,'APR','Aprobado','Asiento aprobado','Activo'),(4,'REC','Rechazado','Asiento rechazado','Activo'),(5,'ANU','Anulado','Asiento anulado','Activo');
/*!40000 ALTER TABLE `estadoasientocontable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientoscontablesdetalles`
--

DROP TABLE IF EXISTS `movimientoscontablesdetalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientoscontablesdetalles` (
  `IdMovimiento` int NOT NULL AUTO_INCREMENT,
  `IdAsiento` int NOT NULL,
  `IdCuenta` int NOT NULL,
  `TipoMovimiento` enum('Debito','Credito') NOT NULL,
  `Monto` decimal(14,2) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`IdMovimiento`),
  KEY `IdAsiento` (`IdAsiento`),
  KEY `IdCuenta` (`IdCuenta`),
  CONSTRAINT `movimientoscontablesdetalles_ibfk_1` FOREIGN KEY (`IdAsiento`) REFERENCES `asientocontableencabezado` (`IdAsiento`),
  CONSTRAINT `movimientoscontablesdetalles_ibfk_2` FOREIGN KEY (`IdCuenta`) REFERENCES `cuentascontables` (`IdCuenta`),
  CONSTRAINT `movimientoscontablesdetalles_chk_1` CHECK ((`Monto` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientoscontablesdetalles`
--

LOCK TABLES `movimientoscontablesdetalles` WRITE;
/*!40000 ALTER TABLE `movimientoscontablesdetalles` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientoscontablesdetalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pantallas`
--

DROP TABLE IF EXISTS `pantallas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pantallas` (
  `IdPantalla` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(40) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Ruta` varchar(100) NOT NULL,
  `Estado` enum('Activa','Inactiva') NOT NULL,
  PRIMARY KEY (`IdPantalla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pantallas`
--

LOCK TABLES `pantallas` WRITE;
/*!40000 ALTER TABLE `pantallas` DISABLE KEYS */;
/*!40000 ALTER TABLE `pantallas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodocontable`
--

DROP TABLE IF EXISTS `periodocontable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodocontable` (
  `IdPeriodo` int NOT NULL AUTO_INCREMENT,
  `Anio` int NOT NULL,
  `Mes` int NOT NULL,
  `Estado` enum('Abierto','Cerrado') NOT NULL,
  `IdUsuarioCierre` int DEFAULT NULL,
  `FechaCierre` datetime DEFAULT NULL,
  PRIMARY KEY (`IdPeriodo`),
  UNIQUE KEY `Anio` (`Anio`,`Mes`),
  KEY `IdUsuarioCierre` (`IdUsuarioCierre`),
  CONSTRAINT `periodocontable_ibfk_1` FOREIGN KEY (`IdUsuarioCierre`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodocontable`
--

LOCK TABLES `periodocontable` WRITE;
/*!40000 ALTER TABLE `periodocontable` DISABLE KEYS */;
INSERT INTO `periodocontable` VALUES (1,2026,1,'Abierto',NULL,NULL);
/*!40000 ALTER TABLE `periodocontable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `IdRol` varchar(40) NOT NULL,
  `NombreRol` varchar(40) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Estado` enum('Activo','Inactivo') NOT NULL,
  PRIMARY KEY (`IdRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('ADMIN','Administrador','Acceso total al sistema','Activo'),('CONTADOR','Contador','Registro de asientos contables','Activo'),('CONTADOR_JEFE','Contador Jefe','Aprobacion y cierre contable','Activo');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolespantallas`
--

DROP TABLE IF EXISTS `rolespantallas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolespantallas` (
  `IdRol` varchar(40) NOT NULL,
  `IdPantalla` int NOT NULL,
  PRIMARY KEY (`IdRol`,`IdPantalla`),
  KEY `IdPantalla` (`IdPantalla`),
  CONSTRAINT `rolespantallas_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `roles` (`IdRol`),
  CONSTRAINT `rolespantallas_ibfk_2` FOREIGN KEY (`IdPantalla`) REFERENCES `pantallas` (`IdPantalla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolespantallas`
--

LOCK TABLES `rolespantallas` WRITE;
/*!40000 ALTER TABLE `rolespantallas` DISABLE KEYS */;
/*!40000 ALTER TABLE `rolespantallas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(100) NOT NULL,
  `ClaveCifrada` varbinary(240) NOT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  `ApellidoUsuario` varchar(50) NOT NULL,
  `CorreoElectronico` varchar(100) NOT NULL,
  `TagAutenticacion` varbinary(16) NOT NULL,
  `Nonce` varbinary(12) NOT NULL,
  `Estado` enum('Activo','Inactivo','Bloqueado') NOT NULL,
  `IntentosFallidos` int DEFAULT '0',
  `UltimoIntento` datetime DEFAULT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `Usuario` (`Usuario`),
  UNIQUE KEY `CorreoElectronico` (`CorreoElectronico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin',0x639583BCEAD5D722B1,'Admin','Admin','admin@correo.com', 0x9FFBCEEBCBB1879679EE6707EC473EFF, 0xD313E86DDB3593A97A9C41CE,'Activo',0,'2026-01-28 16:12:13');/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariosroles`
--

DROP TABLE IF EXISTS `usuariosroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuariosroles` (
  `IdUsuario` int NOT NULL,
  `IdRol` varchar(40) NOT NULL,
  PRIMARY KEY (`IdUsuario`,`IdRol`),
  KEY `IdRol` (`IdRol`),
  CONSTRAINT `usuariosroles_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `usuariosroles_ibfk_2` FOREIGN KEY (`IdRol`) REFERENCES `roles` (`IdRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosroles`
--

LOCK TABLES `usuariosroles` WRITE;
/*!40000 ALTER TABLE `usuariosroles` DISABLE KEYS */;
INSERT INTO `usuariosroles` VALUES (1,'ADMIN');
/*!40000 ALTER TABLE `usuariosroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sistemacontable'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_asientos_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asientos_listar`(
    IN p_id_periodo INT,
    IN p_id_estado INT,      -- NULL = todos
    IN p_offset INT          -- (pagina - 1) * 10
)
BEGIN
    SELECT
        a.IdAsientoEncabezado,
        a.Consecutivo,
        a.FechaAsiento,
        a.Referencia,
        a.IdEstadoAsiento
    FROM asientocontableencabezado a
    WHERE a.IdPeriodo = p_id_periodo
      AND a.Activo = 1
      AND (p_id_estado IS NULL OR a.IdEstadoAsiento = p_id_estado)
    ORDER BY a.FechaAsiento DESC
    LIMIT 10 OFFSET p_offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asientos_listar_por_periodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asientos_listar_por_periodo`(
    IN p_id_periodo INT
)
BEGIN
    SELECT 
        a.IdAsiento,
        a.Consecutivo,
        a.Codigo,
        a.Fecha,
        a.Referencia,
        a.IdEstadoAsiento,
        e.Nombre AS EstadoNombre,
        CASE 
            WHEN IFNULL(SUM(
                CASE d.TipoMovimiento
                    WHEN 'D' THEN d.Monto
                    WHEN 'C' THEN -d.Monto
                END
            ), 0) = 0 THEN 1
            ELSE 0
        END AS EstaBalanceado
    FROM asientocontableencabezado a
    INNER JOIN estadoasientocontable e
        ON a.IdEstadoAsiento = e.IdEstadoAsiento
    LEFT JOIN asientocontabledetalle d
        ON d.IdAsiento = a.IdAsiento
    WHERE a.IdPeriodo = p_id_periodo
    GROUP BY
        a.IdAsiento,
        a.Consecutivo,
        a.Codigo,
        a.Fecha,
        a.Referencia,
        a.IdEstadoAsiento,
        e.Nombre
    ORDER BY a.Fecha DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_actualizar_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_actualizar_estado`(
    IN p_id_asiento INT,
    IN p_id_estado INT
)
BEGIN
    UPDATE asiento_contable_encabezado
    SET IdEstadoAsiento = p_id_estado
    WHERE IdAsientoEncabezado = p_id_asiento
      AND IdEstadoAsiento IN (1, 2) -- 1=Borrador, 2=Pendiente
      AND Activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_anular` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_anular`(
    IN p_id_asiento INT
)
BEGIN
    UPDATE asientocontableencabezado
    SET IdEstadoAsiento = 5 -- ANULADO
    WHERE IdAsiento = p_id_asiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_insertar_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_insertar_detalle`(
    IN p_id_asiento INT,
    IN p_id_cuenta INT,
    IN p_tipo_mov CHAR(1),
    IN p_monto DECIMAL(18,2),
    IN p_descripcion VARCHAR(255)
)
BEGIN
    INSERT INTO asientocontabledetalle
    (IdAsiento, IdCuentaContable, TipoMovimiento, Monto, Descripcion)
    VALUES
    (p_id_asiento, p_id_cuenta, p_tipo_mov, p_monto, p_descripcion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_insertar_encabezado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_insertar_encabezado`(
    IN p_id_periodo INT,
    IN p_id_usuario INT,
    IN p_fecha DATE,
    IN p_codigo VARCHAR(50),
    IN p_referencia VARCHAR(200),
    IN p_id_estado INT,
    OUT p_id_asiento INT
)
BEGIN
    DECLARE v_consecutivo INT;

    SELECT IFNULL(MAX(Consecutivo), 0) + 1
    INTO v_consecutivo
    FROM asientocontableencabezado
    WHERE IdPeriodo = p_id_periodo;

    INSERT INTO asientocontableencabezado
    (
        Consecutivo, Fecha, Codigo, Referencia,
        IdPeriodo, IdEstadoAsiento, IdUsuario
    )
    VALUES
    (
        v_consecutivo, p_fecha, p_codigo, p_referencia,
        p_id_periodo, p_id_estado, p_id_usuario
    );

    SET p_id_asiento = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_listar_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_listar_detalle`(
    IN p_id_asiento INT
)
BEGIN
    SELECT
        d.IdAsientoDetalle,
        c.CodigoCuenta AS Cuenta,
        d.TipoMovimiento,
        d.Monto,
        d.Descripcion
    FROM asientocontabledetalle d
    INNER JOIN cuentascontables c
        ON c.IdCuenta = d.IdCuentaContable
    WHERE d.IdAsiento = p_id_asiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_sumatoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_sumatoria`(
    IN p_id_asiento INT
)
BEGIN
    SELECT
        SUM(CASE WHEN TipoMovimiento = 'D' THEN Monto ELSE 0 END) AS TotalDebito,
        SUM(CASE WHEN TipoMovimiento = 'C' THEN Monto ELSE 0 END) AS TotalCredito
    FROM asientocontabledetalle
    WHERE IdAsientoEncabezado = p_id_asiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_sumatorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asiento_sumatorias`(
    IN p_id_asiento INT
)
BEGIN
    SELECT
        SUM(CASE WHEN TipoMovimiento = 'Debito'  THEN Monto ELSE 0 END) AS TotalDebito,
        SUM(CASE WHEN TipoMovimiento = 'Credito' THEN Monto ELSE 0 END) AS TotalCredito
    FROM movimientoscontablesdetalles
    WHERE IdAsiento = p_id_asiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BitacoraInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_BitacoraInsertar`(
    IN pI_IdUsuarioAccion INT,
    IN pI_DescripcionAccion VARCHAR(300),
    IN pI_ListadoAccion JSON
)
BEGIN
    INSERT INTO bitacora (
        IdUsuarioAccion,
        DescripcionAccion,
        ListadoAccion
    )
    VALUES (
        pI_IdUsuarioAccion,
        pI_DescripcionAccion,
        pI_ListadoAccion
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BitacoraListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_BitacoraListar`()
BEGIN
    SELECT 
        IdBitacora,
        IdUsuarioAccion,
        FechaBitacora,
        DescripcionAccion,
        ListadoAccion
    FROM bitacora
    ORDER BY FechaBitacora DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BitacoraListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_BitacoraListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdBitacora,
        IdUsuarioAccion,
        FechaBitacora,
        DescripcionAccion,
        ListadoAccion
    FROM bitacora
    ORDER BY FechaBitacora DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegistrarIntentoFallido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_RegistrarIntentoFallido`(
    IN pI_usuario VARCHAR(100),
    OUT pS_resultado INT
)
BEGIN
    UPDATE usuarios
    SET
        IntentosFallidos = IF(IntentosFallidos < 4, IntentosFallidos + 1, IntentosFallidos),
        UltimoIntento = NOW(),
        Estado = IF(IntentosFallidos + 1 >= 4, 'Bloqueado', Estado)
    WHERE Usuario = pI_usuario
      AND IntentosFallidos < 3;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ReiniciarIntentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_ReiniciarIntentos`(
    IN pI_usuario VARCHAR(100)
)
BEGIN
    UPDATE usuarios
    SET
        IntentosFallidos = 0,
        UltimoIntento = NULL
    WHERE Usuario = pI_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosActualizarPorIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosActualizarPorIdUsuario`(
    IN pI_id_usuario INT,
    IN pI_usuario VARCHAR(100),
    IN pI_nombre_usuario VARCHAR(50),
    IN pI_apellido_usuario VARCHAR(50),
    IN pI_correo_electronico VARCHAR(100),
    IN pI_estado ENUM('Activo','Inactivo','Bloqueado'),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    UPDATE usuarios
    SET
        Usuario = pI_usuario,
        NombreUsuario = pI_nombre_usuario,
        ApellidoUsuario = pI_apellido_usuario,
        CorreoElectronico = pI_correo_electronico,
        Estado = pI_estado
    WHERE IdUsuario = pI_id_usuario;

    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosConteo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosConteo`()
BEGIN
    SELECT COUNT(*) AS Total FROM usuarios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosEliminarPorIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosEliminarPorIdUsuario`(
    IN pI_id_usuario INT,
    OUT pS_resultado INT
)
BEGIN
    DELETE FROM usuarios
    WHERE IdUsuario = pI_id_usuario;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosInsertar`(
    IN pI_usuario VARCHAR(100),
    IN pI_clave_cifrada VARBINARY(240),
    IN pI_nombre_usuario VARCHAR(50),
    IN pI_apellido_usuario VARCHAR(50),
    IN pI_correo_electronico VARCHAR(100),
    IN pI_tag VARBINARY(16),
    IN pI_nonce VARBINARY(12),
    IN pI_estado ENUM('Activo','Inactivo','Bloqueado'),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    INSERT INTO usuarios (
        Usuario,
        ClaveCifrada,
        NombreUsuario,
        ApellidoUsuario,
        CorreoElectronico,
        TagAutenticacion,
        Nonce,
        Estado
    )
    VALUES (
        pI_usuario,
        pI_clave_cifrada,
        pI_nombre_usuario,
        pI_apellido_usuario,
        pI_correo_electronico,
        pI_tag,
        pI_nonce,
        pI_estado
    );

    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosListar`()
BEGIN
    SELECT 
        IdUsuario,
        Usuario,
        NombreUsuario,
        ApellidoUsuario,
        CorreoElectronico,
        Estado,
        IntentosFallidos,
        UltimoIntento
    FROM usuarios
    ORDER BY IdUsuario DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdUsuario,
        Usuario,
        NombreUsuario,
        ApellidoUsuario,
        CorreoElectronico,
        Estado,
        IntentosFallidos,
        UltimoIntento
    FROM usuarios
    ORDER BY IdUsuario DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosListarPorIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_UsuariosListarPorIdUsuario`(
    IN pI_id_usuario INT
)
BEGIN
    SELECT 
        IdUsuario,
        Usuario,
        NombreUsuario,
        ApellidoUsuario,
        CorreoElectronico,
        Estado,
        IntentosFallidos,
        UltimoIntento
    FROM usuarios
    WHERE IdUsuario = pI_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VerificarCredencial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontable`@`localhost` PROCEDURE `sp_VerificarCredencial`(
    IN pI_usuario VARCHAR(100)
)
BEGIN
    SELECT 
        IdUsuario,
        Usuario,
        NombreUsuario,
        ApellidoUsuario,
        CorreoElectronico,
        ClaveCifrada,
        TagAutenticacion,
        Nonce,
        Estado,
        1 AS encontrado
    FROM usuarios
    WHERE Usuario = pI_usuario
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-02 20:30:16
