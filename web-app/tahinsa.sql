-- MySQL dump 10.13  Distrib 5.6.24, for Linux (x86_64)
--
-- Host: localhost    Database: tahinsa
-- ------------------------------------------------------
-- Server version	5.6.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accn`
--

LOCK TABLES `accn` WRITE;
/*!40000 ALTER TABLE `accn` DISABLE KEYS */;
INSERT INTO `accn` VALUES (1,1,'Configuración del menú',1,'fa fa-server',3,'acciones',4,1,3),(3,2,'list',1,'',3,'list',3,2,NULL),(4,2,'showAlerta',1,'',3,'showAlerta',4,2,NULL),(8,3,'desactivarBodega',1,'',4,'desactivarBodega',8,2,NULL),(14,3,'Lista de Bodegas',1,'fa fa-archive',4,'list',1,1,4),(18,4,'Inventario',1,'',4,'inventarioResumen',18,2,NULL),(20,4,'Ingreso De Bodega',1,'fa fa-cart-arrow-down',4,'ingresoDeBodega',2,1,4),(25,4,'inventario',1,'',4,'inventario',25,2,NULL),(30,5,'Items',1,'flaticon-two195',4,'arbolAdmin',4,1,4),(33,5,'Inventario',1,'flaticon-two195',4,'arbol',5,1,4),(43,6,'Maquinaria',1,'flaticon-construction11',4,'arbol',43,1,4),(48,6,'Maquinaria',1,'flaticon-construction11',4,'arbolAdmin',48,1,4),(54,7,'list',1,'',3,'list',54,2,NULL),(59,8,'list',1,'',3,'list',59,2,NULL),(65,9,'list',1,'',3,'list',65,2,NULL),(74,10,'list',1,'',3,'list',74,2,NULL),(79,11,'list',1,'',3,'list',79,2,NULL),(97,13,'Usuarios',1,'flaticon-construction4',3,'arbol',1,1,2),(103,14,'list',1,'',3,'list',103,2,NULL),(113,15,'list',1,'',7,'list',113,2,NULL),(115,16,'Configuración del proyecto',1,'',7,'config',115,2,NULL),(116,16,'Nuevo proyecto',1,'flaticon-hammer42',7,'form',2,1,2),(118,16,'Lista de Proyectos',1,'fa fa-list',7,'list',1,1,2),(119,16,'show',1,'',7,'show',119,2,NULL),(135,19,'Inicio',1,'',2,'index',135,2,NULL),(136,19,'Parámetros',1,'fa fa-cogs',3,'parametros',2,1,3),(137,19,'demoUI',1,'',2,'demoUI',137,2,NULL),(165,22,'personal',1,'',3,'personal',165,2,NULL),(211,13,'Usuarios',1,'flaticon-construction4',3,'arbolAdmin',1,1,2),(212,16,'Lista de Proyectos',1,'fa fa-list',7,'listAdmin',1,1,2),(217,25,'list',1,'',3,'list',217,2,NULL),(219,4,'Egreso De Bodega',1,'fa fa-upload',4,'egresoDeBodega',3,1,4),(221,4,'Egresos Sin Desecho',1,'fa fa-folder-open-o',4,'listaEgresosSinDesecho',0,1,4),(222,27,'list',1,'',3,'list',222,2,NULL),(239,29,'Nueva solicitud de mant. ext.',1,'flaticon-forklift3',9,'pedido',2,1,1),(240,30,'Lista Bodega',1,'fa fa-inbox',5,'listaBodega',8,1,1),(241,30,'Lista Por revisar',1,'fa fa-check-circle-o',5,'listaJefatura',3,1,1),(242,30,'revisarGerente',1,'',5,'revisarGerente',242,2,NULL),(244,30,'revisarAsistenteCompras',1,'',5,'revisarAsistenteCompras',244,2,NULL),(245,30,'Lista Por aprobar',1,'fa fa-check-circle',5,'listaGerente',7,1,1),(246,30,'revisarJefatura',1,'',5,'revisarJefatura',246,2,NULL),(247,30,'Nueva nota de pedido',1,'fa fa-shopping-cart',5,'pedido',2,1,1),(248,30,'Lista Jefe de Compras',1,'fa fa-users',5,'listaJefeCompras',4,1,1),(249,30,'Lista Aprobadas',1,'fa fa-check',5,'listaAprobadas',9,1,1),(250,30,'Lista Por aprobar',1,'fa fa-check-circle',5,'listaJefe',6,1,1),(251,30,'Todas las notas de pedido',1,'fa fa-list-alt',5,'lista',1,1,1),(252,30,'revisarJefeCompras',1,'',5,'revisarJefeCompras',252,2,NULL),(253,30,'Lista Pendiente asignación',1,'fa fa-slideshare',5,'listaAsistenteCompras',5,1,1),(254,30,'revisarJefe',1,'',5,'revisarJefe',254,2,NULL),(255,5,'Items de Desecho',1,'fa fa-trash-o',4,'arbolItemsDesecho',255,1,4),(256,29,'Todas las solicitudes',1,'fa fa-list-alt',9,'lista',1,1,1),(258,29,'Lista Jefe de Compras',1,'fa fa-users',9,'listaJefeCompras',3,1,1),(259,29,'revisarJefeCompras',1,'',9,'revisarJefeCompras',259,2,NULL),(260,31,'list',1,'',3,'list',260,2,NULL),(261,29,'Lista Asistente de Compras',1,'fa fa-slideshare',9,'listaAsistenteCompras',4,1,1),(262,29,'revisarAsistenteCompras',1,'',9,'revisarAsistenteCompras',262,2,NULL),(263,29,'revisarGerente',1,'',9,'revisarGerente',263,2,NULL),(264,29,'revisarJefe',1,'',9,'revisarJefe',264,2,NULL),(265,29,'Lista Gerente (aprobación final)',1,'fa fa-check-circle',9,'listaGerente',6,1,1),(266,29,'Lista Por Aprobar',1,'fa fa-check-circle',9,'listaJefe',5,1,1),(267,29,'Lista Aprobadas',1,'fa fa-check',9,'listaAprobadas',7,1,1),(271,32,'Todas las solicitudes',1,'fa fa-list-alt',10,'lista',1,1,1),(272,32,'Lista Gerente (aprobación final)',1,'fa fa-check-circle',10,'listaGerente',4,1,1),(273,32,'Nueva solicitud de mant. int.',1,'fa fa-automobile',10,'pedido',2,1,1),(274,32,'Lista Por Aprobar',1,'fa fa-check-circle',10,'listaJefe',3,1,1),(275,32,'revisarJefe',1,'',10,'revisarJefe',275,2,NULL),(276,32,'revisarGerente',1,'',10,'revisarGerente',276,2,NULL),(277,32,'Lista Aprobadas',1,'fa fa-check',10,'listaAprobadas',6,1,1),(282,32,'completarPedido',1,'',10,'completarPedido',282,2,NULL),(285,33,'Notas de Pedido',1,'fa fa-folder-open',8,'notasDePedido',1,1,1),(286,33,'Solicitudes de Mantenimiento Externo',1,'flaticon-forklift3',8,'mantenimientoExterno',2,1,1),(287,33,'Solicitudes de Mantenimiento Interno',1,'fa fa-automobile',8,'mantenimientoInterno',3,1,1),(289,34,'list',1,'',3,'list',289,2,NULL),(290,4,'inventarioDesecho',1,'',4,'inventarioDesecho',290,2,NULL),(291,4,'inventarioDesechoResumen',1,'',4,'inventarioDesechoResumen',291,2,NULL),(292,35,'Archivos',1,'fa fa-files-o',12,'index',3,1,3),(293,22,'foto',1,'',3,'foto',293,2,NULL),(297,38,'Registro asistencia',1,'fa fa-check-square-o',11,'registroAsistencia',2,1,2),(298,39,'list',1,'',3,'list',298,2,NULL),(303,35,'downloadArchivo',1,'',12,'downloadArchivo',303,2,NULL),(304,40,'list',1,'',3,'list',304,2,NULL),(305,38,'Registro de horas extra',1,'fa fa-history',11,'registroHorasExtra',3,1,2),(307,40,'Nómina',1,'flaticon-construction4',2,'inicioNomina',2,2,NULL),(308,40,'Administración',1,'fa fa-cog',2,'inicioAdmin',5,2,NULL),(309,40,'index',1,'',2,'index',309,2,NULL),(310,40,'Solicitudes',1,'fa fa-list-alt',2,'inicioSolicitudes',1,2,NULL),(311,40,'Inventario',1,'flaticon-construction11',2,'inicioInventario',3,2,NULL),(313,41,'asignarPersonal',1,'',11,'asignarPersonal',313,2,2),(314,41,'Personal de Proyectos',1,'flaticon-constructor2',7,'personalProyectos',314,1,2),(315,33,'Personal de Proyectos',1,'flaticon-construction4',8,'personalProyecto',5,1,2),(316,33,'Bodegas',1,'fa fa-archive',8,'bodegas',4,1,4),(317,33,'Asistencia y Vacaciones',1,'fa fa-check-square-o',8,'asistencias',6,1,2),(322,32,'Lista Devueltas',1,'fa fa-arrow-left',10,'listaDevueltas',5,1,1),(323,41,'Personal Proyectos',1,'flaticon-constructor2',7,'personalProyectosAdmin',323,1,2),(324,38,'Ver Horas Extra',1,'fa fa-th-list',11,'verHorasExtra',6,1,2),(325,38,'Ver Asistencia',1,'fa fa-calendar',11,'verAsistencia',5,1,2),(326,38,'Registro Comidas',1,'fa fa-cutlery',11,'registroComidas',4,1,2),(327,38,'Ver Comidas',1,'fa fa-coffee',11,'verComidas',7,1,2);
/*!40000 ALTER TABLE `accn` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alrt`
--

