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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientocontabledetalle`
--

LOCK TABLES `asientocontabledetalle` WRITE;
/*!40000 ALTER TABLE `asientocontabledetalle` DISABLE KEYS */;
INSERT INTO `asientocontabledetalle` VALUES (9,3,1,'D',123456.00,'Pagos'),(10,3,2,'C',123456.00,'Caja chica'),(11,2,1,'D',10000.00,'Prueba debido'),(12,2,2,'C',200.00,'Prueba credito'),(15,4,1,'D',100.00,''),(16,4,2,'C',100.00,''),(17,1,1,'D',100000.00,'Pago de servicios de alquiler'),(18,1,2,'C',100000.00,'Cobro por alquiler de propiedad'),(19,5,1,'D',500.00,'test'),(20,5,2,'C',500.00,'test'),(21,6,1,'D',1000.00,'Alquiler'),(22,6,2,'C',1000.00,'Servicio de alquiler'),(23,7,1,'D',12456546.00,'Pago de fletes en el GAM'),(24,7,2,'C',12456546.00,'Entrada por alquiler de camiones'),(25,8,28,'D',1000.00,'Papeleria'),(26,8,19,'C',1000.00,'Gastos en papeleria'),(29,10,5,'D',150000.00,'Pago de cliente recibido'),(30,10,2,'C',150000.00,'Venta de consultoria'),(31,11,21,'D',85000.00,'Compra de 2 sillas '),(32,11,9,'C',85000.00,'Queda pendiente de pago'),(33,9,16,'D',2500000.00,'Pago de electricidad'),(34,9,1,'C',2400000.00,'Salida de efectivo'),(35,12,1,'D',150000.00,'Pago mensualidad'),(36,12,2,'C',150000.00,'Recibo pago mensual'),(37,13,24,'D',200.00,'Pago'),(38,13,16,'C',100.00,'Pago');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientocontableencabezado`
--

