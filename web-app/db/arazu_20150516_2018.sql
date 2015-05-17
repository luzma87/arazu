-- MySQL dump 10.13  Distrib 5.6.22, for Win64 (x86_64)
--
-- Host: localhost    Database: arazu
-- ------------------------------------------------------
-- Server version	5.6.22-log
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accn`
--

DROP TABLE IF EXISTS `accn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accn` (
  `accn__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ctrl__id` bigint(20) NOT NULL,
  `accndscr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `accnaudt` int(11) NOT NULL,
  `accnicno` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `mdlo__id` bigint(20) NOT NULL,
  `accnnmbr` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `accnordn` int(11) NOT NULL,
  `tpac__id` bigint(20) NOT NULL,
  `sstm__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`accn__id`),
  KEY `FK_npngjegpnha2yqyurd71v5og5` (`ctrl__id`),
  KEY `FK_s9kn3m3291rultbep9u0hxye0` (`mdlo__id`),
  KEY `FK_fxc1l021gljgwfeukgh9jn80b` (`tpac__id`),
  KEY `FK_qf8uhs76rupf8p2u5824hegkt` (`sstm__id`),
  CONSTRAINT `FK_fxc1l021gljgwfeukgh9jn80b` FOREIGN KEY (`tpac__id`) REFERENCES `tpac` (`tpac__id`),
  CONSTRAINT `FK_npngjegpnha2yqyurd71v5og5` FOREIGN KEY (`ctrl__id`) REFERENCES `ctrl` (`ctrl__id`),
  CONSTRAINT `FK_qf8uhs76rupf8p2u5824hegkt` FOREIGN KEY (`sstm__id`) REFERENCES `sstm` (`sstm__id`),
  CONSTRAINT `FK_s9kn3m3291rultbep9u0hxye0` FOREIGN KEY (`mdlo__id`) REFERENCES `mdlo` (`mdlo__id`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accn`
--