LOCK TABLES `alrt` WRITE;
/*!40000 ALTER TABLE `alrt` DISABLE KEYS */;
INSERT INTO `alrt` VALUES (1,'listaJefatura','notaPedido',1,'2015-12-17 13:04:20','2015-12-17 13:06:23',0,'Admin Admin ha realizado la nota de pedido NP-1',3);
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
  `prsn__id` int(20) DEFAULT NULL,
  `asstentr` datetime DEFAULT NULL,
  `asstfcha` datetime NOT NULL,
  `asstfcrg` datetime NOT NULL,
  `assth100` double NOT NULL,
  `assth_50` double NOT NULL,
  `asstobrs` longtext COLLATE latin1_spanish_ci,
  `prsnrgst` bigint(20) NOT NULL,
  `asstslda` datetime DEFAULT NULL,
  `tpas__id` bigint(20) NOT NULL,
  `asstalmr` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `asstalin` int(11) NOT NULL,
  `asstdsyn` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `asstdsin` int(11) NOT NULL,
  `asstmrnd` varchar(255) COLLATE latin1_spanish_ci DEFAULT NULL,
  `asstmrin` int(11) NOT NULL,
  `proy__id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`asst__id`),
  KEY `FK_1yvl71erlclskido9h5exynou` (`prsn__id`),
  KEY `FK_5yuhqs3ik8t53e3cmu1meyau` (`prsnrgst`),
  KEY `FK_7vsibaqj9auskrhuevv059cnd` (`tpas__id`),
  KEY `FK_5hfqwo01vqbvk3wxww1obvdku` (`proy__id`),
  CONSTRAINT `FK_5hfqwo01vqbvk3wxww1obvdku` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`),
  CONSTRAINT `FK_5yuhqs3ik8t53e3cmu1meyau` FOREIGN KEY (`prsnrgst`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_7vsibaqj9auskrhuevv059cnd` FOREIGN KEY (`tpas__id`) REFERENCES `tpas` (`tpas__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asst`
--

LOCK TABLES `asst` WRITE;
/*!40000 ALTER TABLE `asst` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bdga`
--

LOCK TABLES `bdga` WRITE;
/*!40000 ALTER TABLE `bdga` DISABLE KEYS */;
INSERT INTO `bdga` VALUES (1,1,'Bodega de UEM Pimocha H&T',NULL,1,11,NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bdpd`
--

LOCK TABLES `bdpd` WRITE;
/*!40000 ALTER TABLE `bdpd` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctzn`
--

LOCK TABLES `ctzn` WRITE;
/*!40000 ALTER TABLE `ctzn` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dtmo`
--

LOCK TABLES `dtmo` WRITE;
/*!40000 ALTER TABLE `dtmo` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dtrp`
--

LOCK TABLES `dtrp` WRITE;
/*!40000 ALTER TABLE `dtrp` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dttr`
--

LOCK TABLES `dttr` WRITE;
/*!40000 ALTER TABLE `dttr` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egrs`
--

LOCK TABLES `egrs` WRITE;
/*!40000 ALTER TABLE `egrs` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essl`
--

LOCK TABLES `essl` WRITE;
/*!40000 ALTER TABLE `essl` DISABLE KEYS */;
INSERT INTO `essl` VALUES (1,'E01','La nota de pedido fue solicitada y está a la espera de que un jefe la apruebe','Pendiente de revisión','NP'),(2,'E02','La nota de pedido fue aprobada por un jefe y está a la espera de que un jefe de compras asigne a un asistente de compras para las cotizaciones','Pendiente de asignación','NP'),(3,'E03','Un asistente de compras fue asignado a la nota de pedido y está a la espera del registro de las cotizaciones','Pendientes cotizaciones','NP'),(4,'E04','Las cotizaciones de la nota de pedido fueron registradas y está a la espera de la aprobación final','Pendiente de aprobación final','NP'),(5,'N01','La nota de pedido fue negada','Negada','NP'),(6,'A01','La nota de pedido fue aprobada y se procederá a su adquisición','Aprobada','NP'),(7,'B01','El item solicitado existe en bodega y se procederá al envío','En bodega','NP'),(8,'C01','El item solicitado fue ingresado en una bodega','Completada','NP'),(9,'E11','La solicitud de mantenimiento externo fue realizada y está a la espera que un jefe de compras asigne a un asistente de compras','Pendiente de asignación','MX'),(10,'E12','Un asistente de compras fue asignado a la solicitud de mantenimiento externo y está a la espera del registro de las cotizaciones','Pendientes cotizaciones','MX'),(11,'A11','La solicitud de mantenimiento externo fue aprobada','Aprobada','MX'),(12,'N11','La solicitud de mantenimiento externo  fue negada','Negada','MX'),(13,'E13','Las cotizaciones de la solicitud de mantenimiento externo fueron registradas y está a la espera de la aprobación final','Pendiente de aprobación final','MX'),(14,'E21','La solicitud de mantenimiento interno fue realizada y está a la espera que un jefe o gerente la apruebe','Pendiente de aprobación final','MI'),(15,'A21','La solicitud de mantenimiento interno fue aprobada','Aprobada','MI'),(16,'N21','La solicitud de mantenimiento interno fue negada','Negada','MI'),(17,'C21','El formulario de la solicitud de mantenimiento interno fue completado y el documento fue marcado como completado','Completada','MI'),(18,'D21','La solicitud de mantenimiento interno fue devuelta para correcciones','Devuelta','MI');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fncn`
--

LOCK TABLES `fncn` WRITE;
/*!40000 ALTER TABLE `fncn` DISABLE KEYS */;
INSERT INTO `fncn` VALUES (1,2,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frma`
--

LOCK TABLES `frma` WRITE;
/*!40000 ALTER TABLE `frma` DISABLE KEYS */;
INSERT INTO `frma` VALUES (1,'Ingreso a bodega de 5.0U LAPTOPS DELL INSPIRON 5558 I7 8GB 1TB VID4GB el 30-09-2015 13:17','2015-09-30 13:17:07','d174381378aff6719f168eea0fa916ad0eec966459735976cb0e','bpimochal_20150930_1317.png','ingresoDeBodega','reportesInventario',1,11),(2,'Ingreso a bodega de 7.0U MOUSE GENIUS MICRO TRAVELLER USB RUBY el 30-09-2015 13:17','2015-09-30 13:17:07','46b6bcb85b8cc0bbcff21b0beeef6b3d0eec966459735976cb0e','bpimochal_20150930_1317.png','ingresoDeBodega','reportesInventario',2,11),(3,'Ingreso a bodega de 5.0U CABLE IMEXX 25301 SEGURITY KEY LOCK el 30-09-2015 13:17','2015-09-30 13:17:07','5141f06ae71bc608291e7fd6e70311eb0eec966459735976cb0e','bpimochal_20150930_1317.png','ingresoDeBodega','reportesInventario',3,11),(4,'Ingreso a bodega de 2.0U CABLE IMEXX 25419 SEGURITY KEY LOCK el 30-09-2015 13:17','2015-09-30 13:17:07','eade9b6ab8ffee80740aa51e4b49957d0eec966459735976cb0e','bpimochal_20150930_1317.png','ingresoDeBodega','reportesInventario',4,11),(5,'Ingreso a bodega de 7.0U FLASH MEMORY ADATA 16GB UV100 NEGRO el 30-09-2015 13:17','2015-09-30 13:17:07','a9fcd6f420890e4506b5efee98cd25ca0eec966459735976cb0e','bpimochal_20150930_1317.png','ingresoDeBodega','reportesInventario',5,11),(6,'Ingreso a bodega de 1.0U IMPRESORA EPSON WF7010 CON TINTA CONTINUA el 30-09-2015 13:17','2015-09-30 13:17:07','e1baaab88afbea479570d03ce5187c320eec966459735976cb0e','bpimochal_20150930_1317.png','ingresoDeBodega','reportesInventario',6,11),(7,'Ingreso a bodega de 5.0U LAPTOPS DELL INSPIRON 5558 I7 8GB 1TB VID4GB el 30-09-2015 13:23','2015-09-30 13:23:14','60d8c1fa46a3a85e7a3d7fd42efa891f0eec966459735976cb0e','bpimochal_20150930_1323.png','ingresoDeBodega','reportesInventario',7,11),(8,'Ingreso a bodega de 7.0U MOUSE GENIUS MICRO TRAVELLER USB RUBY el 30-09-2015 13:23','2015-09-30 13:23:14','9a2341baa6f9248bee3a58eff69fd7780eec966459735976cb0e','bpimochal_20150930_1323.png','ingresoDeBodega','reportesInventario',8,11),(9,'Ingreso a bodega de 5.0U CABLE IMEXX 25301 SEGURITY KEY LOCK el 30-09-2015 13:23','2015-09-30 13:23:14','fc9b758ef34f95f637e5c9fd587006240eec966459735976cb0e','bpimochal_20150930_1323.png','ingresoDeBodega','reportesInventario',9,11),(10,'Ingreso a bodega de 2.0U CABLE IMEXX 25419 SEGURITY KEY LOCK el 30-09-2015 13:23','2015-09-30 13:23:14','ac1820216855be6d75dc2c629267b9680eec966459735976cb0e','bpimochal_20150930_1323.png','ingresoDeBodega','reportesInventario',10,11),(11,'Ingreso a bodega de 7.0U FLASH MEMORY ADATA 16GB UV100 NEGRO el 30-09-2015 13:23','2015-09-30 13:23:14','fe3af96fda7b453991d6cf94a91c7f870eec966459735976cb0e','bpimochal_20150930_1323.png','ingresoDeBodega','reportesInventario',11,11),(12,'Ingreso a bodega de 1.0U IMPRESORA EPSON WF7010 CON TINTA CONTINUA el 30-09-2015 13:23','2015-09-30 13:23:14','c9b275c9204936e056410b3b59b60ffe0eec966459735976cb0e','bpimochal_20150930_1323.png','ingresoDeBodega','reportesInventario',12,11),(13,'Nota de pedido NP-1 de Admin Admin 17-12-2015 13:04','2015-12-17 13:04:16','74e02066175ad58a4a15ee12672060eb21232f297a773f3f8dc8','admin_20151217_1304.png','notaDePedido','reportesPedidos',1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingr`
--

LOCK TABLES `ingr` WRITE;
/*!40000 ALTER TABLE `ingr` DISABLE KEYS */;
INSERT INTO `ingr` VALUES (1,1,5,0,NULL,NULL,'2015-09-30 13:17:07',1,256,NULL,5,2,1149,NULL),(2,1,7,0,NULL,NULL,'2015-09-30 13:17:11',2,263,NULL,7,2,6.2,NULL),(3,1,5,0,NULL,NULL,'2015-09-30 13:17:11',3,257,NULL,5,2,4.2,NULL),(4,1,2,0,NULL,NULL,'2015-09-30 13:17:11',4,258,NULL,2,2,4.1,NULL),(5,1,7,0,NULL,NULL,'2015-09-30 13:17:11',5,260,NULL,7,2,6.8,NULL),(6,1,1,0,NULL,NULL,'2015-09-30 13:17:12',6,259,NULL,1,2,401.79,NULL),(7,1,5,0,NULL,NULL,'2015-09-30 13:23:14',7,256,NULL,5,2,1149,NULL),(8,1,7,0,NULL,NULL,'2015-09-30 13:23:15',8,263,NULL,7,2,6.2,NULL),(9,1,5,0,NULL,NULL,'2015-09-30 13:23:15',9,257,NULL,5,2,4.2,NULL),(10,1,2,0,NULL,NULL,'2015-09-30 13:23:15',10,258,NULL,2,2,4.1,NULL),(11,1,7,0,NULL,NULL,'2015-09-30 13:23:15',11,260,NULL,7,2,6.8,NULL),(12,1,1,0,NULL,NULL,'2015-09-30 13:23:15',12,259,NULL,1,2,401.79,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Abrazadera de pletina de 38x4mm',215,2),(2,'ABRAZADERA PARA CANALON',215,2),(3,'ABRAZADERA PARA EXTINTOR',215,2),(4,'Absorbente Químico',215,2),(5,'Accesorio PVC  3/4',217,2),(6,'Accesorio PVC  1/2\"',217,2),(7,'Accesorio PVC  1\"',217,2),(8,'Accesorio PVC  1 1/2\"',217,2),(9,'Accesorio PVC  2\"',217,2),(10,'Accesorio PVC  2 1/2\"',217,2),(11,'Accesorios de cobre 1/2\"',218,2),(12,'Accesorios de cobre 1/4\"',218,2),(13,'Accesorios de cobre 3/4\"',218,2),(14,'Accesorios de cobre 3/8\"',218,2),(15,'Accesorios para bomba 1 HP',215,2),(16,'Accesorios para Sujección y Anclaje',215,2),(17,'Accesorios Sujección ( felpas,tornillos,tacos)',215,2),(18,'Accesss point inalámbrico 10/100/1000',215,2),(19,'Acero de Refuerzo F\'y= 4.200 Kg/cm2',225,2),(20,'Acero en Perfiles',225,2),(21,'Acero Estructural A36',225,2),(22,'ACOMETIDA DE MEDIA TENSIÓN SUBTERRÁNEA TRIFÁSICA',215,2),(23,'Acometida en baja tension',215,2),(24,'Acometida en media tension',215,2),(25,'Acoples valvulas de presion',215,2),(26,'Adhesivo de curado rápido para anclajes (480 gr.) / 60 usos.',215,2),(27,'Aditivo Acelerante Tipo Plastocrete 161HE',219,2),(28,'Aditivo impermeabilizante',219,2),(29,'Aditivo Impermeabilizante p/morteros-Sika 1',219,2),(30,'Adoquin de granito cortado',226,2),(31,'Adoquin Vehicular',226,2),(32,'Adoquines de Calzada (20u m2)-F\'c=350kg/cm2',226,2),(33,'Afiche Color Tamaño A3',215,2),(34,'Aislador de Suspención de caucho siliconado',215,2),(35,'Aislador Tipo Espiga ANSI 561',215,2),(36,'Aislamiento rubatex 1/2\" x 1/2\"',215,2),(37,'Aislamiento rubatex 3/4\" x 1/2\"',215,2),(38,'Aislamiento rubatex 3/8\" x 1/2\"',215,2),(39,'Aislamiento Térmico- Rubatex o similar e = 1/2 x 1/2\"',215,2),(40,'Aislante Térmico de Tubería -Tipo Rubatex o Similar',215,2),(41,'Alambre de amarre #18',215,2),(42,'Alambre Galvanizado #18',215,2),(43,'Alfajía de Eucalipto 4x4x250 (cm)',215,2),(44,'Alucobond',215,2),(45,'Amarras Plásticas 30cm-CATEG 06251',215,2),(46,'Amplificador 1000W 4 canales 250W/canal 120 v - 220 v salida de linea 70-100 V',215,2),(47,'Angulo 25x3mm-Peso= 6.66 Kg.',215,2),(48,'Angulo 30x3mm-Peso=8.04 Kg.',215,2),(49,'Angulo 50x3 mm-Peso = 13,71 Kg.',215,2),(50,'Angulo 50x3 mm-Peso = 13,71 Kg.',215,2),(51,'Angulo 60x6mm',215,2),(52,'Angulo Galvanizado 3/4\" x 3/4\" x 10\"',215,2),(53,'ANILLO DE CERA',215,2),(54,'Anticorrosivo (Cromato Zinc)',215,2),(55,'ARBOL GRANDE - JOBO',215,2),(56,'Arco de futbol( tubo 4\") incl. pintado',215,2),(57,'ARENA',215,2),(58,'Arena Fina',215,2),(59,'Argollas metalicas galv. e=10mm d=0.04 m',215,2),(60,'Asta y Cordón para Bandera',215,2),(61,'Bandeja tipo Escalerilla Galvanizada 200 x 100 mm',215,2),(62,'Barra antipanico para puerta',215,2),(63,'BARRA BATIENTE PARA ESCUSADOS',215,2),(64,'BARRA RECTA DE HG 60 CM',215,2),(65,'BARRAS DE COBRE DE DISTRIBUCION',218,2),(66,'Barreras Móviles',215,2),(67,'BASE DE HORMIGON 20-30 h= 40 cm.',215,2),(68,'Bateria de SS.HH- Portátil (Alquiler)',215,2),(69,'BATERIA RESPALDO ENERGIA  CENTRAL',215,2),(70,'BATERIA SUPERVISION',215,2),(71,'Bebedero de agua',215,2),(72,'Bisagra dor.1/2\"x1 5/16\",con tornillos',215,2),(73,'Blancola',215,2),(74,'Bloque  Alivianado 20x20x40',215,2),(75,'Bloque d/carga 10x20x40',215,2),(76,'Bloque de 10 cm',215,2),(77,'Bloque Vibroprensado 0.15 cm.',215,2),(78,'Bomba 1 HP-220 V',215,2),(79,'Bomba 5 HP',215,2),(80,'Bomba 6 HP',215,2),(81,'Bomba de Condensado',215,2),(82,'Bondex Plus-(Pega cerámica con cerámica)',223,2),(83,'BONDEX PREMIUM',215,2),(84,'BORNERA TIPO DIN PARA 4 CONDUCTORES',222,2),(85,'BOTIQUIN DE PRIMEROS AUXILIOS 25X50CM ACERO INOX',225,2),(86,'Breaker 2 polos 15-60 AMP',220,2),(87,'BREAKER 3P 225 AMP TRIFASICO',220,2),(88,'BREAKER 3P 350 AMP TRIFASICO',220,2),(89,'BREAKER PRINCIPAL DE 3P - 225 AMP',220,2),(90,'BREAKER PRINCIPAL DE 3P - 350 AMP',220,2),(91,'Breaker QOvs 1 polo 10-32 A.',220,2),(92,'Breaker QOvs 1 polo 40-60 A.',220,2),(93,'BREAKERS  2P - 40 AMP',220,2),(94,'BREAKERS 2P-100A',220,2),(95,'BREAKERS 2P-20A',220,2),(96,'BREAKERS 2P-30A',220,2),(97,'BREAKERS 2P-40A',220,2),(98,'BREAKERS 2P-50A',220,2),(99,'BREAKERS 2P-60A',220,2),(100,'BREAKERS 2P-80A',220,2),(101,'BREAKERS 3P-150A',220,2),(102,'BREAKERS 3P-175A',220,2),(103,'BREAKERS 3P-60A',220,2),(104,'BX EMT 3/4\"',215,2),(105,'CABLE #1/0 TTU 600V',221,2),(106,'CABLE 8 THHN AWG 7H',221,2),(107,'Cable antiflama 2 X 16 AWG',221,2),(108,'CABLE ANTIFLAMA 2*16 AWG',221,2),(109,'Cable Contrafuego FL 1PR#18 AWG E25028',221,2),(110,'Cable de Acero D=1/2\"',225,2),(111,'CABLE DE INCENDIO PARA EXTERIORES 2 x 16 AWG',221,2),(112,'CABLE DE VIDEO VGA MACHO-MACHO 10M',221,2),(113,'Cable F\\UTP CAT 6A',221,2),(114,'Cable F\\UTP CAT 6A armado para exteriores',221,2),(115,'Cable gemelo 2x14 AWG para exteriores',221,2),(116,'Cable gemelo 2x16 AWG para exteriores',221,2),(117,'Cable gemelo 2x18 AWG para exteriores',221,2),(118,'CABLE UTP CAT 6A CERTIFICADO SOLIDO GRIS',221,2),(119,'CABLE UTP CAT3 DE 3 PARES',221,2),(120,'Cable UTP, Cat 6 A, 4 pares, 100 ohmios 24 AWG',221,2),(121,'Caja 20x20 Tipo NEMA 3X',215,2),(122,'Caja de distribución principal 60x40x15',215,2),(123,'Caja de paso de 15x15cm',215,2),(124,'CAJA OCTOGONAL CHICA',215,2),(125,'CAJA OCTOGONAL GRANDE',215,2),(126,'Caja portafusible',215,2),(127,'CAJA RECTANGULAR PROFUNDA',215,2),(128,'Cámara IP POE tipo bala para exteriores (inc. accesorios)',215,2),(129,'Cámara IP POE tipo minidomo para interiores (inc. accesorios)',215,2),(130,'Campana de Extracción 1 x 0.80 en acero inoxidable',225,2),(131,'Campana de Extracción 1 x 1.30 en acero inoxidable tipo compensada',225,2),(132,'Caña rollisa',215,2),(133,'Caucho granulometría 0.7 - 2.5 mm',215,2),(134,'Cemento Blanco',215,2),(135,'Cemento Portland Gris',215,2),(136,'Cemento(pega) para PVC-WELD ON',217,2),(137,'Central de Alarma -Inc. Accesorios',215,2),(138,'Central de Seguridad',215,2),(139,'Central Telefónica IP',215,2),(140,'CERAMICA  PARA PARED',223,2),(141,'Ceramica antideslizante de 40*40 para pisos',223,2),(142,'Ceramica importada (paredes y pisos)',223,2),(143,'Cerámica para Pisos 0.30 x 0.30-Producción Nacional',223,2),(144,'Cerco de H.F D=600mm',215,2),(145,'Cerradura Caja 75 mm-Doble Pasador VIRO',224,2),(146,'Cerradura para Embutir-Puerta de Aluminio',224,2),(147,'Cerradura principal de alta calidad para puertas',224,2),(148,'Cerradura Principal Llave/Llave-KWIKSET-Delta ( Manija)',224,2),(149,'Certificación de Cableado instalado Cat. 6A.',221,2),(150,'CERTIFICACION DE DATOS POR PUNTO',215,2),(151,'Césped',215,2),(152,'Césped Sintético h=46mm altura de pelo',215,2),(153,'Cinta Aislante 20 ydas.(negra)',215,2),(154,'Cinta aislante 600v. 20 yardas',215,2),(155,'Cinta antideslizante para pisos a=5 cm.',215,2),(156,'Cinta de malla',215,2),(157,'Cinta de Papel 75m',215,2),(158,'Cinta de peligro',215,2),(159,'Cinta Masking- 3/4\"',215,2),(160,'Cintas de seguridad',215,2),(161,'CIRCUITO DE CONTROL DE BAJO NIVEL Y DE ARMONICOS, CON LUSES INDICADORAS',215,2),(162,'Clavos 2\"pulgadas',215,2),(163,'Clavos 2 1/2\" pulgadas',215,2),(164,'Clavos  3\" pulgadas',215,2),(165,'Clavos  3 1/2\" pulgadas',215,2),(166,'Codo Cu 1/2\" x 90°',215,2),(167,'Codo cu 1/4\"',215,2),(168,'Codo Cu 3/4” x 90°',215,2),(169,'Codo cu 3/8\"',215,2),(170,'Codo PVC 110mm x 90-Desague',217,2),(171,'CODO PVC 110MM X 90I - DESAGUE',217,2),(172,'CODO PVC 160MM X 90Ï - DESAGUE',217,2),(173,'Codo PVC 400 mm. X 90 grados',217,2),(174,'Codo PVC 45 CED 80 (p/presión) roscable 4”',221,2),(175,'Codo PVC 50mm x 90-Desague',217,2),(176,'Codo PVC 540 mm. X 90 grados',217,2),(177,'Codo PVC 650 mm. X 90 grados',217,2),(178,'Codo PVC 75mm x 90-Desague',217,2),(179,'Codo pvc 90 ced 40 (p/presión) roscable 1\"',221,2),(180,'Codo PVC 90 ced 40 (p/presión) roscable 1/2\"',221,2),(181,'Codo PVC 90 ced 40 (p/presión) roscable 2 1/2\"',221,2),(182,'Codo pvc 90 ced 40 (p/presión) roscable 3/4\"',221,2),(183,'Codo PVC 90º ced 40 (p/presión) roscable 1 1/2\"',221,2),(184,'Codo PVC L/R 90\" de 1/2\"',217,2),(185,'Colgador de Manguera de Incendios 30 m',215,2),(186,'CONDUCTOR CU #12 AWG TIPO THHN',222,2),(187,'CONDUCTOR CU #14 AWG TIPO THHN',222,2),(188,'Conductor de Cobre Desnudo # 2/0 AWG-19H',222,2),(189,'Conductor de Cobre THHN 2/0 AWG 19H',222,2),(190,'Conductor de Cobre THHN 3/0 AWG-19H',222,2),(191,'Conductor de cu # 10 awg tipo thhn',222,2),(192,'Conductor de cu #14 awg tipo tw',222,2),(193,'Conductor Flexible 3x#16 AWG-Tipo Sucre',222,2),(194,'Conductor Sólido THHN # 10 AWG',222,2),(195,'Conductor Sólido THHN # 12 AWG',222,2),(196,'Conductor Sólido THHN # 14 AWG',222,2),(197,'Conductor Sólido THHN # 2 AWG- 7 hilos',222,2),(198,'Conductor Sólido THHN # 4 AWG- 7 hilos',222,2),(199,'Conductor THHN #10',222,2),(200,'Conductor THHN #12',222,2),(201,'Conductor THHN #14',222,2),(202,'Conductor TTU #4',222,2),(203,'Conductor TTU #6',222,2),(204,'Conector BX 3/4\"',215,2),(205,'CONECTOR EMT 1\"',215,2),(206,'Conector EMT 1/2\"',215,2),(207,'Conector EMT 3/4\"',215,2),(208,'CONECTOR JACK P/C CAT 6A NEGRO S LM',215,2),(209,'Configuración y Puesta en Marcha del sistema',215,2),(210,'Consola Mezcladora de Audio-8 canales',215,2),(211,'CONTACTO MAGNETICO ADHESIVO',215,2),(212,'Cruceta Centrada de perfil  \"L\"  70x70x6 mm L= 2.4 m',215,2),(213,'Cuarton encofrado',215,2),(214,'Cubierta de Galvalume e= 0,4 mm. prepintado',215,2),(256,'LAPTOPS DELL INSPIRON 5558 I7 8GB 1TB VID4GB',227,NULL),(257,'0',231,NULL),(258,'CABLE IMEXX 25419 SEGURITY KEY LOCK',231,NULL),(259,'IMPRESORA EPSON WF7010 CON TINTA CONTINUA',232,NULL),(260,'FLASH MEMORY ADATA 16GB UV100 NEGRO',229,NULL),(261,'IMPRESORA SAMSUNG SL M2885FW',232,NULL),(262,'ESTUCHE NEOPR',233,NULL),(263,NULL,228,NULL),(264,'REGULADOR DE VOLTAJE R2C AVR1008 1000VA',230,NULL),(265,'CASCOS PROTECTORES COLOR AMARILLO',234,NULL),(266,'CHALECOS REFLECTIVOS  COLOR VERDE',235,NULL),(267,'CHALECOS REFLECTIVOS COLOR NARANJA',235,NULL),(268,'GAFAS DE PROTECCION',238,NULL),(269,'GUANTES PROTECTORES',237,NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maqn`
--

LOCK TABLES `maqn` WRITE;
/*!40000 ALTER TABLE `maqn` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdlo`
--

LOCK TABLES `mdlo` WRITE;
/*!40000 ALTER TABLE `mdlo` DISABLE KEYS */;
INSERT INTO `mdlo` VALUES (1,'Módulo por defecto','','noAsignado',9999),(2,'Inicio','fa fa-dashboard','Inicio',10),(3,'Administración','fa fa-cogs','Administración',20),(4,'Inventario','fa fa-archive','Inventario',30),(5,'Pedidos','fa fa-folder-open','Nota de Pedido',40),(7,'Proyectos','flaticon-hammer42','Proyectos',60),(8,'Reportes','fa fa-file-pdf-o','Reportes',70),(9,'Solicitude de Mantenimiento Externo','flaticon-forklift3','Mant. Externo',41),(10,'Solicitude de Mantenimiento Interno','fa fa-automobile','Mant. Interno',42),(11,'Asistencia','flaticon-construction4','Asistencia',65),(12,'Archivos','fa fa-folder-open','Archivos',21);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ntpd`
--

LOCK TABLES `ntpd` WRITE;
/*!40000 ALTER TABLE `ntpd` DISABLE KEYS */;
INSERT INTO `ntpd` VALUES (1,NULL,5,0,'NP-1',1,1,'2015-12-17 13:04:16',NULL,NULL,NULL,NULL,NULL,NULL,13,268,NULL,3,1,'<strong>Admin Admin</strong> ha <strong>realizado</strong> la nota de pedido NP-1 el 17-12-2015 13:04',3,NULL,NULL,NULL,NULL,2,2);
/*!40000 ALTER TABLE `ntpd` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prfl`
--

LOCK TABLES `prfl` WRITE;
/*!40000 ALTER TABLE `prfl` DISABLE KEYS */;
INSERT INTO `prfl` VALUES (1,'SPAD','Perfil de super admin','Super Admin','Puede hacer de todo',NULL),(2,'JEFE','Perfil para los jefes','Jefe','Copiados permisos de admin antes de modificar',NULL),(3,'JFCM','Perfil para jefe de compras','Jefe de compras','Copiados permisos de jefe antes de modificar',NULL),(4,'ASCM','Perfil del asistente de compras','Asistente de compras','Copiados permisos de jefe de compras',NULL),(5,'GRNT','Perilf de gerentes','Gerente','Copiados permisos de jefe de compras',NULL),(6,'RSBD','Perfil para los responsables de bodega','Responsable de bodega','Copiados permisos de jefe de compras',NULL),(7,'USRO','Usuario normal','Usuario','Copiados permisos de responsable de bodega',NULL),(8,'JFMN','Jefes de mantenimiento','Jefe de mantenimiento','copiado de jefe',NULL),(9,'MCNC','Mecánicos','Mecánico',NULL,NULL),(10,'ADM','Perfil de administración','Administrador',NULL,NULL),(11,'OFCN','Usuarios de oficina','Oficina',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=712 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prms`
--

LOCK TABLES `prms` WRITE;
/*!40000 ALTER TABLE `prms` DISABLE KEYS */;
INSERT INTO `prms` VALUES (1,1,1),(3,136,1),(5,3,1),(6,4,1),(8,54,1),(10,59,1),(12,65,1),(14,74,1),(15,79,1),(21,103,1),(23,165,1),(27,14,1),(29,18,1),(30,25,1),(31,30,1),(48,48,1),(50,116,1),(51,115,1),(52,119,1),(56,135,2),(59,3,2),(60,4,2),(77,165,2),(81,14,2),(82,18,2),(83,25,2),(89,118,2),(92,119,2),(96,33,2),(101,43,2),(102,135,3),(104,3,3),(105,4,3),(106,165,3),(110,14,3),(111,18,3),(112,25,3),(116,118,3),(119,119,3),(123,33,3),(128,43,3),(129,211,1),(130,97,2),(131,97,3),(134,135,4),(135,3,4),(136,4,4),(137,165,4),(141,14,4),(147,118,4),(150,119,4),(154,33,4),(155,43,4),(156,97,4),(161,135,5),(162,3,5),(163,4,5),(164,165,5),(168,14,5),(169,18,5),(170,25,5),(177,119,5),(192,135,6),(193,3,6),(194,4,6),(195,165,6),(199,14,6),(200,18,6),(201,25,6),(205,118,6),(208,119,6),(211,20,6),(214,97,6),(217,30,6),(219,48,6),(220,18,4),(221,25,4),(223,135,7),(224,3,7),(225,4,7),(226,165,7),(236,118,7),(239,119,7),(249,212,1),(251,217,1),(253,219,6),(254,221,5),(255,222,1),(294,135,8),(295,3,8),(296,4,8),(297,165,8),(299,14,8),(300,18,8),(301,25,8),(302,118,8),(303,119,8),(305,33,8),(315,239,8),(316,48,8),(317,251,1),(318,247,1),(319,249,1),(320,251,4),(321,247,4),(322,253,4),(323,249,4),(324,244,4),(325,251,5),(326,247,5),(327,245,5),(328,249,5),(329,242,5),(330,251,2),(331,247,2),(332,241,2),(333,250,2),(334,249,2),(335,246,2),(336,254,2),(337,251,3),(338,247,3),(339,248,3),(340,249,3),(341,252,3),(342,251,8),(343,247,8),(344,249,8),(345,251,6),(346,247,6),(347,240,6),(348,249,6),(349,251,7),(350,247,7),(351,249,7),(352,255,1),(353,256,8),(355,256,3),(356,258,3),(364,259,3),(365,260,1),(374,256,4),(375,261,4),(376,262,4),(377,256,5),(378,265,5),(379,263,5),(380,256,2),(381,266,2),(382,264,2),(383,267,4),(384,267,5),(385,267,2),(386,267,3),(387,267,8),(391,271,8),(392,273,8),(393,277,8),(394,271,2),(395,274,2),(396,277,2),(397,275,2),(398,271,5),(399,272,5),(400,277,5),(401,276,5),(402,255,3),(403,282,8),(404,285,1),(405,286,1),(406,287,1),(407,285,4),(408,286,4),(410,285,5),(411,286,5),(412,287,5),(413,285,2),(414,286,2),(415,287,2),(416,285,3),(417,286,3),(418,287,3),(419,285,8),(420,286,8),(421,287,8),(422,285,6),(432,289,1),(433,290,1),(434,291,1),(435,290,3),(436,291,3),(437,290,5),(438,291,5),(439,292,1),(440,292,4),(441,292,5),(442,292,2),(443,292,3),(444,292,8),(446,293,1),(452,293,5),(456,297,1),(457,298,1),(465,304,1),(466,303,1),(467,305,1),(468,307,1),(469,308,1),(470,310,1),(471,309,1),(472,135,1),(473,309,7),(474,309,4),(475,309,5),(476,310,4),(477,307,4),(478,308,4),(479,310,5),(480,307,5),(481,308,5),(482,310,2),(483,307,2),(484,308,2),(485,309,2),(486,310,3),(487,307,3),(488,308,3),(489,309,3),(490,310,8),(491,307,8),(492,308,8),(493,309,8),(494,310,6),(495,308,6),(496,309,6),(497,310,7),(498,308,7),(499,311,1),(500,311,4),(501,311,5),(502,311,2),(503,311,3),(504,311,8),(505,307,6),(506,311,6),(508,307,7),(509,311,7),(511,135,9),(512,3,9),(513,4,9),(514,165,9),(515,14,9),(516,18,9),(517,25,9),(518,118,9),(519,119,9),(520,33,9),(521,239,9),(523,251,9),(524,247,9),(525,249,9),(526,256,9),(527,267,9),(528,271,9),(529,273,9),(530,277,9),(531,282,9),(537,310,9),(538,307,9),(539,308,9),(540,309,9),(541,311,9),(542,43,9),(543,313,1),(546,314,1),(547,315,1),(548,316,1),(550,316,4),(551,315,5),(552,316,5),(553,315,2),(554,316,2),(555,315,3),(556,316,3),(558,316,8),(560,316,6),(561,317,1),(567,317,5),(570,317,2),(573,317,3),(583,322,8),(584,323,1),(585,324,1),(586,325,1),(587,326,1),(588,327,1),(600,14,10),(601,18,10),(602,25,10),(603,30,10),(604,48,10),(607,119,10),(612,251,10),(613,247,10),(614,249,10),(615,255,10),(617,285,10),(618,286,10),(619,287,10),(621,290,10),(622,291,10),(623,292,10),(625,297,10),(628,303,10),(629,305,10),(630,307,10),(632,310,10),(633,309,10),(634,135,10),(635,311,10),(636,313,10),(638,315,10),(639,316,10),(640,317,10),(641,323,10),(642,324,10),(643,325,10),(644,326,10),(645,327,10),(646,118,10),(647,113,10),(648,256,10),(649,239,10),(650,267,10),(651,271,10),(652,273,10),(653,277,10),(654,3,10),(655,4,10),(656,165,10),(657,303,4),(658,303,5),(659,97,5),(660,33,5),(661,43,5),(662,255,5),(663,118,5),(664,325,5),(665,324,5),(666,327,5),(667,303,2),(668,255,2),(669,290,2),(670,291,2),(671,313,2),(672,303,3),(673,303,8),(674,255,8),(675,290,8),(676,291,8),(677,255,9),(678,290,9),(679,291,9),(680,255,6),(681,290,6),(682,291,6),(683,135,11),(684,3,11),(685,4,11),(686,165,11),(687,118,11),(688,119,11),(689,97,11),(690,33,11),(691,43,11),(692,251,11),(693,247,11),(694,249,11),(695,309,11),(696,310,11),(697,308,11),(698,307,11),(699,311,11),(700,313,11),(701,325,11),(702,324,11),(703,327,11),(704,317,11),(705,285,11),(706,286,11),(707,287,11),(708,316,11),(709,315,11),(710,292,11),(711,303,11);
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
  `prmthfal` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  `prmthfds` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  `prmthfmr` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  `prmthial` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  `prmthids` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  `prmthimr` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  `prmthnsa` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`prmt__id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prmt`
--

LOCK TABLES `prmt` WRITE;
/*!40000 ALTER TABLE `prmt` DISABLE KEYS */;
INSERT INTO `prmt` VALUES (1,200,100,'15:59','10:59','23:59','11:00','06:00','16:00','2');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proy`
--

LOCK TABLES `proy` WRITE;
/*!40000 ALTER TABLE `proy` DISABLE KEYS */;
INSERT INTO `proy` VALUES (1,'Escuela \"Simón Bolivar\"','SECOB',NULL,'2015-09-10 00:00:00',-1.8311319913966744e16,-7.960212707519531e15,'UEM Pimocha H&T',12),(2,'Socio 60%','CONSORCIO H&T',NULL,'2015-09-10 00:00:00',-1.8267625740105132e16,-7.960590362548828e15,'PIMOCHA HINSA',11),(3,'Escuela \"José de San Martín\"','SECOB',NULL,'2015-09-22 00:00:00',-1.357325418818099e15,-7.941965103149414e15,'UEM Zapotal TAHINSA',10),(4,'Socio 60%','Consorcio TAHINSA',NULL,'2015-09-23 00:00:00',-1.3230025456659424e16,-7.945587158203125e15,'ZAPOTAL HINSA',8);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prpr`
--

LOCK TABLES `prpr` WRITE;
/*!40000 ALTER TABLE `prpr` DISABLE KEYS */;
INSERT INTO `prpr` VALUES (1,'2015-09-24 15:30:38','2015-09-24 15:30:27',NULL,11,2),(2,NULL,'2015-09-24 15:31:04',NULL,11,1),(3,NULL,'2015-12-17 13:19:10',NULL,13,1),(4,NULL,'2015-12-17 13:19:23',NULL,14,1),(5,NULL,'2015-12-17 13:19:33',NULL,15,1),(6,NULL,'2015-12-17 13:19:44',NULL,18,1),(7,NULL,'2015-12-17 13:19:54',NULL,16,1),(8,NULL,'2015-12-17 13:20:04',NULL,17,1),(9,NULL,'2015-12-17 13:20:18',NULL,12,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prsn`
--

LOCK TABLES `prsn` WRITE;
/*!40000 ALTER TABLE `prsn` DISABLE KEYS */;
INSERT INTO `prsn` VALUES (1,1,'Admin','250cf8b51c773f3f8dc8b4be867a9a02','1234567890',NULL,'1987-01-23 00:00:00','1.jpeg','admin','luzma_87@yahoo.com','Admin',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,1),(2,1,'Normal','250cf8b51c773f3f8dc8b4be867a9a02','1234567891',NULL,'1950-06-15 00:00:00',NULL,'usu','luzma_87@yahoo.com','Usuario',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','M',NULL,7),(3,1,'jefe','250cf8b51c773f3f8dc8b4be867a9a02','1234567892',NULL,NULL,'3.jpeg','jefe','luzma_87@yahoo.com','jefe',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,3),(4,1,'rsbd','250cf8b51c773f3f8dc8b4be867a9a02','1234567895',NULL,NULL,NULL,'rsbd','luzma_87@yahoo.com','rsbd',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,4),(5,1,'ascm','250cf8b51c773f3f8dc8b4be867a9a02','1234567894',NULL,NULL,'5.jpeg','ascm','luzma_87@yahoo.com','ascm',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,6),(6,1,'grnt','250cf8b51c773f3f8dc8b4be867a9a02','1234567893',NULL,NULL,'6.jpeg','grnt','luzma_87@yahoo.com','grnt',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,2),(7,1,'jfcm','250cf8b51c773f3f8dc8b4be867a9a02','1234567896',NULL,NULL,'7.jpeg','jfcm','luzma_87@yahoo.com','jfcm',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,5),(8,1,'rsbd2','250cf8b51c773f3f8dc8b4be867a9a02','1234567897',NULL,NULL,NULL,'rsbd2','luzma_87@yahoo.com','rsbd2',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,4),(9,1,'mantenimiento','e10adc3949ba59abbe56e057f20f883e','1234567989',NULL,NULL,'9.jpeg','jfmn','luzma_87@yahoo.com','jefe',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,8),(10,1,'mecanico',NULL,'1234567898',NULL,'1984-07-10 00:00:00',NULL,'mcnc','luzma_87@yahoo.com','mecanico',NULL,'9c3ba79cc2633680e0926a30e9bb0ed1','F',NULL,9),(11,1,'Cuzco','e8b4166e5e735976cb0edaec38c5fcac','1720753001','Ecuatoriana','1986-04-02 00:00:00',NULL,'bpimochal','bodega.pimocha@hinsaec.com','Luis','Responsable de bodega de Pimocha Luis Cuzco','8c249675aea6c3cbd91661bbae767ff1','M','0997871550',4),(12,0,'Villacis',NULL,'1702869650','San Cristobal 10-38 y Río Coca','1949-08-17 00:00:00',NULL,'eduardovillacís','eduardo.villacis@hinsaec.com','Eduardo',NULL,'36ac8e558ac7690b6f44e2cb5ef93322','M','0999861875',5),(13,1,'Haro','8ea647394d89b94791dfe9872dfb1b4d','1707374169','Conjunto Ciudad Alegría casa 2D-40','1967-04-15 00:00:00',NULL,'diegoharo','compras@hinsaec.com','Diego','Asistente compras oficina central','a82d922b133be19c1171534e6594f754','M','0991620045',6),(14,1,'hidalgo',NULL,'1714834825','Petirrojo n.72 y José Matía Vargas','1987-02-19 00:00:00',NULL,'anahidalgo','ana.hidalgo@hinsaec.com','ana','Procurador Común','21929bcae11fad459ad54d8bea3666ef','F','0991620299',2),(15,1,'Hidalgo',NULL,'1704248887','Quito, petirrojo 72','1955-06-15 00:00:00',NULL,'maxhidalgo','max.hidalgo@hinsaec.com','Maximiliano',NULL,'378a063b8fdb1db941e34f4bde584c7d','M','0993681963',2),(16,1,'Mejia',NULL,'1713305363','Cdla. Yaguachisgto Puyan OE8-71 y Venacio Escandon','1975-05-30 00:00:00',NULL,'katiamejia','kattia.mejia@hinsaec.com','Katia',NULL,'e89bf7e5a1d99e0713d89a06f2def793','F','0980079325',7),(17,1,'Peña',NULL,'1716310378','Urbanización Biloxi calle 11 lote 110','1980-04-19 00:00:00',NULL,'gloriapena','gloria.penia@hinsaec.com','Gloria',NULL,'65e6491a81108cf8e0bd100592772da0','F','0997987894',1),(18,1,'Chicaiza',NULL,'1701841163','Alangasi calle Atahualpa S 1-167 y Sucre','1938-09-03 00:00:00',NULL,'efrainchicaiza','efrain.chicaiza@hinsaec.com','Efrain',NULL,'788a36ef2450d7b922b9f38caaa9d41a','M','0997987121',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesn`
--

LOCK TABLES `sesn` WRITE;
/*!40000 ALTER TABLE `sesn` DISABLE KEYS */;
INSERT INTO `sesn` VALUES (1,1,1),(2,7,2),(3,2,3),(4,6,4),(5,4,5),(6,5,6),(7,3,7),(8,6,8),(9,8,9),(10,9,10),(11,5,1),(12,6,11),(13,3,12),(14,4,13),(15,1,14),(16,5,14),(17,5,15),(18,11,16),(19,10,17),(20,10,18),(21,2,14);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smex`
--

LOCK TABLES `smex` WRITE;
/*!40000 ALTER TABLE `smex` DISABLE KEYS */;
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
  `sminfrdv` bigint(20) DEFAULT NULL,
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
  KEY `FK_4d191ub7j00s96ial9n8shr4q` (`sminfrdv`),
  CONSTRAINT `FK_4d191ub7j00s96ial9n8shr4q` FOREIGN KEY (`sminfrdv`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_5ci63uot2cx6w4q3v48yhltw5` FOREIGN KEY (`proy__id`) REFERENCES `proy` (`proy__id`),
  CONSTRAINT `FK_85ht6hd7eo2wdpcwebc662kfp` FOREIGN KEY (`maqn__id`) REFERENCES `maqn` (`maqn__id`),
  CONSTRAINT `FK_eevcrnq3beil4i1cguprgqhca` FOREIGN KEY (`sminprde`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_f229g0x3te9pfvlnekc5ofwa9` FOREIGN KEY (`sminfrsl`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_h8glkesmmxh1dl4wp53o8t55t` FOREIGN KEY (`sminfrng`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_j1x1h53b1xx2yg63fyojmplb8` FOREIGN KEY (`sminfrap`) REFERENCES `frma` (`frma__id`),
  CONSTRAINT `FK_kxbg9ypa8oliuoemn34sju9ea` FOREIGN KEY (`essl__id`) REFERENCES `essl` (`essl__id`),
  CONSTRAINT `FK_m1nndxlffurte23473aswrbe1` FOREIGN KEY (`sminpren`) REFERENCES `prsn` (`prsn__id`),
  CONSTRAINT `FK_tnfnvknbcda9jxoxhccwex7bp` FOREIGN KEY (`sminpraf`) REFERENCES `prsn` (`prsn__id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smin`
--

LOCK TABLES `smin` WRITE;
/*!40000 ALTER TABLE `smin` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
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
  `tpascdgo` varchar(4) COLLATE latin1_spanish_ci NOT NULL,
  `tpasclor` varchar(9) COLLATE latin1_spanish_ci NOT NULL,
  `tpasicno` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `tpasnmbr` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `tpasordn` int(11) NOT NULL,
  PRIMARY KEY (`tpas__id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpas`
--

LOCK TABLES `tpas` WRITE;
/*!40000 ALTER TABLE `tpas` DISABLE KEYS */;
INSERT INTO `tpas` VALUES (1,'ASTE','#82a640','fa fa-check','Asiste',1),(2,'NAST','#ffa324','fa fa-remove','No asiste',2),(3,'VCJN','#a583a6','fa fa-automobile','Vacación de jornada',3),(4,'VCAN','#ed6898','fa fa-plane','Vacación anual',4),(5,'PRMD','#2b96a6','fa fa-stethoscope','Permiso médico',5),(6,'CLDM','#637ee0','fa fa-home','Calamidad doméstica',6),(7,'PRPT','#df67e5','fa fa-gift','Permiso de paternidad',7);
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
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpit`
--

LOCK TABLES `tpit` WRITE;
/*!40000 ALTER TABLE `tpit` DISABLE KEYS */;
INSERT INTO `tpit` VALUES (215,'MATS','MATERILES','MATERIALES'),(217,'PVC',NULL,'Items de PVC'),(218,'CBRE',NULL,'Items de cobre'),(219,'ADTV',NULL,'Aditivos'),(220,'BRKR',NULL,'Breakers'),(221,'CBLS',NULL,'Cables'),(222,'CNDC',NULL,'Conductores'),(223,'CRMC',NULL,'Cerámicas'),(224,'CRRD',NULL,'Cerraduras'),(225,'ACRO',NULL,'Items de acero'),(226,'ADQN',NULL,'Adoquines'),(227,'1',NULL,'LAPTOPS'),(228,'ms',NULL,'MOUSE GENIUS'),(229,'FSH',NULL,'flash memory'),(230,'RGD',NULL,'REGULADOR'),(231,'0',NULL,'0'),(232,'I',NULL,'Impresora'),(233,'E',NULL,'estuche'),(234,'c',NULL,'cascos'),(235,'ch',NULL,'chalecos'),(236,'tp',NULL,'tapones auditivos'),(237,'g',NULL,'guantes'),(238,'gf',NULL,'gafas');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpmq`
--

LOCK TABLES `tpmq` WRITE;
/*!40000 ALTER TABLE `tpmq` DISABLE KEYS */;
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
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-06 21:46:55