LOCK TABLES `asientocontableencabezado` WRITE;
/*!40000 ALTER TABLE `asientocontableencabezado` DISABLE KEYS */;
INSERT INTO `asientocontableencabezado` VALUES (1,1,'2026-02-08','AS-0001','Pago alquiler mes actual',1,3,1),(2,2,'2026-01-06','AS-0001','Prueba asiento caja vs ingresos',1,1,1),(3,3,'2026-01-01','AS-0001','Segunda prueba',1,5,1),(4,4,'2026-01-23','AS-0002','Prueba',1,3,1),(5,1,'2026-02-09','AS-0003','Prueba Febrero 2',3,3,1),(6,2,'2026-02-09','AS-0001','Pago alquiler mes actual',3,4,1),(7,3,'2026-02-09','AS-00133','Pago de alquiler de camiones',3,2,1),(8,4,'2026-02-09','AS-0004','Papeleria',3,3,1),(9,5,'2026-02-09','AS-0005','Pago recibo luz Enero',3,1,1),(10,6,'2026-02-09','AS-0006','Factura de venta 001',3,5,1),(11,7,'2026-02-01','AS-0007','Compra sillas oficina - Factura #99',3,3,1),(12,8,'2026-02-10','AS-0008','Pago mensualidad',3,2,1),(13,9,'2026-02-10','AS-0009','Pago',3,5,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=779 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,1,'2026-02-08 12:23:08','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:23:08.0715385Z\"}'),(2,1,'2026-02-08 12:30:35','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:30:35.2494137Z\"}'),(3,1,'2026-02-08 12:41:32','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:41:32.258094Z\"}'),(4,1,'2026-02-08 12:41:43','Consulta de asientos','{\"idPeriodo\":1}'),(5,1,'2026-02-08 12:42:12','Consulta de asientos','{\"idPeriodo\":1}'),(6,1,'2026-02-08 12:44:57','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:44:57.4548546Z\"}'),(7,1,'2026-02-08 12:45:01','Consulta de asientos','{\"idPeriodo\":1}'),(8,1,'2026-02-08 12:50:57','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T18:50:57.2762808Z\"}'),(9,1,'2026-02-08 12:50:59','Consulta de asientos','{\"idPeriodo\":1}'),(10,1,'2026-02-08 14:11:54','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T20:11:53.695801Z\"}'),(11,1,'2026-02-08 14:11:59','Consulta de asientos','{\"idPeriodo\":1}'),(12,1,'2026-02-08 14:12:01','Consulta de asientos','{\"idPeriodo\":1}'),(13,1,'2026-02-08 14:12:03','Consulta paginada de usuarios','{\"Pagina\":1,\"UsuariosMostrados\":1}'),(14,1,'2026-02-08 14:12:05','Consulta de asientos','{\"idPeriodo\":1}'),(15,1,'2026-02-08 14:12:50','Creación de asiento','{\"encabezado\":{\"IdAsiento\":0,\"Consecutivo\":0,\"Fecha\":\"2026-02-08T00:00:00\",\"Codigo\":\"AS-0001\",\"Referencia\":\"Pago alquiler mes actual\",\"IdPeriodo\":1,\"IdEstadoAsiento\":2,\"IdUsuario\":1,\"Detalles\":[]},\"detalles\":[{\"IdAsientoDetalle\":0,\"IdAsiento\":1,\"IdCuentaContable\":1,\"TipoMovimiento\":\"D\",\"Monto\":250000.0,\"Descripcion\":\"Pago de servicios de alquiler\"},{\"IdAsientoDetalle\":0,\"IdAsiento\":1,\"IdCuentaContable\":2,\"TipoMovimiento\":\"C\",\"Monto\":250000.0,\"Descripcion\":\"Cobro por alquiler de propiedad\"}]}'),(16,1,'2026-02-08 14:12:50','Consulta de asientos','{\"idPeriodo\":1}'),(17,1,'2026-02-08 14:14:38','Edición de asiento','{\"Antes\":{\"Encabezado\":{\"IdAsiento\":1,\"Consecutivo\":1,\"Fecha\":\"2026-02-08T00:00:00\",\"Codigo\":\"AS-0001\",\"Referencia\":\"Pago alquiler mes actual\",\"IdPeriodo\":1,\"IdEstadoAsiento\":2,\"IdUsuario\":1,\"Detalles\":[]},\"Detalles\":[{\"IdAsientoDetalle\":1,\"IdAsiento\":1,\"IdCuentaContable\":1,\"TipoMovimiento\":\"D\",\"Monto\":250000.00,\"Descripcion\":\"Pago de servicios de alquiler\"},{\"IdAsientoDetalle\":2,\"IdAsiento\":1,\"IdCuentaContable\":2,\"TipoMovimiento\":\"C\",\"Monto\":250000.00,\"Descripcion\":\"Cobro por alquiler de propiedad\"}]},\"Despues\":{\"encabezado\":{\"IdAsiento\":1,\"Consecutivo\":1,\"Fecha\":\"2026-02-08T00:00:00\",\"Codigo\":\"AS-0001\",\"Referencia\":\"Pago alquiler mes actual\",\"IdPeriodo\":1,\"IdEstadoAsiento\":2,\"IdUsuario\":0,\"Detalles\":[]},\"detalles\":[{\"IdAsientoDetalle\":1,\"IdAsiento\":1,\"IdCuentaContable\":1,\"TipoMovimiento\":\"D\",\"Monto\":200000.0,\"Descripcion\":\"Pago de servicios de alquiler\"},{\"IdAsientoDetalle\":2,\"IdAsiento\":1,\"IdCuentaContable\":2,\"TipoMovimiento\":\"C\",\"Monto\":200000.0,\"Descripcion\":\"Cobro por alquiler de propiedad\"}]}}'),(18,1,'2026-02-08 14:14:39','Consulta de asientos','{\"idPeriodo\":1}'),(19,1,'2026-02-08 14:14:55','Consulta de asientos','{\"idPeriodo\":1}'),(20,1,'2026-02-08 14:55:26','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T20:55:26.5477274Z\\\"}\"'),(21,1,'2026-02-08 14:56:16','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T20:56:16.4356217Z\\\"}\"'),(22,1,'2026-02-08 14:59:45','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T20:59:44.6346475Z\"}'),(23,1,'2026-02-08 15:01:56','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:01:56.4530667Z\"}'),(24,1,'2026-02-08 15:01:59','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(25,1,'2026-02-08 15:03:37','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:03:37.6918522Z\"}'),(26,1,'2026-02-08 15:03:39','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(27,1,'2026-02-08 15:05:47','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:05:47.042841Z\"}'),(28,1,'2026-02-08 15:05:49','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(29,1,'2026-02-08 15:08:55','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:08:55.5842391Z\"}'),(30,1,'2026-02-08 15:08:57','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(31,1,'2026-02-08 15:14:07','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:14:06.9959592Z\"}'),(32,1,'2026-02-08 15:14:09','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(33,1,'2026-02-08 15:14:26','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(34,1,'2026-02-08 15:14:33','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":1}'),(35,1,'2026-02-08 15:14:35','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":1}'),(36,1,'2026-02-08 15:14:38','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":2}'),(37,1,'2026-02-08 15:14:42','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":3}'),(38,1,'2026-02-08 15:14:50','Consulta paginada de usuarios','{\"Pagina\":1,\"UsuariosMostrados\":1}'),(39,1,'2026-02-08 15:14:54','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(40,1,'2026-02-08 15:15:04','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(41,1,'2026-02-08 15:15:05','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(42,1,'2026-02-08 15:15:09','Consulta de asientos','{\"idPeriodo\":1,\"idEstado\":null}'),(43,1,'2026-02-08 15:16:42','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:16:42.6095858Z\\\"}\"'),(44,1,'2026-02-08 15:23:43','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:23:42.9757666Z\\\"}\"'),(45,1,'2026-02-08 15:24:40','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:24:39.9658223Z\\\"}\"'),(46,1,'2026-02-08 15:25:00','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(47,1,'2026-02-08 15:26:00','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:26:00.496245Z\\\"}\"'),(48,1,'2026-02-08 15:26:04','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(49,1,'2026-02-08 15:26:19','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(50,1,'2026-02-08 15:26:23','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(51,1,'2026-02-08 15:26:26','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(52,1,'2026-02-08 15:26:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(53,1,'2026-02-08 15:26:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(54,1,'2026-02-08 15:27:00','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(55,1,'2026-02-08 15:27:06','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(56,1,'2026-02-08 15:27:19','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:27:19.5992314Z\"}'),(57,1,'2026-02-08 15:29:24','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:29:23.7960276Z\\\"}\"'),(58,1,'2026-02-08 15:32:12','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:32:12.3015529Z\\\"}\"'),(59,1,'2026-02-08 15:32:15','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(60,1,'2026-02-08 15:33:57','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:33:57.867524Z\\\"}\"'),(61,1,'2026-02-08 15:33:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(62,1,'2026-02-08 15:33:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(63,1,'2026-02-08 15:34:05','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(64,1,'2026-02-08 15:34:40','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(65,1,'2026-02-08 15:34:43','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(66,1,'2026-02-08 15:34:45','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(67,1,'2026-02-08 15:35:28','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:35:28.6225414Z\\\"}\"'),(68,1,'2026-02-08 15:35:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(69,1,'2026-02-08 15:36:37','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(70,1,'2026-02-08 15:36:42','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(71,1,'2026-02-08 15:36:43','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(72,1,'2026-02-08 15:36:46','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(73,1,'2026-02-08 15:36:48','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(74,1,'2026-02-08 15:43:05','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:43:05.5427537Z\\\"}\"'),(75,1,'2026-02-08 15:43:08','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(76,1,'2026-02-08 15:43:23','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(77,1,'2026-02-08 15:49:27','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:49:27.7097547Z\\\"}\"'),(78,1,'2026-02-08 15:49:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(79,1,'2026-02-08 15:49:33','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(80,1,'2026-02-08 15:49:40','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(81,1,'2026-02-08 15:49:43','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(82,1,'2026-02-08 15:49:46','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(83,1,'2026-02-08 15:49:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(84,1,'2026-02-08 15:50:00','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:49:59.6971307Z\"}'),(85,1,'2026-02-08 15:50:07','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T21:50:07.7031046Z\"}'),(86,1,'2026-02-08 15:55:54','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T21:55:53.8600931Z\\\"}\"'),(87,1,'2026-02-08 15:55:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(88,1,'2026-02-08 15:55:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(89,1,'2026-02-08 15:56:03','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(90,1,'2026-02-08 15:56:08','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(91,1,'2026-02-08 16:01:16','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:01:16.3397404Z\\\"}\"'),(92,1,'2026-02-08 16:01:18','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(93,1,'2026-02-08 16:01:21','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(94,1,'2026-02-08 16:01:24','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(95,1,'2026-02-08 16:01:49','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:01:49.3904678Z\"}'),(96,1,'2026-02-08 16:02:26','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:02:26.7384386Z\"}'),(97,1,'2026-02-08 16:12:01','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:12:01.8742186Z\\\"}\"'),(98,1,'2026-02-08 16:12:03','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(99,1,'2026-02-08 16:12:06','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(100,1,'2026-02-08 16:12:10','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(101,1,'2026-02-08 16:12:24','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(102,1,'2026-02-08 16:24:26','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:24:27.4542427Z\"}'),(103,1,'2026-02-08 16:27:30','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:27:30.0169917Z\\\"}\"'),(104,1,'2026-02-08 16:27:32','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(105,1,'2026-02-08 16:27:36','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(106,1,'2026-02-08 16:27:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(107,1,'2026-02-08 16:27:56','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(108,1,'2026-02-08 16:27:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(109,1,'2026-02-08 16:39:15','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:39:16.2731746Z\"}'),(110,1,'2026-02-08 16:46:52','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-08T22:46:53.2654647Z\"}'),(111,1,'2026-02-08 16:52:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:52:20.8800329Z\\\"}\"'),(112,1,'2026-02-08 16:52:23','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(113,1,'2026-02-08 16:53:26','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(114,1,'2026-02-08 16:54:43','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(115,1,'2026-02-08 16:55:28','Actualización de Asiento Contable','\"{\\\"Antes\\\":{\\\"Antes\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":1,\\\"Consecutivo\\\":1,\\\"Fecha\\\":\\\"2026-02-08T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":5,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Pago de servicios de alquiler\\\"},{\\\"IdAsientoDetalle\\\":6,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Cobro por alquiler de propiedad\\\"}]}},\\\"Despues\\\":{\\\"Despues\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":1,\\\"Consecutivo\\\":1,\\\"Fecha\\\":\\\"2026-02-08T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":0,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":3,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100000,\\\"Descripcion\\\":\\\"Pago de servicios de alquiler\\\"},{\\\"IdAsientoDetalle\\\":4,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100000,\\\"Descripcion\\\":\\\"Cobro por alquiler de propiedad\\\"}]}}}\"'),(116,1,'2026-02-08 16:55:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(117,1,'2026-02-08 16:59:07','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T22:59:07.7473508Z\\\"}\"'),(118,1,'2026-02-08 16:59:10','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(119,1,'2026-02-08 17:01:18','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:01:18.6369192Z\\\"}\"'),(120,1,'2026-02-08 17:01:22','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(121,1,'2026-02-08 17:03:29','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:03:29.1765828Z\\\"}\"'),(122,1,'2026-02-08 17:03:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(123,1,'2026-02-08 17:03:56','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:03:56.3817432Z\\\"}\"'),(124,1,'2026-02-08 17:03:58','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(125,1,'2026-02-08 17:13:41','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:13:41.4681803Z\\\"}\"'),(126,1,'2026-02-08 17:13:45','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(127,1,'2026-02-08 17:13:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(128,1,'2026-02-08 17:13:52','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(129,1,'2026-02-08 17:14:25','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":2,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":0,\\\"Fecha\\\":\\\"2026-01-06T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Prueba asiento caja vs ingresos\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":2,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100,\\\"Descripcion\\\":\\\"Prueba debido\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":2,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100,\\\"Descripcion\\\":\\\"Prueba credito\\\"}],\\\"FechaCreacion\\\":\\\"2026-02-08T17:14:25.364542-06:00\\\"}\"'),(130,1,'2026-02-08 17:14:25','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(131,1,'2026-02-08 17:14:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(132,1,'2026-02-08 17:19:47','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:19:47.9256353Z\\\"}\"'),(133,1,'2026-02-08 17:19:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(134,1,'2026-02-08 17:21:17','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":3,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":0,\\\"Fecha\\\":\\\"2026-01-01T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Segunda prueba\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":3,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":123456,\\\"Descripcion\\\":\\\"Pagos\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":3,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":123456,\\\"Descripcion\\\":\\\"Caja chica\\\"}],\\\"FechaCreacion\\\":\\\"2026-02-08T17:21:17.6431106-06:00\\\"}\"'),(135,1,'2026-02-08 17:21:17','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(136,1,'2026-02-08 17:23:52','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:23:52.9104176Z\\\"}\"'),(137,1,'2026-02-08 17:25:12','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(138,1,'2026-02-08 17:26:38','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(139,1,'2026-02-08 17:26:42','Eliminación de Asiento Contable','\"{\\\"IdAsiento\\\":3,\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Segunda prueba\\\",\\\"Fecha\\\":\\\"2026-01-01T00:00:00\\\",\\\"Motivo\\\":\\\"Anulaci\\\\u00F3n manual desde interfaz de usuario\\\",\\\"FechaAnulacion\\\":\\\"2026-02-08T17:26:42.7015513-06:00\\\"}\"'),(140,1,'2026-02-08 17:26:46','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(141,1,'2026-02-08 17:27:53','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(142,1,'2026-02-08 17:27:56','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(143,1,'2026-02-08 17:28:00','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(144,1,'2026-02-08 17:28:14','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos\\\"}\"'),(145,1,'2026-02-08 17:37:16','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-08T23:37:16.9106399Z\\\"}\"'),(146,1,'2026-02-08 17:37:18','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(147,1,'2026-02-08 17:37:32','Actualización de Asiento Contable','\"{\\\"Antes\\\":{\\\"Antes\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":2,\\\"Consecutivo\\\":2,\\\"Fecha\\\":\\\"2026-01-06T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Prueba asiento caja vs ingresos\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":7,\\\"IdAsiento\\\":2,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100.00,\\\"Descripcion\\\":\\\"Prueba debido\\\"},{\\\"IdAsientoDetalle\\\":8,\\\"IdAsiento\\\":2,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100.00,\\\"Descripcion\\\":\\\"Prueba credito\\\"}]}},\\\"Despues\\\":{\\\"Despues\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":2,\\\"Consecutivo\\\":2,\\\"Fecha\\\":\\\"2026-01-06T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Prueba asiento caja vs ingresos\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":1,\\\"IdUsuario\\\":0,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":7,\\\"IdAsiento\\\":2,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":10000,\\\"Descripcion\\\":\\\"Prueba debido\\\"},{\\\"IdAsientoDetalle\\\":8,\\\"IdAsiento\\\":2,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":200,\\\"Descripcion\\\":\\\"Prueba credito\\\"}]}}}\"'),(148,1,'2026-02-08 17:37:32','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(149,1,'2026-02-08 17:37:48','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(150,1,'2026-02-08 17:37:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(151,1,'2026-02-08 17:37:53','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(152,1,'2026-02-08 18:32:32','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:32:32.0274791Z\\\"}\"'),(153,1,'2026-02-08 18:32:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(154,1,'2026-02-08 18:32:45','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(155,1,'2026-02-08 18:33:07','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(156,1,'2026-02-08 18:33:10','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(157,1,'2026-02-08 18:33:20','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(158,1,'2026-02-08 18:33:22','Actualización de Asiento Contable','\"{\\\"Antes\\\":{\\\"Antes\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":1,\\\"Consecutivo\\\":1,\\\"Fecha\\\":\\\"2026-02-08T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":5,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Pago de servicios de alquiler\\\"},{\\\"IdAsientoDetalle\\\":6,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Cobro por alquiler de propiedad\\\"}]}},\\\"Despues\\\":{\\\"Despues\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":1,\\\"Consecutivo\\\":1,\\\"Fecha\\\":\\\"2026-02-08T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":0,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":5,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Pago de servicios de alquiler\\\"},{\\\"IdAsientoDetalle\\\":6,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Cobro por alquiler de propiedad\\\"}]}}}\"'),(159,1,'2026-02-08 18:33:22','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(160,1,'2026-02-08 18:34:01','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(161,1,'2026-02-08 18:35:15','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":4,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":0,\\\"Fecha\\\":\\\"2026-01-23T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0002\\\",\\\"Referencia\\\":\\\"Prueba\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":4,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100,\\\"Descripcion\\\":\\\"\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":4,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100,\\\"Descripcion\\\":\\\"\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-08T18:35:15.8339413-06:00\\\"}\"'),(162,1,'2026-02-08 18:35:15','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(163,1,'2026-02-08 18:36:08','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(164,1,'2026-02-08 18:36:19','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(165,1,'2026-02-08 18:42:21','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:42:22.0551135Z\\\"}\"'),(166,1,'2026-02-08 18:42:23','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(167,1,'2026-02-08 18:49:13','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:49:13.9072037Z\\\"}\"'),(168,1,'2026-02-08 18:51:32','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:51:32.6964692Z\\\"}\"'),(169,1,'2026-02-08 18:51:36','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(170,1,'2026-02-08 18:52:58','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:52:58.2585026Z\\\"}\"'),(171,1,'2026-02-08 18:52:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(172,1,'2026-02-08 18:54:54','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:54:54.5098616Z\\\"}\"'),(173,1,'2026-02-08 18:55:30','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:55:30.9603365Z\\\"}\"'),(174,1,'2026-02-08 18:59:58','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T00:59:58.7254059Z\\\"}\"'),(175,1,'2026-02-08 19:06:04','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T01:06:04.5215339Z\\\"}\"'),(176,1,'2026-02-08 19:29:23','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T01:29:23.3740358Z\\\"}\"'),(177,1,'2026-02-08 19:30:17','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T01:30:18.0406158Z\\\"}\"'),(178,1,'2026-02-08 19:35:52','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T01:35:52.1273049Z\\\"}\"'),(179,1,'2026-02-08 19:36:21','Cambio de estado asiento AS-0001','{\"asiento_id\": \"1\", \"codigo\": \"AS-0001\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"4\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-08 19:36:21\"}'),(180,1,'2026-02-08 19:36:21','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":1,\\\"De\\\":2,\\\"A\\\":4}\"'),(181,1,'2026-02-08 19:36:41','Cambio de estado asiento AS-0002','{\"asiento_id\": \"4\", \"codigo\": \"AS-0002\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-08 19:36:41\"}'),(182,1,'2026-02-08 19:36:41','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":4,\\\"De\\\":2,\\\"A\\\":3}\"'),(183,1,'2026-02-08 19:37:53','Cambio de estado asiento AS-0002','{\"asiento_id\": \"4\", \"codigo\": \"AS-0002\", \"estado_anterior\": \"3\", \"estado_nuevo\": \"2\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-08 19:37:53\"}'),(184,1,'2026-02-08 19:37:53','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":4,\\\"De\\\":3,\\\"A\\\":2}\"'),(185,1,'2026-02-08 19:38:05','Cambio de estado asiento AS-0002','{\"asiento_id\": \"4\", \"codigo\": \"AS-0002\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-08 19:38:05\"}'),(186,1,'2026-02-08 19:38:05','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":4,\\\"De\\\":2,\\\"A\\\":3}\"'),(187,1,'2026-02-08 19:38:35','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(188,1,'2026-02-08 19:38:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(189,1,'2026-02-08 19:45:56','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T01:45:56.6816096Z\\\"}\"'),(190,1,'2026-02-08 19:48:00','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T01:48:00.7030891Z\\\"}\"'),(191,1,'2026-02-08 19:48:04','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(192,1,'2026-02-09 11:20:59','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:20:58.3030204Z\\\"}\"'),(193,1,'2026-02-09 11:21:04','Consulta de asientos con filtro','\"{\\\"IdEstado\\\":null,\\\"IdPeriodo\\\":1,\\\"Pagina\\\":1,\\\"ItemsPorPagina\\\":10}\"'),(194,1,'2026-02-09 11:21:20','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(195,1,'2026-02-09 11:21:23','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(196,1,'2026-02-09 11:21:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(197,1,'2026-02-09 11:22:57','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:22:56.0205338Z\\\"}\"'),(198,1,'2026-02-09 11:24:06','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:24:04.7133933Z\\\"}\"'),(199,1,'2026-02-09 11:24:24','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(200,1,'2026-02-09 11:25:41','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:25:39.8454146Z\\\"}\"'),(201,1,'2026-02-09 11:25:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(202,1,'2026-02-09 11:28:08','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:28:06.625857Z\\\"}\"'),(203,1,'2026-02-09 11:28:12','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(204,1,'2026-02-09 11:28:34','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(205,1,'2026-02-09 11:28:51','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(206,1,'2026-02-09 11:28:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(207,1,'2026-02-09 11:32:01','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:32:00.0340758Z\\\"}\"'),(208,1,'2026-02-09 11:32:04','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(209,1,'2026-02-09 11:32:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(210,1,'2026-02-09 11:32:57','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(211,1,'2026-02-09 11:33:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(212,1,'2026-02-09 11:34:34','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:34:32.9221566Z\\\"}\"'),(213,1,'2026-02-09 11:34:36','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(214,1,'2026-02-09 11:35:07','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(215,1,'2026-02-09 11:36:00','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:35:58.7056464Z\\\"}\"'),(216,1,'2026-02-09 11:36:02','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(217,1,'2026-02-09 11:36:11','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(218,1,'2026-02-09 11:37:58','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:37:56.9655459Z\\\"}\"'),(219,1,'2026-02-09 11:37:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(220,1,'2026-02-09 11:38:10','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(221,1,'2026-02-09 11:38:13','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(222,1,'2026-02-09 11:38:25','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(223,1,'2026-02-09 11:38:30','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(224,1,'2026-02-09 11:38:47','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:38:46.476102Z\\\"}\"'),(225,1,'2026-02-09 11:38:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(226,1,'2026-02-09 11:40:31','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:40:30.1308297Z\\\"}\"'),(227,1,'2026-02-09 11:40:33','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(228,1,'2026-02-09 11:40:41','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(229,1,'2026-02-09 11:44:23','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:44:21.9731687Z\\\"}\"'),(230,1,'2026-02-09 11:44:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1}\"'),(231,1,'2026-02-09 11:52:02','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:52:01.0400428Z\\\"}\"'),(232,1,'2026-02-09 11:52:05','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(233,1,'2026-02-09 11:52:16','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(234,1,'2026-02-09 11:52:25','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(235,1,'2026-02-09 11:52:40','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(236,1,'2026-02-09 11:52:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(237,1,'2026-02-09 11:54:07','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T17:54:06.1786986Z\\\"}\"'),(238,1,'2026-02-09 11:54:11','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(239,1,'2026-02-09 11:54:12','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(240,1,'2026-02-09 11:54:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(241,1,'2026-02-09 11:55:19','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(242,1,'2026-02-09 11:55:22','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(243,1,'2026-02-09 12:00:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T18:00:19.2100564Z\\\"}\"'),(244,1,'2026-02-09 12:00:32','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(245,1,'2026-02-09 12:00:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(246,1,'2026-02-09 12:00:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(247,1,'2026-02-09 14:46:47','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T20:46:46.7382246Z\\\"}\"'),(248,1,'2026-02-09 14:47:36','Cambio de estado asiento AS-0001','{\"asiento_id\": \"1\", \"codigo\": \"AS-0001\", \"estado_anterior\": \"4\", \"estado_nuevo\": \"2\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-09 14:47:36\"}'),(249,1,'2026-02-09 14:47:36','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":1,\\\"De\\\":4,\\\"A\\\":2}\"'),(250,1,'2026-02-09 14:50:20','Cambio de estado asiento AS-0001','{\"asiento_id\": \"1\", \"codigo\": \"AS-0001\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"4\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-09 14:50:20\"}'),(251,1,'2026-02-09 14:50:20','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":1,\\\"De\\\":2,\\\"A\\\":4}\"'),(252,1,'2026-02-09 14:52:12','Cambio de estado asiento AS-0001','{\"asiento_id\": \"1\", \"codigo\": \"AS-0001\", \"estado_anterior\": \"4\", \"estado_nuevo\": \"2\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-09 14:52:12\"}'),(253,1,'2026-02-09 14:52:13','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":1,\\\"De\\\":4,\\\"A\\\":2}\"'),(254,1,'2026-02-09 15:05:06','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-09T21:05:06.6724206Z\\\"}\"'),(255,1,'2026-02-09 15:05:08','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(256,1,'2026-02-09 15:05:24','Actualización de Asiento Contable','\"{\\\"Antes\\\":{\\\"Antes\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":1,\\\"Consecutivo\\\":1,\\\"Fecha\\\":\\\"2026-02-08T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":13,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Pago de servicios de alquiler\\\"},{\\\"IdAsientoDetalle\\\":14,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Cobro por alquiler de propiedad\\\"}]}},\\\"Despues\\\":{\\\"Despues\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":1,\\\"Consecutivo\\\":1,\\\"Fecha\\\":\\\"2026-02-08T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":1,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":0,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":13,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Pago de servicios de alquiler\\\"},{\\\"IdAsientoDetalle\\\":14,\\\"IdAsiento\\\":1,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100000.00,\\\"Descripcion\\\":\\\"Cobro por alquiler de propiedad\\\"}]}}}\"'),(257,1,'2026-02-09 15:05:24','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(258,1,'2026-02-09 15:05:42','Cambio de estado asiento AS-0001','{\"asiento_id\": \"1\", \"codigo\": \"AS-0001\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"1\", \"fecha_cambio\": \"2026-02-09 15:05:42\"}'),(259,1,'2026-02-09 15:05:42','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":1,\\\"De\\\":2,\\\"A\\\":3}\"'),(260,1,'2026-02-09 15:06:06','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(261,1,'2026-02-09 15:06:23','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(262,1,'2026-02-09 15:06:25','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(263,1,'2026-02-09 15:06:34','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(264,1,'2026-02-09 15:06:42','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(265,1,'2026-02-09 15:07:16','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":5,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":0,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0003\\\",\\\"Referencia\\\":\\\"Prueba Febrero 2\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":5,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":500,\\\"Descripcion\\\":\\\"test\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":5,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":500,\\\"Descripcion\\\":\\\"test\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T15:07:16.6257918-06:00\\\"}\"'),(266,1,'2026-02-09 15:07:16','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(267,1,'2026-02-09 15:07:21','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(268,1,'2026-02-09 15:07:28','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(269,1,'2026-02-09 15:07:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(270,1,'2026-02-09 15:07:30','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(271,1,'2026-02-09 15:07:50','Cambio de estado asiento AS-0003','{\"asiento_id\": \"5\", \"codigo\": \"AS-0003\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-09 15:07:50\"}'),(272,1,'2026-02-09 15:07:50','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":5,\\\"De\\\":2,\\\"A\\\":3}\"'),(273,1,'2026-02-09 15:09:50','Creación de Proceso de Cierre Contable','\"{\\\"IdPeriodo\\\":1,\\\"FechaInicio\\\":\\\"2026-02-09T15:09:50.4591337-06:00\\\",\\\"Usuario\\\":1}\"'),(274,1,'2026-02-09 15:09:51','Creación de Cierre Contable Completado','\"{\\\"IdPeriodo\\\":1,\\\"Anio\\\":2026,\\\"Mes\\\":1,\\\"TotalDebe\\\":100100.00,\\\"TotalHaber\\\":100100.00,\\\"FechaCierre\\\":\\\"2026-02-09T15:09:51.3522752-06:00\\\",\\\"Balanceado\\\":true}\"'),(275,1,'2026-02-09 18:15:04','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T00:15:04.071388Z\\\"}\"'),(276,1,'2026-02-09 18:15:10','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(277,1,'2026-02-09 18:15:39','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(278,1,'2026-02-09 18:15:40','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(279,1,'2026-02-09 18:15:43','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(280,1,'2026-02-09 18:15:48','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(281,1,'2026-02-09 18:15:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(282,1,'2026-02-09 18:16:26','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(283,1,'2026-02-09 18:16:58','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":6,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":0,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0001\\\",\\\"Referencia\\\":\\\"Pago alquiler mes actual\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":6,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":1000,\\\"Descripcion\\\":\\\"Alquiler\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":6,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":1000,\\\"Descripcion\\\":\\\"Servicio de alquiler\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T18:16:58.4945771-06:00\\\"}\"'),(284,1,'2026-02-09 18:16:58','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(285,1,'2026-02-09 18:17:08','Cambio de estado asiento AS-0001','{\"asiento_id\": \"6\", \"codigo\": \"AS-0001\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"4\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-09 18:17:08\"}'),(286,1,'2026-02-09 18:17:08','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":6,\\\"De\\\":2,\\\"A\\\":4}\"'),(287,1,'2026-02-09 18:17:17','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(288,1,'2026-02-09 18:22:48','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T00:22:48.4621337Z\\\"}\"'),(289,1,'2026-02-09 18:23:01','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(290,1,'2026-02-09 18:23:17','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(291,1,'2026-02-09 18:23:20','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(292,1,'2026-02-09 18:23:22','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(293,1,'2026-02-09 18:23:25','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":4,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(294,1,'2026-02-09 18:23:28','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":5,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(295,1,'2026-02-09 18:23:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(296,1,'2026-02-09 18:34:43','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T00:34:43.3379552Z\\\"}\"'),(297,1,'2026-02-09 18:34:45','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(298,1,'2026-02-09 18:36:07','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":7,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":0,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-00133\\\",\\\"Referencia\\\":\\\"Pago de alquiler de camiones\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":7,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":12456546,\\\"Descripcion\\\":\\\"Pago de fletes en el GAM\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":7,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":12456546,\\\"Descripcion\\\":\\\"Entrada por alquiler de camiones\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T18:36:07.4040025-06:00\\\"}\"'),(299,1,'2026-02-09 18:36:07','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(300,1,'2026-02-09 18:43:24','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T00:43:24.1927972Z\\\"}\"'),(301,1,'2026-02-09 18:43:27','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(302,1,'2026-02-09 18:46:27','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T00:46:26.9533975Z\\\"}\"'),(303,1,'2026-02-09 18:46:28','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(304,1,'2026-02-09 18:47:15','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(305,1,'2026-02-09 19:12:52','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T01:12:52.2311424Z\\\"}\"'),(306,1,'2026-02-09 19:12:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(307,1,'2026-02-09 19:12:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(308,1,'2026-02-09 19:16:13','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T01:16:13.082226Z\\\"}\"'),(309,1,'2026-02-09 19:16:18','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(310,1,'2026-02-09 19:17:08','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":8,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":5,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0005\\\",\\\"Referencia\\\":\\\"Papeleria\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":8,\\\"IdCuentaContable\\\":28,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":1000,\\\"Descripcion\\\":\\\"Papeleria\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":8,\\\"IdCuentaContable\\\":19,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":1000,\\\"Descripcion\\\":\\\"Gastos en papeleria\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T19:17:08.8901684-06:00\\\"}\"'),(311,1,'2026-02-09 19:17:08','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(312,1,'2026-02-09 19:19:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(313,1,'2026-02-09 19:21:28','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":9,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":5,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0005\\\",\\\"Referencia\\\":\\\"Pago recibo luz Enero\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":9,\\\"IdCuentaContable\\\":16,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":25000,\\\"Descripcion\\\":\\\"Pago de electricidad\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":9,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":25000,\\\"Descripcion\\\":\\\"Salida de efectivo\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T19:21:28.5725107-06:00\\\"}\"'),(314,1,'2026-02-09 19:21:28','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(315,1,'2026-02-09 19:24:05','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":10,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":6,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0006\\\",\\\"Referencia\\\":\\\"Factura de venta 001\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":10,\\\"IdCuentaContable\\\":5,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":150000,\\\"Descripcion\\\":\\\"Pago de cliente recibido\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":10,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":150000,\\\"Descripcion\\\":\\\"Venta de consultoria\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T19:24:05.1862888-06:00\\\"}\"'),(316,1,'2026-02-09 19:24:05','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(317,1,'2026-02-09 19:25:25','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":11,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":7,\\\"Fecha\\\":\\\"2026-02-01T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0007\\\",\\\"Referencia\\\":\\\"Compra sillas oficina - Factura #99\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":11,\\\"IdCuentaContable\\\":21,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":85000,\\\"Descripcion\\\":\\\"Compra de 2 sillas \\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":11,\\\"IdCuentaContable\\\":9,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":85000,\\\"Descripcion\\\":\\\"Queda pendiente de pago\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-09T19:25:25.8959333-06:00\\\"}\"'),(318,1,'2026-02-09 19:25:25','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(319,1,'2026-02-09 19:25:59','Cambio de estado asiento AS-0004','{\"asiento_id\": \"8\", \"codigo\": \"AS-0004\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-09 19:25:59\"}'),(320,1,'2026-02-09 19:25:59','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":8,\\\"De\\\":2,\\\"A\\\":3}\"'),(321,1,'2026-02-09 19:26:06','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(322,1,'2026-02-09 19:30:13','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T01:30:13.1181102Z\\\"}\"'),(323,1,'2026-02-09 19:30:14','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(324,1,'2026-02-09 19:30:32','Actualización de Asiento Contable','\"{\\\"Antes\\\":{\\\"Antes\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":9,\\\"Consecutivo\\\":5,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0005\\\",\\\"Referencia\\\":\\\"Pago recibo luz Enero\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":27,\\\"IdAsiento\\\":9,\\\"IdCuentaContable\\\":16,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":25000.00,\\\"Descripcion\\\":\\\"Pago de electricidad\\\"},{\\\"IdAsientoDetalle\\\":28,\\\"IdAsiento\\\":9,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":25000.00,\\\"Descripcion\\\":\\\"Salida de efectivo\\\"}]}},\\\"Despues\\\":{\\\"Despues\\\":{\\\"Encabezado\\\":{\\\"IdAsiento\\\":9,\\\"Consecutivo\\\":5,\\\"Fecha\\\":\\\"2026-02-09T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0005\\\",\\\"Referencia\\\":\\\"Pago recibo luz Enero\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":1,\\\"IdUsuario\\\":0,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":27,\\\"IdAsiento\\\":9,\\\"IdCuentaContable\\\":16,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":2500000,\\\"Descripcion\\\":\\\"Pago de electricidad\\\"},{\\\"IdAsientoDetalle\\\":28,\\\"IdAsiento\\\":9,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":2400000,\\\"Descripcion\\\":\\\"Salida de efectivo\\\"}]}}}\"'),(325,1,'2026-02-09 19:30:32','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(326,1,'2026-02-09 19:33:33','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(327,1,'2026-02-09 19:33:47','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(328,1,'2026-02-09 19:34:06','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(329,1,'2026-02-09 19:34:22','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":1,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(330,1,'2026-02-09 19:34:30','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(331,1,'2026-02-09 19:34:35','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":1,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(332,1,'2026-02-09 19:34:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":2,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(333,1,'2026-02-09 19:34:44','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":3,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(334,1,'2026-02-09 19:34:48','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":4,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(335,1,'2026-02-09 19:34:52','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":5,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(336,1,'2026-02-09 19:34:57','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(337,1,'2026-02-09 19:36:44','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(338,1,'2026-02-09 19:37:13','Cambio de estado asiento AS-0007','{\"asiento_id\": \"11\", \"codigo\": \"AS-0007\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-09 19:37:13\"}'),(339,1,'2026-02-09 19:37:13','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":11,\\\"De\\\":2,\\\"A\\\":3}\"'),(340,1,'2026-02-09 19:37:53','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(341,1,'2026-02-09 19:37:59','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T01:37:58.8622623Z\\\"}\"'),(342,1,'2026-02-09 19:38:04','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(343,1,'2026-02-09 19:39:02','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(344,1,'2026-02-09 19:39:03','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(345,1,'2026-02-09 19:39:25','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(346,1,'2026-02-09 19:39:34','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":1}\"'),(347,1,'2026-02-09 20:04:28','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T02:04:28.0156057Z\\\"}\"'),(348,1,'2026-02-09 20:04:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(349,1,'2026-02-10 11:45:17','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T17:45:16.2492305Z\\\"}\"'),(350,1,'2026-02-10 12:00:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-10T18:00:20.3429673Z\\\"}\"'),(351,2,'2026-02-10 17:07:23','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-10T23:07:22.5113741Z\\\"}\"'),(352,1,'2026-02-10 18:22:31','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T00:22:31.7806259Z\\\"}\"'),(353,1,'2026-02-10 18:22:58','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(354,1,'2026-02-10 18:23:01','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(355,1,'2026-02-10 18:23:03','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(356,1,'2026-02-10 18:23:10','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(357,1,'2026-02-10 18:23:12','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(358,1,'2026-02-10 18:23:14','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(359,1,'2026-02-10 18:23:17','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(360,1,'2026-02-10 18:23:20','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(361,1,'2026-02-10 18:23:49','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(362,1,'2026-02-10 18:24:03','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(363,1,'2026-02-10 18:24:17','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(364,1,'2026-02-10 18:24:26','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(365,1,'2026-02-10 18:24:29','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(366,1,'2026-02-10 18:24:40','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(367,1,'2026-02-10 18:24:46','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(368,1,'2026-02-10 18:24:49','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(369,1,'2026-02-10 18:24:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(370,1,'2026-02-10 18:27:15','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T00:27:15.7916561Z\\\"}\"'),(371,1,'2026-02-10 18:27:25','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(372,1,'2026-02-10 18:27:59','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(373,1,'2026-02-10 18:28:04','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(374,1,'2026-02-10 20:49:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T02:49:19.2515911Z\\\"}\"'),(375,2,'2026-02-10 20:51:52','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-11T02:51:51.9879856Z\\\"}\"'),(376,1,'2026-02-10 20:52:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(377,1,'2026-02-10 20:54:34','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":12,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":8,\\\"Fecha\\\":\\\"2026-02-10T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0008\\\",\\\"Referencia\\\":\\\"Pago mensualidad\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":2,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":12,\\\"IdCuentaContable\\\":1,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":150000,\\\"Descripcion\\\":\\\"Pago mensualidad\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":12,\\\"IdCuentaContable\\\":2,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":150000,\\\"Descripcion\\\":\\\"Recibo pago mensual\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-10T20:54:34.4418725-06:00\\\"}\"'),(378,1,'2026-02-10 20:54:35','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(379,1,'2026-02-10 20:56:16','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(380,1,'2026-02-10 20:57:31','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(381,1,'2026-02-10 20:57:56','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(382,1,'2026-02-10 20:58:42','Creación de Asiento Contable','\"{\\\"IdAsiento\\\":13,\\\"Encabezado\\\":{\\\"IdAsiento\\\":0,\\\"Consecutivo\\\":9,\\\"Fecha\\\":\\\"2026-02-10T00:00:00\\\",\\\"Codigo\\\":\\\"AS-0009\\\",\\\"Referencia\\\":\\\"Pago\\\",\\\"IdPeriodo\\\":3,\\\"IdEstadoAsiento\\\":1,\\\"IdUsuario\\\":1,\\\"EstadoNombre\\\":\\\"\\\",\\\"Detalles\\\":[]},\\\"Detalles\\\":[{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":13,\\\"IdCuentaContable\\\":24,\\\"TipoMovimiento\\\":\\\"D\\\",\\\"Monto\\\":200,\\\"Descripcion\\\":\\\"Pago\\\"},{\\\"IdAsientoDetalle\\\":0,\\\"IdAsiento\\\":13,\\\"IdCuentaContable\\\":16,\\\"TipoMovimiento\\\":\\\"C\\\",\\\"Monto\\\":100,\\\"Descripcion\\\":\\\"Pago\\\"}],\\\"FechaOperacion\\\":\\\"2026-02-10T20:58:42.3546044-06:00\\\"}\"'),(383,1,'2026-02-10 20:58:42','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(384,1,'2026-02-10 20:58:51','Eliminación de Asiento Contable','\"{\\\"IdAsiento\\\":13,\\\"Codigo\\\":\\\"AS-0009\\\",\\\"Motivo\\\":\\\"Anulaci\\\\u00F3n manual por el usuario\\\",\\\"FechaAnulacion\\\":\\\"2026-02-10T20:58:51.3258445-06:00\\\"}\"'),(385,1,'2026-02-10 20:59:02','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":3,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(386,1,'2026-02-10 21:01:00','Cambio de estado asiento AS-0008','{\"asiento_id\": \"12\", \"codigo\": \"AS-0008\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"4\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-10 21:01:00\"}'),(387,1,'2026-02-10 21:01:00','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":12,\\\"De\\\":2,\\\"A\\\":4}\"'),(388,1,'2026-02-10 21:01:24','Cambio de estado asiento AS-00133','{\"asiento_id\": \"7\", \"codigo\": \"AS-00133\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"3\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-10 21:01:24\"}'),(389,1,'2026-02-10 21:01:24','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":7,\\\"De\\\":2,\\\"A\\\":3}\"'),(390,1,'2026-02-10 21:01:47','Cambio de estado asiento AS-0006','{\"asiento_id\": \"10\", \"codigo\": \"AS-0006\", \"estado_anterior\": \"2\", \"estado_nuevo\": \"5\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-10 21:01:47\"}'),(391,1,'2026-02-10 21:01:47','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":10,\\\"De\\\":2,\\\"A\\\":5}\"'),(392,1,'2026-02-10 21:02:12','Cambio de estado asiento AS-0008','{\"asiento_id\": \"12\", \"codigo\": \"AS-0008\", \"estado_anterior\": \"4\", \"estado_nuevo\": \"2\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-10 21:02:12\"}'),(393,1,'2026-02-10 21:02:12','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":12,\\\"De\\\":4,\\\"A\\\":2}\"'),(394,1,'2026-02-10 21:02:23','Cambio de estado asiento AS-00133','{\"asiento_id\": \"7\", \"codigo\": \"AS-00133\", \"estado_anterior\": \"3\", \"estado_nuevo\": \"2\", \"periodo_id\": \"3\", \"fecha_cambio\": \"2026-02-10 21:02:23\"}'),(395,1,'2026-02-10 21:02:23','Cambio de Estado Asiento','\"{\\\"IdAsiento\\\":7,\\\"De\\\":3,\\\"A\\\":2}\"'),(396,1,'2026-02-10 21:04:51','Creación de Proceso de Cierre Contable','\"{\\\"IdPeriodo\\\":3,\\\"FechaInicio\\\":\\\"2026-02-10T21:04:50.6573804-06:00\\\",\\\"Usuario\\\":1}\"'),(397,1,'2026-02-10 21:04:52','Creación de Cierre Contable Completado','\"{\\\"IdPeriodo\\\":3,\\\"Anio\\\":2026,\\\"Mes\\\":2,\\\"TotalDebe\\\":185600.00,\\\"TotalHaber\\\":185600.00,\\\"FechaCierre\\\":\\\"2026-02-10T21:04:51.5634128-06:00\\\",\\\"Balanceado\\\":true}\"'),(398,2,'2026-02-10 21:29:22','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-11T03:29:22.2765687Z\\\"}\"'),(399,2,'2026-02-10 21:29:50','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(400,2,'2026-02-10 21:29:55','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(401,2,'2026-02-10 21:30:21','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(402,2,'2026-02-10 21:30:35','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(403,2,'2026-02-10 21:31:50','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(404,2,'2026-02-10 21:31:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(405,1,'2026-02-10 21:42:51','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:42:51.591792Z\\\"}\"'),(406,1,'2026-02-10 21:43:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:43:20.3937673Z\\\"}\"'),(407,1,'2026-02-10 21:44:42','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:44:42.6717719Z\\\"}\"'),(408,1,'2026-02-10 21:45:25','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:45:24.7628489Z\\\"}\"'),(409,1,'2026-02-10 21:45:55','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:45:55.5592585Z\\\"}\"'),(410,1,'2026-02-10 21:48:53','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:48:53.827135Z\\\"}\"'),(411,1,'2026-02-10 21:51:27','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:51:27.0026722Z\\\"}\"'),(412,1,'2026-02-10 21:51:49','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:51:49.7198808Z\\\"}\"'),(413,1,'2026-02-10 21:53:18','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:53:18.5889205Z\\\"}\"'),(414,1,'2026-02-10 21:54:45','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:54:44.9506041Z\\\"}\"'),(415,1,'2026-02-10 21:55:43','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:55:43.2768299Z\\\"}\"'),(416,1,'2026-02-10 21:56:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:56:20.6119457Z\\\"}\"'),(417,1,'2026-02-10 21:57:02','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T03:57:02.9181467Z\\\"}\"'),(418,1,'2026-02-10 22:02:40','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:02:40.9560958Z\\\"}\"'),(419,1,'2026-02-10 22:02:43','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(420,1,'2026-02-10 22:02:51','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(421,1,'2026-02-10 22:03:21','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:03:21.7613527Z\\\"}\"'),(422,1,'2026-02-10 22:03:38','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(423,1,'2026-02-10 22:17:57','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:17:57.555567Z\\\"}\"'),(424,1,'2026-02-10 22:17:59','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(425,1,'2026-02-10 22:20:24','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:20:24.4695503Z\\\"}\"'),(426,1,'2026-02-10 22:21:16','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:21:16.4511379Z\\\"}\"'),(427,1,'2026-02-10 22:21:47','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:21:47.2864818Z\\\"}\"'),(428,1,'2026-02-10 22:23:08','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:23:08.0805756Z\\\"}\"'),(429,1,'2026-02-10 22:27:12','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:27:11.9384954Z\\\"}\"'),(430,1,'2026-02-10 22:27:48','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:27:48.5995492Z\\\"}\"'),(431,1,'2026-02-10 22:28:17','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:28:17.553241Z\\\"}\"'),(432,1,'2026-02-10 22:28:39','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:28:39.994928Z\\\"}\"'),(433,1,'2026-02-10 22:28:59','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:28:59.8150256Z\\\"}\"'),(434,1,'2026-02-10 22:29:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:29:20.8438749Z\\\"}\"'),(435,1,'2026-02-10 22:29:42','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:29:42.6098418Z\\\"}\"'),(436,1,'2026-02-10 22:30:38','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:30:38.5386749Z\\\"}\"'),(437,1,'2026-02-10 22:32:41','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:32:41.4616327Z\\\"}\"'),(438,1,'2026-02-10 22:33:08','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:33:08.0181539Z\\\"}\"'),(439,1,'2026-02-10 22:33:31','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:33:31.1638845Z\\\"}\"'),(440,1,'2026-02-10 22:33:53','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:33:53.598456Z\\\"}\"'),(441,1,'2026-02-10 22:34:20','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:34:20.1393276Z\\\"}\"'),(442,1,'2026-02-10 22:35:58','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:35:58.8264977Z\\\"}\"'),(443,1,'2026-02-10 22:36:19','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:36:19.8559609Z\\\"}\"'),(444,1,'2026-02-10 22:36:40','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:36:40.6344286Z\\\"}\"'),(445,1,'2026-02-10 22:37:30','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:37:30.2237493Z\\\"}\"'),(446,1,'2026-02-10 22:38:03','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:38:03.5681667Z\\\"}\"'),(447,1,'2026-02-10 22:40:34','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:40:34.4942172Z\\\"}\"'),(448,1,'2026-02-10 22:41:50','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:41:50.4960689Z\\\"}\"'),(449,1,'2026-02-10 22:55:23','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T04:55:23.7178222Z\\\"}\"'),(450,1,'2026-02-11 11:14:19','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:14:18.0093052Z\\\"}\"'),(451,1,'2026-02-11 11:15:00','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(452,1,'2026-02-11 11:17:25','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:17:24.4957498Z\\\"}\"'),(453,1,'2026-02-11 11:17:28','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(454,1,'2026-02-11 11:17:35','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(455,1,'2026-02-11 11:17:38','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(456,1,'2026-02-11 11:20:16','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:20:15.4754224Z\\\"}\"'),(457,1,'2026-02-11 11:20:18','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(458,1,'2026-02-11 11:20:21','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(459,1,'2026-02-11 11:20:33','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(460,1,'2026-02-11 11:27:13','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:27:12.3834644Z\\\"}\"'),(461,1,'2026-02-11 11:27:19','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(462,1,'2026-02-11 11:30:04','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:30:03.8514334Z\\\"}\"'),(463,1,'2026-02-11 11:31:30','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:31:28.9720559Z\\\"}\"'),(464,1,'2026-02-11 11:31:39','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(465,1,'2026-02-11 11:31:54','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(466,1,'2026-02-11 11:32:33','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:32:32.2763962Z\\\"}\"'),(467,1,'2026-02-11 11:33:50','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:33:49.0892352Z\\\"}\"'),(468,1,'2026-02-11 11:35:54','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T17:35:52.9574765Z\\\"}\"'),(469,1,'2026-02-11 12:17:13','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:17:12.2611007Z\\\"}\"'),(470,1,'2026-02-11 12:17:15','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(471,1,'2026-02-11 12:17:30','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(472,1,'2026-02-11 12:17:37','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(473,1,'2026-02-11 12:17:39','El usuario consulta Asientos por Periodo','\"{\\\"IdPeriodo\\\":0,\\\"IdEstado\\\":null,\\\"Detalle\\\":\\\"Consulta de asientos por filtro de periodo\\\"}\"'),(474,1,'2026-02-11 12:22:08','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:22:06.9754848Z\\\"}\"'),(475,1,'2026-02-11 12:28:05','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:28:04.5007227Z\\\"}\"'),(476,1,'2026-02-11 12:28:08','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:28:07.0501336Z\\\"}\"'),(477,1,'2026-02-11 12:28:43','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:28:42.4565734Z\\\"}\"'),(478,1,'2026-02-11 12:37:57','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:37:56.4290613Z\\\"}\"'),(479,1,'2026-02-11 12:40:30','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:40:29.4773188Z\\\"}\"'),(480,1,'2026-02-11 12:45:41','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T18:45:40.146894Z\\\"}\"'),(481,1,'2026-02-11 12:45:42','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(482,1,'2026-02-11 12:45:52','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(483,1,'2026-02-11 13:05:03','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:05:02.0301721Z\\\"}\"'),(484,1,'2026-02-11 13:05:05','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(485,1,'2026-02-11 13:07:37','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:07:36.3439092Z\\\"}\"'),(486,1,'2026-02-11 13:07:39','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(487,1,'2026-02-11 13:07:53','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(488,1,'2026-02-11 13:08:49','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:08:48.3130459Z\\\"}\"'),(489,1,'2026-02-11 13:08:56','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(490,1,'2026-02-11 13:17:43','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:17:42.4815621Z\\\"}\"'),(491,1,'2026-02-11 13:17:45','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(492,1,'2026-02-11 13:20:05','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(493,1,'2026-02-11 13:20:11','Cambio de contraseña','\"{\\\"IdUsuario\\\":\\\"2\\\"}\"'),(494,1,'2026-02-11 13:20:12','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(495,1,'2026-02-11 13:21:52','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:21:51.3911015Z\\\"}\"'),(496,1,'2026-02-11 13:21:54','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(497,1,'2026-02-11 13:22:02','Cambio de contraseña','\"{\\\"IdUsuario\\\":\\\"2\\\"}\"'),(498,1,'2026-02-11 13:22:02','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(499,1,'2026-02-11 13:22:30','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(500,1,'2026-02-11 13:31:31','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:31:29.7336604Z\\\"}\"'),(501,1,'2026-02-11 13:31:32','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(502,1,'2026-02-11 13:31:48','Cambio de contraseña','\"{\\\"IdUsuario\\\":\\\"2\\\"}\"'),(503,1,'2026-02-11 13:31:48','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(504,2,'2026-02-11 13:31:56','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-11T19:31:55.9084564Z\\\"}\"'),(505,2,'2026-02-11 13:32:43','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(506,2,'2026-02-11 13:33:06','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(507,2,'2026-02-11 13:33:18','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-11T19:33:17.3046971Z\\\"}\"'),(508,1,'2026-02-11 13:35:54','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:35:53.2646246Z\\\"}\"'),(509,1,'2026-02-11 13:35:55','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(510,1,'2026-02-11 13:36:47','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:36:46.38166Z\\\"}\"'),(511,1,'2026-02-11 13:36:50','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(512,1,'2026-02-11 13:39:40','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:39:39.5844757Z\\\"}\"'),(513,1,'2026-02-11 13:39:42','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(514,1,'2026-02-11 13:41:35','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:41:33.8009314Z\\\"}\"'),(515,1,'2026-02-11 13:41:36','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(516,1,'2026-02-11 13:41:55','Cambio de contraseña','\"{\\\"IdUsuario\\\":\\\"2\\\"}\"'),(517,1,'2026-02-11 13:41:55','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(518,2,'2026-02-11 13:42:11','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-11T19:42:09.9818674Z\\\"}\"'),(519,1,'2026-02-11 13:43:37','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:43:36.0275206Z\\\"}\"'),(520,1,'2026-02-11 13:43:39','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(521,1,'2026-02-11 13:43:47','Cambio de contraseña','\"{\\\"IdUsuario\\\":\\\"2\\\"}\"'),(522,1,'2026-02-11 13:43:48','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(523,1,'2026-02-11 13:43:52','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:43:51.4877418Z\\\"}\"'),(524,1,'2026-02-11 13:43:53','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(525,2,'2026-02-11 13:44:05','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Cristian\\\",\\\"Fecha\\\":\\\"2026-02-11T19:44:03.9565883Z\\\"}\"'),(526,2,'2026-02-11 13:44:56','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(527,2,'2026-02-11 13:45:09','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(528,1,'2026-02-11 13:50:47','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:50:45.8663934Z\\\"}\"'),(529,1,'2026-02-11 13:50:49','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(530,1,'2026-02-11 13:50:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(531,1,'2026-02-11 13:51:40','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:51:39.5614528Z\\\"}\"'),(532,1,'2026-02-11 13:51:43','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(533,1,'2026-02-11 13:51:51','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(534,1,'2026-02-11 13:51:57','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(535,1,'2026-02-11 13:52:00','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(536,1,'2026-02-11 13:52:03','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(537,1,'2026-02-11 13:57:31','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:57:30.0745051Z\\\"}\"'),(538,1,'2026-02-11 13:57:31','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-11T19:57:30.0745051Z\\\"}\"'),(539,1,'2026-02-11 13:57:33','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(540,1,'2026-02-11 13:58:05','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(541,1,'2026-02-12 11:00:41','Inicio de sesión','\"{\\\"NombreUsuario\\\":\\\"Admin\\\",\\\"Fecha\\\":\\\"2026-02-12T17:00:38.982429Z\\\"}\"'),(542,1,'2026-02-12 11:00:43','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(543,1,'2026-02-12 11:01:17','Consulta paginada de usuarios','\"{\\\"Pagina\\\":1,\\\"UsuariosMostrados\\\":3}\"'),(544,1,'2026-02-12 13:36:27','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:36:24.2055529Z\"}'),(545,1,'2026-02-12 13:36:28','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:36:26.3679318-06:00\"}'),(546,1,'2026-02-12 13:36:37','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:36:34.6285948-06:00\"}'),(547,1,'2026-02-12 13:36:43','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:36:40.9027298-06:00\"}'),(548,1,'2026-02-12 13:36:47','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:36:44.7465492-06:00\"}'),(549,1,'2026-02-12 13:37:04','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:02.0762301-06:00\"}'),(550,1,'2026-02-12 13:37:09','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:07.0766646-06:00\"}'),(551,1,'2026-02-12 13:37:12','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:10.2890558-06:00\"}'),(552,1,'2026-02-12 13:37:13','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:11.0549177-06:00\"}'),(553,1,'2026-02-12 13:37:14','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:12.0549591-06:00\"}'),(554,1,'2026-02-12 13:37:14','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:12.4257609-06:00\"}'),(555,1,'2026-02-12 13:37:15','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:12.803306-06:00\"}'),(556,1,'2026-02-12 13:37:16','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:37:13.7547075-06:00\"}'),(557,1,'2026-02-12 13:41:17','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:41:14.4006118Z\"}'),(558,1,'2026-02-12 13:41:19','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:41:16.517504-06:00\"}'),(559,1,'2026-02-12 13:41:20','Cambio de estado de usuario','{\"Id_Usuario\":1,\"Nombre_Usuario\":\"Admin\",\"Apellido_Usuario\":\"Sistema\",\"Estado_Anterior\":\"Activo\",\"Estado_Nuevo\":\"Inactivo\"}'),(560,1,'2026-02-12 13:41:21','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:41:18.5460658-06:00\"}'),(561,1,'2026-02-12 13:41:24','Cambio de estado de usuario','{\"Id_Usuario\":1,\"Nombre_Usuario\":\"Admin\",\"Apellido_Usuario\":\"Sistema\",\"Estado_Anterior\":\"Inactivo\",\"Estado_Nuevo\":\"Activo\"}'),(562,1,'2026-02-12 13:41:24','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:41:21.7758202-06:00\"}'),(563,1,'2026-02-12 13:41:28','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:41:25.8039841-06:00\"}'),(564,1,'2026-02-12 13:41:29','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:41:27.2764593-06:00\"}'),(565,1,'2026-02-12 13:43:11','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:43:08.8463235Z\"}'),(566,1,'2026-02-12 13:43:13','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:43:11.0337624-06:00\"}'),(567,1,'2026-02-12 13:43:16','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:43:14.1028961-06:00\"}'),(568,1,'2026-02-12 13:45:44','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:45:41.4996716Z\"}'),(569,1,'2026-02-12 13:45:44','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:45:41.5868423Z\"}'),(570,1,'2026-02-12 13:45:46','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:45:44.2459082-06:00\"}'),(571,1,'2026-02-12 13:45:54','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:45:52.0966401-06:00\"}'),(572,1,'2026-02-12 13:45:58','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:45:55.9486744-06:00\"}'),(573,1,'2026-02-12 13:46:12','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:46:09.5828862-06:00\"}'),(574,1,'2026-02-12 13:46:59','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:46:57.4341824-06:00\"}'),(575,1,'2026-02-12 13:47:07','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:47:04.9157447-06:00\"}'),(576,1,'2026-02-12 13:51:28','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:51:25.7527418Z\"}'),(577,1,'2026-02-12 13:51:59','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:51:56.9731722-06:00\"}'),(578,1,'2026-02-12 13:52:16','Cambio de estado de usuario','{\"IdUsuario\":1,\"NombreUsuario\":\"Admin\",\"ApellidoUsuario\":\"Sistema\",\"EstadoAnterior\":\"Activo\",\"EstadoNuevo\":\"Bloqueado\"}'),(579,1,'2026-02-12 13:52:16','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:52:14.1521586-06:00\"}'),(580,1,'2026-02-12 13:52:34','Cambio de estado de usuario','{\"IdUsuario\":1,\"NombreUsuario\":\"Admin\",\"ApellidoUsuario\":\"Sistema\",\"EstadoAnterior\":\"Bloqueado\",\"EstadoNuevo\":\"Activo\"}'),(581,1,'2026-02-12 13:52:34','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T13:52:32.4117488-06:00\"}'),(582,1,'2026-02-12 14:08:28','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:08:25.6492368\"}'),(583,1,'2026-02-12 14:08:30','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T14:08:28.0274233-06:00\"}'),(584,1,'2026-02-12 14:15:01','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:14:58.7241405\"}'),(585,1,'2026-02-12 14:15:06','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T14:15:03.478472-06:00\"}'),(586,1,'2026-02-12 14:17:31','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:17:29.1510481\"}'),(587,1,'2026-02-12 14:17:34','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T14:17:31.5580466-06:00\"}'),(588,1,'2026-02-12 14:18:26','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T14:18:24.4164459-06:00\"}'),(589,1,'2026-02-12 14:24:42','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:24:39.6166949\"}'),(590,1,'2026-02-12 14:24:44','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":3},\"Fecha\":\"2026-02-12T14:24:42.0303446-06:00\"}'),(591,1,'2026-02-12 14:25:18','Usuario creado','{\"IdUsuario\":4,\"NombreUsuario\":\"Emilio\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"Estado\":\"Activo\"}'),(592,1,'2026-02-12 14:25:18','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:25:16.3813014-06:00\"}'),(593,1,'2026-02-12 14:25:29','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:25:27.2326414-06:00\"}'),(594,1,'2026-02-12 14:27:36','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:27:33.9846305\"}'),(595,1,'2026-02-12 14:27:38','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:27:36.0973685-06:00\"}'),(596,1,'2026-02-12 14:27:49','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:27:47.4059116-06:00\"}'),(597,1,'2026-02-12 14:32:00','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:31:56.4547009\"}'),(598,1,'2026-02-12 14:32:02','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:31:59.9407004-06:00\"}'),(599,1,'2026-02-12 14:32:14','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:32:12.3881155-06:00\"}'),(600,1,'2026-02-12 14:32:24','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:32:21.655892-06:00\"}'),(601,1,'2026-02-12 14:41:55','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:41:52.5942935\"}'),(602,1,'2026-02-12 14:41:58','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:41:55.7493808-06:00\"}'),(603,1,'2026-02-12 14:42:07','Usuario actualizado','{\"Antes\":{\"IdUsuario\":4,\"Usuario\":\"emr03\",\"NombreUsuario\":\"Emilio\",\"ApellidoUsuario\":\"Smith Rocha\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"ClaveCifrada\":\"\",\"TagAutenticacion\":\"\",\"Nonce\":\"\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"},\"Despues\":{\"IdUsuario\":4,\"Usuario\":\"emr03\",\"NombreUsuario\":\"Emilios\",\"ApellidoUsuario\":\"Smith Rocha\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"ClaveCifrada\":\"ALyKsRZEqwpz+g==\",\"TagAutenticacion\":\"SG1VJbcHc31ZlCxPxOBhvA==\",\"Nonce\":\"s8ucNuZzw2YoLWZc\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"}}'),(604,1,'2026-02-12 14:42:08','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:42:05.5948765-06:00\"}'),(605,1,'2026-02-12 14:42:15','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:42:13.114294-06:00\"}'),(606,1,'2026-02-12 14:52:20','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:52:18.0224669\"}'),(607,1,'2026-02-12 14:52:22','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:52:19.8612953-06:00\"}'),(608,4,'2026-02-12 14:53:11','Rol asignado a usuario','{\"idUsuario\":4,\"idRol\":\"CONTADOR\"}'),(609,1,'2026-02-12 14:53:11','Usuario actualizado','{\"Antes\":{\"IdUsuario\":4,\"Usuario\":\"emr03\",\"NombreUsuario\":\"Emilios\",\"ApellidoUsuario\":\"Smith Rocha\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"ClaveCifrada\":\"\",\"TagAutenticacion\":\"\",\"Nonce\":\"\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"},\"Despues\":{\"IdUsuario\":4,\"Usuario\":\"emr03\",\"NombreUsuario\":\"Emilios\",\"ApellidoUsuario\":\"Smith Rocha\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"ClaveCifrada\":\"KGWd7hQT6MQ=\",\"TagAutenticacion\":\"LTj4UdLPvD7bvVPwjVl9Dg==\",\"Nonce\":\"MhDYtDsT3tdSojKA\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"}}'),(610,1,'2026-02-12 14:53:12','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:53:09.4012549-06:00\"}'),(611,4,'2026-02-12 14:53:26','Rol removido de usuario','{\"idUsuario\":4,\"idRol\":\"CONTADOR\"}'),(612,4,'2026-02-12 14:53:26','Rol asignado a usuario','{\"idUsuario\":4,\"idRol\":\"CONTADOR\"}'),(613,1,'2026-02-12 14:53:26','Usuario actualizado','{\"Antes\":{\"IdUsuario\":4,\"Usuario\":\"emr03\",\"NombreUsuario\":\"Emilios\",\"ApellidoUsuario\":\"Smith Rocha\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"ClaveCifrada\":\"\",\"TagAutenticacion\":\"\",\"Nonce\":\"\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"},\"Despues\":{\"IdUsuario\":4,\"Usuario\":\"emr03\",\"NombreUsuario\":\"Emilios\",\"ApellidoUsuario\":\"Smith Rocha\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"emilio.smith.rocha@cuc.cr\",\"ClaveCifrada\":\"tZpOIa7henq8fQ==\",\"TagAutenticacion\":\"uJF/NTiZQ3PBy9uFEL3vyQ==\",\"Nonce\":\"16CZKEAcpHGH1p8w\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"}}'),(614,1,'2026-02-12 14:53:27','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:53:24.4214253-06:00\"}'),(615,1,'2026-02-12 14:55:30','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T14:55:27.9321814\"}'),(616,1,'2026-02-12 14:55:32','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:55:29.8649481-06:00\"}'),(617,1,'2026-02-12 14:56:06','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T14:56:03.4349384-06:00\"}'),(618,2,'2026-02-12 14:56:28','Rol removido de usuario','{\"idUsuario\":2,\"idRol\":\"CONTADOR_JEFE\"}'),(619,2,'2026-02-12 14:56:28','Rol asignado a usuario','{\"idUsuario\":2,\"idRol\":\"CONTADOR_JEFE\"}'),(620,2,'2026-02-12 14:56:28','Rol asignado a usuario','{\"idUsuario\":2,\"idRol\":\"CONTADOR\"}'),(621,2,'2026-02-12 14:56:28','Rol asignado a usuario','{\"idUsuario\":2,\"idRol\":\"ADMIN\"}'),(622,1,'2026-02-12 14:56:28','Usuario actualizado','{\"Antes\":{\"IdUsuario\":2,\"Usuario\":\"cbv09\",\"NombreUsuario\":\"Cristian\",\"ApellidoUsuario\":\"Brenes Víquez\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"cristian.brenes.viquez@cuc.cr\",\"ClaveCifrada\":\"\",\"TagAutenticacion\":\"\",\"Nonce\":\"\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"},\"Despues\":{\"IdUsuario\":2,\"Usuario\":\"cbv09\",\"NombreUsuario\":\"Cristian\",\"ApellidoUsuario\":\"Brenes Víquez\",\"NombreCompleto\":\"\",\"CorreoElectronico\":\"cristian.brenes.viquez@cuc.cr\",\"ClaveCifrada\":\"we5Sx15Inw==\",\"TagAutenticacion\":\"Wfv4cLWOqSZU4JRAcBsc8g==\",\"Nonce\":\"KRt6UkIhf0RbdoC3\",\"Estado\":0,\"IntentosFallidos\":0,\"UltimoIntento\":null,\"Encontrado\":0,\"NombreRol\":\"\"}}'),(623,1,'2026-02-12 14:56:28','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":6},\"Fecha\":\"2026-02-12T14:56:26.3543417-06:00\"}'),(624,1,'2026-02-12 14:56:46','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":6},\"Fecha\":\"2026-02-12T14:56:44.2869-06:00\"}'),(626,1,'2026-02-12 15:00:48','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:00:46.1532215\"}'),(627,1,'2026-02-12 15:00:50','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:00:48.0654215-06:00\"}'),(628,1,'2026-02-12 15:01:31','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:01:28.6947714\"}'),(629,1,'2026-02-12 15:01:34','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:01:31.9807759-06:00\"}'),(630,1,'2026-02-12 15:01:44','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:01:42.1430556-06:00\"}'),(631,1,'2026-02-12 15:05:12','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:05:09.3837607\"}'),(632,1,'2026-02-12 15:05:14','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:05:11.6632711-06:00\"}'),(633,1,'2026-02-12 15:07:07','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:07:04.5762062\"}'),(634,1,'2026-02-12 15:07:09','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:07:06.9114039-06:00\"}'),(635,1,'2026-02-12 15:09:49','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:09:46.5896397\"}'),(636,1,'2026-02-12 15:09:50','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:09:48.3333754-06:00\"}'),(637,1,'2026-02-12 15:11:57','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:11:54.7865885\"}'),(638,1,'2026-02-12 15:11:58','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:11:56.2599929-06:00\"}'),(639,1,'2026-02-12 15:14:41','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:14:38.7539961\"}'),(640,1,'2026-02-12 15:14:43','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:14:40.6392096-06:00\"}'),(641,1,'2026-02-12 15:19:25','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:19:22.1742836\"}'),(642,1,'2026-02-12 15:19:26','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:19:24.0691186-06:00\"}'),(643,1,'2026-02-12 15:20:38','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:20:35.991449\"}'),(644,1,'2026-02-12 15:20:40','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:20:37.5612947-06:00\"}'),(645,1,'2026-02-12 15:21:34','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:21:31.2494107\"}'),(646,1,'2026-02-12 15:21:35','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:21:33.1621749-06:00\"}'),(647,1,'2026-02-12 15:22:49','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:22:46.6023469\"}'),(648,1,'2026-02-12 15:22:51','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:22:48.3569377-06:00\"}'),(649,1,'2026-02-12 15:23:04','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:23:01.2494097\"}'),(650,1,'2026-02-12 15:23:05','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:23:02.915256-06:00\"}'),(651,1,'2026-02-12 15:24:10','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:24:07.7981053\"}'),(652,1,'2026-02-12 15:24:12','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:24:09.6069076-06:00\"}'),(653,1,'2026-02-12 15:24:32','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:24:30.0291951\"}'),(654,1,'2026-02-12 15:24:34','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:24:31.6072378-06:00\"}'),(655,1,'2026-02-12 15:25:39','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:25:37.0245714\"}'),(656,1,'2026-02-12 15:25:41','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:25:38.8856128-06:00\"}'),(657,1,'2026-02-12 15:26:42','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T15:26:39.7703873\"}'),(658,1,'2026-02-12 15:26:46','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:26:43.7167219-06:00\"}'),(659,4,'2026-02-12 15:27:01','Cambio de estado de usuario','{\"IdUsuario\":4,\"NombreUsuario\":\"Emilios\",\"ApellidoUsuario\":\"Smith Rocha\",\"EstadoAnterior\":\"Activo\",\"EstadoNuevo\":\"Bloqueado\"}'),(660,1,'2026-02-12 15:27:01','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:26:59.3002112-06:00\"}'),(661,3,'2026-02-12 15:27:03','Cambio de estado de usuario','{\"IdUsuario\":3,\"NombreUsuario\":\"Steven\",\"ApellidoUsuario\":\"Guillen Alfaro\",\"EstadoAnterior\":\"Activo\",\"EstadoNuevo\":\"Inactivo\"}'),(662,1,'2026-02-12 15:27:03','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T15:27:01.2099723-06:00\"}'),(663,1,'2026-02-12 19:51:12','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T19:51:09.1296995\"}'),(664,1,'2026-02-12 19:51:15','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T19:51:12.0293769-06:00\"}'),(665,1,'2026-02-12 19:51:29','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T19:51:26.1049957-06:00\"}'),(666,2,'2026-02-12 19:51:35','Cambio de estado de usuario','{\"IdUsuario\":2,\"NombreUsuario\":\"Cristian\",\"ApellidoUsuario\":\"Brenes Víquez\",\"EstadoAnterior\":\"Activo\",\"EstadoNuevo\":\"Inactivo\"}'),(667,1,'2026-02-12 19:51:35','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T19:51:32.552006-06:00\"}'),(668,2,'2026-02-12 19:51:36','Cambio de estado de usuario','{\"IdUsuario\":2,\"NombreUsuario\":\"Cristian\",\"ApellidoUsuario\":\"Brenes Víquez\",\"EstadoAnterior\":\"Inactivo\",\"EstadoNuevo\":\"Activo\"}'),(669,1,'2026-02-12 19:51:36','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T19:51:33.8624758-06:00\"}'),(670,1,'2026-02-12 19:51:42','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T19:51:39.8421582-06:00\"}'),(671,1,'2026-02-12 19:51:48','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T19:51:45.0222123-06:00\"}'),(672,1,'2026-02-12 19:53:50','Consulta de Asientos por Periodo','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Asientos por Periodo\",\"Datos\":{\"IdPeriodo\":0,\"IdEstado\":null,\"Detalle\":\"Consulta de asientos por filtro de periodo\"},\"Fecha\":\"2026-02-12T19:53:47.6588579-06:00\"}'),(673,1,'2026-02-12 20:22:57','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T20:22:54.204716\"}'),(674,1,'2026-02-12 20:23:29','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T20:23:26.3562726-06:00\"}'),(675,1,'2026-02-12 20:38:56','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T20:38:52.6734691\"}'),(676,1,'2026-02-12 20:38:57','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T20:38:54.4098935-06:00\"}'),(677,1,'2026-02-12 20:41:06','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T20:41:02.6252709\"}'),(678,1,'2026-02-12 20:41:08','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T20:41:04.963914-06:00\"}'),(679,1,'2026-02-12 20:43:00','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T20:42:56.5853954\"}'),(680,1,'2026-02-12 20:43:02','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T20:42:59.3670884-06:00\"}'),(681,1,'2026-02-12 20:43:09','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T20:43:06.8407587-06:00\"}'),(682,1,'2026-02-12 20:43:24','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T20:43:21.4546687-06:00\"}'),(683,1,'2026-02-12 20:43:25','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T20:43:22.091172-06:00\"}'),(684,1,'2026-02-12 20:44:19','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T20:44:15.8963676\"}'),(685,1,'2026-02-12 20:44:20','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-12T20:44:17.4560173-06:00\"}'),(686,1,'2026-02-12 20:44:22','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T20:44:19.8481081-06:00\"}'),(687,1,'2026-02-12 20:44:23','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T20:44:20.4705047-06:00\"}'),(688,1,'2026-02-12 20:44:26','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T20:44:23.1462678-06:00\"}'),(689,1,'2026-02-12 21:02:40','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:02:36.9965891\"}'),(690,1,'2026-02-12 21:02:42','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:02:38.838265-06:00\"}'),(691,1,'2026-02-12 21:02:44','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:02:41.7993183-06:00\"}'),(692,1,'2026-02-12 21:02:46','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:02:43.2524559-06:00\"}'),(693,1,'2026-02-12 21:02:47','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:02:44.3200986-06:00\"}'),(694,1,'2026-02-12 21:02:48','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:02:45.1990588-06:00\"}'),(695,1,'2026-02-12 21:02:49','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:02:46.0295995-06:00\"}'),(696,1,'2026-02-12 21:03:37','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:03:34.11147\"}'),(697,1,'2026-02-12 21:03:38','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:03:35.4744386-06:00\"}'),(698,1,'2026-02-12 21:03:43','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:03:40.4182988-06:00\"}'),(699,1,'2026-02-12 21:03:52','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:03:49.2465394-06:00\"}'),(700,1,'2026-02-12 21:05:51','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:05:48.0873568\"}'),(701,1,'2026-02-12 21:05:53','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:05:49.8582681-06:00\"}'),(702,1,'2026-02-12 21:05:56','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:05:53.6225406-06:00\"}'),(703,1,'2026-02-12 21:14:23','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:14:20.4961112\"}'),(704,1,'2026-02-12 21:14:25','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:14:21.8742936-06:00\"}'),(705,1,'2026-02-12 21:16:01','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:15:58.4446872\"}'),(706,1,'2026-02-12 21:16:03','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:16:00.2434077-06:00\"}'),(707,1,'2026-02-12 21:18:39','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:18:36.3151066\"}'),(708,1,'2026-02-12 21:18:42','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:18:39.0292374-06:00\"}'),(709,1,'2026-02-12 21:18:57','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:18:54.4008026-06:00\"}'),(710,1,'2026-02-12 21:21:14','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:21:11.3076166\"}'),(711,1,'2026-02-12 21:21:16','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:21:13.3800397-06:00\"}'),(712,1,'2026-02-12 21:22:04','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-12T21:22:01.4947038\"}'),(713,1,'2026-02-12 21:22:06','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-12T21:22:03.0784168-06:00\"}'),(714,1,'2026-02-13 11:31:46','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T11:31:46.3695243\"}'),(715,1,'2026-02-13 11:31:46','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T11:31:46.3750083\"}'),(716,1,'2026-02-13 11:31:49','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-13T11:31:49.4766798-06:00\"}'),(717,1,'2026-02-13 11:32:46','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T11:32:45.582621\"}'),(718,1,'2026-02-13 11:32:47','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":3},\"Fecha\":\"2026-02-13T11:32:47.1916701-06:00\"}'),(719,1,'2026-02-13 11:33:10','Rol creado','{\"IdRol\":\"CONTADOR_ASISTENTE\",\"NombreRol\":\"Contador asistente\",\"Descripcion\":\"Contador asistente\",\"Estado\":\"Activo\"}'),(720,1,'2026-02-13 11:33:11','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:33:10.9321037-06:00\"}'),(721,1,'2026-02-13 11:33:20','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:33:20.5704843-06:00\"}'),(722,1,'2026-02-13 11:33:22','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:33:22.8012736-06:00\"}'),(723,1,'2026-02-13 11:33:24','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:33:23.8176187-06:00\"}'),(724,1,'2026-02-13 11:33:25','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-13T11:33:25.320136-06:00\"}'),(725,1,'2026-02-13 11:33:26','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:33:26.7702901-06:00\"}'),(726,1,'2026-02-13 11:33:42','Rol actualizado','{\"Antes\":{\"IdRol\":\"CONTADOR_ASISTENTE\",\"NombreRol\":\"Contador asistente\",\"Descripcion\":\"Contador asistente\",\"Estado\":\"Activo\"},\"Despues\":{\"IdRol\":\"CONTADOR_ASISTENTE\",\"NombreRol\":\"Contador asistente\",\"Descripcion\":\"Contador asistentes\",\"Estado\":\"Activo\"}}'),(727,1,'2026-02-13 11:33:42','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:33:42.1095466-06:00\"}'),(728,1,'2026-02-13 11:37:05','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T11:37:05.3371892\"}'),(729,1,'2026-02-13 11:37:07','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:37:07.1527638-06:00\"}'),(730,1,'2026-02-13 11:37:10','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T11:37:09.8723109-06:00\"}'),(731,1,'2026-02-13 12:30:56','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T12:30:56.3412991\"}'),(732,1,'2026-02-13 12:30:58','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":0},\"Fecha\":\"2026-02-13T12:30:58.2619631-06:00\"}'),(733,1,'2026-02-13 14:38:31','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T14:38:30.3779251\"}'),(734,1,'2026-02-13 14:38:32','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T14:38:32.3691009-06:00\"}'),(735,1,'2026-02-13 14:38:41','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-13T14:38:40.8768469-06:00\"}'),(736,1,'2026-02-13 14:55:04','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T14:55:03.9428754\"}'),(737,1,'2026-02-13 14:55:08','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T14:55:08.437544-06:00\"}'),(738,1,'2026-02-13 14:55:15','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T14:55:15.1885013-06:00\"}'),(739,1,'2026-02-13 14:55:57','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T14:55:57.1589269\"}'),(740,1,'2026-02-13 14:55:59','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T14:55:59.0256075-06:00\"}'),(741,1,'2026-02-13 14:56:42','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T14:56:41.8595642\"}'),(742,1,'2026-02-13 14:56:44','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T14:56:44.0984882-06:00\"}'),(743,1,'2026-02-13 15:30:15','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:30:14.3369022\"}'),(744,1,'2026-02-13 15:30:16','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:30:16.3945616-06:00\"}'),(745,1,'2026-02-13 15:32:47','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:32:46.6635782\"}'),(746,1,'2026-02-13 15:32:48','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:32:47.9767787-06:00\"}'),(747,1,'2026-02-13 15:42:17','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:42:16.5227104\"}'),(748,1,'2026-02-13 15:42:20','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":0},\"Fecha\":\"2026-02-13T15:42:19.4880153-06:00\"}'),(749,1,'2026-02-13 15:42:21','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:42:20.4530485-06:00\"}'),(750,1,'2026-02-13 15:45:15','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:45:15.0514634\"}'),(751,1,'2026-02-13 15:45:17','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":0},\"Fecha\":\"2026-02-13T15:45:17.3653813-06:00\"}'),(752,1,'2026-02-13 15:45:18','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:45:17.6654575-06:00\"}'),(753,1,'2026-02-13 15:45:26','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:45:26.0448199-06:00\"}'),(754,1,'2026-02-13 15:46:41','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:46:40.2968947\"}'),(755,1,'2026-02-13 15:46:42','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:46:41.8960946-06:00\"}'),(756,1,'2026-02-13 15:46:45','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:46:45.3710842-06:00\"}'),(757,1,'2026-02-13 15:46:49','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:46:49.4311957-06:00\"}'),(758,1,'2026-02-13 15:46:50','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":0},\"Fecha\":\"2026-02-13T15:46:50.4319203-06:00\"}'),(759,1,'2026-02-13 15:49:38','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:49:37.7105261\"}'),(760,1,'2026-02-13 15:50:24','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:50:23.8026921\"}'),(761,1,'2026-02-13 15:50:34','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-13T15:50:34.0670902-06:00\"}'),(762,1,'2026-02-13 15:50:38','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":0},\"Fecha\":\"2026-02-13T15:50:37.7858127-06:00\"}'),(763,1,'2026-02-13 15:51:13','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:51:12.2455475\"}'),(764,1,'2026-02-13 15:51:14','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:51:13.7982469-06:00\"}'),(765,1,'2026-02-13 15:52:07','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T15:52:06.909514\"}'),(766,1,'2026-02-13 15:52:11','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T15:52:10.8853415-06:00\"}'),(767,1,'2026-02-13 16:24:59','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T16:24:58.8606085\"}'),(768,1,'2026-02-13 16:25:02','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T16:25:01.4012583-06:00\"}'),(769,1,'2026-02-13 16:26:53','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T16:26:52.0993227\"}'),(770,1,'2026-02-13 16:32:21','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T16:32:20.6211417\"}'),(771,1,'2026-02-13 16:56:38','Inicio de sesión','{\"NombreUsuario\":\"Admin\",\"Fecha\":\"2026-02-13T16:56:37.8957452\"}'),(772,1,'2026-02-13 16:56:45','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T16:56:44.3309687-06:00\"}'),(773,1,'2026-02-13 16:56:46','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T16:56:46.0156722-06:00\"}'),(774,1,'2026-02-13 16:56:47','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T16:56:47.2039024-06:00\"}'),(775,1,'2026-02-13 16:56:48','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":0},\"Fecha\":\"2026-02-13T16:56:47.7857385-06:00\"}'),(776,1,'2026-02-13 16:56:49','Consulta de Consulta paginada de roles','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de roles\",\"Datos\":{\"Pagina\":1,\"RolesMostrados\":4},\"Fecha\":\"2026-02-13T16:56:48.8840059-06:00\"}'),(777,1,'2026-02-13 16:56:51','Consulta de Consulta paginada de usuarios','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Consulta paginada de usuarios\",\"Datos\":{\"Pagina\":1,\"UsuariosMostrados\":4},\"Fecha\":\"2026-02-13T16:56:50.7783206-06:00\"}'),(778,1,'2026-02-13 16:56:54','Consulta de Asientos por Periodo','{\"TipoAccion\":\"CONSULTAR\",\"Elemento\":\"Asientos por Periodo\",\"Datos\":{\"IdPeriodo\":0,\"IdEstado\":null,\"Detalle\":\"Consulta de asientos por filtro de periodo\"},\"Fecha\":\"2026-02-13T16:56:53.8786936-06:00\"}');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cierrescontables`
--