LOCK TABLES `accn` WRITE;
/*!40000 ALTER TABLE `accn` DISABLE KEYS */;
INSERT INTO `accn` VALUES (1,1,'Configuración del menú',1,'fa fa-server',3,'acciones',4,1,3),(3,2,'list',1,'',3,'list',3,2,NULL),(4,2,'showAlerta',1,'',3,'showAlerta',4,2,NULL),(8,3,'desactivarBodega',1,'',4,'desactivarBodega',8,2,NULL),(14,3,'Lista de Bodegas',1,'fa fa-archive',4,'list',1,1,4),(18,4,'Inventario',1,'',4,'inventarioResumen',18,2,NULL),(20,4,'Ingreso De Bodega',1,'fa fa-cart-arrow-down',4,'ingresoDeBodega',2,1,4),(25,4,'inventario',1,'',4,'inventario',25,2,NULL),(30,5,'Items',1,'flaticon-two195',4,'arbolAdmin',4,1,4),(33,5,'Inventario',1,'flaticon-two195',4,'arbol',5,1,4),(43,6,'Maquinaria',1,'flaticon-construction11',4,'arbol',43,1,4),(48,6,'Maquinaria',1,'flaticon-construction11',4,'arbolAdmin',48,1,4),(54,7,'list',1,'',3,'list',54,2,NULL),(59,8,'list',1,'',3,'list',59,2,NULL),(65,9,'list',1,'',3,'list',65,2,NULL),(74,10,'list',1,'',3,'list',74,2,NULL),(79,11,'list',1,'',3,'list',79,2,NULL),(97,13,'Usuarios',1,'flaticon-construction4',3,'arbol',1,1,2),(103,14,'list',1,'',3,'list',103,2,NULL),(113,15,'list',1,'',7,'list',113,2,NULL),(115,16,'Configuración del proyecto',1,'',7,'config',115,2,NULL),(116,16,'Nuevo proyecto',1,'flaticon-hammer42',7,'form',2,1,2),(118,16,'Lista de Proyectos',1,'fa fa-list',7,'list',1,1,2),(119,16,'show',1,'',7,'show',119,2,NULL),(135,19,'Inicio',1,'',2,'index',135,2,NULL),(136,19,'Parámetros',1,'fa fa-cogs',3,'parametros',2,1,3),(137,19,'demoUI',1,'',2,'demoUI',137,2,NULL),(165,22,'personal',1,'',3,'personal',165,2,NULL),(211,13,'Usuarios',1,'flaticon-construction4',3,'arbolAdmin',1,1,2),(212,16,'Lista de Proyectos',1,'fa fa-list',7,'listAdmin',1,1,2),(217,25,'list',1,'',3,'list',217,2,NULL),(219,4,'Egreso De Bodega',1,'fa fa-upload',4,'egresoDeBodega',3,1,4),(221,4,'Egresos Sin Desecho',1,'fa fa-folder-open-o',4,'listaEgresosSinDesecho',0,1,4),(222,27,'list',1,'',3,'list',222,2,NULL),(239,29,'Nueva solicitud de mant. ext.',1,'flaticon-forklift3',9,'pedido',2,1,1),(240,30,'Lista Bodega',1,'fa fa-inbox',5,'listaBodega',8,1,1),(241,30,'Lista Jefe',1,'fa fa-check-circle-o',5,'listaJefatura',3,1,1),(242,30,'revisarGerente',1,'',5,'revisarGerente',242,2,NULL),(244,30,'revisarAsistenteCompras',1,'',5,'revisarAsistenteCompras',244,2,NULL),(245,30,'Lista Gerente (aprobación final)',1,'fa fa-check-circle',5,'listaGerente',7,1,1),(246,30,'revisarJefatura',1,'',5,'revisarJefatura',246,2,NULL),(247,30,'Nueva nota de pedido',1,'fa fa-shopping-cart',5,'pedido',2,1,1),(248,30,'Lista Jefe de Compras',1,'fa fa-users',5,'listaJefeCompras',4,1,1),(249,30,'Lista Aprobadas',1,'fa fa-check',5,'listaAprobadas',9,1,1),(250,30,'Lista Jefe (aprobación final)',1,'fa fa-check-circle',5,'listaJefe',6,1,1),(251,30,'Todas las notas de pedido',1,'fa fa-list-alt',5,'lista',1,1,1),(252,30,'revisarJefeCompras',1,'',5,'revisarJefeCompras',252,2,NULL),(253,30,'Lista Asistente de Compras',1,'fa fa-slideshare',5,'listaAsistenteCompras',5,1,1),(254,30,'revisarJefe',1,'',5,'revisarJefe',254,2,NULL),(255,5,'Items de Desecho',1,'fa fa-trash-o',4,'arbolItemsDesecho',255,1,4),(256,29,'Todas las solicitudes',1,'fa fa-list-alt',9,'lista',1,1,1),(258,29,'Lista Jefe de Compras',1,'fa fa-users',9,'listaJefeCompras',3,1,1),(259,29,'revisarJefeCompras',1,'',9,'revisarJefeCompras',259,2,NULL),(260,31,'list',1,'',3,'list',260,2,NULL),(261,29,'Lista Asistente de Compras',1,'fa fa-slideshare',9,'listaAsistenteCompras',4,1,1),(262,29,'revisarAsistenteCompras',1,'',9,'revisarAsistenteCompras',262,2,NULL),(263,29,'revisarGerente',1,'',9,'revisarGerente',263,2,NULL),(264,29,'revisarJefe',1,'',9,'revisarJefe',264,2,NULL),(265,29,'Lista Gerente (aprobación final)',1,'fa fa-check-circle',9,'listaGerente',6,1,1),(266,29,'Lista Jefe (aprobación final)',1,'fa fa-check-circle',9,'listaJefe',5,1,1),(267,29,'Lista Aprobadas',1,'fa fa-check',9,'listaAprobadas',7,1,1),(271,32,'Todas las solicitudes',1,'fa fa-list-alt',10,'lista',1,1,1),(272,32,'Lista Gerente (aprobación final)',1,'fa fa-check-circle',10,'listaGerente',4,1,1),(273,32,'Nueva solicitud de mant. int.',1,'fa fa-automobile',10,'pedido',2,1,1),(274,32,'Lista Jefe  (aprobación final)',1,'fa fa-check-circle',10,'listaJefe',3,1,1),(275,32,'revisarJefe',1,'',10,'revisarJefe',275,2,NULL),(276,32,'revisarGerente',1,'',10,'revisarGerente',276,2,NULL),(277,32,'Lista Aprobadas',1,'fa fa-check',10,'listaAprobadas',5,1,1),(282,32,'completarPedido',1,'',10,'completarPedido',282,2,NULL),(285,33,'Notas de Pedido',1,'fa fa-folder-open',8,'notasDePedido',1,1,1),(286,33,'Solicitudes de Mantenimiento Externo',1,'flaticon-forklift3',8,'mantenimientoExterno',2,1,1),(287,33,'Solicitudes de Mantenimiento Interno',1,'fa fa-automobile',8,'mantenimientoInterno',3,1,1),(289,34,'list',1,'',3,'list',289,2,NULL),(290,4,'inventarioDesecho',1,'',4,'inventarioDesecho',290,2,NULL),(291,4,'inventarioDesechoResumen',1,'',4,'inventarioDesechoResumen',291,2,NULL),(292,35,'Archivos',1,'fa fa-files-o',3,'index',3,1,3),(293,22,'foto',1,'',3,'foto',293,2,NULL),(297,38,'Registro asistencia',1,'fa fa-check-square-o',11,'registroAsistencia',2,1,2),(298,39,'list',1,'',3,'list',298,2,NULL),(303,35,'downloadArchivo',1,'',3,'downloadArchivo',303,2,NULL),(304,40,'list',1,'',3,'list',304,2,NULL),(305,38,'Registro de horas extra',1,'fa fa-history',11,'registroHorasExtra',3,1,2),(307,40,'Nómina',1,'flaticon-construction4',2,'inicioNomina',2,2,NULL),(308,40,'Administración',1,'fa fa-cog',2,'inicioAdmin',5,2,NULL),(309,40,'index',1,'',2,'index',309,2,NULL),(310,40,'Solicitudes',1,'fa fa-list-alt',2,'inicioSolicitudes',1,2,NULL),(311,40,'Inventario',1,'flaticon-construction11',2,'inicioInventario',3,2,NULL),(313,41,'asignarPersonal',1,'',11,'asignarPersonal',313,2,2),(314,41,'Personal de Proyectos',1,'flaticon-constructor2',7,'personalProyectos',314,1,2),(315,33,'Personal de Proyectos',1,'flaticon-construction4',8,'personalProyecto',5,1,2),(316,33,'Bodegas',1,'fa fa-archive',8,'bodegas',4,1,4),(317,33,'Asistencia y Vacaciones',1,'fa fa-check-square-o',8,'asistencias',6,1,2),(319,33,'Horas Extra',1,'fa fa-history',8,'horasExtra',7,1,2);
/*!40000 ALTER TABLE `accn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accs`
--

DROP TABLE IF EXISTS `accs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accs` (
  `accs__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accsfcfn` datetime NOT NULL,
  `accsfcin` datetime NOT NULL,
  `accsobsr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsn__id` bigint(20) NOT NULL,
  PRIMARY KEY (`accs__id`),
  KEY `FK_tgw7c13tg0lgno2dc0bibla9n` (`prsn__id`),
  CONSTRAINT `FK_tgw7c13tg0lgno2dc0bibla9n` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accs`
--

LOCK TABLES `accs` WRITE;
/*!40000 ALTER TABLE `accs` DISABLE KEYS */;
/*!40000 ALTER TABLE `accs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alrt`
--

DROP TABLE IF EXISTS `alrt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alrt` (
  `alrt__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alrtaccn` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `alrtctrl` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `alrtfrom` bigint(20) NOT NULL,
  `alrtfcen` datetime NOT NULL,
  `alrtfcrc` datetime DEFAULT NULL,
  `alrtidrm` int(11) NOT NULL,
  `alrtmesn` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `alrt__to` bigint(20) NOT NULL,
  PRIMARY KEY (`alrt__id`),
  KEY `FK_q900atcqq58cf5lkdvtt77e7i` (`alrtfrom`),
  KEY `FK_sh2lg1dwluk22oskho3lnd7an` (`alrt__to`),
  CONSTRAINT `FK_q900atcqq58cf5lkdvtt77e7i` FOREIGN KEY (`alrtfrom`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_sh2lg1dwluk22oskho3lnd7an` FOREIGN KEY (`alrt__to`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alrt`
--

LOCK TABLES `alrt` WRITE;
/*!40000 ALTER TABLE `alrt` DISABLE KEYS */;
INSERT INTO `alrt` VALUES (1,'listaJefatura','notaPedido',2,'2015-03-27 00:00:42','2015-03-27 21:45:48',0,'Usuario Normal ha realizado la nota de pedido núm. 1',3),(2,'listaJefatura','notaPedido',2,'2015-03-27 21:49:32','2015-03-27 21:51:16',0,'Usuario Normal ha realizado la nota de pedido núm. 2',3),(3,'lista','notaPedido',3,'2015-03-27 21:51:41',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 1',2),(4,'listaBodega','notaPedido',3,'2015-03-27 21:51:45','2015-03-27 21:53:22',0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 1',4),(5,'listaBodega','notaPedido',3,'2015-03-27 21:51:48',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 1',8),(6,'listaJefeCompras','notaPedido',3,'2015-03-27 21:52:24','2015-03-27 22:30:00',0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (2.0 de 4.0) la nota de pedido núm. 2',7),(7,'lista','notaPedido',3,'2015-03-27 21:52:28',NULL,0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (2.0 de 4.0) la nota de pedido núm. 2',2),(8,'listaBodega','notaPedido',3,'2015-03-27 21:52:31','2015-03-27 22:06:40',0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (2.0 de 4.0) la nota de pedido núm. 2',4),(9,'listaBodega','notaPedido',3,'2015-03-27 21:52:34',NULL,0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (2.0 de 4.0) la nota de pedido núm. 2',8),(10,'listaEgresosSinDesecho','inventario',4,'2015-03-27 21:53:50',NULL,0,'rsbd rsbd ha realizado un egreso de bodega de 2.0U LLANTA RIN 19 sin un ingreso de desecho',6),(11,'listaEgresosSinDesecho','inventario',4,'2015-03-27 22:16:40','2015-03-28 23:28:22',0,'rsbd rsbd ha realizado un egreso de bodega de 2.0U LLANTA RIN 19 sin un ingreso de desecho',6),(12,'listaAsistenteCompras','notaPedido',7,'2015-03-27 22:32:12','2015-03-27 22:32:26',0,'jfcm jfcm ha aprobado (2.0 U) la nota de pedido núm. 2',5),(13,'lista','notaPedido',7,'2015-03-27 22:32:14',NULL,0,'jfcm jfcm ha aprobado (2.0 U) la nota de pedido núm. 2',2),(14,'listaJefe','notaPedido',5,'2015-03-27 22:35:08','2015-03-27 22:35:41',0,'ascm ascm ha cargado cotizaciones (2.0 U) la nota de pedido núm. 2',3),(15,'lista','notaPedido',5,'2015-03-27 22:35:10',NULL,0,'ascm ascm ha cargado cotizaciones (2.0 U) la nota de pedido núm. 2',2),(16,'listaAsistenteCompras','notaPedido',3,'2015-03-27 22:35:58','2015-03-27 22:36:22',0,'jefe jefe ha solicitado la recarga de cotizaciones la nota de pedido núm. 2',5),(17,'lista','notaPedido',3,'2015-03-27 22:36:00',NULL,0,'jefe jefe ha solicitado la recarga de cotizaciones la nota de pedido núm. 2',2),(18,'listaJefe','notaPedido',5,'2015-03-27 22:36:38','2015-03-27 22:36:54',0,'ascm ascm ha cargado cotizaciones (2.0 U) la nota de pedido núm. 2',3),(19,'lista','notaPedido',5,'2015-03-27 22:36:40',NULL,0,'ascm ascm ha cargado cotizaciones (2.0 U) la nota de pedido núm. 2',2),(20,'listaAprobadas','notaPedido',3,'2015-03-27 22:37:13',NULL,0,'jefe jefe ha APROBADO (2.0 U) la nota de pedido núm. 2. Puede proceder a la compra de 4.0U LLANTA RIN 19',2),(21,'lista','notaPedido',3,'2015-03-27 22:37:15','2015-03-27 22:37:50',0,'jefe jefe ha APROBADO (2.0 U) la nota de pedido núm. 2. Puede proceder a la compra de 4.0U LLANTA RIN 19',5),(22,'listaEgresosSinDesecho','inventario',4,'2015-03-27 22:53:37','2015-03-27 22:55:18',0,'rsbd rsbd ha realizado un egreso de bodega de 2.0U LLANTA RIN 19 sin un ingreso de desecho',6),(23,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-03-28 17:33:48','2015-03-29 00:49:09',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 5',7),(24,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-03-28 20:52:12','2015-03-28 21:07:36',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 6',7),(25,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-03-28 20:55:14','2015-03-28 21:01:53',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 7',7),(26,'listaAsistenteCompras','solicitudMantenimientoExterno',7,'2015-03-28 22:01:54','2015-03-28 22:02:17',0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 4',5),(27,'lista','solicitudMantenimientoExterno',7,'2015-03-28 22:01:58',NULL,0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 4',9),(28,'listaGerente','solicitudMantenimientoExterno',5,'2015-03-28 22:43:16','2015-03-28 23:27:00',0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 4',6),(29,'lista','solicitudMantenimientoExterno',5,'2015-03-28 22:43:19',NULL,0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 4',9),(30,'listaAsistenteCompras','solicitudMantenimientoExterno',6,'2015-03-28 23:29:41','2015-03-28 23:30:05',0,'grnt grnt ha solicitado la recarga de cotizaciones la solicitud de mantenimiento externo núm. 4',5),(31,'lista','solicitudMantenimientoExterno',6,'2015-03-28 23:29:43',NULL,0,'grnt grnt ha solicitado la recarga de cotizaciones la solicitud de mantenimiento externo núm. 4',9),(32,'listaGerente','solicitudMantenimientoExterno',5,'2015-03-28 23:30:35','2015-03-28 23:30:56',0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 4',6),(33,'lista','solicitudMantenimientoExterno',5,'2015-03-28 23:30:39',NULL,0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 4',9),(34,'listaAprobadas','solicitudMantenimientoExterno',6,'2015-03-28 23:32:45',NULL,0,'grnt grnt ha APROBADO la solicitud de mantenimiento externo núm. 4. Puede proceder al mantenimiento solicitado.',9),(35,'listaAsistenteCompras','solicitudMantenimientoExterno',7,'2015-03-29 00:49:52','2015-03-29 00:54:01',0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 5',5),(36,'lista','solicitudMantenimientoExterno',7,'2015-03-29 00:49:55',NULL,0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 5',9),(37,'listaAsistenteCompras','solicitudMantenimientoExterno',7,'2015-03-29 00:50:11','2015-03-29 00:50:34',0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 6',5),(38,'lista','solicitudMantenimientoExterno',7,'2015-03-29 00:50:14',NULL,0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 6',9),(39,'listaJefe','solicitudMantenimientoExterno',5,'2015-03-29 00:50:58','2015-03-29 00:52:36',0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 5',3),(40,'lista','solicitudMantenimientoExterno',5,'2015-03-29 00:51:01',NULL,0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 5',9),(41,'lista','solicitudMantenimientoExterno',5,'2015-03-29 00:51:19',NULL,0,'ascm ascm ha negado la solicitud de mantenimiento externo núm. 6',9),(42,'lista','solicitudMantenimientoExterno',3,'2015-03-29 00:52:55',NULL,0,'jefe jefe ha NEGADO la solicitud de mantenimiento externo núm. 5',9),(43,'listaAsistenteCompras','solicitudMantenimientoExterno',7,'2015-03-29 00:53:40','2015-03-29 00:53:58',0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 7',5),(44,'lista','solicitudMantenimientoExterno',7,'2015-03-29 00:53:43',NULL,0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 7',9),(45,'lista','solicitudMantenimientoExterno',5,'2015-03-29 00:54:17',NULL,0,'ascm ascm ha negado la solicitud de mantenimiento externo núm. 7',9),(46,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 16:58:09',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 9',6),(47,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 16:58:57','2015-03-29 17:13:40',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 10',6),(48,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 16:59:00',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 10',7),(49,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 17:04:19','2015-03-29 17:05:12',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 11',6),(50,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 17:04:24',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 11',7),(51,'listaGerente','solicitudMantenimientoInterno',9,'2015-03-29 17:09:25','2015-03-29 17:09:47',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 12',6),(52,'listaGerente','solicitudMantenimientoInterno',9,'2015-03-29 17:09:29',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 12',7),(53,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 17:11:36','2015-03-29 17:11:54',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 13',3),(54,'listaJefe','solicitudMantenimientoInterno',9,'2015-03-29 17:11:40',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno n?m. 13',7),(55,'listaAprobadas','solicitudMantenimientoInterno',3,'2015-03-29 17:12:43','2015-03-29 17:13:16',0,'jefe jefe ha APROBADO la solicitud de mantenimiento interno n?m. 12. Puede proceder al mantenimiento solicitado.',9),(56,'lista','solicitudMantenimientoInterno',6,'2015-03-29 17:14:36','2015-03-29 17:15:03',0,'grnt grnt ha NEGADO la solicitud de mantenimiento interno n?m. 11',9),(57,'listaJefatura','notaPedido',1,'2015-03-29 20:35:35',NULL,0,'Admin Admin ha realizado la nota de pedido núm. 3',3),(58,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-03-29 20:36:50',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 8',7),(59,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-03-29 21:13:03',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 11',7),(60,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-03-29 21:22:01',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 12',7),(61,'listaGerente','solicitudMantenimientoInterno',9,'2015-03-29 22:12:53',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 17',6),(62,'listaGerente','solicitudMantenimientoInterno',9,'2015-03-29 22:12:57',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 17',7),(63,'listaGerente','solicitudMantenimientoInterno',9,'2015-03-29 22:40:40','2015-03-29 22:45:19',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 18',6),(64,'listaGerente','solicitudMantenimientoInterno',9,'2015-03-29 22:40:43',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 18',7),(65,'listaAprobadas','solicitudMantenimientoInterno',6,'2015-03-29 22:46:57','2015-03-29 22:47:16',0,'grnt grnt ha APROBADO la solicitud de mantenimiento interno núm. 18. Puede proceder al mantenimiento solicitado.',9),(66,'listaGerente','solicitudMantenimientoInterno',9,'2015-04-22 17:12:02','2015-04-22 17:13:38',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 19',6),(67,'listaGerente','solicitudMantenimientoInterno',9,'2015-04-22 17:12:04','2015-04-22 17:25:52',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 19',7),(68,'listaAprobadas','solicitudMantenimientoInterno',6,'2015-04-22 17:14:06','2015-04-22 17:14:22',0,'grnt grnt ha APROBADO la solicitud de mantenimiento interno núm. 19. Puede proceder al mantenimiento solicitado.',9),(69,'listaJefeCompras','solicitudMantenimientoExterno',9,'2015-04-22 17:24:49',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento externo núm. 13',7),(70,'listaAsistenteCompras','solicitudMantenimientoExterno',7,'2015-04-22 17:26:28','2015-04-22 17:26:42',0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 13',5),(71,'lista','solicitudMantenimientoExterno',7,'2015-04-22 17:26:28',NULL,0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 13',9),(72,'listaJefe','solicitudMantenimientoExterno',5,'2015-04-22 17:28:12','2015-04-22 17:28:26',0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 13',3),(73,'lista','solicitudMantenimientoExterno',5,'2015-04-22 17:28:12',NULL,0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 13',9),(74,'listaAsistenteCompras','solicitudMantenimientoExterno',3,'2015-04-22 17:28:55','2015-04-22 17:29:19',0,'jefe jefe ha solicitado la recarga de cotizaciones la solicitud de mantenimiento externo núm. 13',5),(75,'lista','solicitudMantenimientoExterno',3,'2015-04-22 17:28:55',NULL,0,'jefe jefe ha solicitado la recarga de cotizaciones la solicitud de mantenimiento externo núm. 13',9),(76,'listaGerente','solicitudMantenimientoExterno',5,'2015-04-22 17:29:55','2015-04-22 17:30:09',0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 13',6),(77,'lista','solicitudMantenimientoExterno',5,'2015-04-22 17:29:55',NULL,0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 13',9),(78,'listaAprobadas','solicitudMantenimientoExterno',6,'2015-04-22 17:30:37',NULL,0,'grnt grnt ha APROBADO la solicitud de mantenimiento externo núm. 13. Puede proceder al mantenimiento solicitado.',9),(79,'listaJefatura','notaPedido',2,'2015-04-22 17:34:45','2015-04-22 17:35:17',0,'Usuario Normal ha realizado la nota de pedido núm. 4',3),(80,'listaJefatura','notaPedido',2,'2015-04-22 17:37:43','2015-04-22 17:37:54',0,'Usuario Normal ha realizado la nota de pedido núm. 5',3),(81,'lista','notaPedido',3,'2015-04-22 17:38:13',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 5',2),(82,'listaBodega','notaPedido',3,'2015-04-22 17:38:14','2015-04-22 17:38:30',0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 5',4),(83,'listaBodega','notaPedido',3,'2015-04-22 17:38:14',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 5',8),(84,'listaJefatura','notaPedido',2,'2015-04-22 17:41:04','2015-04-26 00:57:47',0,'Usuario Normal ha realizado la nota de pedido núm. 6',3),(85,'listaJefeCompras','notaPedido',3,'2015-04-22 17:41:59','2015-04-22 17:42:32',0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (7.0 de 10.0) la nota de pedido núm. 6',7),(86,'lista','notaPedido',3,'2015-04-22 17:42:00',NULL,0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (7.0 de 10.0) la nota de pedido núm. 6',2),(87,'listaBodega','notaPedido',3,'2015-04-22 17:42:00',NULL,0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (7.0 de 10.0) la nota de pedido núm. 6',4),(88,'listaBodega','notaPedido',3,'2015-04-22 17:42:00',NULL,0,'jefe jefe ha notificado que existe en bodega y aprobado parcialmente (7.0 de 10.0) la nota de pedido núm. 6',8),(89,'listaAsistenteCompras','notaPedido',7,'2015-04-22 17:43:18','2015-04-22 17:43:31',0,'jfcm jfcm ha aprobado (7.0 GL) la nota de pedido núm. 6',5),(90,'lista','notaPedido',7,'2015-04-22 17:43:18',NULL,0,'jfcm jfcm ha aprobado (7.0 GL) la nota de pedido núm. 6',2),(91,'listaJefe','notaPedido',5,'2015-04-22 17:44:10','2015-04-22 17:44:21',0,'ascm ascm ha cargado cotizaciones (7.0 GL) la nota de pedido núm. 6',3),(92,'lista','notaPedido',5,'2015-04-22 17:44:10',NULL,0,'ascm ascm ha cargado cotizaciones (7.0 GL) la nota de pedido núm. 6',2),(93,'listaAsistenteCompras','notaPedido',3,'2015-04-22 17:44:46','2015-04-22 17:44:59',0,'jefe jefe ha solicitado la recarga de cotizaciones la nota de pedido núm. 6',5),(94,'lista','notaPedido',3,'2015-04-22 17:44:46',NULL,0,'jefe jefe ha solicitado la recarga de cotizaciones la nota de pedido núm. 6',2),(95,'listaJefe','notaPedido',5,'2015-04-22 17:45:28','2015-04-22 17:45:39',0,'ascm ascm ha cargado cotizaciones (7.0 GL) la nota de pedido núm. 6',3),(96,'lista','notaPedido',5,'2015-04-22 17:45:28',NULL,0,'ascm ascm ha cargado cotizaciones (7.0 GL) la nota de pedido núm. 6',2),(97,'listaAprobadas','notaPedido',3,'2015-04-22 17:46:19',NULL,0,'jefe jefe ha APROBADO (7.0 GL) la nota de pedido núm. 6. Puede proceder a la compra de 10.0GL ACEITE TIPO 2',2),(98,'lista','notaPedido',3,'2015-04-22 17:46:19','2015-04-29 20:57:19',0,'jefe jefe ha APROBADO (7.0 GL) la nota de pedido núm. 6. Puede proceder a la compra de 10.0GL ACEITE TIPO 2',5),(99,'listaAsistenteCompras','solicitudMantenimientoExterno',7,'2015-04-27 22:05:54','2015-04-29 20:56:39',0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 12',5),(100,'lista','solicitudMantenimientoExterno',7,'2015-04-27 22:05:59',NULL,0,'jfcm jfcm ha aprobado la solicitud de mantenimiento externo núm. 12',9),(101,'listaJefatura','notaPedido',2,'2015-04-29 21:05:45','2015-04-29 21:06:12',0,'Usuario Normal ha realizado la nota de pedido núm. 7',3),(102,'listaJefeCompras','notaPedido',3,'2015-04-29 21:06:41','2015-04-29 21:07:10',0,'jefe jefe ha aprobado (5.0 U) la nota de pedido núm. 7',7),(103,'lista','notaPedido',3,'2015-04-29 21:06:45',NULL,0,'jefe jefe ha aprobado (5.0 U) la nota de pedido núm. 7',2),(104,'listaAsistenteCompras','notaPedido',7,'2015-04-29 21:07:22','2015-04-29 21:08:13',0,'jfcm jfcm ha aprobado (5.0 U) la nota de pedido núm. 7',5),(105,'lista','notaPedido',7,'2015-04-29 21:07:26',NULL,0,'jfcm jfcm ha aprobado (5.0 U) la nota de pedido núm. 7',2),(106,'listaGerente','solicitudMantenimientoExterno',5,'2015-04-29 22:46:04','2015-04-29 22:46:24',0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 12',6),(107,'lista','solicitudMantenimientoExterno',5,'2015-04-29 22:46:07',NULL,0,'ascm ascm ha cargado cotizaciones la solicitud de mantenimiento externo núm. 12',9),(108,'listaAprobadas','solicitudMantenimientoExterno',6,'2015-04-29 22:58:11',NULL,0,'grnt grnt ha APROBADO la solicitud de mantenimiento externo núm. 12. Puede proceder al mantenimiento solicitado.',9),(109,'listaJefatura','notaPedido',2,'2015-05-07 19:39:37',NULL,0,'Usuario Normal ha realizado la nota de pedido núm. 8',3),(110,'','notaPedido',2,'2015-05-07 19:48:44',NULL,0,'PRUEBA',2),(111,'','notaPedido',2,'2015-05-07 19:49:17',NULL,0,'PRUEBA',2),(112,'','notaPedido',2,'2015-05-07 20:02:23',NULL,0,'PRUEBA',2),(113,'','notaPedido',2,'2015-05-07 20:03:13',NULL,0,'PRUEBA',2),(114,'','notaPedido',2,'2015-05-07 20:04:08',NULL,0,'PRUEBA',2),(115,'','notaPedido',2,'2015-05-07 20:04:57',NULL,0,'PRUEBA',2),(116,'','notaPedido',2,'2015-05-07 20:05:33',NULL,0,'PRUEBA',2),(117,'','notaPedido',1,'2015-05-07 20:07:47',NULL,0,'PRUEBA',1),(118,'','notaPedido',1,'2015-05-07 20:07:56',NULL,0,'PRUEBA',1),(119,'','notaPedido',1,'2015-05-07 20:10:30',NULL,0,'PRUEBA',1),(120,'','notaPedido',1,'2015-05-07 20:13:57',NULL,0,'PRUEBA',1),(121,'','notaPedido',1,'2015-05-07 20:18:49','2015-05-07 21:32:53',0,'PRUEBA',1),(122,'','notaPedido',1,'2015-05-07 20:25:54','2015-05-07 21:32:50',0,'PRUEBA',1),(123,'listaJefatura','notaPedido',2,'2015-05-07 20:32:11',NULL,0,'Usuario Normal ha realizado la nota de pedido núm. 9',3),(124,'lista','notaPedido',3,'2015-05-07 20:39:27',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 8',2),(125,'listaBodega','notaPedido',3,'2015-05-07 20:39:30',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 8',8),(126,'listaBodega','notaPedido',3,'2015-05-07 20:39:32',NULL,0,'jefe jefe ha notificado que existe en bodega la nota de pedido núm. 8',4),(127,'listaGerente','solicitudMantenimientoInterno',9,'2015-05-09 17:10:00','2015-05-09 17:34:03',0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 25',6),(128,'listaGerente','solicitudMantenimientoInterno',9,'2015-05-09 17:10:05',NULL,0,'jefe mantenimiento ha realizado la solicitud de mantenimiento interno núm. 25',7),(129,'listaAprobadas','solicitudMantenimientoInterno',6,'2015-05-09 17:41:00','2015-05-09 17:45:50',0,'grnt grnt ha APROBADO la solicitud de mantenimiento interno núm. 25. Puede proceder al mantenimiento solicitado.',9);
/*!40000 ALTER TABLE `alrt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asst`
--

DROP TABLE IF EXISTS `asst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asst` (
  `asst__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prsn__id` bigint(20) NOT NULL,
  `asstentr` datetime DEFAULT NULL,
  `asstfcha` datetime NOT NULL,
  `asstfcrg` datetime NOT NULL,
  `assth100` double NOT NULL,
  `assth_50` double NOT NULL,
  `asstobrs` longtext COLLATE latin1_spanish_ci,
  `prsnrgst` bigint(20) NOT NULL,
  `asstslda` datetime DEFAULT NULL,
  `tpas__id` bigint(20) NOT NULL,
  PRIMARY KEY (`asst__id`),
  KEY `FK_1yvl71erlclskido9h5exynou` (`prsn__id`),
  KEY `FK_5yuhqs3ik8t53e3cmu1meyau` (`prsnrgst`),
  KEY `FK_7vsibaqj9auskrhuevv059cnd` (`tpas__id`),
  CONSTRAINT `FK_1yvl71erlclskido9h5exynou` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_5yuhqs3ik8t53e3cmu1meyau` FOREIGN KEY (`prsnrgst`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_7vsibaqj9auskrhuevv059cnd` FOREIGN KEY (`tpas__id`) REFERENCES `tpas` (`tpas__id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asst`
--

LOCK TABLES `asst` WRITE;
/*!40000 ALTER TABLE `asst` DISABLE KEYS */;
INSERT INTO `asst` VALUES (1,1,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:12',0,0,NULL,1,NULL,2),(2,5,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:12',0,3,NULL,1,NULL,1),(3,3,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:12',0,0,NULL,1,NULL,2),(4,7,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:12',3,3,NULL,1,NULL,1),(5,2,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:13',0,0,NULL,1,NULL,2),(6,4,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:13',1,3,NULL,1,NULL,1),(7,8,NULL,'2015-04-26 00:00:00','2015-04-26 00:32:13',2,2,NULL,1,NULL,1),(8,6,NULL,'2015-04-26 00:00:00','2015-04-26 00:44:58',0,0,NULL,1,NULL,2),(9,9,NULL,'2015-04-26 00:00:00','2015-04-26 00:46:33',2,0,NULL,1,NULL,1),(10,1,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',0,0,NULL,1,NULL,1),(11,5,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',2,2,NULL,1,NULL,1),(12,6,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',1,0,NULL,1,NULL,1),(13,3,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',0,0,NULL,1,NULL,1),(14,7,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',0,1,NULL,1,NULL,1),(15,9,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',0,1,NULL,1,NULL,1),(16,2,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:04',0,0,NULL,1,NULL,1),(17,4,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:05',0,0,NULL,1,NULL,1),(18,8,NULL,'2015-04-27 00:00:00','2015-04-27 02:04:05',0,0,NULL,1,NULL,2),(19,1,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(20,5,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(21,6,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(22,3,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(23,7,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(24,9,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(25,10,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(26,2,NULL,'2015-05-07 00:00:00','2015-05-07 22:59:08',0,0,NULL,1,NULL,1),(27,1,NULL,'2015-05-08 00:00:00','2015-05-08 22:49:24',0,1,NULL,1,NULL,1),(28,5,NULL,'2015-05-08 00:00:00','2015-05-08 22:49:25',0,0,NULL,1,NULL,2),(29,6,NULL,'2015-05-08 00:00:00','2015-05-08 22:49:25',0,0,NULL,1,NULL,4),(30,3,NULL,'2015-05-08 00:00:00','2015-05-08 22:49:25',0,0,NULL,1,NULL,4),(31,7,NULL,'2015-05-08 00:00:00','2015-05-08 22:53:16',2,1,NULL,1,NULL,1),(32,9,NULL,'2015-05-08 00:00:00','2015-05-08 22:53:16',2,0,NULL,1,NULL,1),(33,10,NULL,'2015-05-08 00:00:00','2015-05-08 22:53:16',0,0,NULL,1,NULL,3),(34,2,NULL,'2015-05-08 00:00:00','2015-05-08 22:53:16',0,0,NULL,1,NULL,4),(35,4,NULL,'2015-05-08 00:00:00','2015-05-08 22:53:16',0,1,NULL,1,NULL,1),(36,8,NULL,'2015-05-08 00:00:00','2015-05-08 22:53:16',2,0,NULL,1,NULL,1);
/*!40000 ALTER TABLE `asst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bdga`
--

DROP TABLE IF EXISTS `bdga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bdga` (
  `bdga__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activo` int(11) NOT NULL,
  `bdgadscr` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `bdgaobsr` varchar(1023) COLLATE latin1_spanish_ci DEFAULT NULL,
  `proy__id` bigint(20) DEFAULT NULL,
  `prsnrspn` bigint(20) NOT NULL,
  `prsnspln` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`bdga__id`),
  KEY `FK_o398erdig2akiqmt0dqpmcn5a` (`proy__id`),
  KEY `FK_haywswilenafaec6tv5lvqall` (`prsnrspn`),
  KEY `FK_mhsv2y0m99jbm80oiptoa6yyp` (`prsnspln`),
  CONSTRAINT `FK_haywswilenafaec6tv5lvqall` FOREIGN KEY (`prsnrspn`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_mhsv2y0m99jbm80oiptoa6yyp` FOREIGN KEY (`prsnspln`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_o398erdig2akiqmt0dqpmcn5a` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bdga`
--

LOCK TABLES `bdga` WRITE;
/*!40000 ALTER TABLE `bdga` DISABLE KEYS */;
INSERT INTO `bdga` VALUES (1,1,'Quito',NULL,NULL,4,8),(2,1,'Santo Domingo',NULL,NULL,8,4),(3,1,'San Antonio',NULL,NULL,4,8),(4,0,'test',NULL,NULL,4,NULL);
/*!40000 ALTER TABLE `bdga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bdpd`
--

DROP TABLE IF EXISTS `bdpd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bdpd` (
  `bdpd__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bdga__id` bigint(20) NOT NULL,
  `bdpdcntd` double NOT NULL,
  `bdpdentr` double NOT NULL,
  `ntpd__id` bigint(20) NOT NULL,
  PRIMARY KEY (`bdpd__id`),
  KEY `FK_ma0xlact08t8cu5nergsxe5rx` (`bdga__id`),
  KEY `FK_f62r4touklmgl9uhdc0m170vv` (`ntpd__id`),
  CONSTRAINT `FK_f62r4touklmgl9uhdc0m170vv` FOREIGN KEY (`ntpd__id`) REFERENCES `ntpd` (`ntpd__id`),
  CONSTRAINT `FK_ma0xlact08t8cu5nergsxe5rx` FOREIGN KEY (`bdga__id`) REFERENCES `bdga` (`bdga__id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bdpd`
--

LOCK TABLES `bdpd` WRITE;
/*!40000 ALTER TABLE `bdpd` DISABLE KEYS */;
INSERT INTO `bdpd` VALUES (1,1,2,2,1),(2,1,2,2,2),(3,1,5,0,4),(4,3,7,7,5),(5,1,3,0,6),(6,2,2,0,8);
/*!40000 ALTER TABLE `bdpd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colr`
--

DROP TABLE IF EXISTS `colr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colr` (
  `colr__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `colr_hex` varchar(9) COLLATE latin1_spanish_ci DEFAULT NULL,
  `colrnmr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`colr__id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colr`
--

LOCK TABLES `colr` WRITE;
/*!40000 ALTER TABLE `colr` DISABLE KEYS */;
INSERT INTO `colr` VALUES (1,'#cf0e0e','Rojo'),(2,'#000000','Negro'),(3,'#f2e917','Amarillo'),(4,'#3c9e0e','Verde'),(5,'#3262de','Azul'),(6,'#b8b8b8','Gris'),(7,'#707070','Plomo'),(8,'#ffa800','Naranja');
/*!40000 ALTER TABLE `colr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crgo`
--

DROP TABLE IF EXISTS `crgo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crgo` (
  `crgo__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `crgocdgo` varchar(4) COLLATE latin1_spanish_ci DEFAULT NULL,
  `crgodscr` varchar(63) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`crgo__id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crgo`
--

LOCK TABLES `crgo` WRITE;
/*!40000 ALTER TABLE `crgo` DISABLE KEYS */;
INSERT INTO `crgo` VALUES (1,'JFE','Jefe'),(2,'ADM','Administrador'),(3,'ASC','Asistente de compras'),(4,'RSM','Responsable de mantenimiento');
/*!40000 ALTER TABLE `crgo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctrl`
--

DROP TABLE IF EXISTS `ctrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctrl` (
  `ctrl__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ctrlnmbr` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`ctrl__id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctrl`
--

LOCK TABLES `ctrl` WRITE;
/*!40000 ALTER TABLE `ctrl` DISABLE KEYS */;
INSERT INTO `ctrl` VALUES (1,'Acciones'),(2,'Alerta'),(3,'Bodega'),(4,'Inventario'),(5,'Item'),(6,'Maquinaria'),(7,'Cargo'),(8,'Color'),(9,'EstadoSolicitud'),(10,'TipoItem'),(11,'TipoMaquinaria'),(13,'TipoUsuario'),(14,'Unidad'),(15,'Funcion'),(16,'Proyecto'),(19,'Inicio'),(22,'Persona'),(25,'MotivoSolicitud'),(27,'TipoTrabajo'),(29,'SolicitudMantenimientoExterno'),(30,'NotaPedido'),(31,'Parametros'),(32,'SolicitudMantenimientoInterno'),(33,'ReportesInterfaz'),(34,'TipoDesecho'),(35,'Archivos'),(38,'Asistencia'),(39,'TipoAsistencia'),(40,'Sistema'),(41,'PersonalProyecto');
/*!40000 ALTER TABLE `ctrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctzn`
--

DROP TABLE IF EXISTS `ctzn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctzn` (
  `ctzn__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ctzndsen` int(11) NOT NULL,
  `essl__id` bigint(20) NOT NULL,
  `ctznfcha` datetime NOT NULL,
  `ctznfcfn` datetime DEFAULT NULL,
  `ntpd__id` bigint(20) DEFAULT NULL,
  `ctznprvd` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `ctznvlor` double NOT NULL,
  `solicitud_mantenimiento_externo_id` bigint(20) DEFAULT NULL,
  `ctznfrpg` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `smex__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ctzn__id`),
  KEY `FK_o3lfr9cnk0vbrhwv6l739xuvo` (`essl__id`),
  KEY `FK_vomrg4kov3kxtgdy1x7ofy88` (`ntpd__id`),
  KEY `FK_q8d03be6oc1wfg6k2xmcdwebt` (`solicitud_mantenimiento_externo_id`),
  KEY `FK_bu58rx84dd390ytek5k4himl3` (`smex__id`),
  CONSTRAINT `FK_bu58rx84dd390ytek5k4himl3` FOREIGN KEY (`smex__id`) REFERENCES `smex` (`smex__id`),
  CONSTRAINT `FK_o3lfr9cnk0vbrhwv6l739xuvo` FOREIGN KEY (`essl__id`) REFERENCES `essl` (`essl__id`),
  CONSTRAINT `FK_q8d03be6oc1wfg6k2xmcdwebt` FOREIGN KEY (`solicitud_mantenimiento_externo_id`) REFERENCES `smex` (`smex__id`),
  CONSTRAINT `FK_vomrg4kov3kxtgdy1x7ofy88` FOREIGN KEY (`ntpd__id`) REFERENCES `ntpd` (`ntpd__id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctzn`
--

LOCK TABLES `ctzn` WRITE;
/*!40000 ALTER TABLE `ctzn` DISABLE KEYS */;
INSERT INTO `ctzn` VALUES (1,3,1,'2015-03-27 22:34:16',NULL,2,'fsf',4,NULL,NULL,NULL),(2,4,6,'2015-03-27 22:36:32',NULL,2,'4434f',3,NULL,NULL,NULL),(3,4,1,'2015-03-28 22:38:11',NULL,NULL,'Taller test',150,4,NULL,4),(4,2,11,'2015-03-28 22:39:15',NULL,NULL,'Taller otro',200,4,NULL,4),(5,3,1,'2015-03-28 23:30:22',NULL,NULL,'otro mas',180,4,NULL,4),(6,3,1,'2015-03-29 00:50:47',NULL,NULL,'das',33,5,NULL,5),(7,6,1,'2015-04-22 17:27:46',NULL,NULL,'taller',150,13,NULL,13),(8,5,11,'2015-04-22 17:29:45',NULL,NULL,'otro',250,13,NULL,13),(9,5,6,'2015-04-22 17:43:58',NULL,6,'proveedor',2,NULL,NULL,NULL),(10,8,1,'2015-04-22 17:45:19',NULL,6,'proveedor 2',1.5,NULL,NULL,NULL),(11,4,1,'2015-04-29 22:42:15',NULL,NULL,'Taller test',211,12,'efectivo',12),(12,6,11,'2015-04-29 22:45:50',NULL,NULL,'taller 2',230,12,'credito',12);
/*!40000 ALTER TABLE `ctzn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dtmo`
--

DROP TABLE IF EXISTS `dtmo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dtmo` (
  `dtmo__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dtmofcha` datetime NOT NULL,
  `dtmohrtr` double NOT NULL,
  `dtmoobsv` longtext COLLATE latin1_spanish_ci,
  `prsn__id` bigint(20) NOT NULL,
  `smin__id` bigint(20) NOT NULL,
  `dtmotipo` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`dtmo__id`),
  KEY `FK_7kg6yamch694wqu3n5cc8xk9y` (`prsn__id`),
  KEY `FK_f3uli2bt8wrbsoqwvnhgshtxb` (`smin__id`),
  CONSTRAINT `FK_7kg6yamch694wqu3n5cc8xk9y` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_f3uli2bt8wrbsoqwvnhgshtxb` FOREIGN KEY (`smin__id`) REFERENCES `smin` (`smin__id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dtmo`
--

LOCK TABLES `dtmo` WRITE;
/*!40000 ALTER TABLE `dtmo` DISABLE KEYS */;
INSERT INTO `dtmo` VALUES (1,'2015-05-12 00:00:00',4,'',6,25,'P'),(2,'2015-05-11 00:00:00',3,'',1,25,'P'),(3,'2015-05-15 00:00:00',3,'asdf',1,25,'R'),(4,'2015-05-22 00:00:00',4,'1235',6,25,'R'),(5,'2015-05-12 00:00:00',4,'eee',7,25,'R');
/*!40000 ALTER TABLE `dtmo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dtrp`
--

DROP TABLE IF EXISTS `dtrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dtrp` (
  `dtrp__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item__id` bigint(20) NOT NULL,
  `dtrpcntd` double NOT NULL,
  `dtrpcdgo` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `dtrpmrca` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `smin__id` bigint(20) NOT NULL,
  `undd__id` bigint(20) NOT NULL,
  `dtrpobsv` longtext COLLATE latin1_spanish_ci,
  `dtrptipo` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`dtrp__id`),
  KEY `FK_o4myo9oi1diqi1yji5jremnlx` (`item__id`),
  KEY `FK_1eict7reqs1ogx1i2s27fe19l` (`smin__id`),
  KEY `FK_ti49m8w71rsr0i11yvcwfju4c` (`undd__id`),
  CONSTRAINT `FK_1eict7reqs1ogx1i2s27fe19l` FOREIGN KEY (`smin__id`) REFERENCES `smin` (`smin__id`),
  CONSTRAINT `FK_o4myo9oi1diqi1yji5jremnlx` FOREIGN KEY (`item__id`) REFERENCES `item` (`item__id`),
  CONSTRAINT `FK_ti49m8w71rsr0i11yvcwfju4c` FOREIGN KEY (`undd__id`) REFERENCES `undd` (`undd__id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dtrp`
--

LOCK TABLES `dtrp` WRITE;
/*!40000 ALTER TABLE `dtrp` DISABLE KEYS */;
INSERT INTO `dtrp` VALUES (1,1,4,'1234','marca',12,2,'observaciones',''),(2,1,4,'1234','marca',12,2,'observaciones',''),(7,9,1,'12','asdf',19,1,'observaciones',''),(8,7,4,'','',24,2,'','P'),(9,4,1,'','',24,2,'','P'),(10,9,12,'','',24,1,'','P'),(11,7,4,'','',25,2,'','P'),(12,4,1,'','',25,2,'','P'),(13,9,12,'','',25,1,'','P'),(14,9,15,'','',25,1,'','R'),(15,4,2,'','',25,2,'','R');
/*!40000 ALTER TABLE `dtrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dttr`
--

DROP TABLE IF EXISTS `dttr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dttr` (
  `dttr__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tptr__id` bigint(20) NOT NULL,
  `smex__id` bigint(20) DEFAULT NULL,
  `smin__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`dttr__id`),
  KEY `FK_2n6jnc4fjj1jy7mddds3g7vds` (`tptr__id`),
  KEY `FK_qoa1cwt52xncf2ye8rn2w1wm7` (`smin__id`),
  KEY `FK_n5t0ut82cylyrjpvw4242uqnk` (`smex__id`),
  CONSTRAINT `FK_2n6jnc4fjj1jy7mddds3g7vds` FOREIGN KEY (`tptr__id`) REFERENCES `tptr` (`tptr__id`),
  CONSTRAINT `FK_n5t0ut82cylyrjpvw4242uqnk` FOREIGN KEY (`smex__id`) REFERENCES `smex` (`smex__id`),
  CONSTRAINT `FK_qoa1cwt52xncf2ye8rn2w1wm7` FOREIGN KEY (`smin__id`) REFERENCES `smin` (`smin__id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dttr`
--

LOCK TABLES `dttr` WRITE;
/*!40000 ALTER TABLE `dttr` DISABLE KEYS */;
INSERT INTO `dttr` VALUES (1,2,4,NULL),(2,1,4,NULL),(3,2,5,NULL),(4,5,5,NULL),(5,9,5,NULL),(6,2,6,NULL),(7,1,6,NULL),(8,2,7,NULL),(9,1,7,NULL),(10,4,7,NULL),(11,7,7,NULL),(12,2,NULL,2),(13,1,NULL,2),(14,11,NULL,2),(15,2,NULL,3),(16,1,NULL,3),(17,11,NULL,3),(18,2,NULL,4),(19,1,NULL,4),(20,11,NULL,4),(21,2,NULL,5),(22,1,NULL,5),(23,11,NULL,5),(24,2,NULL,6),(25,1,NULL,6),(26,11,NULL,6),(27,2,NULL,7),(28,1,NULL,7),(29,11,NULL,7),(30,2,NULL,8),(31,1,NULL,8),(32,11,NULL,8),(33,2,NULL,9),(34,1,NULL,9),(35,11,NULL,9),(36,2,NULL,10),(37,1,NULL,10),(38,11,NULL,10),(39,2,NULL,11),(40,1,NULL,11),(41,2,NULL,12),(42,1,NULL,12),(43,2,NULL,13),(44,1,NULL,13),(45,2,8,NULL),(46,5,8,NULL),(47,4,8,NULL),(48,2,9,NULL),(49,1,9,NULL),(50,5,9,NULL),(51,2,10,NULL),(52,1,10,NULL),(53,5,10,NULL),(54,9,10,NULL),(55,2,11,NULL),(56,1,11,NULL),(57,5,11,NULL),(58,9,11,NULL),(59,2,12,NULL),(60,1,12,NULL),(61,5,12,NULL),(62,4,12,NULL),(63,9,12,NULL),(64,2,NULL,14),(65,5,NULL,14),(66,9,NULL,14),(67,2,NULL,15),(68,5,NULL,15),(69,9,NULL,15),(70,2,NULL,16),(71,5,NULL,16),(72,9,NULL,16),(73,2,NULL,17),(74,5,NULL,17),(75,9,NULL,17),(76,2,NULL,18),(77,5,NULL,18),(78,9,NULL,18),(79,2,NULL,19),(80,1,NULL,19),(81,5,13,NULL),(82,4,13,NULL),(83,9,13,NULL),(84,2,NULL,21),(85,1,NULL,21),(86,5,NULL,21),(87,2,NULL,22),(88,1,NULL,22),(89,5,NULL,22),(90,2,NULL,23),(91,1,NULL,23),(92,5,NULL,23),(93,2,NULL,24),(94,1,NULL,24),(95,5,NULL,24),(96,2,NULL,25),(97,1,NULL,25),(98,5,NULL,25);
/*!40000 ALTER TABLE `dttr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egrs`
--

DROP TABLE IF EXISTS `egrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `egrs` (
  `egrs__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `egrscant` double NOT NULL,
  `egrsfcha` datetime NOT NULL,
  `frma__id` bigint(20) DEFAULT NULL,
  `ingr__id` bigint(20) DEFAULT NULL,
  `egrsobsr` varchar(1023) COLLATE latin1_spanish_ci DEFAULT NULL,
  `ntpd__id` bigint(20) DEFAULT NULL,
  `prsn__id` bigint(20) DEFAULT NULL,
  `egrsresp` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `trsf__id` bigint(20) DEFAULT NULL,
  `ingreso_desecho_id` bigint(20) DEFAULT NULL,
  `ingrdsch` bigint(20) DEFAULT NULL,
  `egrslgds` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `egrsprds` double DEFAULT NULL,
  `tpds__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`egrs__id`),
  KEY `FK_cwv62798wspg8oqms8hp2fbvw` (`frma__id`),
  KEY `FK_9ad5o5m157o84sfyxwa580hjl` (`ingr__id`),
  KEY `FK_s7qtq66wpy4nk7xquul09gupe` (`ntpd__id`),
  KEY `FK_9kf67j04t5bfy4253dvsdoi4q` (`prsn__id`),
  KEY `FK_p842ehclifk2jcmm4xa3jcvd1` (`trsf__id`),
  KEY `FK_40a5vt6fhy2icpmw7t8pge296` (`ingreso_desecho_id`),
  KEY `FK_sq20mxtvn0h4kgubaumeuc76x` (`ingrdsch`),
  KEY `FK_cban3obtp4grx481vxby1kmns` (`tpds__id`),
  CONSTRAINT `FK_40a5vt6fhy2icpmw7t8pge296` FOREIGN KEY (`ingreso_desecho_id`) REFERENCES `ingr` (`ingr__id`),
  CONSTRAINT `FK_9ad5o5m157o84sfyxwa580hjl` FOREIGN KEY (`ingr__id`) REFERENCES `ingr` (`ingr__id`),
  CONSTRAINT `FK_9kf67j04t5bfy4253dvsdoi4q` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_cban3obtp4grx481vxby1kmns` FOREIGN KEY (`tpds__id`) REFERENCES `tpds` (`tpds__id`),
  CONSTRAINT `FK_cwv62798wspg8oqms8hp2fbvw` FOREIGN KEY (`frma__id`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_p842ehclifk2jcmm4xa3jcvd1` FOREIGN KEY (`trsf__id`) REFERENCES `trsf` (`trsf__id`),
  CONSTRAINT `FK_s7qtq66wpy4nk7xquul09gupe` FOREIGN KEY (`ntpd__id`) REFERENCES `ntpd` (`ntpd__id`),
  CONSTRAINT `FK_sq20mxtvn0h4kgubaumeuc76x` FOREIGN KEY (`ingrdsch`) REFERENCES `ingr` (`ingr__id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egrs`
--

LOCK TABLES `egrs` WRITE;
/*!40000 ALTER TABLE `egrs` DISABLE KEYS */;
INSERT INTO `egrs` VALUES (1,2,'2015-03-27 21:53:50',6,1,NULL,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,'2015-03-27 22:16:39',7,1,'no tiene',2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,2,'2015-03-27 22:53:36',16,2,'vsd',NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,5,'2015-04-04 11:52:13',88,23,NULL,NULL,1,NULL,NULL,NULL,24,NULL,NULL,NULL),(5,7,'2015-04-04 11:52:24',90,23,NULL,NULL,1,NULL,NULL,NULL,25,NULL,NULL,NULL),(6,10,'2015-04-04 11:52:33',92,22,NULL,NULL,1,NULL,NULL,NULL,26,NULL,NULL,NULL),(7,5,'2015-04-04 12:16:24',94,22,NULL,NULL,1,NULL,NULL,NULL,27,NULL,NULL,NULL),(8,2,'2015-04-04 12:32:14',96,24,'Egreso de desecho',NULL,NULL,'asdf',NULL,NULL,NULL,'qwer',NULL,2),(9,3,'2015-04-04 15:13:24',97,24,'Egreso de desecho',NULL,NULL,'qwer',NULL,NULL,NULL,'qwer',18,1),(10,5,'2015-04-04 15:13:37',98,26,'Egreso de desecho',NULL,NULL,'234f',NULL,NULL,NULL,'eee',NULL,3),(11,2,'2015-04-04 15:59:26',99,26,'Egreso de desecho',NULL,NULL,'zxcv',NULL,NULL,NULL,'zxcv',NULL,2),(12,5,'2015-04-22 17:07:41',100,25,'Egreso de desecho',NULL,NULL,'',NULL,NULL,NULL,'lugar',NULL,2),(13,5,'2015-04-22 17:36:09',NULL,6,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,7,'2015-04-22 17:39:39',112,10,NULL,5,2,NULL,NULL,NULL,28,NULL,NULL,NULL),(15,3,'2015-04-22 17:41:59',NULL,4,NULL,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,2,'2015-05-07 20:39:26',NULL,20,NULL,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `egrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essl`
--

DROP TABLE IF EXISTS `essl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essl` (
  `essl__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `esslcdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `essldscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `esslnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `essltipo` varchar(2) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`essl__id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essl`
--

LOCK TABLES `essl` WRITE;
/*!40000 ALTER TABLE `essl` DISABLE KEYS */;
INSERT INTO `essl` VALUES (1,'E01','La nota de pedido fue solicitada y está a la espera de que un jefe la apruebe','Pendiente de aprobación','NP'),(2,'E02','La nota de pedido fue aprobada por un jefe y está a la espera de que un jefe de compras asigne a un asistente de compras para las cotizaciones','Pendiente de asignación','NP'),(3,'E03','Un asistente de compras fue asignado a la nota de pedido y está a la espera del registro de las cotizaciones','Pendientes cotizaciones','NP'),(4,'E04','Las cotizaciones de la nota de pedido fueron registradas y está a la espera de la aprobación final','Pendiente de aprobación final','NP'),(5,'N01','La nota de pedido fue negada','Negada','NP'),(6,'A01','La nota de pedido fue aprobada y se procederá a su adquisición','Aprobada','NP'),(7,'B01','El item solicitado existe en bodega y se procederá al envío','En bodega','NP'),(8,'C01','El item solicitado fue ingresado en una bodega','Completada','NP'),(9,'E11','La solicitud de mantenimiento externo fue realizada y está a la espera que un jefe de compras asigne a un asistente de compras','Pendiente de asignación','MX'),(10,'E12','Un asistente de compras fue asignado a la solicitud de mantenimiento externo y está a la espera del registro de las cotizaciones','Pendientes cotizaciones','MX'),(11,'A11','La solicitud de mantenimiento externo fue aprobada','Aprobada','MX'),(12,'N11','La solicitud de mantenimiento externo  fue negada','Negada','MX'),(13,'E13','Las cotizaciones de la solicitud de mantenimiento externo fueron registradas y está a la espera de la aprobación final','Pendiente de aprobación final','MX'),(14,'E21','La solicitud de mantenimiento interno fue realizada y está a la espera que un jefe o gerente la apruebe','Pendiente de aprobación final','MI'),(15,'A21','La solicitud de mantenimiento interno fue aprobada','Aprobada','MI'),(16,'N21','La solicitud de mantenimiento interno fue negada','Negada','MI'),(17,'C21','El formulario de la solicitud de mantenimiento interno fue completado y el documento fue marcado como completado','Completada','MI');
/*!40000 ALTER TABLE `essl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fncn`
--

DROP TABLE IF EXISTS `fncn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fncn` (
  `fncn__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `crgo__id` bigint(20) NOT NULL,
  `prsn__id` bigint(20) NOT NULL,
  `proy__id` bigint(20) NOT NULL,
  PRIMARY KEY (`fncn__id`),
  KEY `FK_4tt7n59ikf20dmi7au9g3d4s7` (`crgo__id`),
  KEY `FK_oc78gd3hpg3j759fseplnm1j3` (`prsn__id`),
  KEY `FK_q956c7dw09yjvo8dn5qdr860w` (`proy__id`),
  CONSTRAINT `FK_4tt7n59ikf20dmi7au9g3d4s7` FOREIGN KEY (`crgo__id`) REFERENCES `crgo` (`crgo__id`),
  CONSTRAINT `FK_oc78gd3hpg3j759fseplnm1j3` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_q956c7dw09yjvo8dn5qdr860w` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fncn`
--

LOCK TABLES `fncn` WRITE;
/*!40000 ALTER TABLE `fncn` DISABLE KEYS */;
/*!40000 ALTER TABLE `fncn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frma`
--

DROP TABLE IF EXISTS `frma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frma` (
  `frma__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `frmacncp` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `frmafcha` datetime NOT NULL,
  `frma_key` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `frmapath` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `frmapdfa` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `frmapdfc` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `frmapdfi` bigint(20) NOT NULL,
  `prsn__id` bigint(20) NOT NULL,
  PRIMARY KEY (`frma__id`),
  KEY `FK_emj92ad1q6mb6c6vvyie81fkp` (`prsn__id`),
  CONSTRAINT `FK_emj92ad1q6mb6c6vvyie81fkp` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frma`
--

LOCK TABLES `frma` WRITE;
/*!40000 ALTER TABLE `frma` DISABLE KEYS */;
INSERT INTO `frma` VALUES (1,'Ingreso a bodega de 4.0U LLANTA RIN 19 el 26-03-2015 23:56','2015-03-26 23:56:04','98b9740de0b7b7c773a2a982fc8942f1769c1e9608773f3f8dc8','rsbd_20150326_2356.png','ingresoDeBodega','reportesInventario',1,4),(2,'Nota de pedido núm. 1 de Usuario Normal 27-03-2015 00:00','2015-03-27 00:00:41','cab1fe5d4f7659b8d43fed4338fe1429cc25dddbb8773f3f8dc8','usu_20150327_0000.png','notaPedido','reportesInventario',1,2),(3,'Nota de pedido núm. 2 de Usuario Normal 27-03-2015 21:49','2015-03-27 21:49:29','906e7ce2129578216334d6cd1b467f1fcc25dddbb8773f3f8dc8','usu_20150327_2149.png','notaPedido','reportesInventario',2,2),(4,'Notificación de existencia en bodega de Nota de pedido núm. 1 de Usuario Normal 27-03-2015 21:51','2015-03-27 21:51:41','b97c35e5ff8c07d7b590b3966caa156e8d6d3e8b96773f3f8dc8','jefe_20150327_2151.png','notaPedido','reportesInventario',1,3),(5,'Notificación de existencia en bodega y aprobación parcial de Nota de pedido núm. 2 de Usuario Normal 27-03-2015 21:52','2015-03-27 21:52:24','b3c4ca7e47417dcf5cc4286fa3d63c698d6d3e8b96773f3f8dc8','jefe_20150327_2152.png','notaPedido','reportesInventario',2,3),(6,'Egreso de bodega de 2.0U LLANTA RIN 19, nota de pedido 1 el 27-03-2015 21:53','2015-03-27 21:53:50',NULL,NULL,'egresoDeBodega','reportesInventario',1,4),(7,'Egreso de bodega de 2.0U LLANTA RIN 19, nota de pedido 2 el 27-03-2015 22:16','2015-03-27 22:16:39',NULL,NULL,'egresoDeBodega','reportesInventario',2,4),(8,'Aprobación (2.0 U) de Nota de pedido núm. 2 de Usuario Normal 27-03-2015 22:32','2015-03-27 22:32:11','9b2c3d823b40ce5d6174c3d2f485ec830c839180d5773f3f8dc8','jfcm_20150327_2232.png','notaPedido','reportesInventario',2,7),(9,'Cargado de cotizaciones (2.0 U) de Nota de pedido núm. 2 de Usuario Normal 27-03-2015 22:35','2015-03-27 22:35:07','1ea4e7552172713b62e556bac84c6f96c42eb684d0773f3f8dc8','ascm_20150327_2235.png','notaPedido','reportesInventario',2,5),(10,'Solicitud de recarga de cotizaciones de Nota de pedido núm. 2 de Usuario Normal 27-03-2015 22:35','2015-03-27 22:35:57','982150300eae4451d95c8c35be4f8bd18d6d3e8b96773f3f8dc8','jefe_20150327_2235.png','notaPedido','reportesInventario',2,3),(11,'Cargado de cotizaciones (2.0 U) de Nota de pedido núm. 2 de Usuario Normal 27-03-2015 22:36','2015-03-27 22:36:37','cda97f68c3557a64cd96843cf5531253c42eb684d0773f3f8dc8','ascm_20150327_2236.png','notaPedido','reportesInventario',2,5),(12,'APROBACIÓN (2.0 U) de Nota de pedido núm. 2 de Usuario Normal 27-03-2015 22:37','2015-03-27 22:37:12','fa20e732080345e78750ea3434800cc18d6d3e8b96773f3f8dc8','jefe_20150327_2237.png','notaPedido','reportesInventario',2,3),(13,'','2015-03-27 22:38:19',NULL,NULL,'ingresoDeBodega','reportesInventario',0,4),(14,'','2015-03-27 22:49:11',NULL,NULL,'ingresoDeBodega','reportesInventario',0,4),(15,'Ingreso a bodega de 4.0U LLANTA RIN 19, nota de pedido 2 el 27-03-2015 22:52','2015-03-27 22:52:42','4f6f6cee40efc36fcc3a2659e74be9f7769c1e9608773f3f8dc8','rsbd_20150327_2252.png','ingresoDeBodega','reportesInventario',2,4),(16,'Egreso de bodega de 2.0U LLANTA RIN 19 el 27-03-2015 22:53','2015-03-27 22:53:36',NULL,NULL,'egresoDeBodega','reportesInventario',3,4),(17,'','2015-03-28 17:16:51',NULL,NULL,'solicitudMAntExt','reportesPedidos',0,9),(18,'','2015-03-28 17:20:38',NULL,NULL,'solicitudMAntExt','reportesPedidos',0,9),(19,'','2015-03-28 17:25:03',NULL,NULL,'solicitudMAntExt','reportesPedidos',0,9),(20,'Solicitud de mantenimiento externo núm. 4 de jefe mantenimiento 28-03-2015 17:32','2015-03-28 17:32:30','e8a9d510fbd138401d6d4a8f6b795f3ecec7ca9346ba59abbe56','jfmn_20150328_1732.png','solicitudMAntExt','reportesPedidos',4,9),(21,'Solicitud de mantenimiento externo núm. 5 de jefe mantenimiento 28-03-2015 17:33','2015-03-28 17:33:47','35711c90eefaa7825f356079528279b2cec7ca9346ba59abbe56','jfmn_20150328_1733.png','solicitudMAntExt','reportesPedidos',5,9),(22,'Solicitud de mantenimiento externo núm. 6 de jefe mantenimiento 28-03-2015 20:52','2015-03-28 20:52:08','b9108207105809dcb609a994ce299511cec7ca9346ba59abbe56','jfmn_20150328_2052.png','solicitudMAntExt','reportesPedidos',6,9),(23,'Solicitud de mantenimiento externo núm. 7 de jefe mantenimiento 28-03-2015 20:55','2015-03-28 20:55:13','78ca7540bed46b1ee55a19c3fca67031cec7ca9346ba59abbe56','jfmn_20150328_2055.png','solicitudMAntExt','reportesPedidos',7,9),(24,'Aprobación de Solicitud de mantenimiento externo núm. 4 de jefe mantenimiento 28-03-2015 22:01','2015-03-28 22:01:52','2602f43a6f892b68b2ef8f9fbd9f8b860c839180d5773f3f8dc8','jfcm_20150328_2201.png','solicitudMantenimientoExterno','reportesPedidos',4,7),(25,'Cargado de cotizaciones de Solicitud de mantenimiento externo núm. 4 de jefe mantenimiento 28-03-2015 22:43','2015-03-28 22:43:13','852e868fe509377535d7af04bc907555c42eb684d0773f3f8dc8','ascm_20150328_2243.png','solicitudMantenimientoExterno','reportesPedidos',4,5),(26,'Solicitud de recarga de cotizaciones de Solicitud de mantenimiento externo núm. 4 de jefe mantenimiento 28-03-2015 23:29','2015-03-28 23:29:40','8f09dee166dc878c682dce83f549da1d4896ea479c773f3f8dc8','grnt_20150328_2329.png','solicitudMantenimientoExterno','reportesPedidos',4,6),(27,'Cargado de cotizaciones de Solicitud de mantenimiento externo núm. 4 de jefe mantenimiento 28-03-2015 23:30','2015-03-28 23:30:34','d7eeaf7fb631549d37f40f55b9eb8be5c42eb684d0773f3f8dc8','ascm_20150328_2330.png','solicitudMantenimientoExterno','reportesPedidos',4,5),(28,'APROBACIÓN de Solicitud de mantenimiento externo núm. 4 de jefe mantenimiento 28-03-2015 23:32','2015-03-28 23:32:44','15df2feca64bd7bb0333c977206f4d7d4896ea479c773f3f8dc8','grnt_20150328_2332.png','solicitudMantenimientoExterno','reportesPedidos',4,6),(29,'Aprobación de Solicitud de mantenimiento externo núm. 5 de jefe mantenimiento 29-03-2015 00:49','2015-03-29 00:49:51','e76b2c9a4700dce833110f2ef790b9cd0c839180d5773f3f8dc8','jfcm_20150329_0049.png','solicitudMantenimientoExterno','reportesPedidos',5,7),(30,'Aprobación de Solicitud de mantenimiento externo núm. 6 de jefe mantenimiento 29-03-2015 00:50','2015-03-29 00:50:09','17d423960dbc436a32e588785462777b0c839180d5773f3f8dc8','jfcm_20150329_0050.png','solicitudMantenimientoExterno','reportesPedidos',6,7),(31,'Cargado de cotizaciones de Solicitud de mantenimiento externo núm. 5 de jefe mantenimiento 29-03-2015 00:50','2015-03-29 00:50:57','975e7b3383eec28b54f333ec3434a923c42eb684d0773f3f8dc8','ascm_20150329_0050.png','solicitudMantenimientoExterno','reportesPedidos',5,5),(32,'Negación de Solicitud de mantenimiento externo núm. 6 de jefe mantenimiento 29-03-2015 00:51','2015-03-29 00:51:18','82148c7d914beb17dbb1f426599a3ce7c42eb684d0773f3f8dc8','ascm_20150329_0051.png','solicitudMantenimientoExterno','reportesPedidos',6,5),(33,'NEGACIÓN de Solicitud de mantenimiento externo núm. 5 de jefe mantenimiento 29-03-2015 00:52','2015-03-29 00:52:54','cb7af547cf2142fd4ac9cdbc9f48ddfc8d6d3e8b96773f3f8dc8','jefe_20150329_0052.png','solicitudMantenimientoExterno','reportesPedidos',5,3),(34,'Aprobación de Solicitud de mantenimiento externo núm. 7 de jefe mantenimiento 29-03-2015 00:53','2015-03-29 00:53:40','16d6f367f16b6ca87ea0be9fc13aa8f60c839180d5773f3f8dc8','jfcm_20150329_0053.png','solicitudMantenimientoExterno','reportesPedidos',7,7),(35,'Negación de Solicitud de mantenimiento externo núm. 7 de jefe mantenimiento 29-03-2015 00:54','2015-03-29 00:54:16','3ca26ff757a6d814555e707b0805960fc42eb684d0773f3f8dc8','ascm_20150329_0054.png','solicitudMantenimientoExterno','reportesPedidos',7,5),(36,'','2015-03-29 16:39:40',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(37,'','2015-03-29 16:41:34',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(38,'','2015-03-29 16:42:10',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(39,'','2015-03-29 16:43:37',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(40,'','2015-03-29 16:46:11',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(41,'','2015-03-29 16:49:16',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(42,'','2015-03-29 16:49:59',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(43,'','2015-03-29 16:50:25','8f9034357ac44ce44efb1cee2372c588cec7ca9346ba59abbe56','jfmn_20150329_1650.png','solicitudMantInt','reportesPedidos',8,9),(44,'Solicitud de mantenimiento interno n?m. 9 de jefe mantenimiento 29-03-2015 16:58','2015-03-29 16:58:07','fe98f7482c989cce63caba734c71ee10cec7ca9346ba59abbe56','jfmn_20150329_1658.png','solicitudMantInt','reportesPedidos',9,9),(45,'Solicitud de mantenimiento interno n?m. 10 de jefe mantenimiento 29-03-2015 16:58','2015-03-29 16:58:56','a2bf7ebbcf501cf979aa5698d70042d0cec7ca9346ba59abbe56','jfmn_20150329_1658.png','solicitudMantInt','reportesPedidos',10,9),(46,'Solicitud de mantenimiento interno n?m. 11 de jefe mantenimiento 29-03-2015 17:04','2015-03-29 17:04:17','6d2623270c4262bae3e0151c57fd7496cec7ca9346ba59abbe56','jfmn_20150329_1704.png','solicitudMantInt','reportesPedidos',11,9),(47,'Solicitud de mantenimiento interno n?m. 12 de jefe mantenimiento 29-03-2015 17:09','2015-03-29 17:09:24','f976f474577f9d83d7a590a5dda677cbcec7ca9346ba59abbe56','jfmn_20150329_1709.png','solicitudMantInt','reportesPedidos',12,9),(48,'Solicitud de mantenimiento interno n?m. 13 de jefe mantenimiento 29-03-2015 17:11','2015-03-29 17:11:34','961764f5d5ac67848a3336f6e0189f3fcec7ca9346ba59abbe56','jfmn_20150329_1711.png','solicitudMantInt','reportesPedidos',13,9),(49,'APROBACI?N de Solicitud de mantenimiento interno n?m. 12 de jefe mantenimiento 29-03-2015 17:12','2015-03-29 17:12:42','348c0cdf1ec61e77766e2d21f1abb9dc8d6d3e8b96773f3f8dc8','jefe_20150329_1712.png','solicitudMantenimientoInterno','reportesPedidos',12,3),(50,'NEGACI?N de Solicitud de mantenimiento interno n?m. 11 de jefe mantenimiento 29-03-2015 17:14','2015-03-29 17:14:36','8ffa81689cbf9e742da68affa02c64414896ea479c773f3f8dc8','grnt_20150329_1714.png','solicitudMantenimientoInterno','reportesPedidos',11,6),(51,'Nota de pedido núm. 3 de Admin Admin 29-03-2015 20:35','2015-03-29 20:35:28','2d4506f14e3bbf6d60a72e6997abe56421232f297a773f3f8dc8','admin_20150329_2035.png','notaDePedido','reportesPedidos',3,1),(52,'Solicitud de mantenimiento externo núm. 8 de jefe mantenimiento 29-03-2015 20:36','2015-03-29 20:36:48','57378c8f215b98be4bf3078e51516fe9cec7ca9346ba59abbe56','jfmn_20150329_2036.png','solicitudMantExt','reportesPedidos',8,9),(53,'','2015-03-29 20:57:46',NULL,NULL,'solicitudMantExt','reportesPedidos',0,9),(54,'','2015-03-29 20:58:07',NULL,NULL,'solicitudMantExt','reportesPedidos',0,9),(55,'','2015-03-29 21:02:03',NULL,NULL,'solicitudMantExt','reportesPedidos',0,9),(56,'','2015-03-29 21:05:30',NULL,NULL,'solicitudMantExt','reportesPedidos',0,9),(57,'','2015-03-29 21:07:01',NULL,NULL,'solicitudMantExt','reportesPedidos',0,9),(58,'','2015-03-29 21:11:14',NULL,NULL,'solicitudMantExt','reportesPedidos',0,9),(59,'Solicitud de mantenimiento externo núm. 11 de jefe mantenimiento 29-03-2015 21:12','2015-03-29 21:13:00','5702e54c1858091046fd68edb81676facec7ca9346ba59abbe56','jfmn_20150329_2113.png','solicitudMantExt','reportesPedidos',11,9),(60,'Solicitud de mantenimiento externo núm. 12 de jefe mantenimiento 29-03-2015 21:21','2015-03-29 21:21:57','3b26a94a1bd23bbde2540328c355c9f6cec7ca9346ba59abbe56','jfmn_20150329_2121.png','solicitudMantExt','reportesPedidos',12,9),(61,'','2015-03-29 21:22:36',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(62,'','2015-03-29 21:29:10',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(63,'','2015-03-29 21:36:58',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(64,'Solicitud de mantenimiento interno núm. 17 de jefe mantenimiento 29-03-2015 22:12','2015-03-29 22:12:50','ae9b63ed0e041298d845e94b7f6890c1cec7ca9346ba59abbe56','jfmn_20150329_2212.png','solicitudMantInt','reportesPedidos',17,9),(65,'Solicitud de mantenimiento interno núm. 18 de jefe mantenimiento 29-03-2015 22:40','2015-03-29 22:40:38','2a01a82d7ee857e073436d4d16c63f3fcec7ca9346ba59abbe56','jfmn_20150329_2240.png','solicitudMantInt','reportesPedidos',18,9),(66,'APROBACIÓN de Solicitud de mantenimiento interno núm. 18 de jefe mantenimiento 29-03-2015 22:46','2015-03-29 22:46:56','4a57a9ccdbb7d902eca7fa67b1e1bf6f4896ea479c773f3f8dc8','grnt_20150329_2246.png','solicitudMantenimientoInterno','reportesPedidos',18,6),(67,'Ingreso a bodega de 23.0GL ACEITE TIPO 1 el 04-04-2015 11:48','2015-04-04 11:48:17','5ac298b3e94e36a9b26982de9019f34b769c1e9608773f3f8dc8','rsbd_20150404_1148.png','ingresoDeBodega','reportesInventario',3,4),(68,'Ingreso a bodega de 3.0GL ACEITE TIPO 2 el 04-04-2015 11:48','2015-04-04 11:48:17','c94ee8d6b524e359b22e1284685c739c769c1e9608773f3f8dc8','rsbd_20150404_1148.png','ingresoDeBodega','reportesInventario',4,4),(69,'Ingreso a bodega de 4.0U LLANTA 10 el 04-04-2015 11:48','2015-04-04 11:48:17','718e31a93191f44ff093f7974dcad9e7769c1e9608773f3f8dc8','rsbd_20150404_1148.png','ingresoDeBodega','reportesInventario',5,4),(70,'Ingreso a bodega de 5.0U LLANTA 12 el 04-04-2015 11:48','2015-04-04 11:48:17','e647b2443bc3b286a21e4743ab785719769c1e9608773f3f8dc8','rsbd_20150404_1148.png','ingresoDeBodega','reportesInventario',6,4),(71,'Ingreso a bodega de 6.0U LLANTA 15 el 04-04-2015 11:48','2015-04-04 11:48:17','c40757cd45e2a0acbd8132a970db3411769c1e9608773f3f8dc8','rsbd_20150404_1148.png','ingresoDeBodega','reportesInventario',7,4),(72,'Ingreso a bodega de 11.0U LLANTA 17 el 04-04-2015 11:48','2015-04-04 11:48:17','ab60cff04c01c4d2520bca254ab7876f769c1e9608773f3f8dc8','rsbd_20150404_1148.png','ingresoDeBodega','reportesInventario',8,4),(73,'Ingreso a bodega de 11.0U LLANTA 15 el 04-04-2015 11:49','2015-04-04 11:49:16','6f3fef9a70338c2cbc7bccd80a19e964769c1e9608773f3f8dc8','rsbd_20150404_1149.png','ingresoDeBodega','reportesInventario',9,4),(74,'Ingreso a bodega de 16.0U LLANTA 12 el 04-04-2015 11:49','2015-04-04 11:49:16','54cdd346a5f259eff8c4ae0ae76420c4769c1e9608773f3f8dc8','rsbd_20150404_1149.png','ingresoDeBodega','reportesInventario',10,4),(75,'Ingreso a bodega de 14.0U LLANTA 17 el 04-04-2015 11:49','2015-04-04 11:49:16','a436b73e3a015a1b716295ceb27b0c6f769c1e9608773f3f8dc8','rsbd_20150404_1149.png','ingresoDeBodega','reportesInventario',11,4),(76,'Ingreso a bodega de 27.0U LLANTA RIN 19 el 04-04-2015 11:49','2015-04-04 11:49:16','ccc8dbb577f8acbd7245429c71e65483769c1e9608773f3f8dc8','rsbd_20150404_1149.png','ingresoDeBodega','reportesInventario',12,4),(77,'Ingreso a bodega de 55.0U TUERCA 1\' el 04-04-2015 11:49','2015-04-04 11:49:16','79d8d70f059c7ee1ed4c57029ba63b88769c1e9608773f3f8dc8','rsbd_20150404_1149.png','ingresoDeBodega','reportesInventario',13,4),(78,'Ingreso a bodega de 34.0U TUERCA 1/2\' el 04-04-2015 11:49','2015-04-04 11:49:16','360fe550353b5be5fa41b81d172fee15769c1e9608773f3f8dc8','rsbd_20150404_1149.png','ingresoDeBodega','reportesInventario',14,4),(79,'Ingreso a bodega de 24.0U LLANTA 17 el 04-04-2015 11:50','2015-04-04 11:50:00','54b94f3cc98a3c6d043f9025090e6ef9769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',15,4),(80,'Ingreso a bodega de 14.0U LLANTA RIN 19 el 04-04-2015 11:50','2015-04-04 11:50:00','23938edb5d81b85127b7beb7fb970bee769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',16,4),(81,'Ingreso a bodega de 24.0U TUERCA 1\' el 04-04-2015 11:50','2015-04-04 11:50:00','be01e3a70c6467c4697a6ed0a229e292769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',17,4),(82,'Ingreso a bodega de 12.0U TUERCA 1/2\' el 04-04-2015 11:50','2015-04-04 11:50:00','e617f143e5769191dd0ab106e4d84897769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',18,4),(83,'Ingreso a bodega de 44.0U TUERCA 1/4\' el 04-04-2015 11:50','2015-04-04 11:50:00','622ca2ec8082c40c0b89da686ae8f8fb769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',19,4),(84,'Ingreso a bodega de 24.0U LLANTA 10 el 04-04-2015 11:50','2015-04-04 11:50:00','717a446d7086c4ca42d31707b72def31769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',20,4),(85,'Ingreso a bodega de 23.0GL ACEITE TIPO 1 el 04-04-2015 11:50','2015-04-04 11:50:28','33f6ab027db55530b54b84fc7ff13dc4769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',21,4),(86,'Ingreso a bodega de 32.0U TUERCA 1/4\' el 04-04-2015 11:50','2015-04-04 11:50:28','bc98db07698ec036d546c273d3691d79769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',22,4),(87,'Ingreso a bodega de 32.0U TUERCA 1\' el 04-04-2015 11:50','2015-04-04 11:50:28','4f8f3920f761b25cc847f3a6afdfaac0769c1e9608773f3f8dc8','rsbd_20150404_1150.png','ingresoDeBodega','reportesInventario',23,4),(88,'Egreso de bodega de 5.0U TUERCA 1\' el 04-04-2015 11:52','2015-04-04 11:52:13',NULL,NULL,'egresoDeBodega','reportesInventario',4,4),(89,'Ingreso de desecho de 5.0U TUERCA 1\' el 04-04-2015 11:52','2015-04-04 11:52:13',NULL,NULL,'ingresoDeDesecho','reportesInventario',24,4),(90,'Egreso de bodega de 7.0U TUERCA 1\' el 04-04-2015 11:52','2015-04-04 11:52:24',NULL,NULL,'egresoDeBodega','reportesInventario',5,4),(91,'Ingreso de desecho de 7.0U TUERCA 1\' el 04-04-2015 11:52','2015-04-04 11:52:24',NULL,NULL,'ingresoDeDesecho','reportesInventario',25,4),(92,'Egreso de bodega de 10.0U TUERCA 1/4\' el 04-04-2015 11:52','2015-04-04 11:52:33',NULL,NULL,'egresoDeBodega','reportesInventario',6,4),(93,'Ingreso de desecho de 10.0U TUERCA 1/4\' el 04-04-2015 11:52','2015-04-04 11:52:33',NULL,NULL,'ingresoDeDesecho','reportesInventario',26,4),(94,'Egreso de bodega de 5.0U TUERCA 1/4\' el 04-04-2015 12:16','2015-04-04 12:16:24',NULL,NULL,'egresoDeBodega','reportesInventario',7,4),(95,'Ingreso de desecho de 5.0U TUERCA 1/4\' el 04-04-2015 12:16','2015-04-04 12:16:24',NULL,NULL,'ingresoDeDesecho','reportesInventario',27,4),(96,'Egreso de bodega de de desecho 2.0U TUERCA 1\' el 04-04-2015 12:32','2015-04-04 12:32:14',NULL,NULL,'egresoDeBodegaDesecho','reportesInventario',8,7),(97,'Egreso de bodega de de desecho 3.0U TUERCA 1\' el 04-04-2015 15:13','2015-04-04 15:13:24',NULL,NULL,'egresoDeBodegaDesecho','reportesInventario',9,7),(98,'Egreso de bodega de de desecho 5.0U TUERCA 1/4\' el 04-04-2015 15:13','2015-04-04 15:13:37',NULL,NULL,'egresoDeBodegaDesecho','reportesInventario',10,7),(99,'Egreso de bodega de de desecho 2.0U TUERCA 1/4\' el 04-04-2015 15:59','2015-04-04 15:59:26',NULL,NULL,'egresoDeBodegaDesecho','reportesInventario',11,7),(100,'Egreso de bodega de de desecho 5.0U TUERCA 1\' el 22-04-2015 17:07','2015-04-22 17:07:41',NULL,NULL,'egresoDeBodegaDesecho','reportesInventario',12,7),(101,'Solicitud de mantenimiento interno núm. 19 de jefe mantenimiento 22-04-2015 17:12','2015-04-22 17:12:00','195548f8d321b943aa11917d23652abdcec7ca9346ba59abbe56','jfmn_20150422_1712.png','solicitudMantInt','reportesPedidos',19,9),(102,'APROBACIÓN de Solicitud de mantenimiento interno núm. 19 de jefe mantenimiento 22-04-2015 17:14','2015-04-22 17:14:06','7fbf883a7aea612ea34970d7a97ac38d4896ea479c773f3f8dc8','grnt_20150422_1714.png','solicitudMantenimientoInterno','reportesPedidos',19,6),(103,'Solicitud de mantenimiento externo núm. 13 de jefe mantenimiento 22-04-2015 17:24','2015-04-22 17:24:48','450081b8a408eb68ae1ea52fbf3ee890cec7ca9346ba59abbe56','jfmn_20150422_1724.png','solicitudMantExt','reportesPedidos',13,9),(104,'Aprobación de Solicitud de mantenimiento externo núm. 13 de jefe mantenimiento 22-04-2015 17:26','2015-04-22 17:26:28','5395a2cec14d78e178930293847edda80c839180d5773f3f8dc8','jfcm_20150422_1726.png','solicitudMantenimientoExterno','reportesPedidos',13,7),(105,'Cargado de cotizaciones de Solicitud de mantenimiento externo núm. 13 de jefe mantenimiento 22-04-2015 17:28','2015-04-22 17:28:12','064ce120fc3e5b2830a83c043f24e430c42eb684d0773f3f8dc8','ascm_20150422_1728.png','solicitudMantenimientoExterno','reportesPedidos',13,5),(106,'Solicitud de recarga de cotizaciones de Solicitud de mantenimiento externo núm. 13 de jefe mantenimiento 22-04-2015 17:28','2015-04-22 17:28:54','8abeae95dc69ea54350bbb8f5a6b24218d6d3e8b96773f3f8dc8','jefe_20150422_1728.png','solicitudMantenimientoExterno','reportesPedidos',13,3),(107,'Cargado de cotizaciones de Solicitud de mantenimiento externo núm. 13 de jefe mantenimiento 22-04-2015 17:29','2015-04-22 17:29:54','4002327c76502cfcde0952cf3bc42980c42eb684d0773f3f8dc8','ascm_20150422_1729.png','solicitudMantenimientoExterno','reportesPedidos',13,5),(108,'APROBACIÓN de Solicitud de mantenimiento externo núm. 13 de jefe mantenimiento 22-04-2015 17:30','2015-04-22 17:30:36','2e2e73a72086734465b5fd2a1a1bf45d4896ea479c773f3f8dc8','grnt_20150422_1730.png','solicitudMantenimientoExterno','reportesPedidos',13,6),(109,'Nota de pedido núm. 4 de Usuario Normal 22-04-2015 17:34','2015-04-22 17:34:44','00bfb69f686c7449d98e5a9b6daf7e91cc25dddbb8773f3f8dc8','usu_20150422_1734.png','notaDePedido','reportesPedidos',4,2),(110,'Nota de pedido núm. 5 de Usuario Normal 22-04-2015 17:37','2015-04-22 17:37:42','7fdf86bf7a38710a1c152fca5b1da265cc25dddbb8773f3f8dc8','usu_20150422_1737.png','notaDePedido','reportesPedidos',5,2),(111,'Notificación de existencia en bodega de Nota de pedido núm. 5 de Usuario Normal 22-04-2015 17:38','2015-04-22 17:38:13','51a84c7d1147a8affe8f1649be58a70d8d6d3e8b96773f3f8dc8','jefe_20150422_1738.png','notaPedido','reportesInventario',5,3),(112,'Egreso de bodega de 7.0U LLANTA 12, nota de pedido 5 el 22-04-2015 17:39','2015-04-22 17:39:39',NULL,NULL,'egresoDeBodega','reportesInventario',14,4),(113,'Ingreso de desecho de 7.0U LLANTA 12 el 22-04-2015 17:39','2015-04-22 17:39:39',NULL,NULL,'ingresoDeDesecho','reportesInventario',28,4),(114,'Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:41','2015-04-22 17:41:03','5ab399a96f7b5e3a55984fa8930245c9cc25dddbb8773f3f8dc8','usu_20150422_1741.png','notaDePedido','reportesPedidos',6,2),(115,'Notificación de existencia en bodega y aprobación parcial de Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:41','2015-04-22 17:41:59','10defae3a86dd2e40ecaddfd4b864a308d6d3e8b96773f3f8dc8','jefe_20150422_1741.png','notaPedido','reportesInventario',6,3),(116,'Aprobación (7.0 GL) de Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:43','2015-04-22 17:43:18','d4578d45e8542b66ff3a4b06e0c84a200c839180d5773f3f8dc8','jfcm_20150422_1743.png','notaPedido','reportesInventario',6,7),(117,'Cargado de cotizaciones (7.0 GL) de Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:44','2015-04-22 17:44:10','93074cd41449430886d1e912d0f7f6c9c42eb684d0773f3f8dc8','ascm_20150422_1744.png','notaPedido','reportesInventario',6,5),(118,'Solicitud de recarga de cotizaciones de Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:44','2015-04-22 17:44:45','a62700166d63a98a35fdf3e530908e908d6d3e8b96773f3f8dc8','jefe_20150422_1744.png','notaPedido','reportesInventario',6,3),(119,'Cargado de cotizaciones (7.0 GL) de Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:45','2015-04-22 17:45:28','56e365f56642a9f9adc882e125e8fff5c42eb684d0773f3f8dc8','ascm_20150422_1745.png','notaPedido','reportesInventario',6,5),(120,'APROBACIÓN (7.0 GL) de Nota de pedido núm. 6 de Usuario Normal 22-04-2015 17:46','2015-04-22 17:46:19','fec9caf9ee9ab3b92e806abff53acd118d6d3e8b96773f3f8dc8','jefe_20150422_1746.png','notaPedido','reportesInventario',6,3),(121,'Aprobación de Solicitud de mantenimiento externo núm. 12 de jefe mantenimiento 27-04-2015 22:05','2015-04-27 22:05:49','00806167eda9f3e5b96d2480d58d98200c839180d5773f3f8dc8','jfcm_20150427_2205.png','solicitudMantenimientoExterno','reportesPedidos',12,7),(122,'Nota de pedido núm. 7 de Usuario Normal 29-04-2015 21:05','2015-04-29 21:05:40','dd5073d7ee13e9d9e7494e39bf7af038cc25dddbb8773f3f8dc8','usu_20150429_2105.png','notaDePedido','reportesPedidos',7,2),(123,'Aprobación (5.0 U) de Nota de pedido núm. 7 de Usuario Normal 29-04-2015 21:06','2015-04-29 21:06:41','cf481853ee4af9e54097e5b71f5cb5c48d6d3e8b96773f3f8dc8','jefe_20150429_2106.png','notaPedido','reportesInventario',7,3),(124,'Aprobación (5.0 U) de Nota de pedido núm. 7 de Usuario Normal 29-04-2015 21:07','2015-04-29 21:07:21','c3877153814345ee3173df8e19e7f2de0c839180d5773f3f8dc8','jfcm_20150429_2107.png','notaPedido','reportesInventario',7,7),(125,'Cargado de cotizaciones de Solicitud de mantenimiento externo núm. 12 de jefe mantenimiento 29-04-2015 22:46','2015-04-29 22:46:03','ab2a8d43574c4240efbe9e37010fe097c42eb684d0773f3f8dc8','ascm_20150429_2246.png','solicitudMantenimientoExterno','reportesPedidos',12,5),(126,'APROBACIÓN de Solicitud de mantenimiento externo núm. 12 de jefe mantenimiento 29-04-2015 22:58','2015-04-29 22:58:09','a8fa48aff3653d2446a8e61682fd94c44896ea479c773f3f8dc8','grnt_20150429_2258.png','solicitudMantenimientoExterno','reportesPedidos',12,6),(127,'Nota de pedido núm. 8 de Usuario Normal 07-05-2015 19:39','2015-05-07 19:39:32','6444631a17c7f4e4d718a8bd9b8f19e7cc25dddbb8773f3f8dc8','usu_20150507_1939.png','notaDePedido','reportesPedidos',8,2),(128,'Nota de pedido núm. 9 de Usuario Normal 07-05-2015 20:32','2015-05-07 20:32:09','6d474b87d23c85a1d5fb6f3a7171cecbcc25dddbb8773f3f8dc8','usu_20150507_2032.png','notaDePedido','reportesPedidos',9,2),(129,'Notificación de existencia en bodega de Nota de pedido núm. 8 de Usuario Normal 07-05-2015 20:39','2015-05-07 20:39:26','6888d83dec88e52431526bf7574e1fae8d6d3e8b96773f3f8dc8','jefe_20150507_2039.png','notaPedido','reportesInventario',8,3),(130,'','2015-05-09 16:52:16',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(131,'','2015-05-09 17:00:05',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(132,'','2015-05-09 17:01:00',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(133,'','2015-05-09 17:01:12',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(134,'','2015-05-09 17:06:07',NULL,NULL,'solicitudMantInt','reportesPedidos',0,9),(135,'Solicitud de mantenimiento interno núm. 25 de jefe mantenimiento 09-05-2015 17:09','2015-05-09 17:09:55','2f6c73e681f19aa7e9c50e8c5aaadedccec7ca9346ba59abbe56','jfmn_20150509_1709.png','solicitudMantInt','reportesPedidos',25,9),(136,'APROBACIÓN de Solicitud de mantenimiento interno núm. 25 de jefe mantenimiento 09-05-2015 17:40','2015-05-09 17:40:59','16a0131d30feb593ca93b794e48a26e94896ea479c773f3f8dc8','grnt_20150509_1740.png','solicitudMantenimientoInterno','reportesPedidos',25,6);
/*!40000 ALTER TABLE `frma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hsit`
--

DROP TABLE IF EXISTS `hsit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hsit` (
  `hsit__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hsitfcha` datetime NOT NULL,
  `item__id` bigint(20) DEFAULT NULL,
  `maqn__id` bigint(20) DEFAULT NULL,
  `hsittxto` longtext COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`hsit__id`),
  KEY `FK_b71ksxqy6wkv5q9cbebc0ue4c` (`item__id`),
  KEY `FK_8ujx9ulan5cnmphqsve97cnof` (`maqn__id`),
  CONSTRAINT `FK_8ujx9ulan5cnmphqsve97cnof` FOREIGN KEY (`maqn__id`) REFERENCES `maqn` (`maqn__id`),
  CONSTRAINT `FK_b71ksxqy6wkv5q9cbebc0ue4c` FOREIGN KEY (`item__id`) REFERENCES `item` (`item__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hsit`
--

LOCK TABLES `hsit` WRITE;
/*!40000 ALTER TABLE `hsit` DISABLE KEYS */;
/*!40000 ALTER TABLE `hsit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingr`
--

DROP TABLE IF EXISTS `ingr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingr` (
  `ingr__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bdga__id` bigint(20) NOT NULL,
  `ingrcant` double NOT NULL,
  `ingrdsch` int(11) NOT NULL,
  `egrs__id` bigint(20) DEFAULT NULL,
  `ingrfact` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `ingrfcha` datetime NOT NULL,
  `frma__id` bigint(20) DEFAULT NULL,
  `item__id` bigint(20) NOT NULL,
  `n__id` bigint(20) DEFAULT NULL,
  `ingrsldo` double NOT NULL,
  `undd__id` bigint(20) NOT NULL,
  `ingrvlor` double NOT NULL,
  `ntpd__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ingr__id`),
  KEY `FK_h2ggibftmqarmajp77yivd8vq` (`bdga__id`),
  KEY `FK_9g0b1ac7uclgcqh2girdmyvtw` (`egrs__id`),
  KEY `FK_c9srjpt6trqs7h5bjrwun2q8m` (`frma__id`),
  KEY `FK_o7of81dctetkvf8m97v8vok9a` (`item__id`),
  KEY `FK_9my8kq6qp3oackgtgc3dpwofm` (`n__id`),
  KEY `FK_ejyhwbwbdlip9liq26b94i2e5` (`undd__id`),
  KEY `FK_2awg4wl1tpp0s8n50d8qpgkvj` (`ntpd__id`),
  CONSTRAINT `FK_2awg4wl1tpp0s8n50d8qpgkvj` FOREIGN KEY (`ntpd__id`) REFERENCES `ntpd` (`ntpd__id`),
  CONSTRAINT `FK_9g0b1ac7uclgcqh2girdmyvtw` FOREIGN KEY (`egrs__id`) REFERENCES `egrs` (`egrs__id`),
  CONSTRAINT `FK_9my8kq6qp3oackgtgc3dpwofm` FOREIGN KEY (`n__id`) REFERENCES `ntpd` (`ntpd__id`),
  CONSTRAINT `FK_c9srjpt6trqs7h5bjrwun2q8m` FOREIGN KEY (`frma__id`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_ejyhwbwbdlip9liq26b94i2e5` FOREIGN KEY (`undd__id`) REFERENCES `undd` (`undd__id`),
  CONSTRAINT `FK_h2ggibftmqarmajp77yivd8vq` FOREIGN KEY (`bdga__id`) REFERENCES `bdga` (`bdga__id`),
  CONSTRAINT `FK_o7of81dctetkvf8m97v8vok9a` FOREIGN KEY (`item__id`) REFERENCES `item` (`item__id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingr`
--

LOCK TABLES `ingr` WRITE;
/*!40000 ALTER TABLE `ingr` DISABLE KEYS */;
INSERT INTO `ingr` VALUES (1,1,4,0,NULL,NULL,'2015-03-26 23:56:04',1,1,NULL,0,2,0,NULL),(2,1,4,0,NULL,NULL,'2015-03-27 22:52:42',15,1,2,2,2,3,NULL),(3,1,23,0,NULL,NULL,'2015-04-04 11:48:17',67,9,NULL,23,1,0,NULL),(4,1,3,0,NULL,NULL,'2015-04-04 11:48:22',68,10,NULL,0,1,0,NULL),(5,1,4,0,NULL,NULL,'2015-04-04 11:48:22',69,2,NULL,4,2,0,NULL),(6,1,5,0,NULL,NULL,'2015-04-04 11:48:22',70,3,NULL,0,2,0,NULL),(7,1,6,0,NULL,NULL,'2015-04-04 11:48:23',71,4,NULL,6,2,0,NULL),(8,1,11,0,NULL,NULL,'2015-04-04 11:48:23',72,5,NULL,11,2,0,NULL),(9,3,11,0,NULL,NULL,'2015-04-04 11:49:16',73,4,NULL,11,2,0,NULL),(10,3,16,0,NULL,NULL,'2015-04-04 11:49:17',74,3,NULL,9,2,0,NULL),(11,3,14,0,NULL,NULL,'2015-04-04 11:49:17',75,5,NULL,14,2,0,NULL),(12,3,27,0,NULL,NULL,'2015-04-04 11:49:17',76,1,NULL,27,2,0,NULL),(13,3,55,0,NULL,NULL,'2015-04-04 11:49:18',77,6,NULL,55,2,0,NULL),(14,3,34,0,NULL,NULL,'2015-04-04 11:49:18',78,7,NULL,34,2,0,NULL),(15,2,24,0,NULL,NULL,'2015-04-04 11:50:00',79,5,NULL,24,2,0,NULL),(16,2,14,0,NULL,NULL,'2015-04-04 11:50:01',80,1,NULL,14,2,0,NULL),(17,2,24,0,NULL,NULL,'2015-04-04 11:50:01',81,6,NULL,24,2,0,NULL),(18,2,12,0,NULL,NULL,'2015-04-04 11:50:02',82,7,NULL,12,2,0,NULL),(19,2,44,0,NULL,NULL,'2015-04-04 11:50:02',83,8,NULL,44,2,0,NULL),(20,2,24,0,NULL,NULL,'2015-04-04 11:50:02',84,2,NULL,22,2,0,NULL),(21,1,23,0,NULL,NULL,'2015-04-04 11:50:28',85,9,NULL,23,1,0,NULL),(22,1,32,0,NULL,NULL,'2015-04-04 11:50:28',86,8,NULL,17,2,0,NULL),(23,1,32,0,NULL,NULL,'2015-04-04 11:50:29',87,6,NULL,20,2,0,NULL),(24,1,5,1,4,NULL,'2015-04-04 11:52:14',89,6,NULL,0,2,1,NULL),(25,1,7,1,5,NULL,'2015-04-04 11:52:24',91,6,NULL,2,2,1,NULL),(26,1,10,1,6,NULL,'2015-04-04 11:52:34',93,8,NULL,3,2,1,NULL),(27,1,5,1,7,NULL,'2015-04-04 12:16:24',95,8,NULL,5,2,1,NULL),(28,3,7,1,14,NULL,'2015-04-22 17:39:40',113,3,NULL,7,2,1,NULL);
/*!40000 ALTER TABLE `ingr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `itemdscr` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tpit__id` bigint(20) NOT NULL,
  `undd__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`item__id`),
  KEY `FK_8ostoy8ux2knbvftrcs2xn6d4` (`tpit__id`),
  KEY `FK_nhmu9fv844fhi0cc21chalmni` (`undd__id`),
  CONSTRAINT `FK_8ostoy8ux2knbvftrcs2xn6d4` FOREIGN KEY (`tpit__id`) REFERENCES `tpit` (`tpit__id`),
  CONSTRAINT `FK_nhmu9fv844fhi0cc21chalmni` FOREIGN KEY (`undd__id`) REFERENCES `undd` (`undd__id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'LLANTA RIN 19',1,NULL),(2,'LLANTA 10',1,NULL),(3,'LLANTA 12',1,NULL),(4,'LLANTA 15',1,NULL),(5,'LLANTA 17',1,NULL),(6,'TUERCA 1\'',2,NULL),(7,'TUERCA 1/2\'',2,NULL),(8,'TUERCA 1/4\'',2,NULL),(9,'ACEITE TIPO 1',3,NULL),(10,'ACEITE TIPO 2',3,NULL);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itmq`
--

DROP TABLE IF EXISTS `itmq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itmq` (
  `itmq__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item__id` bigint(20) NOT NULL,
  `maqn__id` bigint(20) NOT NULL,
  `itmqobsv` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`itmq__id`),
  KEY `FK_ku0u4ncnoa8uuppbgm8sb5miy` (`item__id`),
  KEY `FK_qhqt6t3mi49sexkn864sprhbu` (`maqn__id`),
  CONSTRAINT `FK_ku0u4ncnoa8uuppbgm8sb5miy` FOREIGN KEY (`item__id`) REFERENCES `item` (`item__id`),
  CONSTRAINT `FK_qhqt6t3mi49sexkn864sprhbu` FOREIGN KEY (`maqn__id`) REFERENCES `maqn` (`maqn__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itmq`
--

LOCK TABLES `itmq` WRITE;
/*!40000 ALTER TABLE `itmq` DISABLE KEYS */;
/*!40000 ALTER TABLE `itmq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logf`
--

DROP TABLE IF EXISTS `logf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logf` (
  `logf__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `logfcaus` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `logferro` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `logffcha` datetime NOT NULL,
  `logf_url` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `logfprsn` bigint(20) NOT NULL,
  PRIMARY KEY (`logf__id`),
  KEY `FK_ifmj5d38dbc8r33fxq3fmk6yb` (`logfprsn`),
  CONSTRAINT `FK_ifmj5d38dbc8r33fxq3fmk6yb` FOREIGN KEY (`logfprsn`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logf`
--

LOCK TABLES `logf` WRITE;
/*!40000 ALTER TABLE `logf` DISABLE KEYS */;
/*!40000 ALTER TABLE `logf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maqn`
--

DROP TABLE IF EXISTS `maqn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maqn` (
  `maqn__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `maqnanio` int(11) NOT NULL,
  `maqncdgo` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `clor__id` bigint(20) NOT NULL,
  `maqndscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `maqnmrca` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `modelo` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `maqnobsr` varchar(1023) COLLATE latin1_spanish_ci DEFAULT NULL,
  `maqnplca` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tpmq__id` bigint(20) NOT NULL,
  PRIMARY KEY (`maqn__id`),
  KEY `FK_rohsjplate1m678sy1484w8it` (`clor__id`),
  KEY `FK_54tpphs1v2gyolu2rdsavvrwn` (`tpmq__id`),
  CONSTRAINT `FK_54tpphs1v2gyolu2rdsavvrwn` FOREIGN KEY (`tpmq__id`) REFERENCES `tpmq` (`tpmq__id`),
  CONSTRAINT `FK_rohsjplate1m678sy1484w8it` FOREIGN KEY (`clor__id`) REFERENCES `colr` (`colr__id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maqn`
--

LOCK TABLES `maqn` WRITE;
/*!40000 ALTER TABLE `maqn` DISABLE KEYS */;
INSERT INTO `maqn` VALUES (1,2009,'CM01',6,'Camioneta','Chevrolet','D-Max',NULL,'PGJ-4729',1),(2,2015,'CM02',3,'Camioneta','Ford','F-150',NULL,'PGH-5588',1);
/*!40000 ALTER TABLE `maqn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdlo`
--

DROP TABLE IF EXISTS `mdlo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdlo` (
  `mdlo__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mdlodscr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `mdloicno` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `mdlonmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `mdloordn` int(11) NOT NULL,
  PRIMARY KEY (`mdlo__id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdlo`
--

LOCK TABLES `mdlo` WRITE;
/*!40000 ALTER TABLE `mdlo` DISABLE KEYS */;
INSERT INTO `mdlo` VALUES (1,'Módulo por defecto','','noAsignado',9999),(2,'Inicio','fa fa-dashboard','Inicio',10),(3,'Administración','fa fa-cogs','Administración',20),(4,'Inventario','fa fa-archive','Inventario',30),(5,'Pedidos','fa fa-folder-open','Nota de Pedido',40),(7,'Proyectos','flaticon-hammer42','Proyectos',60),(8,'Reportes','fa fa-file-pdf-o','Reportes',70),(9,'Solicitude de Mantenimiento Externo','flaticon-forklift3','Mant. Externo',41),(10,'Solicitude de Mantenimiento Interno','fa fa-automobile','Mant. Interno',42),(11,'Asistencia','flaticon-construction4','Asistencia',65);
/*!40000 ALTER TABLE `mdlo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mtsl`
--

DROP TABLE IF EXISTS `mtsl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mtsl` (
  `mtsl__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mtsldscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `mtslnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`mtsl__id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mtsl`
--

LOCK TABLES `mtsl` WRITE;
/*!40000 ALTER TABLE `mtsl` DISABLE KEYS */;
INSERT INTO `mtsl` VALUES (1,'Mantenimiento','Mantenimiento'),(2,'Reparación','Reparación'),(3,'Stock','Stock');
/*!40000 ALTER TABLE `mtsl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ntpd`
--

DROP TABLE IF EXISTS `ntpd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ntpd` (
  `ntpd__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ntpdfcap` datetime DEFAULT NULL,
  `ntpdcntd` double NOT NULL,
  `ntpdcnap` double NOT NULL,
  `ntpdcdgo` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `ntpdprde` bigint(20) NOT NULL,
  `essl__id` bigint(20) NOT NULL,
  `ntpdfcha` datetime NOT NULL,
  `ntpdfrap` bigint(20) DEFAULT NULL,
  `ntpdfrac` bigint(20) DEFAULT NULL,
  `ntpdfrbd` bigint(20) DEFAULT NULL,
  `ntpdfrjf` bigint(20) DEFAULT NULL,
  `ntpdfrjc` bigint(20) DEFAULT NULL,
  `ntpdfrng` bigint(20) DEFAULT NULL,
  `ntpdfrsl` bigint(20) DEFAULT NULL,
  `item__id` bigint(20) NOT NULL,
  `maqn__id` bigint(20) DEFAULT NULL,
  `mtsl__id` bigint(20) NOT NULL,
  `ntpdnmro` int(11) NOT NULL,
  `ntpdobsv` longtext COLLATE latin1_spanish_ci,
  `ntpdprpr` bigint(20) NOT NULL,
  `ntpdprac` bigint(20) DEFAULT NULL,
  `ntpdpraf` bigint(20) DEFAULT NULL,
  `ntpdprjc` bigint(20) DEFAULT NULL,
  `ntpdprrd` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `proy__id` bigint(20) DEFAULT NULL,
  `undd__id` bigint(20) NOT NULL,
  PRIMARY KEY (`ntpd__id`),
  KEY `FK_90c4k13jb26nea2o07jmvbnrk` (`ntpdprde`),
  KEY `FK_90odfhjnkoson0k9qr1ur9tgr` (`essl__id`),
  KEY `FK_7t2jcabnurgpc7lkqm5f6eml5` (`ntpdfrap`),
  KEY `FK_qc7me9pn9wwqv2n0gsdtrm3oi` (`ntpdfrac`),
  KEY `FK_jjm5fmyg8kvv0lru8w7uy94j` (`ntpdfrbd`),
  KEY `FK_2qv4ph70hlpsqblknsfjaspjg` (`ntpdfrjf`),
  KEY `FK_sh7gro2xfq1l5om2f9blh2mug` (`ntpdfrjc`),
  KEY `FK_lop9kq07wdghjmuowais9vue7` (`ntpdfrng`),
  KEY `FK_jxoiddx691p6ht1xanvk9x36p` (`ntpdfrsl`),
  KEY `FK_6d93pnxfn40yq56at22b9bg0v` (`item__id`),
  KEY `FK_gi1fbnkdfjvtmcqx940xh9h3i` (`maqn__id`),
  KEY `FK_nqtywmwgrmbwcofedrqhs5m2u` (`mtsl__id`),
  KEY `FK_spubq5fj5tbgurkovrlicgy2x` (`ntpdprpr`),
  KEY `FK_o2wn6xymw52xb2q3500ea560e` (`ntpdprac`),
  KEY `FK_iuw9p96n3vbc7gkh1nu5pevt3` (`ntpdpraf`),
  KEY `FK_axjyrxhmm8x6x5hi1wv60gvxe` (`ntpdprjc`),
  KEY `FK_me489ph6xab2q3y4qgi7stjf8` (`proy__id`),
  KEY `FK_g8xpbqwbw3kfdt2qh95txr7m` (`undd__id`),
  CONSTRAINT `FK_2qv4ph70hlpsqblknsfjaspjg` FOREIGN KEY (`ntpdfrjf`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_6d93pnxfn40yq56at22b9bg0v` FOREIGN KEY (`item__id`) REFERENCES `item` (`item__id`),
  CONSTRAINT `FK_7t2jcabnurgpc7lkqm5f6eml5` FOREIGN KEY (`ntpdfrap`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_90c4k13jb26nea2o07jmvbnrk` FOREIGN KEY (`ntpdprde`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_90odfhjnkoson0k9qr1ur9tgr` FOREIGN KEY (`essl__id`) REFERENCES `essl` (`essl__id`),
  CONSTRAINT `FK_axjyrxhmm8x6x5hi1wv60gvxe` FOREIGN KEY (`ntpdprjc`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_g8xpbqwbw3kfdt2qh95txr7m` FOREIGN KEY (`undd__id`) REFERENCES `undd` (`undd__id`),
  CONSTRAINT `FK_gi1fbnkdfjvtmcqx940xh9h3i` FOREIGN KEY (`maqn__id`) REFERENCES `maqn` (`maqn__id`),
  CONSTRAINT `FK_iuw9p96n3vbc7gkh1nu5pevt3` FOREIGN KEY (`ntpdpraf`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_jjm5fmyg8kvv0lru8w7uy94j` FOREIGN KEY (`ntpdfrbd`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_jxoiddx691p6ht1xanvk9x36p` FOREIGN KEY (`ntpdfrsl`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_lop9kq07wdghjmuowais9vue7` FOREIGN KEY (`ntpdfrng`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_me489ph6xab2q3y4qgi7stjf8` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`),
  CONSTRAINT `FK_nqtywmwgrmbwcofedrqhs5m2u` FOREIGN KEY (`mtsl__id`) REFERENCES `mtsl` (`mtsl__id`),
  CONSTRAINT `FK_o2wn6xymw52xb2q3500ea560e` FOREIGN KEY (`ntpdprac`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_qc7me9pn9wwqv2n0gsdtrm3oi` FOREIGN KEY (`ntpdfrac`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_sh7gro2xfq1l5om2f9blh2mug` FOREIGN KEY (`ntpdfrjc`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_spubq5fj5tbgurkovrlicgy2x` FOREIGN KEY (`ntpdprpr`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ntpd`
--

LOCK TABLES `ntpd` WRITE;
/*!40000 ALTER TABLE `ntpd` DISABLE KEYS */;
INSERT INTO `ntpd` VALUES (1,NULL,2,0,'NP-1',2,7,'2015-03-27 00:00:41',NULL,NULL,4,NULL,NULL,NULL,2,1,1,1,1,'<strong>jefe jefe</strong> ha <strong>notificado que existe en bodega</strong> esta nota de pedido el 27-03-2015 a las 21:51',3,NULL,NULL,NULL,NULL,NULL,2),(2,NULL,4,2,'NP-2',2,8,'2015-03-27 21:49:29',12,11,NULL,5,8,NULL,3,1,1,1,2,'<strong>jefe jefe</strong> ha <strong>APROBADO (2.0 U)</strong> esta nota de pedido el 27-03-2015 a las 22:37 || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones (2.0 U)</strong> esta nota de pedido el 27-03-2015 a las 22:36 || <strong>jefe jefe</strong> ha <strong>solicitado la recarga de cotizaciones</strong> esta nota de pedido el 27-03-2015 a las 22:35, observaciones: necesita otra cotizacion || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones (2.0 U)</strong> esta nota de pedido el 27-03-2015 a las 22:35 || <strong>jfcm jfcm</strong> ha <strong>aprobado (2.0 U)</strong> esta nota de pedido el 27-03-2015 a las 22:32 || <strong>jefe jefe</strong> ha <strong>notificado que existe en bodega y aprobado parcialmente (2.0 de 4.0)</strong> esta nota de pedido el 27-03-2015 a las 21:52, observaciones: aprobado la mitad xq hay en la bodega quito',3,5,3,7,'2MD',NULL,2),(3,NULL,1,0,'NP-3',1,1,'2015-03-29 20:35:28',NULL,NULL,NULL,NULL,NULL,NULL,51,1,1,1,3,'<strong>Admin Admin</strong> ha <strong>realizado</strong> la nota de pedido #3 el 29-03-2015 20:35',3,NULL,NULL,NULL,NULL,NULL,2),(4,NULL,5,0,'NP-4',2,1,'2015-04-22 17:34:44',NULL,NULL,NULL,NULL,NULL,NULL,109,3,1,1,4,'<strong>Usuario Normal</strong> ha <strong>realizado</strong> la nota de pedido #4 el 22-04-2015 17:34',3,NULL,NULL,NULL,NULL,NULL,2),(5,NULL,7,0,'NP-5',2,7,'2015-04-22 17:37:42',NULL,NULL,111,NULL,NULL,NULL,110,3,1,1,5,'<strong>jefe jefe</strong> ha <strong>notificado que existe en bodega</strong> esta nota de pedido el 22-04-2015 a las 17:38 || <strong>Usuario Normal</strong> ha <strong>realizado</strong> la nota de pedido #5 el 22-04-2015 17:37',3,NULL,NULL,NULL,NULL,NULL,2),(6,NULL,10,7,'NP-6',2,6,'2015-04-22 17:41:03',120,119,NULL,115,116,NULL,114,10,1,1,6,'<strong>jefe jefe</strong> ha <strong>APROBADO (7.0 GL)</strong> esta nota de pedido el 22-04-2015 a las 17:46, observaciones: cdfa || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones (7.0 GL)</strong> esta nota de pedido el 22-04-2015 a las 17:45 || <strong>jefe jefe</strong> ha <strong>solicitado la recarga de cotizaciones</strong> esta nota de pedido el 22-04-2015 a las 17:44, observaciones: otra cotizacion || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones (7.0 GL)</strong> esta nota de pedido el 22-04-2015 a las 17:44 || <strong>jfcm jfcm</strong> ha <strong>aprobado (7.0 GL)</strong> esta nota de pedido el 22-04-2015 a las 17:43 || <strong>jefe jefe</strong> ha <strong>notificado que existe en bodega y aprobado parcialmente (7.0 de 10.0)</strong> esta nota de pedido el 22-04-2015 a las 17:41, observaciones: comprar lo q falta || <strong>Usuario Normal</strong> ha <strong>realizado</strong> la nota de pedido #6 el 22-04-2015 17:41',3,5,3,7,'1AL',NULL,1),(7,NULL,5,5,'NP-7',2,3,'2015-04-29 21:05:40',NULL,NULL,NULL,123,124,NULL,122,5,1,1,7,'<strong>jfcm jfcm</strong> ha <strong>aprobado (5.0 U)</strong> esta nota de pedido el 29-04-2015 a las 21:07 || <strong>jefe jefe</strong> ha <strong>aprobado (5.0 U)</strong> esta nota de pedido el 29-04-2015 a las 21:06 || <strong>Usuario Normal</strong> ha <strong>realizado</strong> la nota de pedido #7 el 29-04-2015 21:05',3,5,NULL,7,NULL,NULL,2),(8,NULL,2,0,'NP-8',2,7,'2015-05-07 19:39:32',NULL,NULL,129,NULL,NULL,NULL,127,2,2,1,8,'<strong>jefe jefe</strong> ha <strong>notificado que existe en bodega</strong> esta nota de pedido el 07-05-2015 a las 20:39 || <strong>Usuario Normal</strong> ha <strong>realizado</strong> la nota de pedido #8 el 07-05-2015 19:39',3,NULL,NULL,NULL,NULL,NULL,2),(9,NULL,2,0,'NP-9',2,1,'2015-05-07 20:32:09',NULL,NULL,NULL,NULL,NULL,NULL,128,5,2,1,9,'<strong>Usuario Normal</strong> ha <strong>realizado</strong> la nota de pedido #9 el 07-05-2015 20:32',3,NULL,NULL,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `ntpd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `activo` int(11) NOT NULL,
  `apellido` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `autorizacion` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `cedula` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `direccion` varchar(127) COLLATE latin1_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` datetime DEFAULT NULL,
  `foto` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `login` varchar(15) COLLATE latin1_spanish_ci DEFAULT NULL,
  `mail` varchar(40) COLLATE latin1_spanish_ci DEFAULT NULL,
  `nombre` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `observaciones` varchar(127) COLLATE latin1_spanish_ci DEFAULT NULL,
  `password` varchar(64) COLLATE latin1_spanish_ci DEFAULT NULL,
  `sexo` varchar(1) COLLATE latin1_spanish_ci NOT NULL,
  `telefono` varchar(10) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tipo_usuario_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_awow8n13x05g1w1r50xyi4t5p` (`login`),
  KEY `FK_69mi2kte3t5a01h4hcnf64lb8` (`tipo_usuario_id`),
  CONSTRAINT `FK_69mi2kte3t5a01h4hcnf64lb8` FOREIGN KEY (`tipo_usuario_id`) REFERENCES `tpus` (`tpus__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prfl`
--

DROP TABLE IF EXISTS `prfl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prfl` (
  `prfl__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prflcdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `prfldscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prflnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `prflobsr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prflpdre` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`prfl__id`),
  KEY `FK_i7kwsy4ei47jsupl5rgdbhwpy` (`prflpdre`),
  CONSTRAINT `FK_i7kwsy4ei47jsupl5rgdbhwpy` FOREIGN KEY (`prflpdre`) REFERENCES `prfl` (`prfl__id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prfl`
--

LOCK TABLES `prfl` WRITE;
/*!40000 ALTER TABLE `prfl` DISABLE KEYS */;
INSERT INTO `prfl` VALUES (1,'ADM','Perfil de administración','Administrador',NULL,NULL),(2,'JEFE','Perfil para los jefes','Jefe','Copiados permisos de admin antes de modificar',NULL),(3,'JFCM','Perfil para jefe de compras','Jefe de compras','Copiados permisos de jefe antes de modificar',NULL),(4,'ASCM','Perfil del asistente de compras','Asistente de compras','Copiados permisos de jefe de compras',NULL),(5,'GRNT','Perilf de gerentes','Gerente','Copiados permisos de jefe de compras',NULL),(6,'RSBD','Perfil para los responsables de bodega','Responsable de bodega','Copiados permisos de jefe de compras',NULL),(7,'USRO','Usuario normal','Usuario','Copiados permisos de responsable de bodega',NULL),(8,'JFMN','Jefes de mantenimiento','Jefe de mantenimiento','copiado de jefe',NULL),(9,'MCNC','Mecánicos','Mecánico',NULL,NULL);
/*!40000 ALTER TABLE `prfl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prms`
--

DROP TABLE IF EXISTS `prms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prms` (
  `prms__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accn__id` bigint(20) NOT NULL,
  `prfl__id` bigint(20) NOT NULL,
  PRIMARY KEY (`prms__id`),
  KEY `FK_fprd00hwh4gan21u77jonstay` (`accn__id`),
  KEY `FK_1w9i9nth8oom0mi2rulwsp63q` (`prfl__id`),
  CONSTRAINT `FK_1w9i9nth8oom0mi2rulwsp63q` FOREIGN KEY (`prfl__id`) REFERENCES `prfl` (`prfl__id`),
  CONSTRAINT `FK_fprd00hwh4gan21u77jonstay` FOREIGN KEY (`accn__id`) REFERENCES `accn` (`accn__id`)
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prms`
--

LOCK TABLES `prms` WRITE;
/*!40000 ALTER TABLE `prms` DISABLE KEYS */;
INSERT INTO `prms` VALUES (1,1,1),(3,136,1),(5,3,1),(6,4,1),(8,54,1),(10,59,1),(12,65,1),(14,74,1),(15,79,1),(21,103,1),(23,165,1),(27,14,1),(29,18,1),(30,25,1),(31,30,1),(48,48,1),(50,116,1),(51,115,1),(52,119,1),(56,135,2),(59,3,2),(60,4,2),(77,165,2),(81,14,2),(82,18,2),(83,25,2),(89,118,2),(92,119,2),(96,33,2),(101,43,2),(102,135,3),(104,3,3),(105,4,3),(106,165,3),(110,14,3),(111,18,3),(112,25,3),(116,118,3),(119,119,3),(123,33,3),(128,43,3),(129,211,1),(130,97,2),(131,97,3),(134,135,4),(135,3,4),(136,4,4),(137,165,4),(141,14,4),(147,118,4),(150,119,4),(154,33,4),(155,43,4),(156,97,4),(161,135,5),(162,3,5),(163,4,5),(164,165,5),(168,14,5),(169,18,5),(170,25,5),(175,116,5),(176,115,5),(177,119,5),(186,211,5),(187,136,5),(190,48,5),(191,30,5),(192,135,6),(193,3,6),(194,4,6),(195,165,6),(199,14,6),(200,18,6),(201,25,6),(205,118,6),(208,119,6),(211,20,6),(214,97,6),(217,30,6),(219,48,6),(220,18,4),(221,25,4),(223,135,7),(224,3,7),(225,4,7),(226,165,7),(236,118,7),(239,119,7),(243,97,7),(247,33,7),(248,43,7),(249,212,1),(250,212,5),(251,217,1),(252,217,5),(253,219,6),(254,221,5),(255,222,1),(294,135,8),(295,3,8),(296,4,8),(297,165,8),(299,14,8),(300,18,8),(301,25,8),(302,118,8),(303,119,8),(305,33,8),(315,239,8),(316,48,8),(317,251,1),(318,247,1),(319,249,1),(320,251,4),(321,247,4),(322,253,4),(323,249,4),(324,244,4),(325,251,5),(326,247,5),(327,245,5),(328,249,5),(329,242,5),(330,251,2),(331,247,2),(332,241,2),(333,250,2),(334,249,2),(335,246,2),(336,254,2),(337,251,3),(338,247,3),(339,248,3),(340,249,3),(341,252,3),(342,251,8),(343,247,8),(344,249,8),(345,251,6),(346,247,6),(347,240,6),(348,249,6),(349,251,7),(350,247,7),(351,249,7),(352,255,1),(353,256,8),(355,256,3),(356,258,3),(364,259,3),(365,260,1),(366,54,5),(367,59,5),(368,65,5),(369,74,5),(370,79,5),(371,103,5),(372,222,5),(373,260,5),(374,256,4),(375,261,4),(376,262,4),(377,256,5),(378,265,5),(379,263,5),(380,256,2),(381,266,2),(382,264,2),(383,267,4),(384,267,5),(385,267,2),(386,267,3),(387,267,8),(391,271,8),(392,273,8),(393,277,8),(394,271,2),(395,274,2),(396,277,2),(397,275,2),(398,271,5),(399,272,5),(400,277,5),(401,276,5),(402,255,3),(403,282,8),(404,285,1),(405,286,1),(406,287,1),(407,285,4),(408,286,4),(409,287,4),(410,285,5),(411,286,5),(412,287,5),(413,285,2),(414,286,2),(415,287,2),(416,285,3),(417,286,3),(418,287,3),(419,285,8),(420,286,8),(421,287,8),(422,285,6),(423,286,6),(424,287,6),(432,289,1),(433,290,1),(434,291,1),(435,290,3),(436,291,3),(437,290,5),(438,291,5),(439,292,1),(440,292,4),(441,292,5),(442,292,2),(443,292,3),(444,292,8),(445,289,5),(446,293,1),(452,293,5),(456,297,1),(457,298,1),(465,304,1),(466,303,1),(467,305,1),(468,307,1),(469,308,1),(470,310,1),(471,309,1),(472,135,1),(473,309,7),(474,309,4),(475,309,5),(476,310,4),(477,307,4),(478,308,4),(479,310,5),(480,307,5),(481,308,5),(482,310,2),(483,307,2),(484,308,2),(485,309,2),(486,310,3),(487,307,3),(488,308,3),(489,309,3),(490,310,8),(491,307,8),(492,308,8),(493,309,8),(494,310,6),(495,308,6),(496,309,6),(497,310,7),(498,308,7),(499,311,1),(500,311,4),(501,311,5),(502,311,2),(503,311,3),(504,311,8),(505,307,6),(506,311,6),(508,307,7),(509,311,7),(511,135,9),(512,3,9),(513,4,9),(514,165,9),(515,14,9),(516,18,9),(517,25,9),(518,118,9),(519,119,9),(520,33,9),(521,239,9),(523,251,9),(524,247,9),(525,249,9),(526,256,9),(527,267,9),(528,271,9),(529,273,9),(530,277,9),(531,282,9),(537,310,9),(538,307,9),(539,308,9),(540,309,9),(541,311,9),(542,43,9),(543,313,1),(544,313,5),(545,313,2),(546,314,1),(547,315,1),(548,316,1),(549,315,4),(550,316,4),(551,315,5),(552,316,5),(553,315,2),(554,316,2),(555,315,3),(556,316,3),(557,315,8),(558,316,8),(559,315,6),(560,316,6),(561,317,1),(563,319,1),(564,317,4),(565,319,4),(567,317,5),(568,319,5),(570,317,2),(571,319,2),(573,317,3),(574,319,3),(576,317,8),(577,319,8),(579,317,6),(580,319,6);
/*!40000 ALTER TABLE `prms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prmt`
--

DROP TABLE IF EXISTS `prmt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prmt` (
  `prmt__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prmtmxmx` double NOT NULL,
  `prmtmxnp` double NOT NULL,
  PRIMARY KEY (`prmt__id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prmt`
--

LOCK TABLES `prmt` WRITE;
/*!40000 ALTER TABLE `prmt` DISABLE KEYS */;
INSERT INTO `prmt` VALUES (1,200,100);
/*!40000 ALTER TABLE `prmt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proy`
--

DROP TABLE IF EXISTS `proy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proy` (
  `proy__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `proydscr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `proyentd` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `proyfcfn` datetime DEFAULT NULL,
  `proyfcin` datetime NOT NULL,
  `proylttd` double NOT NULL,
  `proylngt` double NOT NULL,
  `proynmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `proyzoom` int(11) NOT NULL,
  PRIMARY KEY (`proy__id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proy`
--

LOCK TABLES `proy` WRITE;
/*!40000 ALTER TABLE `proy` DISABLE KEYS */;
INSERT INTO `proy` VALUES (1,'Proyecto uno de prueba','Entidad 1',NULL,'2015-08-20 00:00:00',-0.1774975798587709,-78.47724080085754,'Proyecto 1',16);
/*!40000 ALTER TABLE `proy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prpr`
--

DROP TABLE IF EXISTS `prpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prpr` (
  `prpr__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prprfcfn` datetime DEFAULT NULL,
  `prprfcin` datetime NOT NULL,
  `prprobrs` longtext COLLATE latin1_spanish_ci,
  `prsn__id` bigint(20) NOT NULL,
  `proy__id` bigint(20) NOT NULL,
  PRIMARY KEY (`prpr__id`),
  KEY `FK_gbclhaij4biyl8sucw846t5ra` (`prsn__id`),
  KEY `FK_mcdna028uy4x329iemf0opda` (`proy__id`),
  CONSTRAINT `FK_gbclhaij4biyl8sucw846t5ra` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_mcdna028uy4x329iemf0opda` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prpr`
--

LOCK TABLES `prpr` WRITE;
/*!40000 ALTER TABLE `prpr` DISABLE KEYS */;
INSERT INTO `prpr` VALUES (1,'2015-05-13 17:23:16','2015-05-10 14:31:10',NULL,5,1),(2,'2015-05-16 17:23:29','2015-05-09 21:31:11',NULL,6,1),(3,'2015-05-04 17:23:42','2015-04-26 21:31:11',NULL,3,1),(4,'2015-05-13 21:51:48','2015-05-09 21:46:10',NULL,9,1),(5,NULL,'2015-05-16 20:12:03',NULL,5,1),(6,NULL,'2015-05-16 20:12:03',NULL,6,1),(7,NULL,'2015-05-16 20:12:04',NULL,7,1),(8,NULL,'2015-05-16 20:12:13',NULL,3,1);
/*!40000 ALTER TABLE `prpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prsn`
--

DROP TABLE IF EXISTS `prsn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prsn` (
  `prsn__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prsnactv` int(11) NOT NULL,
  `prsnapll` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `prsnatrz` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsncdla` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `prsndire` varchar(127) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsnfcna` datetime DEFAULT NULL,
  `prsnfoto` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsnlogn` varchar(15) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsnmail` varchar(40) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsnnmbr` varchar(40) COLLATE latin1_spanish_ci NOT NULL,
  `prsnobsr` varchar(127) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsnpass` varchar(64) COLLATE latin1_spanish_ci DEFAULT NULL,
  `prsnsexo` varchar(1) COLLATE latin1_spanish_ci NOT NULL,
  `prsntelf` varchar(10) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tpus__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`prsn__id`),
  UNIQUE KEY `UK_jx1yj3rkdawlxgc51ikt2tlwx` (`prsnlogn`),
  KEY `FK_hdkythicey1hh9ya5cid1fwog` (`tpus__id`),
  CONSTRAINT `FK_hdkythicey1hh9ya5cid1fwog` FOREIGN KEY (`tpus__id`) REFERENCES `tpus` (`tpus__id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prsn`
--

LOCK TABLES `prsn` WRITE;
/*!40000 ALTER TABLE `prsn` DISABLE KEYS */;
INSERT INTO `prsn` VALUES (1,1,'Admin','250cf8b51c773f3f8dc8b4be867a9a02','1234567890',NULL,'1987-01-23 00:00:00','1.jpeg','admin','luzma_87@yahoo.com','Admin',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,1),(2,1,'Normal','250cf8b51c773f3f8dc8b4be867a9a02','1234567891',NULL,'1950-06-15 00:00:00',NULL,'usu','luzma_87@yahoo.com','Usuario',NULL,'202cb962ac59075b964b07152d234b70','M',NULL,7),(3,1,'jefe','250cf8b51c773f3f8dc8b4be867a9a02','1234567892',NULL,NULL,'3.jpeg','jefe','luzma_87@yahoo.com','jefe',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,3),(4,1,'rsbd','250cf8b51c773f3f8dc8b4be867a9a02','1234567895',NULL,NULL,NULL,'rsbd','luzma_87@yahoo.com','rsbd',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,4),(5,1,'ascm','250cf8b51c773f3f8dc8b4be867a9a02','1234567894',NULL,NULL,'5.jpeg','ascm','luzma_87@yahoo.com','ascm',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,6),(6,1,'grnt','250cf8b51c773f3f8dc8b4be867a9a02','1234567893',NULL,NULL,'6.jpeg','grnt','luzma_87@yahoo.com','grnt',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,2),(7,1,'jfcm','250cf8b51c773f3f8dc8b4be867a9a02','1234567896',NULL,NULL,'7.jpeg','jfcm','luzma_87@yahoo.com','jfcm',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,5),(8,1,'rsbd2','250cf8b51c773f3f8dc8b4be867a9a02','1234567897',NULL,NULL,NULL,'rsbd2','luzma_87@yahoo.com','rsbd2',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,4),(9,1,'mantenimiento','e10adc3949ba59abbe56e057f20f883e','1234567989',NULL,NULL,'9.jpeg','jfmn','luzma_87@yahoo.com','jefe',NULL,'202cb962ac59075b964b07152d234b70','F',NULL,8),(10,1,'mecanico',NULL,'1234567898',NULL,'1984-07-10 00:00:00',NULL,'mcnc','luzma_87@yahoo.com','mecanico',NULL,'8c10a02a0928511c460bd65e9ec59d0a','F',NULL,9);
/*!40000 ALTER TABLE `prsn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesn`
--

DROP TABLE IF EXISTS `sesn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesn` (
  `sesn__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prfl__id` bigint(20) NOT NULL,
  `prsn__id` bigint(20) NOT NULL,
  PRIMARY KEY (`sesn__id`),
  KEY `FK_t3ere0v912oli7xrfwkliulxw` (`prfl__id`),
  KEY `FK_o51athx9wqddeee1kcno4dyyx` (`prsn__id`),
  CONSTRAINT `FK_o51athx9wqddeee1kcno4dyyx` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_t3ere0v912oli7xrfwkliulxw` FOREIGN KEY (`prfl__id`) REFERENCES `prfl` (`prfl__id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesn`
--

LOCK TABLES `sesn` WRITE;
/*!40000 ALTER TABLE `sesn` DISABLE KEYS */;
INSERT INTO `sesn` VALUES (1,1,1),(2,7,2),(3,2,3),(4,6,4),(5,4,5),(6,5,6),(7,3,7),(8,6,8),(9,8,9),(10,9,10);
/*!40000 ALTER TABLE `sesn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smex`
--

DROP TABLE IF EXISTS `smex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smex` (
  `smex__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smexfcap` datetime DEFAULT NULL,
  `smexcdgo` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `smexprde` bigint(20) NOT NULL,
  `smexdtll` longtext COLLATE latin1_spanish_ci NOT NULL,
  `essl__id` bigint(20) NOT NULL,
  `smexfcha` datetime NOT NULL,
  `smexfrap` bigint(20) DEFAULT NULL,
  `smexfrac` bigint(20) DEFAULT NULL,
  `smexfrjc` bigint(20) DEFAULT NULL,
  `smexfrng` bigint(20) DEFAULT NULL,
  `smexfrsl` bigint(20) DEFAULT NULL,
  `smexhrmt` double NOT NULL,
  `smexklmt` double NOT NULL,
  `smexlclz` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `maqn__id` bigint(20) DEFAULT NULL,
  `smexnmro` int(11) NOT NULL,
  `smexobsv` longtext COLLATE latin1_spanish_ci,
  `smexprac` bigint(20) DEFAULT NULL,
  `smexpraf` bigint(20) DEFAULT NULL,
  `smexprjc` bigint(20) DEFAULT NULL,
  `proy__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`smex__id`),
  KEY `FK_jjwxemn79n496hquua214s51` (`smexprde`),
  KEY `FK_nbt65fa061lxhg6cu5of49dne` (`essl__id`),
  KEY `FK_4046hn9ln1y1op83hrdlieowl` (`smexfrap`),
  KEY `FK_jjg1iffdsmd91loui5j7oofil` (`smexfrac`),
  KEY `FK_j4lb4fm2vuvcphsnpj0f1dn7l` (`smexfrjc`),
  KEY `FK_69gfue84frt57cwx8gbiu6jsf` (`smexfrng`),
  KEY `FK_2062sxm8da02v2tgo16183j2u` (`smexfrsl`),
  KEY `FK_4uaacv2u0k4ikr9ryjlf8rnke` (`maqn__id`),
  KEY `FK_7kh7vwtdnjpst0fntx2w1bohk` (`smexprac`),
  KEY `FK_n520gtchf8af4nsatos8s6h72` (`smexpraf`),
  KEY `FK_12s2yyc68dtv7ebri6gvx7wc1` (`smexprjc`),
  KEY `FK_67p8wnjnr06ehs8sdpivr399c` (`proy__id`),
  CONSTRAINT `FK_12s2yyc68dtv7ebri6gvx7wc1` FOREIGN KEY (`smexprjc`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_2062sxm8da02v2tgo16183j2u` FOREIGN KEY (`smexfrsl`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_4046hn9ln1y1op83hrdlieowl` FOREIGN KEY (`smexfrap`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_4uaacv2u0k4ikr9ryjlf8rnke` FOREIGN KEY (`maqn__id`) REFERENCES `maqn` (`maqn__id`),
  CONSTRAINT `FK_67p8wnjnr06ehs8sdpivr399c` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`),
  CONSTRAINT `FK_69gfue84frt57cwx8gbiu6jsf` FOREIGN KEY (`smexfrng`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_7kh7vwtdnjpst0fntx2w1bohk` FOREIGN KEY (`smexprac`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_j4lb4fm2vuvcphsnpj0f1dn7l` FOREIGN KEY (`smexfrjc`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_jjg1iffdsmd91loui5j7oofil` FOREIGN KEY (`smexfrac`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_jjwxemn79n496hquua214s51` FOREIGN KEY (`smexprde`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_n520gtchf8af4nsatos8s6h72` FOREIGN KEY (`smexpraf`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_nbt65fa061lxhg6cu5of49dne` FOREIGN KEY (`essl__id`) REFERENCES `essl` (`essl__id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smex`
--

LOCK TABLES `smex` WRITE;
/*!40000 ALTER TABLE `smex` DISABLE KEYS */;
INSERT INTO `smex` VALUES (4,NULL,'MX-4',9,'sfdhg sjdfh lgjsdf hgs\r\ndf g\r\nsdf \r\ngs\r\ndf \r\ng\r\nsd',11,'2015-03-28 17:32:30',28,27,24,NULL,20,343,2346,'vdsdf',1,4,'<strong>grnt grnt</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento externo el 28-03-2015 a las 23:32, observaciones: OK || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones</strong> esta solicitud de mantenimiento externo el 28-03-2015 a las 23:30, observaciones: ya ta || <strong>grnt grnt</strong> ha <strong>solicitado la recarga de cotizaciones</strong> esta solicitud de mantenimiento externo el 28-03-2015 a las 23:29, observaciones: 1 mas || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones</strong> esta solicitud de mantenimiento externo el 28-03-2015 a las 22:43, observaciones: OKI || <strong>jfcm jfcm</strong> ha <strong>aprobado</strong> esta solicitud de mantenimiento externo el 28-03-2015 a las 22:01, observaciones: OK',5,6,7,NULL),(5,NULL,'MX-5',9,'sfdhg sjdfh lgjsdf hgs\r\ndf g\r\nsdf \r\ngs\r\ndf \r\ng\r\nsd',12,'2015-03-28 17:33:47',NULL,31,29,33,21,34334,234622,'vdsdf345',1,5,'<strong>jefe jefe</strong> ha <strong>NEGADO</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:52, razón: nope || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:50, observaciones: sdfa || <strong>jfcm jfcm</strong> ha <strong>aprobado</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:49, observaciones: afsd a',5,3,7,NULL),(6,NULL,'MX-6',9,'asdfs fas f\r\nasf sdf as\r\ndf asdf asd fasd\r\nf ads fsd f\r\nasd fasdfadfas\r\nfas\r\ndf\r\nasdfas\r\nd',12,'2015-03-28 20:52:08',NULL,NULL,30,32,22,123,4324,'asdf',1,6,'<strong>ascm ascm</strong> ha <strong>negado</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:51, razón: nope || <strong>jfcm jfcm</strong> ha <strong>aprobado</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:50, observaciones: asdf a || jefe mantenimiento ha realizado la solicitud de mantenimiento externo #6 el 28-03-2015 20:52',5,NULL,7,NULL),(7,NULL,'MX-7',9,'dfs\r\ng df\r\ng\r\ns df\r\ng \r\nsdf\r\ng \r\nsd\r\nfg s',12,'2015-03-28 20:55:13',NULL,NULL,34,35,23,534,3245,'assf',1,7,'<strong>ascm ascm</strong> ha <strong>negado</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:54, razón: nope || <strong>jfcm jfcm</strong> ha <strong>aprobado</strong> esta solicitud de mantenimiento externo el 29-03-2015 a las 00:53, observaciones: asd || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #7 el 28-03-2015 20:55',5,NULL,7,NULL),(8,NULL,'MX-8',9,'qweqweqwe',9,'2015-03-29 20:36:48',NULL,NULL,NULL,NULL,52,123,123,'quito',1,8,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #8 el 29-03-2015 20:36',NULL,NULL,7,NULL),(9,NULL,'MX-9',9,'j;ou\r\n\'\r\nlkl;k;lklghhgfvjf\r\njhfku ioi;lhgfyguhiop;\r\nerftgazsxdfgzsxdfgv',9,'2015-03-29 21:05:30',NULL,NULL,NULL,NULL,56,123,3456,'jhgk',1,9,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #9 el 29-03-2015 21:05',NULL,NULL,7,NULL),(10,NULL,'MX-10',9,'uuisdfoniausdnf isdf asd\r\n fa\r\nsd \r\nhg\r\nj g\r\nh\r\ns dfg s\r\nfg \r\nsdfg\r\nsdfg',9,'2015-03-29 21:11:14',NULL,NULL,NULL,NULL,58,123,4567,'dffghj',1,10,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #10 el 29-03-2015 21:11',NULL,NULL,7,NULL),(11,NULL,'MX-11',9,'dsfk jsahdlfhadslkjfas\r\ndf \r\nasd\r\n f\r\nasd\r\nf\r\na\r\n\r\nfdsa',9,'2015-03-29 21:13:00',NULL,NULL,NULL,NULL,59,65,87654,'fdf',1,11,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #11 el 29-03-2015 21:12',NULL,NULL,7,NULL),(12,NULL,'MX-12',9,'fdyfk asdfkhjasdf\r\nsdf asf\r\n sdaf \r\nasd f\r\nsadf \r\nas df\r\nsadf\r\nsdf',11,'2015-03-29 21:21:57',126,125,121,NULL,60,23456,34567,'fghj',1,12,'<strong>grnt grnt</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento externo el 29-04-2015 a las 22:58 || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones</strong> esta solicitud de mantenimiento externo el 29-04-2015 a las 22:46 || <strong>jfcm jfcm</strong> ha <strong>aprobado</strong> esta solicitud de mantenimiento externo el 27-04-2015 a las 22:05 || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #12 el 29-03-2015 21:21',5,6,7,NULL),(13,NULL,'MX-13',9,'fddhlf ajsfa sdf44a s4f\r\nfasd\r\n f\r\nas',11,'2015-04-22 17:24:48',108,107,104,NULL,103,123,345,'local',1,13,'<strong>grnt grnt</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento externo el 22-04-2015 a las 17:30 || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones</strong> esta solicitud de mantenimiento externo el 22-04-2015 a las 17:29 || <strong>jefe jefe</strong> ha <strong>solicitado la recarga de cotizaciones</strong> esta solicitud de mantenimiento externo el 22-04-2015 a las 17:28, observaciones: otra cotizacion || <strong>ascm ascm</strong> ha <strong>cargado cotizaciones</strong> esta solicitud de mantenimiento externo el 22-04-2015 a las 17:28 || <strong>jfcm jfcm</strong> ha <strong>aprobado</strong> esta solicitud de mantenimiento externo el 22-04-2015 a las 17:26, observaciones: ASDF || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #13 el 22-04-2015 17:24',5,6,7,NULL);
/*!40000 ALTER TABLE `smex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smex_ctzn`
--

DROP TABLE IF EXISTS `smex_ctzn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smex_ctzn` (
  `solicitud_mantenimiento_externo_cotizaciones_id` bigint(20) DEFAULT NULL,
  `cotizacion_id` bigint(20) DEFAULT NULL,
  KEY `FK_535yyi01vjv6uameq0c7vf5bc` (`cotizacion_id`),
  KEY `FK_9h8rjv7trcje0wff2ykdll1v3` (`solicitud_mantenimiento_externo_cotizaciones_id`),
  CONSTRAINT `FK_535yyi01vjv6uameq0c7vf5bc` FOREIGN KEY (`cotizacion_id`) REFERENCES `ctzn` (`ctzn__id`),
  CONSTRAINT `FK_9h8rjv7trcje0wff2ykdll1v3` FOREIGN KEY (`solicitud_mantenimiento_externo_cotizaciones_id`) REFERENCES `smex` (`smex__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smex_ctzn`
--

LOCK TABLES `smex_ctzn` WRITE;
/*!40000 ALTER TABLE `smex_ctzn` DISABLE KEYS */;
/*!40000 ALTER TABLE `smex_ctzn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smin`
--

DROP TABLE IF EXISTS `smin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smin` (
  `smin__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smincdgo` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `sminprde` bigint(20) NOT NULL,
  `smindtll` longtext COLLATE latin1_spanish_ci NOT NULL,
  `essl__id` bigint(20) NOT NULL,
  `sminfcha` datetime NOT NULL,
  `sminfrap` bigint(20) DEFAULT NULL,
  `sminfrng` bigint(20) DEFAULT NULL,
  `sminfrsl` bigint(20) DEFAULT NULL,
  `sminhrmt` double NOT NULL,
  `sminklmt` double NOT NULL,
  `sminlclz` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `maqn__id` bigint(20) DEFAULT NULL,
  `sminnmro` int(11) NOT NULL,
  `sminobsv` longtext COLLATE latin1_spanish_ci,
  `sminpraf` bigint(20) DEFAULT NULL,
  `proy__id` bigint(20) DEFAULT NULL,
  `sminpren` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`smin__id`),
  KEY `FK_eevcrnq3beil4i1cguprgqhca` (`sminprde`),
  KEY `FK_kxbg9ypa8oliuoemn34sju9ea` (`essl__id`),
  KEY `FK_j1x1h53b1xx2yg63fyojmplb8` (`sminfrap`),
  KEY `FK_h8glkesmmxh1dl4wp53o8t55t` (`sminfrng`),
  KEY `FK_f229g0x3te9pfvlnekc5ofwa9` (`sminfrsl`),
  KEY `FK_85ht6hd7eo2wdpcwebc662kfp` (`maqn__id`),
  KEY `FK_tnfnvknbcda9jxoxhccwex7bp` (`sminpraf`),
  KEY `FK_5ci63uot2cx6w4q3v48yhltw5` (`proy__id`),
  KEY `FK_m1nndxlffurte23473aswrbe1` (`sminpren`),
  CONSTRAINT `FK_5ci63uot2cx6w4q3v48yhltw5` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`),
  CONSTRAINT `FK_85ht6hd7eo2wdpcwebc662kfp` FOREIGN KEY (`maqn__id`) REFERENCES `maqn` (`maqn__id`),
  CONSTRAINT `FK_eevcrnq3beil4i1cguprgqhca` FOREIGN KEY (`sminprde`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_f229g0x3te9pfvlnekc5ofwa9` FOREIGN KEY (`sminfrsl`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_h8glkesmmxh1dl4wp53o8t55t` FOREIGN KEY (`sminfrng`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_j1x1h53b1xx2yg63fyojmplb8` FOREIGN KEY (`sminfrap`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_kxbg9ypa8oliuoemn34sju9ea` FOREIGN KEY (`essl__id`) REFERENCES `essl` (`essl__id`),
  CONSTRAINT `FK_m1nndxlffurte23473aswrbe1` FOREIGN KEY (`sminpren`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_tnfnvknbcda9jxoxhccwex7bp` FOREIGN KEY (`sminpraf`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smin`
--

LOCK TABLES `smin` WRITE;
/*!40000 ALTER TABLE `smin` DISABLE KEYS */;
INSERT INTO `smin` VALUES (1,'MI-1',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:39:40',NULL,NULL,36,43,4343,'4fd fas',1,1,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #1 el 29-03-2015 16:39',6,NULL,NULL),(2,'MI-2',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:41:34',NULL,NULL,37,43,4343,'4fd fas',1,2,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #2 el 29-03-2015 16:41',6,NULL,NULL),(3,'MI-3',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:42:10',NULL,NULL,38,43,4343,'4fd fas',1,3,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #3 el 29-03-2015 16:42',6,NULL,NULL),(4,'MI-4',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:43:37',NULL,NULL,39,43,4343,'4fd fas',1,4,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #4 el 29-03-2015 16:43',6,NULL,NULL),(5,'MI-5',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:46:11',NULL,NULL,40,43,4343,'4fd fas',1,5,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #5 el 29-03-2015 16:46',6,NULL,NULL),(6,'MI-6',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:49:16',NULL,NULL,41,43,4343,'4fd fas',1,6,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #6 el 29-03-2015 16:49',6,NULL,NULL),(7,'MI-7',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:49:59',NULL,NULL,42,43,4343,'4fd fas',1,7,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #7 el 29-03-2015 16:49',6,NULL,NULL),(8,'MI-8',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:50:25',NULL,NULL,43,43,4343,'4fd fas',1,8,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #8 el 29-03-2015 16:50',6,NULL,NULL),(9,'MI-9',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:58:07',NULL,NULL,44,43,4343,'4fd fas',1,9,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #9 el 29-03-2015 16:58',6,NULL,NULL),(10,'MI-10',9,'sdf sdfas fasd fas dfasda',14,'2015-03-29 16:58:56',NULL,NULL,45,43,4343,'4fd fas',1,10,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #10 el 29-03-2015 16:58',6,NULL,NULL),(11,'MI-11',9,'df asd fasd fasd fasdf',16,'2015-03-29 17:04:17',NULL,50,46,65,239,'qwerty',1,11,'<strong>grnt grnt</strong> ha <strong>NEGADO</strong> esta solicitud de mantenimiento interno el 29-03-2015 a las 17:14, raz?n: nop || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #11 el 29-03-2015 17:04',6,NULL,NULL),(12,'MI-12',9,'fsda sdfasd fasd fasd \r\nfas\r\nd f\r\nas\r\n df\r\na\r\n sdf',15,'2015-03-29 17:09:24',49,NULL,47,123,456,'qwertyyyyy',1,12,'<strong>jefe jefe</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento interno el 29-03-2015 a las 17:12, observaciones: sdfg sd || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #12 el 29-03-2015 17:09',6,NULL,NULL),(13,'MI-13',9,'af fasd \r\nf\r\nas \r\nf\r\na s\r\nd\r\nf \r\nasd\r\n f\r\nasd\r\n fa',14,'2015-03-29 17:11:34',NULL,NULL,48,1233,12344,'asdfghjkl',1,13,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #13 el 29-03-2015 17:11',3,NULL,NULL),(14,'MI-14',9,'ytf kjghkliliuhlgjh\r\nli jhkjhkjh',14,'2015-03-29 21:22:36',NULL,NULL,61,123,3456,'dfg',1,14,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #14 el 29-03-2015 21:22',6,NULL,NULL),(15,'MI-15',9,'alsdkj fhaslkdjfa\r\nsdf asd\r\n fa\r\nsd f\r\nasd \r\nfas\r\n fasd',14,'2015-03-29 21:29:10',NULL,NULL,62,654,876,'sfs',1,15,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #15 el 29-03-2015 21:29',6,NULL,NULL),(16,'MI-16',9,'jf\r\ndg\r\ndsf\r\ng \r\nsdf\r\n gs\r\ndf g\r\nsdfg',14,'2015-03-29 21:36:58',NULL,NULL,63,1234,3456,'dfgh',1,16,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #16 el 29-03-2015 21:36',6,NULL,NULL),(17,'MI-17',9,'gj sdf\r\ng \r\nsdf \r\ngs\r\ndf\r\ng s\r\ndf',14,'2015-03-29 22:12:50',NULL,NULL,64,234,435,'fsda',1,17,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #17 el 29-03-2015 22:12',6,NULL,NULL),(18,'MI-18',9,'áíóúé ñ < > gjsdj ;glkjsdf;kjgs;kdlf jg;skdjf g;sdf g\r\nsdf\r\n gs\r\ndf \r\ngs\r\nd f\r\ngs\r\ndfg\r\ndfs',15,'2015-03-29 22:40:38',66,NULL,65,234,4556,'fg',1,18,'<strong>grnt grnt</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento interno el 29-03-2015 a las 22:46, observaciones: OK || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #18 el 29-03-2015 22:40',6,NULL,NULL),(19,'MI-19',9,'Detalles kfjsd;fkjsdfkl',17,'2015-04-22 17:12:00',102,NULL,101,123,234,'localizacion',1,19,'<strong>grnt grnt</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento interno el 22-04-2015 a las 17:14 || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #19 el 22-04-2015 17:12',6,NULL,NULL),(20,'MI-20',9,'dfgfd\r\ngdf\r\ng\r\ndf\r\ng\r\nfd',14,'2015-05-09 16:52:16',NULL,NULL,130,2,4,'fghjhgf',1,20,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #20 el 09-05-2015 16:52',6,NULL,10),(21,'MI-21',9,'dfgfd\r\ngdf\r\ng\r\ndf\r\ng\r\nfd',14,'2015-05-09 17:00:05',NULL,NULL,131,2,4,'fghjhgf',1,21,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #21 el 09-05-2015 17:00',6,NULL,10),(22,'MI-22',9,'dfgfd\r\ngdf\r\ng\r\ndf\r\ng\r\nfd',14,'2015-05-09 17:01:00',NULL,NULL,132,2,4,'fghjhgf',1,22,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #22 el 09-05-2015 17:00',6,NULL,10),(23,'MI-23',9,'dfgfd\r\ngdf\r\ng\r\ndf\r\ng\r\nfd',14,'2015-05-09 17:01:12',NULL,NULL,133,2,4,'fghjhgf',1,23,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #23 el 09-05-2015 17:01',6,NULL,10),(24,'MI-24',9,'dfgfd\r\ngdf\r\ng\r\ndf\r\ng\r\nfd',14,'2015-05-09 17:06:07',NULL,NULL,134,2,4,'fghjhgf',1,24,'<strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #24 el 09-05-2015 17:06',6,NULL,10),(25,'MI-25',9,'dfgfd\r\ngdf\r\ng\r\ndf\r\ng\r\nfd',15,'2015-05-09 17:09:55',136,NULL,135,2,4,'fghjhgf',1,25,'<strong>grnt grnt</strong> ha <strong>APROBADO</strong> esta solicitud de mantenimiento interno el 09-05-2015 a las 17:40 || <strong>jefe mantenimiento</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #25 el 09-05-2015 17:09',6,NULL,10);
/*!40000 ALTER TABLE `smin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smin_ctzn`
--

DROP TABLE IF EXISTS `smin_ctzn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smin_ctzn` (
  `solicitud_mantenimiento_interno_cotizaciones_id` bigint(20) DEFAULT NULL,
  `cotizacion_id` bigint(20) DEFAULT NULL,
  KEY `FK_l8yajibidnxl5wtfehp25schn` (`cotizacion_id`),
  KEY `FK_3me9wyh1jgboi96vr3sxo8wgl` (`solicitud_mantenimiento_interno_cotizaciones_id`),
  CONSTRAINT `FK_3me9wyh1jgboi96vr3sxo8wgl` FOREIGN KEY (`solicitud_mantenimiento_interno_cotizaciones_id`) REFERENCES `smin` (`smin__id`),
  CONSTRAINT `FK_l8yajibidnxl5wtfehp25schn` FOREIGN KEY (`cotizacion_id`) REFERENCES `ctzn` (`ctzn__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smin_ctzn`
--

LOCK TABLES `smin_ctzn` WRITE;
/*!40000 ALTER TABLE `smin_ctzn` DISABLE KEYS */;
/*!40000 ALTER TABLE `smin_ctzn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sstm`
--

DROP TABLE IF EXISTS `sstm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sstm` (
  `sstm__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sstmdscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `sstmicno` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `sstmnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `sstmordn` int(11) NOT NULL,
  `sstmptim` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `sstmcdgo` varchar(4) COLLATE latin1_spanish_ci DEFAULT NULL,
  `sstmaccn` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `sstmctrl` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`sstm__id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sstm`
--

LOCK TABLES `sstm` WRITE;
/*!40000 ALTER TABLE `sstm` DISABLE KEYS */;
INSERT INTO `sstm` VALUES (1,'Notas de pedido y solicitudes de mantenimiento','fa fa-list-alt','Solicitudes',1,'solicitudes.png','SLCT','inicioSolicitudes','sistema'),(2,'Todo lo correspondiente a los proyectos, la nómina y manejo de personal','flaticon-construction4','Nómina y Proyectos',2,'nomina.png','NMNA','inicioNomina','sistema'),(3,'Tareas administrativas','fa fa-cog','Administración',5,'admin.png','ADMN','inicioAdmin','sistema'),(4,'Inventario, maquinarias, desechos','flaticon-construction11','Inventario',3,'maquinaria.png','INVN','inicioInventario','sistema');
/*!40000 ALTER TABLE `sstm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpac`
--

DROP TABLE IF EXISTS `tpac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpac` (
  `tpac__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpaccdgo` varchar(1) COLLATE latin1_spanish_ci NOT NULL,
  `tpacdscr` varchar(31) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`tpac__id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpac`
--

LOCK TABLES `tpac` WRITE;
/*!40000 ALTER TABLE `tpac` DISABLE KEYS */;
INSERT INTO `tpac` VALUES (1,'M','Menú'),(2,'P','Proceso');
/*!40000 ALTER TABLE `tpac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpas`
--

DROP TABLE IF EXISTS `tpas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpas` (
  `tpas__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ptascdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `ptasnmbr` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`tpas__id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpas`
--

LOCK TABLES `tpas` WRITE;
/*!40000 ALTER TABLE `tpas` DISABLE KEYS */;
INSERT INTO `tpas` VALUES (1,'ASTE','Asistió'),(2,'NAST','No asistió'),(3,'VCJN','Vacaciones de jornada'),(4,'VCAN','Vacaciones anuales');
/*!40000 ALTER TABLE `tpas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpds`
--

DROP TABLE IF EXISTS `tpds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpds` (
  `tpds__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpdscdgo` varchar(2) COLLATE latin1_spanish_ci NOT NULL,
  `tpdsnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `tpdsrqpr` int(11) NOT NULL,
  PRIMARY KEY (`tpds__id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpds`
--

LOCK TABLES `tpds` WRITE;
/*!40000 ALTER TABLE `tpds` DISABLE KEYS */;
INSERT INTO `tpds` VALUES (1,'VN','Venta',1),(2,'DS','Desecho',0),(3,'ST','Stock',0);
/*!40000 ALTER TABLE `tpds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpit`
--

DROP TABLE IF EXISTS `tpit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpit` (
  `tpit__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpitcdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `tpitdscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tpitnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`tpit__id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpit`
--

LOCK TABLES `tpit` WRITE;
/*!40000 ALTER TABLE `tpit` DISABLE KEYS */;
INSERT INTO `tpit` VALUES (1,'llnt',NULL,'Llantas'),(2,'TRC',NULL,'Tuercas'),(3,'ACT',NULL,'Aceites');
/*!40000 ALTER TABLE `tpit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpmq`
--

DROP TABLE IF EXISTS `tpmq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpmq` (
  `tpmq__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpmqcdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `tpmqdscr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tpmqnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`tpmq__id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpmq`
--

LOCK TABLES `tpmq` WRITE;
/*!40000 ALTER TABLE `tpmq` DISABLE KEYS */;
INSERT INTO `tpmq` VALUES (1,'AUTO',NULL,'Autos');
/*!40000 ALTER TABLE `tpmq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tptr`
--

DROP TABLE IF EXISTS `tptr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tptr` (
  `tptr__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tptrcdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `tptrnmbr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`tptr__id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tptr`
--

LOCK TABLES `tptr` WRITE;
/*!40000 ALTER TABLE `tptr` DISABLE KEYS */;
INSERT INTO `tptr` VALUES (1,'CMFL','Cambio de filtros'),(2,'CMAC','Cambio de Aceite'),(3,'RSCM','Reparación sistema combustible'),(4,'RSAR','Reparación sistema aire'),(5,'RPMT','Reparación del motor'),(6,'RSRF','Reparación sistema refrigeración'),(7,'RSHD','Reparación sistema hidráulico'),(8,'RPCR','Reparación carrocería'),(9,'RSEL','Reparación sistema eléctrico'),(10,'RSFR','Reparación sistema de freno'),(11,'OTRO','Otros (Especificar en el área de detalles)');
/*!40000 ALTER TABLE `tptr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpus`
--

DROP TABLE IF EXISTS `tpus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpus` (
  `tpus__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpusactv` int(11) NOT NULL,
  `tpuscdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `tpusdscr` varchar(127) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tpusnmbr` varchar(25) COLLATE latin1_spanish_ci NOT NULL,
  `tpuspdre` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tpus__id`),
  KEY `FK_m6qf1hgp4rga1tk9pltw2t5wh` (`tpuspdre`),
  CONSTRAINT `FK_m6qf1hgp4rga1tk9pltw2t5wh` FOREIGN KEY (`tpuspdre`) REFERENCES `tpus` (`tpus__id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpus`
--

LOCK TABLES `tpus` WRITE;
/*!40000 ALTER TABLE `tpus` DISABLE KEYS */;
INSERT INTO `tpus` VALUES (1,1,'ADMN','Administradores del sistema','Administradores',NULL),(2,1,'GRNT','Usuarios que pueden aprobar compras mayores a $100','Gerentes',NULL),(3,1,'JEFE','Usuarios que pueden aprobar las notas de pedido de menos de $100','Jefes',NULL),(4,1,'RSBD','Usuarios que pueden ser asignadas como responsable principal o suplente de bodega','Responsables de bodega',NULL),(5,1,'JFCM','Usuarios que asignan Asistentes de compras','Jefes de compras',NULL),(6,1,'ASCM','Usuarios que cargan cotizaciones','Asistentes de compras',NULL),(7,1,'USRO','Usuarios normales','Usuarios',NULL),(8,1,'JFMN','Usuarios que pueden crear solicitudes de mantenimiento externo e interno','Jefes de mantenimiento',NULL),(9,1,'MCNC','Usuarios que pueden ser encargados del mantenimiento interno','Mecánicos',NULL);
/*!40000 ALTER TABLE `tpus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trsf`
--

DROP TABLE IF EXISTS `trsf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trsf` (
  `trsf__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trsfbdds` bigint(20) NOT NULL,
  `trsffcha` datetime NOT NULL,
  `trsfobsr` varchar(1023) COLLATE latin1_spanish_ci DEFAULT NULL,
  `trsfbdor` bigint(20) NOT NULL,
  `prsn__id` bigint(20) NOT NULL,
  PRIMARY KEY (`trsf__id`),
  KEY `FK_t7uo61wa0ll9o0corlwef6ss8` (`trsfbdds`),
  KEY `FK_d2qucd6uem1g9awf00ui5k2xc` (`trsfbdor`),
  KEY `FK_5aghj403jd4fehavepm9rqj6l` (`prsn__id`),
  CONSTRAINT `FK_5aghj403jd4fehavepm9rqj6l` FOREIGN KEY (`prsn__id`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_d2qucd6uem1g9awf00ui5k2xc` FOREIGN KEY (`trsfbdor`) REFERENCES `bdga` (`bdga__id`),
  CONSTRAINT `FK_t7uo61wa0ll9o0corlwef6ss8` FOREIGN KEY (`trsfbdds`) REFERENCES `bdga` (`bdga__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trsf`
--

LOCK TABLES `trsf` WRITE;
/*!40000 ALTER TABLE `trsf` DISABLE KEYS */;
/*!40000 ALTER TABLE `trsf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undd`
--

DROP TABLE IF EXISTS `undd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `undd` (
  `undd__id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unddcdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `unddcnvr` double NOT NULL,
  `undddscr` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `unddpdre` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`undd__id`),
  KEY `FK_jkyl6p4mht5l4w2l8r16trea9` (`unddpdre`),
  CONSTRAINT `FK_jkyl6p4mht5l4w2l8r16trea9` FOREIGN KEY (`unddpdre`) REFERENCES `undd` (`undd__id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undd`
--

LOCK TABLES `undd` WRITE;
/*!40000 ALTER TABLE `undd` DISABLE KEYS */;
INSERT INTO `undd` VALUES (1,'GL',1,'Galón',NULL),(2,'U',1,'Unidad',NULL);
/*!40000 ALTER TABLE `undd` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-16 20:18:28
