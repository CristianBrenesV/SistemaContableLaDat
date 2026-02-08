-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: tiusr10pl.cuc-carrera-ti.ac.cr    Database: tiusr10pl_siscontableladat
-- ------------------------------------------------------
-- Server version	5.5.5-10.5.29-MariaDB

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
-- Table structure for table `asientocontabledetalle`
--

DROP TABLE IF EXISTS `asientocontabledetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asientocontabledetalle` (
  `IdAsientoDetalle` int(11) NOT NULL AUTO_INCREMENT,
  `IdAsiento` int(11) NOT NULL,
  `IdCuentaContable` int(11) NOT NULL,
  `TipoMovimiento` char(1) NOT NULL,
  `Monto` decimal(18,2) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IdAsientoDetalle`),
  KEY `fk_detalle_asiento` (`IdAsiento`),
  KEY `fk_detalle_cuenta` (`IdCuentaContable`),
  CONSTRAINT `fk_detalle_asiento` FOREIGN KEY (`IdAsiento`) REFERENCES `asientocontableencabezado` (`IdAsiento`),
  CONSTRAINT `fk_detalle_cuenta` FOREIGN KEY (`IdCuentaContable`) REFERENCES `cuentascontables` (`IdCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientocontabledetalle`
--

LOCK TABLES `asientocontabledetalle` WRITE;
/*!40000 ALTER TABLE `asientocontabledetalle` DISABLE KEYS */;
INSERT INTO `asientocontabledetalle` VALUES (3,1,1,'D',200000.00,'Pago de servicios de alquiler'),(4,1,2,'C',200000.00,'Cobro por alquiler de propiedad');
/*!40000 ALTER TABLE `asientocontabledetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asientocontableencabezado`
--

DROP TABLE IF EXISTS `asientocontableencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asientocontableencabezado` (
  `IdAsiento` int(11) NOT NULL AUTO_INCREMENT,
  `Consecutivo` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Codigo` varchar(50) NOT NULL,
  `Referencia` varchar(200) DEFAULT NULL,
  `IdPeriodo` int(11) NOT NULL,
  `IdEstadoAsiento` int(11) NOT NULL,
  `IdUsuario` int(11) NOT NULL,
  PRIMARY KEY (`IdAsiento`),
  KEY `IdPeriodo` (`IdPeriodo`),
  KEY `IdEstadoAsiento` (`IdEstadoAsiento`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `asientocontableencabezado_ibfk_1` FOREIGN KEY (`IdPeriodo`) REFERENCES `periodocontable` (`IdPeriodo`),
  CONSTRAINT `asientocontableencabezado_ibfk_2` FOREIGN KEY (`IdEstadoAsiento`) REFERENCES `estadoasientocontable` (`IdEstadoAsiento`),
  CONSTRAINT `asientocontableencabezado_ibfk_3` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientocontableencabezado`
--

LOCK TABLES `asientocontableencabezado` WRITE;
/*!40000 ALTER TABLE `asientocontableencabezado` DISABLE KEYS */;
INSERT INTO `asientocontableencabezado` VALUES (1,1,'2026-02-08','AS-0001','Pago alquiler mes actual',1,2,1);
/*!40000 ALTER TABLE `asientocontableencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `IdBitacora` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuarioAccion` int(11) NOT NULL,
  `FechaBitacora` datetime NOT NULL DEFAULT current_timestamp(),
  `DescripcionAccion` varchar(300) NOT NULL,
  `ListadoAccion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ListadoAccion`)),
  PRIMARY KEY (`IdBitacora`),
  KEY `IdUsuarioAccion` (`IdUsuarioAccion`),
  CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`IdUsuarioAccion`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,1,'2026-02-08 12:23:08','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:23:08.0715385Z\"}'),(2,1,'2026-02-08 12:30:35','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:30:35.2494137Z\"}'),(3,1,'2026-02-08 12:41:32','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:41:32.258094Z\"}'),(4,1,'2026-02-08 12:41:43','Consulta de asientos','{\"idPeriodo\":1}'),(5,1,'2026-02-08 12:42:12','Consulta de asientos','{\"idPeriodo\":1}'),(6,1,'2026-02-08 12:44:57','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:44:57.4548546Z\"}'),(7,1,'2026-02-08 12:45:01','Consulta de asientos','{\"idPeriodo\":1}'),(8,1,'2026-02-08 12:50:57','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:50:57.2762808Z\"}'),(9,1,'2026-02-08 12:50:59','Consulta de asientos','{\"idPeriodo\":1}'),(10,1,'2026-02-08 14:11:54','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T20:11:53.695801Z\"}'),(11,1,'2026-02-08 14:11:59','Consulta de asientos','{\"idPeriodo\":1}'),(12,1,'2026-02-08 14:12:01','Consulta de asientos','{\"idPeriodo\":1}'),(13,1,'2026-02-08 14:12:03','Consulta paginada de usuarios','{\"Pagina\":1,\"UsuariosMostrados\":1}'),(14,1,'2026-02-08 14:12:05','Consulta de asientos','{\"idPeriodo\":1}'),(15,1,'2026-02-08 14:12:50','CreaciÃ³n de asiento','{\"encabezado\":{\"IdAsiento\":0,\"Consecutivo\":0,\"Fecha\":\"2026-02-08T00:00:00\",\"Codigo\":\"AS-0001\",\"Referencia\":\"Pago alquiler mes actual\",\"IdPeriodo\":1,\"IdEstadoAsiento\":2,\"IdUsuario\":1,\"Detalles\":[]},\"detalles\":[{\"IdAsientoDetalle\":0,\"IdAsiento\":1,\"IdCuentaContable\":1,\"TipoMovimiento\":\"D\",\"Monto\":250000.0,\"Descripcion\":\"Pago de servicios de alquiler\"},{\"IdAsientoDetalle\":0,\"IdAsiento\":1,\"IdCuentaContable\":2,\"TipoMovimiento\":\"C\",\"Monto\":250000.0,\"Descripcion\":\"Cobro por alquiler de propiedad\"}]}'),(16,1,'2026-02-08 14:12:50','Consulta de asientos','{\"idPeriodo\":1}'),(17,1,'2026-02-08 14:14:38','EdiciÃ³n de asiento','{\"Antes\":{\"Encabezado\":{\"IdAsiento\":1,\"Consecutivo\":1,\"Fecha\":\"2026-02-08T00:00:00\",\"Codigo\":\"AS-0001\",\"Referencia\":\"Pago alquiler mes actual\",\"IdPeriodo\":1,\"IdEstadoAsiento\":2,\"IdUsuario\":1,\"Detalles\":[]},\"Detalles\":[{\"IdAsientoDetalle\":1,\"IdAsiento\":1,\"IdCuentaContable\":1,\"TipoMovimiento\":\"D\",\"Monto\":250000.00,\"Descripcion\":\"Pago de servicios de alquiler\"},{\"IdAsientoDetalle\":2,\"IdAsiento\":1,\"IdCuentaContable\":2,\"TipoMovimiento\":\"C\",\"Monto\":250000.00,\"Descripcion\":\"Cobro por alquiler de propiedad\"}]},\"Despues\":{\"encabezado\":{\"IdAsiento\":1,\"Consecutivo\":1,\"Fecha\":\"2026-02-08T00:00:00\",\"Codigo\":\"AS-0001\",\"Referencia\":\"Pago alquiler mes actual\",\"IdPeriodo\":1,\"IdEstadoAsiento\":2,\"IdUsuario\":0,\"Detalles\":[]},\"detalles\":[{\"IdAsientoDetalle\":1,\"IdAsiento\":1,\"IdCuentaContable\":1,\"TipoMovimiento\":\"D\",\"Monto\":200000.0,\"Descripcion\":\"Pago de servicios de alquiler\"},{\"IdAsientoDetalle\":2,\"IdAsiento\":1,\"IdCuentaContable\":2,\"TipoMovimiento\":\"C\",\"Monto\":200000.0,\"Descripcion\":\"Cobro por alquiler de propiedad\"}]}}'),(18,1,'2026-02-08 14:14:39','Consulta de asientos','{\"idPeriodo\":1}'),(19,1,'2026-02-08 14:14:55','Consulta de asientos','{\"idPeriodo\":1}'),(20,1,'2026-02-08 14:55:26','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T20:55:26.5477274Z\\\"}\"'),(21,1,'2026-02-08 14:56:16','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T20:56:16.4356217Z\\\"}\"'),(22,1,'2026-02-08 14:59:45','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T20:59:44.6346475Z\"}'),(23,1,'2026-02-08 15:01:56','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:01:56.4530667Z\"}'),(24,1,'2026-02-08 15:01:59','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(25,1,'2026-02-08 15:03:37','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:03:37.6918522Z\"}'),(26,1,'2026-02-08 15:03:39','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(27,1,'2026-02-08 15:05:47','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:05:47.042841Z\"}'),(28,1,'2026-02-08 15:05:49','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(29,1,'2026-02-08 15:08:55','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:08:55.5842391Z\"}'),(30,1,'2026-02-08 15:08:57','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(31,1,'2026-02-08 15:14:07','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:14:06.9959592Z\"}'),(32,1,'2026-02-08 15:14:09','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(33,1,'2026-02-08 15:14:26','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(34,1,'2026-02-08 15:14:33','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":1}'),(35,1,'2026-02-08 15:14:35','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":1}'),(36,1,'2026-02-08 15:14:38','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":2}'),(37,1,'2026-02-08 15:14:42','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":3}'),(38,1,'2026-02-08 15:14:50','Consulta paginada de usuarios','{\"Pagina\":1,\"UsuariosMostrados\":1}'),(39,1,'2026-02-08 15:14:54','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(40,1,'2026-02-08 15:15:04','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(41,1,'2026-02-08 15:15:05','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(42,1,'2026-02-08 15:15:09','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(43,1,'2026-02-08 15:16:42','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:16:42.6095858Z\\\"}\"'),(44,1,'2026-02-08 15:23:43','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:23:42.9757666Z\\\"}\"'),(45,1,'2026-02-08 15:24:40','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:24:39.9658223Z\\\"}\"'),(46,1,'2026-02-08 15:25:00','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(47,1,'2026-02-08 15:26:00','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:26:00.496245Z\\\"}\"'),(48,1,'2026-02-08 15:26:04','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(49,1,'2026-02-08 15:26:19','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(50,1,'2026-02-08 15:26:23','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(51,1,'2026-02-08 15:26:26','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(52,1,'2026-02-08 15:26:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(53,1,'2026-02-08 15:26:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(54,1,'2026-02-08 15:27:00','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(55,1,'2026-02-08 15:27:06','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(56,1,'2026-02-08 15:27:19','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:27:19.5992314Z\"}'),(57,1,'2026-02-08 15:29:24','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:29:23.7960276Z\\\"}\"'),(58,1,'2026-02-08 15:32:12','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:32:12.3015529Z\\\"}\"'),(59,1,'2026-02-08 15:32:15','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(60,1,'2026-02-08 15:33:57','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:33:57.867524Z\\\"}\"'),(61,1,'2026-02-08 15:33:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(62,1,'2026-02-08 15:33:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(63,1,'2026-02-08 15:34:05','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(64,1,'2026-02-08 15:34:40','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(65,1,'2026-02-08 15:34:43','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(66,1,'2026-02-08 15:34:45','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(67,1,'2026-02-08 15:35:28','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:35:28.6225414Z\\\"}\"'),(68,1,'2026-02-08 15:35:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(69,1,'2026-02-08 15:36:37','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(70,1,'2026-02-08 15:36:42','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(71,1,'2026-02-08 15:36:43','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(72,1,'2026-02-08 15:36:46','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(73,1,'2026-02-08 15:36:48','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(74,1,'2026-02-08 15:43:05','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:43:05.5427537Z\\\"}\"'),(75,1,'2026-02-08 15:43:08','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(76,1,'2026-02-08 15:43:23','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(77,1,'2026-02-08 15:49:27','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:49:27.7097547Z\\\"}\"'),(78,1,'2026-02-08 15:49:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(79,1,'2026-02-08 15:49:33','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(80,1,'2026-02-08 15:49:40','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(81,1,'2026-02-08 15:49:43','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(82,1,'2026-02-08 15:49:46','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(83,1,'2026-02-08 15:49:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(84,1,'2026-02-08 15:50:00','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:49:59.6971307Z\"}'),(85,1,'2026-02-08 15:50:07','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:50:07.7031046Z\"}'),(86,1,'2026-02-08 15:55:54','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:55:53.8600931Z\\\"}\"'),(87,1,'2026-02-08 15:55:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(88,1,'2026-02-08 15:55:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(89,1,'2026-02-08 15:56:03','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(90,1,'2026-02-08 15:56:08','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(91,1,'2026-02-08 16:01:16','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:01:16.3397404Z\\\"}\"'),(92,1,'2026-02-08 16:01:18','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(93,1,'2026-02-08 16:01:21','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(94,1,'2026-02-08 16:01:24','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(95,1,'2026-02-08 16:01:49','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:01:49.3904678Z\"}'),(96,1,'2026-02-08 16:02:26','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:02:26.7384386Z\"}'),(97,1,'2026-02-08 16:12:01','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:12:01.8742186Z\\\"}\"'),(98,1,'2026-02-08 16:12:03','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(99,1,'2026-02-08 16:12:06','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(100,1,'2026-02-08 16:12:10','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(101,1,'2026-02-08 16:12:24','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(102,1,'2026-02-08 16:24:26','Inicio de sesiÃ³n','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:24:27.4542427Z\"}'),(103,1,'2026-02-08 16:27:30','Inicio de sesiÃ³n','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:27:30.0169917Z\\\"}\"'),(104,1,'2026-02-08 16:27:32','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(105,1,'2026-02-08 16:27:36','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(106,1,'2026-02-08 16:27:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(107,1,'2026-02-08 16:27:56','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(108,1,'2026-02-08 16:27:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentascontables`
--

DROP TABLE IF EXISTS `cuentascontables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentascontables` (
  `IdCuenta` int(11) NOT NULL AUTO_INCREMENT,
  `CodigoCuenta` varchar(20) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Tipo` enum('Activo','Pasivo','Capital','Gasto','Ingreso') NOT NULL,
  `CuentaPadre` int(11) DEFAULT NULL,
  `TipoSaldo` enum('Deudor','Acreedor') NOT NULL,
  `AceptaMovimiento` tinyint(1) NOT NULL,
  `Estado` enum('Activa','Inactiva') NOT NULL,
  PRIMARY KEY (`IdCuenta`),
  UNIQUE KEY `CodigoCuenta` (`CodigoCuenta`),
  KEY `CuentaPadre` (`CuentaPadre`),
  CONSTRAINT `cuentascontables_ibfk_1` FOREIGN KEY (`CuentaPadre`) REFERENCES `cuentascontables` (`IdCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `IdEstadoAsiento` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(20) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Estado` enum('Activo','Inactivo') NOT NULL,
  PRIMARY KEY (`IdEstadoAsiento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoasientocontable`
--

LOCK TABLES `estadoasientocontable` WRITE;
/*!40000 ALTER TABLE `estadoasientocontable` DISABLE KEYS */;
INSERT INTO `estadoasientocontable` VALUES (1,'BOR','Borrador','Asiento no balanceado','Activo'),(2,'PEN','Pendiente','Asiento pendiente','Activo'),(3,'APR','Aprobado','Asiento aprobado','Activo'),(4,'REC','Rechazado','Asiento rechazado','Activo'),(5,'ANU','Anulado','Asiento anulado','Activo');
/*!40000 ALTER TABLE `estadoasientocontable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientoscontablesdetalles`
--

DROP TABLE IF EXISTS `movimientoscontablesdetalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientoscontablesdetalles` (
  `IdMovimiento` int(11) NOT NULL AUTO_INCREMENT,
  `IdAsiento` int(11) NOT NULL,
  `IdCuenta` int(11) NOT NULL,
  `TipoMovimiento` enum('Debito','Credito') NOT NULL,
  `Monto` decimal(14,2) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`IdMovimiento`),
  KEY `IdAsiento` (`IdAsiento`),
  KEY `IdCuenta` (`IdCuenta`),
  CONSTRAINT `movimientoscontablesdetalles_ibfk_1` FOREIGN KEY (`IdAsiento`) REFERENCES `asientocontableencabezado` (`IdAsiento`),
  CONSTRAINT `movimientoscontablesdetalles_ibfk_2` FOREIGN KEY (`IdCuenta`) REFERENCES `cuentascontables` (`IdCuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `IdPantalla` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(40) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Ruta` varchar(100) NOT NULL,
  `Estado` enum('Activa','Inactiva') NOT NULL,
  PRIMARY KEY (`IdPantalla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `IdPeriodo` int(11) NOT NULL AUTO_INCREMENT,
  `Anio` int(11) NOT NULL,
  `Mes` int(11) NOT NULL,
  `Estado` enum('Abierto','Cerrado') NOT NULL,
  `IdUsuarioCierre` int(11) DEFAULT NULL,
  `FechaCierre` datetime DEFAULT NULL,
  PRIMARY KEY (`IdPeriodo`),
  UNIQUE KEY `Anio` (`Anio`,`Mes`),
  KEY `IdUsuarioCierre` (`IdUsuarioCierre`),
  CONSTRAINT `periodocontable_ibfk_1` FOREIGN KEY (`IdUsuarioCierre`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `IdPantalla` int(11) NOT NULL,
  PRIMARY KEY (`IdRol`,`IdPantalla`),
  KEY `IdPantalla` (`IdPantalla`),
  CONSTRAINT `rolespantallas_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `roles` (`IdRol`),
  CONSTRAINT `rolespantallas_ibfk_2` FOREIGN KEY (`IdPantalla`) REFERENCES `pantallas` (`IdPantalla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `IdUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(100) NOT NULL,
  `ClaveCifrada` varbinary(240) NOT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  `ApellidoUsuario` varchar(50) NOT NULL,
  `CorreoElectronico` varchar(100) NOT NULL,
  `TagAutenticacion` varbinary(16) NOT NULL,
  `Nonce` varbinary(12) NOT NULL,
  `Estado` enum('Activo','Inactivo','Bloqueado') NOT NULL,
  `IntentosFallidos` int(11) DEFAULT 0,
  `UltimoIntento` datetime DEFAULT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `Usuario` (`Usuario`),
  UNIQUE KEY `CorreoElectronico` (`CorreoElectronico`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin',_binary 'c•ƒ¼\ê\Õ\×\"±','Admin','Sistema','admin@correo.com',_binary 'Ÿû\Î\ëË±‡–y\îg\ìG>ÿ',_binary '\Ó\èm\Û5“©zœA\Î','Activo',0,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariosroles`
--

DROP TABLE IF EXISTS `usuariosroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuariosroles` (
  `IdUsuario` int(11) NOT NULL,
  `IdRol` varchar(40) NOT NULL,
  PRIMARY KEY (`IdUsuario`,`IdRol`),
  KEY `IdRol` (`IdRol`),
  CONSTRAINT `usuariosroles_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `usuariosroles_ibfk_2` FOREIGN KEY (`IdRol`) REFERENCES `roles` (`IdRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
-- Dumping routines for database 'tiusr10pl_siscontableladat'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_asientos_contar_filtro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asientos_contar_filtro`(
    IN p_id_periodo INT,
    IN p_id_estado INT
)
BEGIN
    SELECT COUNT(*) 
    FROM asientocontableencabezado
    WHERE IdPeriodo = p_id_periodo
      AND (p_id_estado IS NULL OR IdEstadoAsiento = p_id_estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asientos_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asientos_listar`(
    IN p_id_periodo INT,
    IN p_id_estado INT,
    IN p_offset INT
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_asientos_listar_filtro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asientos_listar_filtro`(
    IN p_id_periodo INT,
    IN p_id_estado INT,
    IN p_offset INT,
    IN p_limit INT
)
BEGIN
    SELECT 
        ace.IdAsiento,
        ace.IdPeriodo,
        ace.Fecha,
        ace.Codigo,
        ace.Referencia,
        ace.IdEstadoAsiento,
        ace.Consecutivo,
        -- Sumamos el monto solo para los movimientos de tipo DÃ©bito ('D')
        (SELECT COALESCE(SUM(Monto), 0) 
         FROM asientocontabledetalle 
         WHERE IdAsiento = ace.IdAsiento 
           AND TipoMovimiento = 'D') AS TotalAsiento
    FROM asientocontableencabezado ace
    WHERE ace.IdPeriodo = p_id_periodo
      AND (p_id_estado IS NULL OR ace.IdEstadoAsiento = p_id_estado)
    ORDER BY ace.Fecha DESC, ace.IdAsiento DESC
    LIMIT p_limit OFFSET p_offset;
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asientos_listar_por_periodo`(
     IN p_id_periodo INT,
     IN p_id_estado INT  -- Quitamos el de usuario para que coincida con tu C#
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
       -- Filtro inteligente: Si p_id_estado es 0 o NULL, trae todos. 
       -- Si trae un valor (ej: 1 para borrador), filtra por ese.
       AND (p_id_estado IS NULL OR p_id_estado = 0 OR a.IdEstadoAsiento = p_id_estado)
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_actualizar_estado`(
    IN p_id_asiento INT,
    IN p_id_estado INT
)
BEGIN
    UPDATE asiento_contable_encabezado
    SET IdEstadoAsiento = p_id_estado
    WHERE IdAsientoEncabezado = p_id_asiento
      AND IdEstadoAsiento IN (1, 2)
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_anular`(
    IN p_id_asiento INT
)
BEGIN
    UPDATE asientocontableencabezado
    SET IdEstadoAsiento = 5
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_insertar_detalle`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_insertar_encabezado`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_listar_detalle`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_sumatoria`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_sumatorias`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_BitacoraInsertar`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_BitacoraListar`()
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_BitacoraListar10`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RegistrarIntentoFallido`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_ReiniciarIntentos`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosActualizarPorIdUsuario`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosConteo`()
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosEliminarPorIdUsuario`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosInsertar`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosListar`()
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosListar10`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosListarPorIdUsuario`(
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_VerificarCredencial`(
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-08 16:29:17