DROP TABLE IF EXISTS `cierrescontables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cierrescontables` (
  `IdCierre` int(11) NOT NULL AUTO_INCREMENT,
  `IdPeriodo` int(11) NOT NULL,
  `FechaCierre` datetime NOT NULL,
  `IdUsuarioCierre` int(11) DEFAULT NULL,
  `TotalDebe` decimal(18,2) NOT NULL DEFAULT 0.00,
  `TotalHaber` decimal(18,2) NOT NULL DEFAULT 0.00,
  `Estado` enum('PROCESANDO','COMPLETADO','ERROR') NOT NULL DEFAULT 'PROCESANDO',
  `Mensaje` text DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`IdCierre`),
  KEY `IdUsuarioCierre` (`IdUsuarioCierre`),
  KEY `idx_cierres_periodo` (`IdPeriodo`),
  KEY `idx_cierres_fecha` (`FechaCierre`),
  CONSTRAINT `cierrescontables_ibfk_1` FOREIGN KEY (`IdPeriodo`) REFERENCES `periodocontable` (`IdPeriodo`) ON DELETE CASCADE,
  CONSTRAINT `cierrescontables_ibfk_2` FOREIGN KEY (`IdUsuarioCierre`) REFERENCES `usuarios` (`IdUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cierrescontables`
--

LOCK TABLES `cierrescontables` WRITE;
/*!40000 ALTER TABLE `cierrescontables` DISABLE KEYS */;
INSERT INTO `cierrescontables` VALUES (1,1,'2026-02-09 15:09:51',1,100100.00,100100.00,'COMPLETADO',NULL,'2026-02-09 15:09:51'),(2,3,'2026-02-10 21:04:52',1,185600.00,185600.00,'COMPLETADO',NULL,'2026-02-10 21:04:52');
/*!40000 ALTER TABLE `cierrescontables` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentascontables`
--

LOCK TABLES `cuentascontables` WRITE;
/*!40000 ALTER TABLE `cuentascontables` DISABLE KEYS */;
INSERT INTO `cuentascontables` VALUES (1,'1.01.01','Caja General','Activo',4,'Deudor',1,'Activa'),(2,'4.01.01','Ingresos por Servicios','Ingreso',14,'Acreedor',1,'Activa'),(3,'1','ACTIVO','Activo',NULL,'Deudor',0,'Activa'),(4,'1.01','ACTIVO CORRIENTE','Activo',3,'Deudor',0,'Activa'),(5,'1.01.02','Bancos - Cuenta Operativa','Activo',4,'Deudor',1,'Activa'),(6,'1.01.03','Cuentas por Cobrar Clientes','Activo',4,'Deudor',1,'Activa'),(7,'2','PASIVO','Pasivo',NULL,'Acreedor',0,'Activa'),(8,'2.01','PASIVO CORRIENTE','Pasivo',7,'Acreedor',0,'Activa'),(9,'2.01.01','Cuentas por Pagar Proveedores','Pasivo',8,'Acreedor',1,'Activa'),(14,'4','INGRESOS','Ingreso',NULL,'Acreedor',0,'Activa'),(15,'5','GASTOS','Gasto',NULL,'Deudor',0,'Activa'),(16,'5.01.01','Servicios Públicos','Gasto',15,'Deudor',1,'Activa'),(19,'1.01.04','Caja Chica','Activo',4,'Deudor',1,'Activa'),(20,'1.02','ACTIVO NO CORRIENTE','Activo',3,'Deudor',0,'Activa'),(21,'1.02.01','Mobiliario y Equipo','Activo',20,'Deudor',1,'Activa'),(22,'1.02.02','Equipo de Cómputo','Activo',20,'Deudor',1,'Activa'),(23,'2.01.03','IVA por Cobrar (Crédito Fiscal)','Pasivo',8,'Acreedor',1,'Activa'),(24,'2.01.04','Retenciones por Pagar','Pasivo',8,'Acreedor',1,'Activa'),(25,'2.01.05','Préstamos Bancarios CP','Pasivo',8,'Acreedor',1,'Activa'),(26,'5.01.04','Gasto Internet y Teléfono','Gasto',15,'Deudor',1,'Activa'),(27,'5.01.05','Gasto de Publicidad','Gasto',15,'Deudor',1,'Activa'),(28,'5.01.06','Suministros de Oficina','Gasto',15,'Deudor',1,'Activa'),(29,'5.01.07','Gastos Bancarios / Comisiones','Gasto',15,'Deudor',1,'Activa'),(30,'6','COSTOS','Gasto',NULL,'Deudor',0,'Activa'),(31,'6.01.01','Costo de Ventas','Gasto',30,'Deudor',1,'Activa');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodocontable`
--

LOCK TABLES `periodocontable` WRITE;
/*!40000 ALTER TABLE `periodocontable` DISABLE KEYS */;
INSERT INTO `periodocontable` VALUES (1,2026,1,'Cerrado',1,'2026-02-09 15:09:51'),(3,2026,2,'Cerrado',1,'2026-02-10 21:04:51');
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
INSERT INTO `roles` VALUES ('ADMIN','Administrador','Acceso total al sistema','Activo'),('CONTADOR','Contador','Registro de asientos contables','Activo'),('CONTADOR_ASISTENTE','Contador asistente','Contador asistentes','Activo'),('CONTADOR_JEFE','Contador Jefe','Aprobacion y cierre contable','Activo');
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
-- Table structure for table `saldoscuentasperiodo`
--

DROP TABLE IF EXISTS `saldoscuentasperiodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saldoscuentasperiodo` (
  `IdSaldoPeriodo` int(11) NOT NULL AUTO_INCREMENT,
  `IdPeriodo` int(11) NOT NULL,
  `IdCuenta` int(11) NOT NULL,
  `SaldoAnterior` decimal(18,2) DEFAULT 0.00,
  `DebitosPeriodo` decimal(18,2) DEFAULT 0.00,
  `CreditosPeriodo` decimal(18,2) DEFAULT 0.00,
  `SaldoActual` decimal(18,2) DEFAULT 0.00,
  `FechaRegistro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`IdSaldoPeriodo`),
  UNIQUE KEY `uk_saldo_periodo_cuenta` (`IdPeriodo`,`IdCuenta`),
  KEY `idx_saldos_periodo` (`IdPeriodo`),
  KEY `idx_saldos_cuenta` (`IdCuenta`),
  CONSTRAINT `saldoscuentasperiodo_ibfk_1` FOREIGN KEY (`IdPeriodo`) REFERENCES `periodocontable` (`IdPeriodo`) ON DELETE CASCADE,
  CONSTRAINT `saldoscuentasperiodo_ibfk_2` FOREIGN KEY (`IdCuenta`) REFERENCES `cuentascontables` (`IdCuenta`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saldoscuentasperiodo`
--

LOCK TABLES `saldoscuentasperiodo` WRITE;
/*!40000 ALTER TABLE `saldoscuentasperiodo` DISABLE KEYS */;
INSERT INTO `saldoscuentasperiodo` VALUES (1,1,1,0.00,100100.00,0.00,100100.00,'2026-02-09 15:09:51'),(2,1,2,0.00,0.00,100100.00,100100.00,'2026-02-09 15:09:51'),(3,3,3,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(4,3,4,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(5,3,1,100100.00,500.00,0.00,100600.00,'2026-02-10 21:04:51'),(6,3,5,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(7,3,6,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(8,3,19,0.00,0.00,1000.00,-1000.00,'2026-02-10 21:04:51'),(9,3,20,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(10,3,21,0.00,85000.00,0.00,85000.00,'2026-02-10 21:04:51'),(11,3,22,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(12,3,7,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(13,3,8,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(14,3,9,0.00,0.00,85000.00,85000.00,'2026-02-10 21:04:51'),(15,3,23,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(16,3,24,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(17,3,25,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(18,3,14,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(19,3,2,100100.00,0.00,500.00,100600.00,'2026-02-10 21:04:51'),(20,3,15,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(21,3,16,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(22,3,26,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(23,3,27,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(24,3,28,0.00,1000.00,0.00,1000.00,'2026-02-10 21:04:51'),(25,3,29,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(26,3,30,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51'),(27,3,31,0.00,0.00,0.00,0.00,'2026-02-10 21:04:51');
/*!40000 ALTER TABLE `saldoscuentasperiodo` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin',_binary 'c���\�\�\�\"�','Admin','Sistema','admin@correo.com',_binary '��\�\�˱��y\�g\�G>�',_binary '\�\�m\�5��z�A\�','Activo',0,NULL),(2,'cbv09',_binary '\�:�j๥\0-','Cristian','Brenes Víquez','cristian.brenes.viquez@cuc.cr',_binary ']�Q\�y:\�p�$\"!zǱ',_binary '?Mg�\'�\�IK�7','Activo',0,NULL),(3,'sga04',_binary '\�t+Mg9\�','Steven','Guillen Alfaro','steven.guillen.alfaro@cuc.cr',_binary '7�N\�W�ua)�_(��',_binary '[\r�i\��HOw','Activo',0,NULL),(4,'emr03',_binary '(\�!ER�nm�B','Emilios','Smith Rocha','emilio.smith.rocha@cuc.cr',_binary '\�\n+U�$\']�]U`1J=',_binary '\\R+�\����U�\0','Inactivo',0,NULL);
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
INSERT INTO `usuariosroles` VALUES (1,'ADMIN'),(2,'ADMIN'),(2,'CONTADOR'),(2,'CONTADOR_JEFE'),(3,'CONTADOR'),(4,'CONTADOR');
/*!40000 ALTER TABLE `usuariosroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tiusr10pl_siscontableladat'
--

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
	IN p_id_periodo INT,      -- NULL = todos los periodos
    IN p_id_estado INT        -- NULL = todos los estados
)
BEGIN
    SELECT COUNT(*)
    FROM asientocontableencabezado a
    WHERE (p_id_periodo IS NULL OR a.IdPeriodo = p_id_periodo)
      AND (p_id_estado IS NULL OR a.IdEstadoAsiento = p_id_estado);
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
    IN p_id_periodo INT,      -- NULL = todos los periodos
    IN p_id_estado INT,       -- NULL = todos los estados
    IN p_offset INT,
    IN p_limit INT
)
BEGIN
    SELECT 
        a.IdAsiento,
        a.Consecutivo,
        a.Codigo,
        a.Fecha,
        a.Referencia,
        a.IdPeriodo,
        a.IdEstadoAsiento,
        e.Nombre AS EstadoNombre,
        p.Anio,
        p.Mes,
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
    INNER JOIN periodocontable p
        ON p.IdPeriodo = a.IdPeriodo
    LEFT JOIN asientocontabledetalle d
        ON d.IdAsiento = a.IdAsiento
    WHERE (p_id_periodo IS NULL OR a.IdPeriodo = p_id_periodo)
      AND (p_id_estado IS NULL OR a.IdEstadoAsiento = p_id_estado)
    GROUP BY
        a.IdAsiento,
        a.Consecutivo,
        a.Codigo,
        a.Fecha,
        a.Referencia,
        a.IdPeriodo,
        a.IdEstadoAsiento,
        e.Nombre,
        p.Anio,
        p.Mes
    ORDER BY a.Fecha DESC
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_actualizar_encabezado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_actualizar_encabezado`(
    IN p_id_asiento INT,
    IN p_fecha DATE,
    IN p_referencia VARCHAR(200),
    IN p_id_estado_asiento INT,
    IN p_codigo VARCHAR(50),
    IN p_consecutivo INT
)
BEGIN
    UPDATE asientocontableencabezado
    SET 
        Fecha = p_fecha,
        Referencia = p_referencia,
        IdEstadoAsiento = p_id_estado_asiento,
        Codigo = p_codigo,
        Consecutivo = p_consecutivo
    WHERE IdAsiento = p_id_asiento;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_cambiar_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_cambiar_estado`(
    IN p_id_asiento INT,
    IN p_id_estado_nuevo INT,
    IN p_id_usuario INT
)
BEGIN
    DECLARE v_estado_actual INT;
    DECLARE v_periodo_id INT;
    DECLARE v_codigo VARCHAR(50);
    
    -- Obtener estado actual y periodo
    SELECT IdEstadoAsiento, IdPeriodo, Codigo 
    INTO v_estado_actual, v_periodo_id, v_codigo
    FROM asientocontableencabezado 
    WHERE IdAsiento = p_id_asiento;
    
    -- Validar transiciones permitidas según reglas de negocio
    IF v_estado_actual = 5 THEN -- ANULADO
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede modificar un asiento anulado';
    END IF;
    
    IF v_estado_actual = 1 THEN -- BORRADOR
        IF p_id_estado_nuevo NOT IN (2, 5) THEN -- Solo puede ir a Pendiente o Anulado
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transición de estado no permitida para borrador';
        END IF;
    END IF;
    
    IF v_estado_actual = 2 THEN -- PENDIENTE APROBACION
        IF p_id_estado_nuevo NOT IN (3, 4, 5) THEN -- Solo puede ir a Aprobado, Rechazado o Anulado
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transición de estado no permitida para pendiente';
        END IF;
    END IF;
    
    IF v_estado_actual = 3 THEN -- APROBADO
        IF p_id_estado_nuevo NOT IN (2, 5) THEN -- Solo puede ir a Pendiente o Anulado
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transición de estado no permitida para aprobado';
        END IF;
    END IF;
    
    IF v_estado_actual = 4 THEN -- RECHAZADO
        IF p_id_estado_nuevo != 2 THEN -- Solo puede volver a Pendiente
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transición de estado no permitida para rechazado';
        END IF;
    END IF;
    
    -- Actualizar estado
    UPDATE asientocontableencabezado
    SET IdEstadoAsiento = p_id_estado_nuevo
    WHERE IdAsiento = p_id_asiento;
    
    -- Registrar en bitácora
    INSERT INTO bitacora (IdUsuarioAccion, DescripcionAccion, ListadoAccion)
    VALUES (
        p_id_usuario,
        CONCAT('Cambio de estado asiento ', v_codigo),
        JSON_OBJECT(
            'asiento_id', p_id_asiento,
            'codigo', v_codigo,
            'estado_anterior', v_estado_actual,
            'estado_nuevo', p_id_estado_nuevo,
            'periodo_id', v_periodo_id,
            'fecha_cambio', NOW()
        )
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_eliminar_detalles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_eliminar_detalles`(
    IN p_id_asiento INT
)
BEGIN
    DELETE FROM asientocontabledetalle 
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
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
    DECLARE v_codigo_generado VARCHAR(50);

    -- 1. Calculamos el siguiente número dentro del periodo
    SELECT IFNULL(MAX(Consecutivo), 0) + 1
    INTO v_consecutivo
    FROM asientocontableencabezado
    WHERE IdPeriodo = p_id_periodo;

    -- 2. Formateamos el código (ej: AS-0001)
    SET v_codigo_generado = CONCAT('AS-', LPAD(v_consecutivo, 4, '0'));

    -- 3. Insertamos
    INSERT INTO asientocontableencabezado
    (
        Consecutivo, Fecha, Codigo, Referencia,
        IdPeriodo, IdEstadoAsiento, IdUsuario
    )
    VALUES
    (
        v_consecutivo, p_fecha, v_codigo_generado, p_referencia,
        p_id_periodo, p_id_estado, p_id_usuario
    );

    -- 4. Devolvemos el ID generado
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_Asiento_ObtenerSiguienteConsecutivo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_Asiento_ObtenerSiguienteConsecutivo`()
BEGIN
    -- Corregido: usando el nombre real de la tabla
    SELECT IFNULL(MAX(Consecutivo), 0) + 1 AS Siguiente 
    FROM asientocontableencabezado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_obtener_detalles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_obtener_detalles`(
    IN p_id_asiento INT
)
BEGIN
    SELECT 
        IdAsientoDetalle,
        IdAsiento,
        IdCuentaContable,
        TipoMovimiento,
        Monto,
        Descripcion
    FROM asientocontabledetalle
    WHERE IdAsiento = p_id_asiento
    ORDER BY IdAsientoDetalle;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_obtener_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_obtener_por_id`(
    IN p_id_asiento INT
)
BEGIN
    SELECT 
        IdAsiento,
        Consecutivo,
        Fecha,
        Codigo,
        Referencia,
        IdPeriodo,
        IdEstadoAsiento,
        IdUsuario
    FROM asientocontableencabezado
    WHERE IdAsiento = p_id_asiento;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_asiento_tiene_relaciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_asiento_tiene_relaciones`(
    IN p_id_asiento INT,
    OUT p_tiene_relaciones BOOLEAN
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM asientocontabledetalle
    WHERE IdAsiento = p_id_asiento;
    
    SET p_tiene_relaciones = v_count > 0;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_CambiarClaveUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CambiarClaveUsuario`(
    IN p_IdUsuario VARCHAR(50),
    IN p_ClaveCifrada BLOB,
    IN p_Tag BLOB,
    IN p_Nonce BLOB
)
BEGIN
    UPDATE usuarios
    SET ClaveCifrada = p_ClaveCifrada,
        TagAutenticacion = p_Tag,
        Nonce = p_Nonce
    WHERE IdUsuario = p_IdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CambiarEstadoUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CambiarEstadoUsuario`(
    IN p_IdUsuario INT,
    IN p_NuevoEstado ENUM('Activo','Inactivo','Bloqueado')
)
BEGIN
    -- Verificar que el usuario exista
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE IdUsuario = p_IdUsuario) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El usuario no existe.';
    END IF;

    -- Actualizar el estado y reiniciar intentos si se activa
    UPDATE usuarios
    SET Estado = p_NuevoEstado,
        IntentosFallidos = CASE 
            WHEN p_NuevoEstado = 'Activo' THEN 0
            ELSE IntentosFallidos
        END,
        UltimoIntento = CASE
            WHEN p_NuevoEstado = 'Activo' THEN NULL
            ELSE UltimoIntento
        END
    WHERE IdUsuario = p_IdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cierres_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_cierres_listar`()
BEGIN
    SELECT 
        c.IdCierre,
        c.IdPeriodo,
        c.FechaCierre,
        c.IdUsuarioCierre,
        c.TotalDebe,
        c.TotalHaber,
        c.Estado,
        c.Mensaje,
        c.FechaRegistro,
        CONCAT(u.NombreUsuario, ' ', u.ApellidoUsuario) as NombreUsuario,
        p.Anio,
        p.Mes
    FROM cierrescontables c
    INNER JOIN periodocontable p ON p.IdPeriodo = c.IdPeriodo
    LEFT JOIN usuarios u ON u.IdUsuario = c.IdUsuarioCierre
    ORDER BY c.FechaCierre DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cierre_calcular_saldos_periodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_cierre_calcular_saldos_periodo`(
    IN p_id_periodo INT,
    IN p_id_periodo_anterior INT
)
BEGIN
    SELECT 
        sa.IdCuenta,
        sa.CodigoCuenta,
        sa.Nombre AS NombreCuenta,
        sa.Tipo AS TipoCuenta,
        sa.TipoSaldo,
        sa.SaldoAnterior,
        COALESCE(mp.Debitos, 0) AS DebitosMes,
        COALESCE(mp.Creditos, 0) AS CreditosMes,
        -- Calcular saldo actual según naturaleza de la cuenta
        CASE sa.TipoSaldo
            WHEN 'Deudor' THEN 
                sa.SaldoAnterior + COALESCE(mp.Debitos, 0) - COALESCE(mp.Creditos, 0)
            WHEN 'Acreedor' THEN 
                sa.SaldoAnterior + COALESCE(mp.Creditos, 0) - COALESCE(mp.Debitos, 0)
            ELSE sa.SaldoAnterior
        END AS SaldoActual,
        -- Determinar naturaleza para el balance
        CASE sa.Tipo
            WHEN 'Activo' THEN 'Deudora'
            WHEN 'Gasto' THEN 'Deudora'
            WHEN 'Pasivo' THEN 'Acreedora'
            WHEN 'Capital' THEN 'Acreedora'
            WHEN 'Ingreso' THEN 'Acreedora'
            ELSE 'Indeterminada'
        END AS Naturaleza
    FROM (
        -- Subquery para saldos anteriores
        SELECT 
            cc.IdCuenta,
            cc.CodigoCuenta,
            cc.Nombre,
            cc.Tipo,
            cc.TipoSaldo,
            COALESCE(
                (SELECT SaldoActual 
                 FROM saldoscuentasperiodo 
                 WHERE IdCuenta = cc.IdCuenta 
                   AND IdPeriodo = p_id_periodo_anterior
                ), 0) AS SaldoAnterior
        FROM cuentascontables cc
        WHERE cc.Estado = 'Activa'
    ) sa
    LEFT JOIN (
        -- Subquery para movimientos del periodo
        SELECT 
            d.IdCuentaContable,
            SUM(CASE WHEN d.TipoMovimiento = 'D' THEN d.Monto ELSE 0 END) AS Debitos,
            SUM(CASE WHEN d.TipoMovimiento = 'C' THEN d.Monto ELSE 0 END) AS Creditos
        FROM asientocontabledetalle d
        INNER JOIN asientocontableencabezado e 
            ON e.IdAsiento = d.IdAsiento
        WHERE e.IdPeriodo = p_id_periodo
          AND e.IdEstadoAsiento = 3 -- Solo asientos APROBADOS
        GROUP BY d.IdCuentaContable
    ) mp ON mp.IdCuentaContable = sa.IdCuenta
    ORDER BY sa.CodigoCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cierre_obtener_ultimo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_cierre_obtener_ultimo`()
BEGIN
    SELECT 
        c.IdCierre,
        c.IdPeriodo,
        c.FechaCierre,
        c.IdUsuarioCierre,
        c.TotalDebe,
        c.TotalHaber,
        c.Estado,
        c.Mensaje,
        c.FechaRegistro,
        CONCAT(u.NombreUsuario, ' ', u.ApellidoUsuario) as NombreUsuario,
        p.Anio,
        p.Mes
    FROM cierrescontables c
    LEFT JOIN periodocontable p ON p.IdPeriodo = c.IdPeriodo
    LEFT JOIN usuarios u ON u.IdUsuario = c.IdUsuarioCierre
    WHERE c.Estado = 'COMPLETADO'
    ORDER BY c.FechaCierre DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cierre_registrar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_cierre_registrar`(
    IN p_id_periodo INT,
    IN p_id_usuario_cierre INT,
    IN p_total_debe DECIMAL(18,2),
    IN p_total_haber DECIMAL(18,2),
    IN p_estado VARCHAR(20),
    IN p_mensaje TEXT
)
BEGIN
    INSERT INTO cierrescontables 
        (IdPeriodo, FechaCierre, IdUsuarioCierre, 
         TotalDebe, TotalHaber, Estado, Mensaje, FechaRegistro)
    VALUES 
        (p_id_periodo, NOW(), p_id_usuario_cierre,
         p_total_debe, p_total_haber, p_estado, p_mensaje, NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContablesActualizarPorIdCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContablesActualizarPorIdCuenta`(
    IN pI_IdCuenta INT,
    IN pI_CodigoCuenta VARCHAR(20),
    IN pI_Nombre VARCHAR(100),
    IN pI_Tipo ENUM('Activo','Pasivo','Capital','Gasto','Ingreso'),
    IN pI_CuentaPadre INT,
    IN pI_TipoSaldo ENUM('Deudor','Acreedor'),
    IN pI_AceptaMovimiento TINYINT(1),
    IN pI_Estado ENUM('Activa','Inactiva')
)
BEGIN
    UPDATE cuentascontables
    SET 
        CodigoCuenta = p_CodigoCuenta,
        Nombre = pI_Nombre,
        Tipo = pI_Tipo,
        CuentaPadre = pI_CuentaPadre,
        TipoSaldo = pI_TipoSaldo,
        AceptaMovimiento = pI_AceptaMovimiento,
        Estado = pI_Estado
    WHERE IdCuenta = pI_IdCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContablesEliminarPorIdCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContablesEliminarPorIdCuenta`(
    IN pI_IdCuenta INT
)
BEGIN
    DELETE FROM cuentascontables
    WHERE IdCuenta = pI_IdCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContablesInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContablesInsertar`(
    IN pI_CodigoCuenta VARCHAR(20),
    IN pI_Nombre VARCHAR(100),
    IN pI_Tipo ENUM('Activo','Pasivo','Capital','Gasto','Ingreso'),
    IN pI_CuentaPadre INT,
    IN pI_TipoSaldo ENUM('Deudor','Acreedor'),
    IN pI_AceptaMovimiento TINYINT(1),
    IN pI_Estado ENUM('Activa','Inactiva')
)
BEGIN
    INSERT INTO cuentascontables 
        (CodigoCuenta, Nombre, Tipo, CuentaPadre, TipoSaldo, AceptaMovimiento, Estado)
    VALUES 
        (pI_CodigoCuenta, pI_Nombre, pI_Tipo, pI_CuentaPadre, pI_TipoSaldo, pI_AceptaMovimiento, pI_Estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContablesListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContablesListar`()
BEGIN
    SELECT * FROM cuentascontables;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContablesListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContablesListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdCuenta,
        CodigoCuenta,
        Nombre,
        Tipo,
        CuentaPadre,
        TipoSaldo,
        AceptaMovimiento,
        Estado
    FROM cuentascontables
    ORDER BY IdCuenta DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContablesListarPorIdCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContablesListarPorIdCuenta`(
    IN pI_IdCuenta INT
)
BEGIN
    SELECT * FROM cuentascontables
    WHERE IdCuenta = pI_IdCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CuentasContables_Count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_CuentasContables_Count`(
    IN pI_Tipo ENUM('Activo','Pasivo','Capital','Gasto','Ingreso'),
    IN pI_Estado ENUM('Activa','Inactiva')
)
BEGIN
    SELECT COUNT(*) AS TotalCuentas
    FROM cuentascontables
    WHERE (pI_Tipo IS NULL OR Tipo = pI_Estado)
      AND (pI_Estado IS NULL OR Estado = pI_Estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cuentas_listar_movimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_cuentas_listar_movimiento`()
BEGIN
    SELECT 
        IdCuenta,
        CodigoCuenta,
        Nombre
    FROM cuentascontables
    WHERE AceptaMovimiento = 1
      AND Estado = 'Activa'
    ORDER BY CodigoCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cuentas_listar_para_combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_cuentas_listar_para_combo`()
BEGIN
    SELECT 
        IdCuenta AS IdCuentaContable, 
        Nombre AS Descripcion,
        CodigoCuenta
    FROM cuentascontables
    WHERE Estado = 'Activa' 
    ORDER BY CodigoCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableActualizarPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableActualizarPorId`(
    IN pI_IdEstadoAsiento INT,
    IN pI_Codigo VARCHAR(20),
    IN pI_Nombre VARCHAR(40),
    IN pI_Descripcion VARCHAR(200),
    IN pI_Estado ENUM('Activo','Inactivo')
)
BEGIN
    UPDATE estadoasientocontable
    SET 
        Codigo = pI_Codigo,
        Nombre = pI_Nombre,
        Descripcion = pI_Descripcion,
        Estado = pI_Estado
    WHERE IdEstadoAsiento = pI_IdEstadoAsiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableCount`(
    IN pI_Estado ENUM('Activo','Inactivo')
)
BEGIN
    SELECT COUNT(*) AS TotalEstados
    FROM estadoasientocontable
    WHERE (pI_Estado IS NULL OR Estado = pI_Estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableEliminarPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableEliminarPorId`(
    IN pI_IdEstadoAsiento INT
)
BEGIN
    DELETE FROM estadoasientocontable
    WHERE IdEstadoAsiento = pI_IdEstadoAsiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableInsertar`(
    IN pI_Codigo VARCHAR(20),
    IN pI_Nombre VARCHAR(40),
    IN pI_Descripcion VARCHAR(200),
    IN pI_Estado ENUM('Activo','Inactivo')
)
BEGIN
    INSERT INTO estadoasientocontable
        (Codigo, Nombre, Descripcion, Estado)
    VALUES
        (pI_Codigo, pI_Nombre, pI_Descripcion, pI_Estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableListar`()
BEGIN
    SELECT * FROM estadoasientocontable;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT *
    FROM estadoasientocontable
    ORDER BY IdEstadoAsiento DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EstadoAsientoContableListarPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_EstadoAsientoContableListarPorId`(
    IN pI_IdEstadoAsiento INT
)
BEGIN
    SELECT * FROM estadoasientocontable
    WHERE IdEstadoAsiento = pI_IdEstadoAsiento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasActualizarPorIdPantalla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasActualizarPorIdPantalla`(
    IN pI_id_pantalla INT,
    IN pI_nombre VARCHAR(40),
    IN pI_descripcion VARCHAR(200),
    IN pI_ruta VARCHAR(100),
    IN pI_estado ENUM('Activa','Inactiva'),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    UPDATE pantallas
    SET
        Nombre = pI_nombre,
        Descripcion = pI_descripcion,
        Ruta = pI_ruta,
        Estado = pI_estado
    WHERE IdPantalla = pI_id_pantalla;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasConteo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasConteo`()
BEGIN
    SELECT COUNT(*) AS Total FROM pantallas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasEliminarPorIdPantalla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasEliminarPorIdPantalla`(
    IN pI_id_pantalla INT,
    OUT pS_resultado INT
)
BEGIN
    DELETE FROM pantallas
    WHERE IdPantalla = pI_id_pantalla;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasInsertar`(
    IN pI_nombre VARCHAR(40),
    IN pI_descripcion VARCHAR(200),
    IN pI_ruta VARCHAR(100),
    IN pI_estado ENUM('Activa','Inactiva'),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    INSERT INTO pantallas (
        Nombre,
        Descripcion,
        Ruta,
        Estado
    )
    VALUES (
        pI_nombre,
        pI_descripcion,
        pI_ruta,
        pI_estado
    );

    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasListar`()
BEGIN
    SELECT 
        IdPantalla,
        Nombre,
        Descripcion,
        Ruta,
        Estado
    FROM pantallas
    ORDER BY IdPantalla DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdPantalla,
        Nombre,
        Descripcion,
        Ruta,
        Estado
    FROM pantallas
    ORDER BY IdPantalla DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PantallasListarPorIdPantalla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PantallasListarPorIdPantalla`(
    IN pI_id_pantalla INT
)
BEGIN
    SELECT 
        IdPantalla,
        Nombre,
        Descripcion,
        Ruta,
        Estado
    FROM pantallas
    WHERE IdPantalla = pI_id_pantalla;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableActualizarPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableActualizarPorId`(
    IN pI_IdPeriodo INT,
    IN pI_Anio INT,
    IN pI_Mes INT,
    IN pI_Estado ENUM('Abierto','Cerrado'),
    IN pI_IdUsuarioCierre INT,
    IN pI_FechaCierre DATETIME
)
BEGIN
    UPDATE periodocontable
    SET 
        Anio = pI_Anio,
        Mes = pI_Mes,
        Estado = pI_Estado,
        IdUsuarioCierre = pI_IdUsuarioCierre,
        FechaCierre = pI_FechaCierre
    WHERE IdPeriodo = pI_IdPeriodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableConteo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableConteo`(
    IN pI_Estado ENUM('Abierto','Cerrado')
)
BEGIN
    SELECT COUNT(*) AS TotalPeriodos
    FROM periodocontable
    WHERE (pI_Estado IS NULL OR Estado = pI_Estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableEliminarPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableEliminarPorId`(
    IN pI_IdPeriodo INT
)
BEGIN
    DELETE FROM periodocontable
    WHERE IdPeriodo = pI_IdPeriodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableInsertar`(
    IN pI_Anio INT,
    IN pI_Mes INT,
    IN pI_Estado ENUM('Abierto','Cerrado'),
    IN pI_IdUsuarioCierre INT,
    IN pI_FechaCierre DATETIME
)
BEGIN
    INSERT INTO periodocontable
        (Anio, Mes, Estado, IdUsuarioCierre, FechaCierre)
    VALUES
        (pI_Anio, pI_Mes, pI_Estado, pI_IdUsuarioCierre, pI_FechaCierre);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableListar`()
BEGIN
    SELECT * FROM periodocontable;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT *
    FROM periodocontable
    ORDER BY IdPeriodo DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PeriodoContableListarPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_PeriodoContableListarPorId`(
    IN pI_IdPeriodo INT
)
BEGIN
    SELECT * FROM periodocontable
    WHERE IdPeriodo = pI_IdPeriodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_periodos_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_periodos_listar`()
BEGIN
    SELECT 
        IdPeriodo,
        Anio,
        Mes,
        Estado,
        IdUsuarioCierre,
        FechaCierre
    FROM periodocontable
    ORDER BY Anio DESC, Mes DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_periodos_listar_para_combo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_periodos_listar_para_combo`()
BEGIN
    SELECT 
        IdPeriodo,
        CONCAT(Mes, '/', Anio) as Descripcion,
        Anio,
        Mes,
        Estado
    FROM periodocontable
    ORDER BY Anio DESC, Mes DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_periodo_cerrar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_periodo_cerrar`(
    IN p_id_periodo INT,
    IN p_id_usuario INT
)
BEGIN
    UPDATE periodocontable 
    SET Estado = 'Cerrado',
        IdUsuarioCierre = p_id_usuario,
        FechaCierre = NOW()
    WHERE IdPeriodo = p_id_periodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_periodo_obtener_anterior_cerrado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_periodo_obtener_anterior_cerrado`(
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT 
        IdPeriodo,
        Anio,
        Mes,
        Estado,
        IdUsuarioCierre,
        FechaCierre
    FROM periodocontable 
    WHERE Estado = 'Cerrado'
      AND (Anio < p_anio OR (Anio = p_anio AND Mes < p_mes))
    ORDER BY Anio DESC, Mes DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_periodo_obtener_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_periodo_obtener_por_id`(
    IN p_id_periodo INT
)
BEGIN
    SELECT 
        IdPeriodo,
        Anio,
        Mes,
        Estado,
        IdUsuarioCierre,
        FechaCierre
    FROM periodocontable
    WHERE IdPeriodo = p_id_periodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_periodo_validar_anteriores_cerrados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_periodo_validar_anteriores_cerrados`(
    IN p_anio INT,
    IN p_mes INT,
    OUT p_puede_cerrar BOOLEAN
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM periodocontable 
    WHERE (Anio < p_anio OR (Anio = p_anio AND Mes < p_mes))
      AND Estado = 'Abierto';
    
    SET p_puede_cerrar = v_count = 0;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesActualizarPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesActualizarPorIdRol`(
    IN pI_id_rol VARCHAR(40),
    IN pI_nombre_rol VARCHAR(40),
    IN pI_descripcion VARCHAR(200),
    IN pI_estado ENUM('Activo','Inactivo'),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    UPDATE Roles
    SET
        NombreRol = pI_nombre_rol,
        Descripcion = pI_descripcion,
        Estado = pI_estado
    WHERE IdRol = pI_id_rol;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesConteo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesConteo`()
BEGIN
    SELECT COUNT(*) AS Total FROM Roles;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesEliminarPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesEliminarPorIdRol`(
    IN pI_id_rol VARCHAR(40),
    OUT pS_resultado INT
)
BEGIN
    DELETE FROM Roles
    WHERE IdRol = pI_id_rol;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesInsertar`(
    IN pI_id_rol VARCHAR(40),
    IN pI_nombre_rol VARCHAR(40),
    IN pI_descripcion VARCHAR(200),
    IN pI_estado ENUM('Activo','Inactivo'),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    INSERT INTO Roles (
        IdRol,
        NombreRol,
        Descripcion,
        Estado
    )
    VALUES (
        pI_id_rol,
        pI_nombre_rol,
        pI_descripcion,
        pI_estado
    );

    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesListar`()
BEGIN
    SELECT 
        IdRol,
        NombreRol,
        Descripcion,
        Estado
    FROM Roles
    ORDER BY IdRol DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdRol,
        NombreRol,
        Descripcion,
        Estado
    FROM Roles
    ORDER BY IdRol DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesListarPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesListarPorIdRol`(
    IN pI_id_rol VARCHAR(40)
)
BEGIN
    SELECT 
        IdRol,
        NombreRol,
        Descripcion,
        Estado
    FROM Roles
    WHERE IdRol = pI_id_rol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasActualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasActualizar`(
    IN pI_id_rol VARCHAR(40),
    IN pI_pantallas TEXT, -- Lista de IdPantalla separados por coma, ej: "1,2,3"
    OUT pS_resultado INT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE n INT DEFAULT 0;
    DECLARE arr TEXT;
    DECLARE IdPantalla INT;

    -- Inicializar resultado
    SET pS_resultado = 0;

    -- 1️⃣ Eliminar todas las pantallas actuales del rol
    DELETE FROM rolespantallas
    WHERE IdRol = pI_id_rol;

    -- 2️⃣ Contar cuántas pantallas vienen en la lista
    IF pI_pantallas IS NOT NULL AND pI_pantallas <> '' THEN
        SET n = CHAR_LENGTH(pI_pantallas) - CHAR_LENGTH(REPLACE(pI_pantallas, ',', '')) + 1;

        -- 3️⃣ Insertar cada pantalla nueva
        WHILE i < n DO
            SET arr = SUBSTRING_INDEX(SUBSTRING_INDEX(pI_pantallas, ',', i + 1), ',', -1);
            SET IdPantalla = CAST(arr AS UNSIGNED);
            INSERT INTO rolespantallas(IdRol, IdPantalla) VALUES(pI_id_rol, IdPantalla);
            SET i = i + 1;
        END WHILE;
    END IF;

    -- 4️⃣ Todo OK
    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasConteo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasConteo`()
BEGIN
    SELECT COUNT(*) AS Total FROM rolespantallas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasEliminarPorIdRolIdPantalla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasEliminarPorIdRolIdPantalla`(
    IN pI_id_rol VARCHAR(40),
    IN pI_id_pantalla INT,
    OUT pS_resultado INT
)
BEGIN
    DELETE FROM rolespantallas
    WHERE IdRol = pI_id_rol
      AND IdPantalla = pI_id_pantalla;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasInsertar`(
    IN pI_id_rol VARCHAR(40),
    IN pI_id_pantalla INT,
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    INSERT INTO rolespantallas (
        IdRol,
        IdPantalla
    )
    VALUES (
        pI_id_rol,
        pI_id_pantalla
    );

    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasListar`()
BEGIN
    SELECT 
        IdRol,
        IdPantalla
    FROM rolespantallas
    ORDER BY IdRol DESC, IdPantalla DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdRol,
        IdPantalla
    FROM rolespantallas
    ORDER BY IdRol DESC, IdPantalla DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasListarConEstado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasListarConEstado`(
    IN pIdRol VARCHAR(40)
)
BEGIN
    SELECT
        p.IdPantalla,
        p.Nombre,
        p.Descripcion,
        p.Ruta,
        p.Estado,
        IF(rp.IdRol IS NULL, 0, 1) AS Asignada
    FROM pantallas p
    LEFT JOIN rolespantallas rp
        ON rp.IdPantalla = p.IdPantalla AND rp.IdRol = pIdRol
    ORDER BY p.IdPantalla ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasListarPantallasPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasListarPantallasPorIdRol`(
    IN pI_id_rol VARCHAR(40)
)
BEGIN
    SELECT 
        p.IdPantalla,
        p.Nombre,
        p.Descripcion,
        p.Ruta,
        p.Estado
    FROM pantallas p
    INNER JOIN rolespantallas rp
        ON rp.IdPantalla = p.IdPantalla
    WHERE rp.IdRol = pI_id_rol
    ORDER BY p.IdPantalla DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasListarPorIdPantalla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasListarPorIdPantalla`(
    IN pI_id_pantalla INT
)
BEGIN
    SELECT 
        IdRol,
        IdPantalla
    FROM rolespantallas
    WHERE IdPantalla = pI_id_pantalla
    ORDER BY IdRol DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RolesPantallasListarPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_RolesPantallasListarPorIdRol`(
    IN pI_id_rol VARCHAR(40)
)
BEGIN
    SELECT 
        IdRol,
        IdPantalla
    FROM rolespantallas
    WHERE IdRol = pI_id_rol
    ORDER BY IdPantalla DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_saldos_insertar_por_periodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_saldos_insertar_por_periodo`(
    IN p_id_periodo INT,
    IN p_id_cuenta INT,
    IN p_saldo_anterior DECIMAL(18,2),
    IN p_debitos_mes DECIMAL(18,2),
    IN p_creditos_mes DECIMAL(18,2),
    IN p_saldo_actual DECIMAL(18,2)
)
BEGIN
    INSERT INTO saldoscuentasperiodo 
        (IdPeriodo, IdCuenta, SaldoAnterior, DebitosPeriodo, 
         CreditosPeriodo, SaldoActual, FechaRegistro)
    VALUES 
        (p_id_periodo, p_id_cuenta, p_saldo_anterior, p_debitos_mes,
         p_creditos_mes, p_saldo_actual, NOW())
    ON DUPLICATE KEY UPDATE
        SaldoAnterior = p_saldo_anterior,
        DebitosPeriodo = p_debitos_mes,
        CreditosPeriodo = p_creditos_mes,
        SaldoActual = p_saldo_actual,
        FechaRegistro = NOW();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tabla_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_tabla_existe`(
    IN p_nombre_tabla VARCHAR(100),
    OUT p_existe BOOLEAN
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM information_schema.tables 
    WHERE table_schema = DATABASE() 
      AND table_name = p_nombre_tabla;
    
    SET p_existe = v_count > 0;
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
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
    OUT pS_resultado INT,
    OUT pS_idUsuario INT
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
    SET pS_idUsuario = pI_id_usuario;
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
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
    OUT pS_resultado INT,
    OUT pS_idUsuario INT
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
    SET pS_idUsuario = LAST_INSERT_ID();
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT
        u.IdUsuario,
        u.Usuario,
        u.NombreUsuario,
        u.ApellidoUsuario,
        u.CorreoElectronico,
        u.Estado,
        GROUP_CONCAT(r.NombreRol SEPARATOR ', ') AS Roles
    FROM usuarios u
    LEFT JOIN usuariosroles ur ON ur.IdUsuario = u.IdUsuario
    LEFT JOIN roles r ON r.IdRol = ur.IdRol
    GROUP BY u.IdUsuario
    ORDER BY u.IdUsuario ASC
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesConteo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesConteo`()
BEGIN
    SELECT COUNT(*) AS Total FROM usuariosroles;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesEliminarPorIdUsuarioIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesEliminarPorIdUsuarioIdRol`(
    IN pI_id_usuario INT,
    IN pI_id_rol VARCHAR(40),
    OUT pS_resultado INT
)
BEGIN
    DELETE FROM usuariosroles
    WHERE IdUsuario = pI_id_usuario
      AND IdRol = pI_id_rol;

    SET pS_resultado = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesInsertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesInsertar`(
    IN pI_id_usuario INT,
    IN pI_id_rol VARCHAR(40),
    OUT pS_resultado INT
)
BEGIN
    SET pS_resultado = 0;

    INSERT INTO usuariosroles (
        IdUsuario,
        IdRol
    )
    VALUES (
        pI_id_usuario,
        pI_id_rol
    );

    SET pS_resultado = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListar`()
BEGIN
    SELECT 
        IdUsuario,
        IdRol
    FROM usuariosroles
    ORDER BY IdUsuario DESC, IdRol DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListar10` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListar10`(
    IN p_Limite INT,
    IN p_Offset INT
)
BEGIN
    SELECT 
        IdUsuario,
        IdRol
    FROM usuariosroles
    ORDER BY IdUsuario DESC, IdRol DESC
    LIMIT p_Limite OFFSET p_Offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListarPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListarPorIdRol`(
    IN pI_id_rol VARCHAR(40)
)
BEGIN
    SELECT 
        IdUsuario,
        IdRol
    FROM usuariosroles
    WHERE IdRol = pI_id_rol
    ORDER BY IdUsuario DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListarPorIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListarPorIdUsuario`(
    IN pI_id_usuario INT
)
BEGIN
    SELECT 
        IdUsuario,
        IdRol
    FROM usuariosroles
    WHERE IdUsuario = pI_id_usuario
    ORDER BY IdRol DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListarRolesActivosPorIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListarRolesActivosPorIdUsuario`(
    IN pI_id_usuario INT
)
BEGIN
    SELECT 
        r.IdRol,
        r.NombreRol,
        r.Descripcion,
        r.Estado
    FROM roles r
    INNER JOIN usuariosroles ur
        ON ur.IdRol = r.IdRol
    WHERE ur.IdUsuario = pI_id_usuario
      AND r.Estado = 'Activo'
    ORDER BY r.IdRol DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListarRolesPorIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListarRolesPorIdUsuario`(
    IN pI_id_usuario INT
)
BEGIN
    SELECT 
        r.IdRol,
        r.NombreRol,
        r.Descripcion,
        r.Estado
    FROM roles r
    INNER JOIN usuariosroles ur
        ON ur.IdRol = r.IdRol
    WHERE ur.IdUsuario = pI_id_usuario
    ORDER BY r.IdRol DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UsuariosRolesListarUsuariosPorIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`siscontableLaDat`@`%` PROCEDURE `sp_UsuariosRolesListarUsuariosPorIdRol`(
    IN pI_id_rol VARCHAR(40)
)
BEGIN
    SELECT 
        u.IdUsuario,
        u.Usuario,
        u.NombreUsuario,
        u.ApellidoUsuario,
        u.CorreoElectronico,
        u.Estado,
        u.IntentosFallidos,
        u.UltimoIntento
    FROM usuarios u
    INNER JOIN usuariosroles ur
        ON ur.IdUsuario = u.IdUsuario
    WHERE ur.IdRol = pI_id_rol
    ORDER BY u.IdUsuario DESC;
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

-- Dump completed on 2026-02-13 18:32:41
