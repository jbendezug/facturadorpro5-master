-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: tenancy
-- ------------------------------------------------------
-- Server version	5.7.44

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
-- Current Database: `tenancy`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenancy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `tenancy`;

--
-- Table structure for table `card_brands`
--

DROP TABLE IF EXISTS `card_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_brands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_brands`
--

LOCK TABLES `card_brands` WRITE;
/*!40000 ALTER TABLE `card_brands` DISABLE KEYS */;
INSERT INTO `card_brands` VALUES (1,'Visa'),(2,'Mastercard');
/*!40000 ALTER TABLE `card_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_payments`
--

DROP TABLE IF EXISTS `client_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` int(10) unsigned NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` int(10) unsigned DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_payments_client_id_foreign` (`client_id`),
  KEY `client_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `client_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `client_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `client_payments_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `client_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_payments`
--

LOCK TABLES `client_payments` WRITE;
/*!40000 ALTER TABLE `client_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostname_id` bigint(20) unsigned DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `locked_users` tinyint(1) NOT NULL DEFAULT '0',
  `locked_tenant` tinyint(1) NOT NULL DEFAULT '0',
  `locked_emission` tinyint(1) NOT NULL DEFAULT '0',
  `plan_id` int(10) unsigned NOT NULL,
  `smtp_encryption` text COLLATE utf8mb4_unicode_ci COMMENT 'Tipo de cifrado de correo',
  `smtp_password` text COLLATE utf8mb4_unicode_ci COMMENT 'contraseña de usuario para el envio de correo',
  `smtp_user` text COLLATE utf8mb4_unicode_ci COMMENT 'Nombre de usuario para el envio de correo',
  `smtp_port` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Puerto de correo del cliente',
  `smtp_host` text COLLATE utf8mb4_unicode_ci COMMENT 'Host de correo del cliente',
  `start_billing_cycle` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_hostname_id_foreign` (`hostname_id`),
  KEY `clients_plan_id_foreign` (`plan_id`),
  CONSTRAINT `clients_hostname_id_foreign` FOREIGN KEY (`hostname_id`) REFERENCES `hostnames` (`id`) ON DELETE CASCADE,
  CONSTRAINT `clients_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,1,'20600206011','INJUSERV','admin@gmail.com','xIwvmnwqDARxHAAXvcjlAeqLM4GJ7wmt8LUcgXjB3IGXNj6FjE',0,0,0,0,1,NULL,NULL,NULL,0,NULL,NULL,'2026-03-13 23:35:23','2026-03-13 23:35:23');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locked_admin` tinyint(1) NOT NULL DEFAULT '0',
  `certificate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_send_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT '01',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT '01',
  `soap_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_public_culqui` text COLLATE utf8mb4_unicode_ci,
  `token_private_culqui` text COLLATE utf8mb4_unicode_ci,
  `url_apiruc` text COLLATE utf8mb4_unicode_ci,
  `token_apiruc` text COLLATE utf8mb4_unicode_ci,
  `use_login_global` tinyint(1) NOT NULL DEFAULT '0',
  `login` text COLLATE utf8mb4_unicode_ci,
  `apk_url` text COLLATE utf8mb4_unicode_ci,
  `enable_whatsapp` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` VALUES (1,0,NULL,'01','2026-03-13 23:23:47','2026-03-13 23:38:31','01',NULL,NULL,NULL,NULL,NULL,'https://apiperu.dev','4b297f3cf07f893870d7d3db9b22e10ea47a8340e2bef32a3b8ca94153ae5a1c',1,'{\"type\":\"image\",\"image\":\"http:\\/\\/localhost:8080\\/images\\/login-v2.svg\",\"position_form\":\"right\",\"show_logo_in_form\":false,\"position_logo\":\"top-left\",\"show_socials\":false,\"use_login_global\":true}',NULL,1);
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_resources`
--

DROP TABLE IF EXISTS `history_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_resources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cpu_percent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memory_total` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memory_free` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memory_used` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_resources`
--

LOCK TABLES `history_resources` WRITE;
/*!40000 ALTER TABLE `history_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostnames`
--

DROP TABLE IF EXISTS `hostnames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostnames` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fqdn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `force_https` tinyint(1) NOT NULL DEFAULT '0',
  `under_maintenance_since` timestamp NULL DEFAULT NULL,
  `website_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostnames_fqdn_unique` (`fqdn`),
  KEY `hostnames_website_id_foreign` (`website_id`),
  CONSTRAINT `hostnames_website_id_foreign` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostnames`
--

LOCK TABLES `hostnames` WRITE;
/*!40000 ALTER TABLE `hostnames` DISABLE KEYS */;
INSERT INTO `hostnames` VALUES (1,'injuserv.localhost',NULL,0,NULL,1,'2026-03-13 23:35:23','2026-03-13 23:35:23',NULL);
/*!40000 ALTER TABLE `hostnames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2017_01_01_000003_tenancy_websites',1),(4,'2017_01_01_000005_tenancy_hostnames',1),(5,'2018_04_06_000001_tenancy_websites_needs_db_host',1),(6,'2019_01_28_092812_create_plans_table',1),(7,'2019_01_29_094116_create_plan_documents_table',1),(8,'2019_01_29_170027_create_clients_table',1),(9,'2019_02_27_165906_change_data_to_plans',1),(10,'2019_07_03_094112_create_card_brands_table',1),(11,'2019_07_03_094441_create_payment_method_types_table',1),(12,'2019_07_03_100132_create_client_payments_table',1),(13,'2019_07_19_163317_add_locked_emission_to_clients',1),(14,'2019_10_09_100840_add_locked_tenant_to_clients',1),(15,'2019_10_09_141307_create_configurations_table',1),(16,'2019_10_11_153451_add_locked_users_to_clients',1),(17,'2019_11_07_155742_create_modules_table',1),(18,'2019_11_14_211509_add_start_billing_cycle_to_clients',1),(19,'2020_02_01_131218_add_certificate_to_configurations',1),(20,'2020_02_01_182806_add_soap_to_configurations',1),(21,'2020_03_10_165827_add_data_module_for_finance',1),(22,'2020_03_31_151819_add_phone_users',1),(23,'2020_07_03_232125_add_culqi_to_configurations',1),(24,'2020_07_27_184250_add_apiruc_to_configurations',1),(25,'2020_09_07_110230_add_data_module_for_establishments_users',1),(26,'2021_03_08_154204_add_login_settings_column_to_configurations_table',1),(27,'2021_03_10_160908_add_extra_modules_to_modules_table',1),(28,'2021_03_10_170439_create_module_levels_table',1),(29,'2021_03_19_112500_create_module_level_client_table',1),(30,'2021_03_19_201634_add_sort_column_to_modules_table',1),(31,'2021_03_20_110950_change_order_item_to_modules_table',1),(32,'2021_04_01_090115_add_levels_to_module_levels_table',1),(33,'2021_05_03_131833_add_mail_configuration',1),(34,'2021_06_18_141136_add_modules_digemid',1),(35,'2021_06_18_141137_add_documentary_requirements',1),(36,'2021_08_20_161555_add_extra_data_item_menu',1),(37,'2021_09_16_144202_add_app_to_modules',1),(38,'2021_09_16_160109_add_url_apk_to_configurations',1),(39,'2021_10_05_171912_add_configuration_module_to_admin',1),(40,'2021_10_14_163406_create_history_resources_table',1),(41,'2021_10_18_154601_add_data_purchase_settlements_to_module_levels',1),(42,'2021_10_22_130040_create_app_suscription',1),(43,'2021_12_10_130040_create_app_production',1),(44,'2022_01_25_152340_create_app_restaurant',1),(45,'2022_01_30_104230_update_token_to_users',1),(46,'2022_01_30_105446_create_restaurant_partners_table',1),(47,'2022_02_23_001946_create_jobs_table',1),(48,'2022_02_25_001413_create_failed_jobs_table',1),(49,'2022_03_11_120508_add_trace_to_api_peru_service',1),(50,'2022_03_11_125431_add_attr_to_restaurant_partners',1),(51,'2022_03_31_132605_create_app_pos_garage',1),(52,'2022_04_19_101832_add_default_to_client_id_track',1),(53,'2022_04_30_124731_addwhatsapp_to_configurations',1),(54,'2022_05_07_165152_update_user_to_users',1),(55,'2022_05_08_130040_create_app_full_suscription',1),(56,'2022_05_09_212031_register_app_generate_link_to_modules',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_level_client`
--

DROP TABLE IF EXISTS `module_level_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_level_client` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `module_level_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_level_client_client_id_foreign` (`client_id`),
  KEY `module_level_client_module_id_foreign` (`module_id`),
  KEY `module_level_client_module_level_id_foreign` (`module_level_id`),
  CONSTRAINT `module_level_client_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `module_level_client_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `module_level_client_module_level_id_foreign` FOREIGN KEY (`module_level_id`) REFERENCES `module_levels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_level_client`
--

LOCK TABLES `module_level_client` WRITE;
/*!40000 ALTER TABLE `module_level_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `module_level_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_levels`
--

DROP TABLE IF EXISTS `module_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_levels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_levels_module_id_foreign` (`module_id`),
  CONSTRAINT `module_levels_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_levels`
--

LOCK TABLES `module_levels` WRITE;
/*!40000 ALTER TABLE `module_levels` DISABLE KEYS */;
INSERT INTO `module_levels` VALUES (1,'new_document','Nuevo comprobante',1,NULL,NULL),(2,'list_document','L. Comprobantes',1,NULL,NULL),(3,'document_not_sent','Doc. No enviados',1,NULL,NULL),(4,'document_contingengy','Doc. Contingencia',1,NULL,NULL),(5,'catalogs','Catálogos',1,NULL,NULL),(6,'summary_voided','Resúmenes y Anulaciones',1,NULL,NULL),(7,'quotations','Cotizaciones',1,NULL,NULL),(8,'sale_notes','Notas de Venta',1,NULL,NULL),(9,'incentives','Comisiones',1,NULL,NULL),(10,'sale-opportunity','Oportunidad de venta',1,NULL,NULL),(11,'contracts','Contratos',1,NULL,NULL),(12,'order-note','Pedidos',1,NULL,NULL),(13,'technical-service','Servicios de soporte técnico',1,NULL,NULL),(14,'regularize_shipping','CPE pendientes de rectificación',1,NULL,NULL),(15,'pos','Punto de venta',6,NULL,NULL),(16,'cash','Caja chica POS',6,NULL,NULL),(17,'ecommerce','Ir a la tienda',10,NULL,NULL),(18,'ecommerce_orders','Pedidos',10,NULL,NULL),(19,'ecommerce_items','Productos tienda virtual',10,NULL,NULL),(20,'ecommerce_tags','Etiquetas',10,NULL,NULL),(21,'ecommerce_promotions','Promociones - Banners',10,NULL,NULL),(22,'ecommerce_settings','Configuración',10,NULL,NULL),(23,'items','Productos',17,NULL,NULL),(24,'items_packs','Packs',17,NULL,NULL),(25,'items_services','Servicios',17,NULL,NULL),(26,'items_categories','Categorías',17,NULL,NULL),(27,'items_brands','Marcas',17,NULL,NULL),(28,'items_lots','Series',17,NULL,NULL),(29,'clients','Clientes',18,NULL,NULL),(30,'clients_types','Tipos de clientes',18,NULL,NULL),(31,'purchases_create','Nuevo',2,NULL,NULL),(32,'purchases_list','Listado',2,NULL,NULL),(33,'purchases_orders','Ordenes de compra',2,NULL,NULL),(34,'purchases_expenses','Gastos diversos',2,NULL,NULL),(35,'purchases_suppliers','Proveedores',2,NULL,NULL),(36,'purchases_quotations','Solicitar cotización',2,NULL,NULL),(37,'purchases_fixed_assets_items','Activos fijos - Ítems',2,NULL,NULL),(38,'purchases_fixed_assets_purchases','Activos fijos - Compras',2,NULL,NULL),(39,'inventory','Movimientos',8,NULL,NULL),(40,'inventory_transfers','Traslados',8,NULL,NULL),(41,'inventory_devolutions','Devoluciones',8,NULL,NULL),(42,'inventory_report_kardex','Reporte kardex',8,NULL,NULL),(43,'inventory_report','Reporte inventario',8,NULL,NULL),(44,'inventory_report_kardex','Kardex valorizado',8,NULL,NULL),(45,'users','Usuarios',14,NULL,NULL),(46,'users_establishments','Establecimientos',14,NULL,NULL),(47,'advanced_retentions','Retenciones',3,NULL,NULL),(48,'advanced_dispatches','Guías de remisión',3,NULL,NULL),(49,'advanced_perceptions','Percepciones',3,NULL,NULL),(50,'advanced_order_forms','Ordenes de pedido',3,NULL,NULL),(51,'account_report','Exportar reporte',9,NULL,NULL),(52,'account_formats','Exportar formatos',9,NULL,NULL),(53,'account_summary','Reporte resumido - Ventas',9,NULL,NULL),(54,'finances_movements','Movimientos',12,NULL,NULL),(55,'finances_incomes','Ingresos',12,NULL,NULL),(56,'finances_unpaid','Cuentas por cobrar',12,NULL,NULL),(57,'finances_to_pay','Cuentas por pagar',12,NULL,NULL),(58,'finances_payments','Pagos',12,NULL,NULL),(59,'finances_balance','Balance',12,NULL,NULL),(60,'finances_payment_method_types','Ingresos y Egresos - M. Pago',12,NULL,NULL),(61,'account_users_settings','Configuración',11,NULL,NULL),(62,'account_users_list','Lista de pagos',11,NULL,NULL),(63,'hotels_reception','Recepción',15,NULL,NULL),(64,'hotels_rates','Tarifas',15,NULL,NULL),(65,'hotels_floors','Pisos',15,NULL,NULL),(66,'hotels_cats','Categorías',15,NULL,NULL),(67,'hotels_rooms','Habitaciones',15,NULL,NULL),(68,'documentary_offices','Oficinas',16,NULL,NULL),(69,'documentary_process','Procesos',16,NULL,NULL),(70,'documentary_documents','Tipos de documento',16,NULL,NULL),(71,'documentary_actions','Acciones',16,NULL,NULL),(72,'documentary_files','Expedientes',16,NULL,NULL),(73,'digemid','Productos',19,'2026-03-13 23:23:50','2026-03-13 23:23:50'),(74,'documentary_requirements','Requerimientos',16,'2026-03-13 23:23:50','2026-03-13 23:23:50'),(75,'inventory_item_extra_data','Datos extra de items',8,'2026-03-13 23:23:50','2026-03-13 23:23:50'),(76,'configuration_company','Empresa',5,NULL,NULL),(77,'configuration_advance','Avanzado',5,NULL,NULL),(78,'configuration_visual','Visual',5,NULL,NULL),(79,'advanced_purchase_settlements','Liquidaciones de compra',3,NULL,NULL),(80,'suscription_app_client','Cliente',21,NULL,NULL),(81,'suscription_app_service','Servicio',21,NULL,NULL),(82,'suscription_app_payments','Pagos',21,NULL,NULL),(83,'suscription_app_plans','Planes',21,NULL,NULL),(84,'pos_garage','Venta rapida',6,NULL,NULL);
/*!40000 ALTER TABLE `module_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'documents','Ventas',2,NULL,NULL),(2,'purchases','Compras',7,NULL,NULL),(3,'advanced','Documentos Avanzados',8,NULL,NULL),(4,'reports','Reportes',9,NULL,NULL),(5,'configuration','Configuración',12,NULL,NULL),(6,'pos','Punto de venta (POS)',3,NULL,NULL),(7,'dashboard','Dashboard',1,NULL,NULL),(8,'inventory','Inventario',7,NULL,NULL),(9,'accounting','Contabilidad',10,NULL,NULL),(10,'ecommerce','Ecommerce',4,NULL,NULL),(11,'cuenta','Cuenta',13,NULL,NULL),(12,'finance','Finanzas',11,NULL,NULL),(14,'establishments','Usuarios/Locales & Series',7,NULL,NULL),(15,'hotels','Hoteles',14,NULL,NULL),(16,'documentary-procedure','Trámite documentario',15,NULL,NULL),(17,'items','Productos/Servicios',5,NULL,NULL),(18,'persons','Clientes',6,NULL,NULL),(19,'digemid','Farmacia',15,'2026-03-13 23:23:50','2026-03-13 23:23:50'),(20,'apps','Apps',1,NULL,NULL),(21,'suscription_app','Suscriptiones',16,NULL,NULL),(22,'production_app','Producción',17,NULL,NULL),(23,'restaurant_app','Restaurante',18,NULL,NULL),(24,'full_suscription_app','Suscripción Servicios SAAS',17,NULL,NULL),(25,'generate_link_app','Generador de link de pago',19,NULL,NULL);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method_types`
--

DROP TABLE IF EXISTS `payment_method_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_method_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method_types`
--

LOCK TABLES `payment_method_types` WRITE;
/*!40000 ALTER TABLE `payment_method_types` DISABLE KEYS */;
INSERT INTO `payment_method_types` VALUES (1,'Efectivo',0),(2,'Tarjeta de crédito',1),(3,'Tarjeta de débito',1),(4,'Transferencia',0);
/*!40000 ALTER TABLE `payment_method_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_documents`
--

DROP TABLE IF EXISTS `plan_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_documents`
--

LOCK TABLES `plan_documents` WRITE;
/*!40000 ALTER TABLE `plan_documents` DISABLE KEYS */;
INSERT INTO `plan_documents` VALUES (1,'Facturas, boletas, notas de débito y crédito, resúmenes y anulaciones'),(2,'Guias de remisión'),(3,'Retenciones'),(4,'Percepciones');
/*!40000 ALTER TABLE `plan_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pricing` double NOT NULL,
  `limit_users` bigint(20) NOT NULL,
  `limit_documents` bigint(20) NOT NULL,
  `plan_documents` json NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'Ilimitado',99,0,0,'[1, 2, 3, 4]',1,'2026-03-13 23:23:51','2026-03-13 23:23:51');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_partners`
--

DROP TABLE IF EXISTS `restaurant_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_partners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gitlab_user` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `restaurant_partners_email_unique` (`email`),
  UNIQUE KEY `restaurant_partners_gitlab_user_unique` (`gitlab_user`),
  UNIQUE KEY `restaurant_partners_domain_unique` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_partners`
--

LOCK TABLES `restaurant_partners` WRITE;
/*!40000 ALTER TABLE `restaurant_partners` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track_api_peru_services`
--

DROP TABLE IF EXISTS `track_api_peru_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track_api_peru_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service` int(10) unsigned DEFAULT '0' COMMENT 'Tipo de servicio 1 => sunat/dni, 2 => validacion_multiple_cpe, 3 => CPE, 4 => tipo_de_cambio, 5 => printer_ticket',
  `ruc` text COLLATE utf8mb4_unicode_ci COMMENT 'Ruc de la empresa que consulta',
  `client_id` int(10) unsigned DEFAULT '0',
  `date_of_issue` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_api_peru_services`
--

LOCK TABLES `track_api_peru_services` WRITE;
/*!40000 ALTER TABLE `track_api_peru_services` DISABLE KEYS */;
INSERT INTO `track_api_peru_services` VALUES (1,1,'20600206011',1,'2026-03-14 11:07:07'),(2,1,'20600206011',1,'2026-03-14 11:50:49'),(3,2,'20600206011',1,'2026-03-14 12:07:31');
/*!40000 ALTER TABLE `track_api_peru_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin Instrador','admin@gmail.com',NULL,'$2y$10$kxSWqLOWM9jvxsJLSWn9oeXjv/eiKdNo2aiAokU/nWxjGdA.Nwnlu',NULL,NULL,'2026-03-13 23:23:51','2026-03-13 23:23:51',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `websites`
--

DROP TABLE IF EXISTS `websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `websites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `managed_by_database_connection` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'References the database connection key in your database.php',
  PRIMARY KEY (`id`),
  UNIQUE KEY `websites_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `websites`
--

LOCK TABLES `websites` WRITE;
/*!40000 ALTER TABLE `websites` DISABLE KEYS */;
INSERT INTO `websites` VALUES (1,'tenancy_injuserv','2026-03-13 23:31:52','2026-03-13 23:31:52',NULL,NULL);
/*!40000 ALTER TABLE `websites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tenancy'
--

--
-- Current Database: `tenancy_injuserv`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenancy_injuserv` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `tenancy_injuserv`;

--
-- Table structure for table `account_payments`
--

DROP TABLE IF EXISTS `account_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_of_payment` date NOT NULL,
  `date_of_payment_real` date DEFAULT NULL,
  `reference_id` int(10) unsigned DEFAULT NULL,
  `payment_method_type_id` int(10) unsigned DEFAULT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` int(10) unsigned DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `reference_payment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_payments`
--

LOCK TABLES `account_payments` WRITE;
/*!40000 ALTER TABLE `account_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounting_ledger`
--

DROP TABLE IF EXISTS `accounting_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounting_ledger` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `month` smallint(5) unsigned DEFAULT '0' COMMENT 'Numero de mes',
  `year` mediumint(8) unsigned DEFAULT '0' COMMENT 'Numero de mes',
  `date_of_report` date DEFAULT NULL,
  `code_account` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Codigo de plan de cuenta',
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de cuenta',
  `last_month_total` double(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Debe ser el valor del total del mes pasado',
  `credits` double(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Créditos en el mes',
  `debs` double(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Debitos en el mes',
  `final_total` double(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Saldo Final de mes',
  `serialize_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'datos serialziados en bruto.',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounting_ledger`
--

LOCK TABLES `accounting_ledger` WRITE;
/*!40000 ALTER TABLE `accounting_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounting_ledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounting_ledger_task`
--

DROP TABLE IF EXISTS `accounting_ledger_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounting_ledger_task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `month` smallint(5) unsigned DEFAULT '0' COMMENT 'Numero de mes',
  `year` mediumint(8) unsigned DEFAULT '0' COMMENT 'Numero de mes',
  `last_rum` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounting_ledger_task`
--

LOCK TABLES `accounting_ledger_task` WRITE;
/*!40000 ALTER TABLE `accounting_ledger_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounting_ledger_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_accounts`
--

DROP TABLE IF EXISTS `bank_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cci` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `initial_balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `show_in_documents` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `bank_accounts_bank_id_foreign` (`bank_id`),
  KEY `bank_accounts_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `bank_accounts_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`),
  CONSTRAINT `bank_accounts_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_accounts`
--

LOCK TABLES `bank_accounts` WRITE;
/*!40000 ALTER TABLE `bank_accounts` DISABLE KEYS */;
INSERT INTO `bank_accounts` VALUES (1,1,'skotia','121332424343434','1332343434343434','PEN',1,0.00,1);
/*!40000 ALTER TABLE `bank_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_loan_fee`
--

DROP TABLE IF EXISTS `bank_loan_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_loan_fee` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_loan_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Relacion con el metodo de pago, Nulo es pago a cuotas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_loan_fee`
--

LOCK TABLES `bank_loan_fee` WRITE;
/*!40000 ALTER TABLE `bank_loan_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_loan_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_loan_items`
--

DROP TABLE IF EXISTS `bank_loan_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_loan_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_loan_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(12,2) DEFAULT '0.00',
  `total_interest` decimal(12,2) DEFAULT '0.00',
  `total_ingress` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_loan_items`
--

LOCK TABLES `bank_loan_items` WRITE;
/*!40000 ALTER TABLE `bank_loan_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_loan_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_loan_payments`
--

DROP TABLE IF EXISTS `bank_loan_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_loan_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_loan_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_loan_payments`
--

LOCK TABLES `bank_loan_payments` WRITE;
/*!40000 ALTER TABLE `bank_loan_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_loan_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_loan_reasons`
--

DROP TABLE IF EXISTS `bank_loan_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_loan_reasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_loan_reasons`
--

LOCK TABLES `bank_loan_reasons` WRITE;
/*!40000 ALTER TABLE `bank_loan_reasons` DISABLE KEYS */;
INSERT INTO `bank_loan_reasons` VALUES (1,'Varios');
/*!40000 ALTER TABLE `bank_loan_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_loan_types`
--

DROP TABLE IF EXISTS `bank_loan_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_loan_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_loan_types`
--

LOCK TABLES `bank_loan_types` WRITE;
/*!40000 ALTER TABLE `bank_loan_types` DISABLE KEYS */;
INSERT INTO `bank_loan_types` VALUES (1,'Prestamo','2026-03-13 23:34:56','2026-03-13 23:34:56');
/*!40000 ALTER TABLE `bank_loan_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_loans`
--

DROP TABLE IF EXISTS `bank_loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank_loans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `bank_loan_type_id` int(10) unsigned NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `bank_id` int(10) unsigned NOT NULL,
  `bank_account_id` int(10) unsigned NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `bank` json NOT NULL,
  `exchange_rate_sale` decimal(12,2) DEFAULT '0.00',
  `total` decimal(12,2) DEFAULT '0.00',
  `total_interest` decimal(12,2) DEFAULT '0.00',
  `total_ingress` decimal(12,2) DEFAULT '0.00',
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_type_id` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_loans`
--

LOCK TABLES `bank_loans` WRITE;
/*!40000 ALTER TABLE `bank_loans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` VALUES (1,'BANCO SCOTIABANK',NULL,NULL,1),(2,'BANCO DE CREDITO DEL PERU',NULL,NULL,1),(3,'BANCO DE COMERCIO',NULL,NULL,1),(4,'BANCO PICHINCHA',NULL,NULL,1),(5,'BBVA CONTINENTAL',NULL,NULL,1),(6,'INTERBANK',NULL,NULL,1);
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_cycles`
--

DROP TABLE IF EXISTS `billing_cycles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_cycles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_time_start` datetime NOT NULL,
  `renew` tinyint(1) NOT NULL DEFAULT '0',
  `quantity_documents` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_cycles`
--

LOCK TABLES `billing_cycles` WRITE;
/*!40000 ALTER TABLE `billing_cycles` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_cycles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brands_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_turns`
--

DROP TABLE IF EXISTS `business_turns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_turns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_turns`
--

LOCK TABLES `business_turns` WRITE;
/*!40000 ALTER TABLE `business_turns` DISABLE KEYS */;
INSERT INTO `business_turns` VALUES (1,'hotel','Hoteles',0,'2026-03-13 23:32:57','2026-03-13 23:32:57'),(2,'transport','Empresa de transporte de pasajeros',0,'2026-03-13 23:32:57','2026-03-13 23:32:57'),(3,'restaurant','Restaurantes',0,'2026-03-13 23:32:57','2026-03-13 23:32:57'),(4,'tap','Grifos',0,'2026-03-13 23:32:57','2026-03-13 23:32:57');
/*!40000 ALTER TABLE `business_turns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_brands`
--

DROP TABLE IF EXISTS `card_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_brands` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `card_brands_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_brands`
--

LOCK TABLES `card_brands` WRITE;
/*!40000 ALTER TABLE `card_brands` DISABLE KEYS */;
INSERT INTO `card_brands` VALUES ('01','Visa',1),('02','Mastercard',1);
/*!40000 ALTER TABLE `card_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash`
--

DROP TABLE IF EXISTS `cash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `date_opening` date NOT NULL,
  `time_opening` time NOT NULL,
  `date_closed` date DEFAULT NULL,
  `time_closed` time DEFAULT NULL,
  `beginning_balance` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `final_balance` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `income` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `reference_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `apply_restaurant` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cash_user_id_foreign` (`user_id`),
  CONSTRAINT `cash_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash`
--

LOCK TABLES `cash` WRITE;
/*!40000 ALTER TABLE `cash` DISABLE KEYS */;
INSERT INTO `cash` VALUES (1,1,'2026-03-14','11:17:51',NULL,NULL,0.0000,0.0000,0.0000,1,NULL,'2026-03-14 11:17:51','2026-03-14 11:17:51',0);
/*!40000 ALTER TABLE `cash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_document_credits`
--

DROP TABLE IF EXISTS `cash_document_credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_document_credits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cash_id` int(10) unsigned NOT NULL,
  `cash_id_processed` int(10) unsigned DEFAULT NULL,
  `document_id` int(10) unsigned DEFAULT NULL,
  `sale_note_id` int(10) unsigned DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_document_credits_document_id_foreign` (`document_id`),
  KEY `cash_document_credits_sale_note_id_foreign` (`sale_note_id`),
  KEY `cash_document_credits_cash_id_foreign` (`cash_id`),
  CONSTRAINT `cash_document_credits_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`),
  CONSTRAINT `cash_document_credits_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `cash_document_credits_sale_note_id_foreign` FOREIGN KEY (`sale_note_id`) REFERENCES `sale_notes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_document_credits`
--

LOCK TABLES `cash_document_credits` WRITE;
/*!40000 ALTER TABLE `cash_document_credits` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_document_credits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_documents`
--

DROP TABLE IF EXISTS `cash_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cash_id` int(10) unsigned NOT NULL,
  `document_id` int(10) unsigned DEFAULT NULL,
  `sale_note_id` int(10) unsigned DEFAULT NULL,
  `technical_service_id` int(10) unsigned DEFAULT NULL,
  `expense_payment_id` int(10) unsigned DEFAULT NULL,
  `purchase_id` int(10) unsigned DEFAULT NULL,
  `bank_loan_payment_id` int(10) unsigned DEFAULT NULL,
  `quotation_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_documents_cash_id_foreign` (`cash_id`),
  KEY `cash_documents_document_id_foreign` (`document_id`),
  KEY `cash_documents_sale_note_id_foreign` (`sale_note_id`),
  KEY `cash_documents_expense_payment_id_foreign` (`expense_payment_id`),
  KEY `cash_documents_technical_service_id_foreign` (`technical_service_id`),
  KEY `cash_documents_purchase_id_foreign` (`purchase_id`),
  KEY `cash_documents_quotation_id_foreign` (`quotation_id`),
  CONSTRAINT `cash_documents_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_documents_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_documents_expense_payment_id_foreign` FOREIGN KEY (`expense_payment_id`) REFERENCES `expense_payments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_documents_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_documents_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`),
  CONSTRAINT `cash_documents_sale_note_id_foreign` FOREIGN KEY (`sale_note_id`) REFERENCES `sale_notes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_documents_technical_service_id_foreign` FOREIGN KEY (`technical_service_id`) REFERENCES `technical_services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_documents`
--

LOCK TABLES `cash_documents` WRITE;
/*!40000 ALTER TABLE `cash_documents` DISABLE KEYS */;
INSERT INTO `cash_documents` VALUES (1,1,3,NULL,NULL,NULL,NULL,NULL,NULL),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,1),(3,1,4,NULL,NULL,NULL,NULL,NULL,NULL),(4,1,5,NULL,NULL,NULL,NULL,NULL,NULL),(5,1,NULL,NULL,NULL,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `cash_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_transactions`
--

DROP TABLE IF EXISTS `cash_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cash_id` int(10) unsigned NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment` decimal(14,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_transactions_cash_id_foreign` (`cash_id`),
  KEY `cash_transactions_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `cash_transactions_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_transactions_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_transactions`
--

LOCK TABLES `cash_transactions` WRITE;
/*!40000 ALTER TABLE `cash_transactions` DISABLE KEYS */;
INSERT INTO `cash_transactions` VALUES (1,1,'01','2026-03-14','Saldo inicial',0.0000);
/*!40000 ALTER TABLE `cash_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_accounting_ledger_code_account`
--

DROP TABLE IF EXISTS `cat_accounting_ledger_code_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_accounting_ledger_code_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code_account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Codigo de plan de cuenta',
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de cuenta',
  `disabled` tinyint(3) unsigned DEFAULT '0' COMMENT 'Permite realizar modificaciones',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_accounting_ledger_code_account`
--

LOCK TABLES `cat_accounting_ledger_code_account` WRITE;
/*!40000 ALTER TABLE `cat_accounting_ledger_code_account` DISABLE KEYS */;
INSERT INTO `cat_accounting_ledger_code_account` VALUES (1,'1','Activos',1,NULL,NULL),(2,'1.1','Activos corrientes',1,NULL,NULL),(3,'1.1.1','Efectivo y equivalentes de efectivo',1,NULL,NULL),(4,'1.1.1.1','Caja',1,NULL,NULL),(5,'1.1.1.2','Bancos',1,NULL,NULL),(6,'1.1.2','Deudores comerciales y otras cuentas por cobrar',1,NULL,NULL),(7,'1.1.2.0','Activos por impuestos corrientes',1,NULL,NULL),(8,'1.1.2.1','Otras cuentas por cobrar',1,NULL,NULL),(9,'1.1.3','Inventarios',1,NULL,NULL),(10,'1.1.4','Inversiones a corto plazo',1,NULL,NULL),(11,'1.1.5','Otros activos corrientes',1,NULL,NULL),(12,'1.2','Activos no corrientes',1,NULL,NULL),(13,'1.2.1','Propiedad, planta y equipo (Activos fijos)',1,NULL,NULL),(14,'1.2.2','Otros Activos no corrientes',1,NULL,NULL),(15,'2','Pasivos',1,NULL,NULL),(16,'2.1','Pasivos corrientes',1,NULL,NULL),(17,'2.1.1','Cuentas por pagar',1,NULL,NULL),(18,'2.1.1.1','Otras cuentas por pagar',1,NULL,NULL),(19,'2.1.2','Provisiones',1,NULL,NULL),(20,'2.1.3','Obligaciones laborales y de seguridad social',1,NULL,NULL),(21,'2.1.4','Pasivos por impuestos corrientes',1,NULL,NULL),(22,'2.1.4.1','Impuestos por pagar',1,NULL,NULL),(23,'2.1.4.2','Retenciones por pagar',1,NULL,NULL),(24,'2.1.5','Cuentas por pagar con costo financiero',1,NULL,NULL),(25,'2.1.6','Obligaciones financieras',1,NULL,NULL),(26,'2.1.6.1','Tarjetas de crédito',1,NULL,NULL),(27,'2.1.7','Otros pasivos corrientes',1,NULL,NULL),(28,'2.2','Pasivos no corrientes',1,NULL,NULL),(29,'2.2.1','Préstamos a largo plazo',1,NULL,NULL),(30,'2.2.2','Otros pasivos no corrientes',1,NULL,NULL),(31,'3','Patrimonio',1,NULL,NULL),(32,'3.1','Capital social',1,NULL,NULL),(33,'3.2','Ganancias acumuladas',1,NULL,NULL),(34,'3.3','Ajustes por saldos iniciales',1,NULL,NULL),(35,'3.3.1','Ajustes iniciales en bancos',1,NULL,NULL),(36,'3.3.2','Ajustes iniciales en inventario',1,NULL,NULL),(37,'4','Ingresos',1,NULL,NULL),(38,'4.1','Ingresos de actividades ordinarias',1,NULL,NULL),(39,'4.2','Otros Ingresos',1,NULL,NULL),(40,'4.2.1','Otros ingresos diversos',1,NULL,NULL);
/*!40000 ALTER TABLE `cat_accounting_ledger_code_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_address_types`
--

DROP TABLE IF EXISTS `cat_address_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_address_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_address_types`
--

LOCK TABLES `cat_address_types` WRITE;
/*!40000 ALTER TABLE `cat_address_types` DISABLE KEYS */;
INSERT INTO `cat_address_types` VALUES ('01','Punto de venta'),('02','Producción'),('03','Extracción'),('04','Explotación'),('05','Otros');
/*!40000 ALTER TABLE `cat_address_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_affectation_igv_types`
--

DROP TABLE IF EXISTS `cat_affectation_igv_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_affectation_igv_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `exportation` tinyint(1) DEFAULT NULL,
  `free` tinyint(1) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_affectation_igv_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_affectation_igv_types`
--

LOCK TABLES `cat_affectation_igv_types` WRITE;
/*!40000 ALTER TABLE `cat_affectation_igv_types` DISABLE KEYS */;
INSERT INTO `cat_affectation_igv_types` VALUES ('10',1,0,0,'Gravado - Operación Onerosa'),('11',1,0,1,'Gravado – Retiro por premio'),('12',1,0,1,'Gravado – Retiro por donación'),('13',1,0,1,'Gravado – Retiro'),('14',1,0,1,'Gravado – Retiro por publicidad'),('15',1,0,1,'Gravado – Bonificaciones'),('16',1,0,1,'Gravado – Retiro por entrega a trabajadores'),('17',0,0,1,'Gravado – IVAP'),('20',1,0,0,'Exonerado - Operación Onerosa'),('21',1,0,1,'Exonerado – Transferencia Gratuita'),('30',1,0,0,'Inafecto - Operación Onerosa'),('31',1,0,1,'Inafecto – Retiro por Bonificación'),('32',1,0,1,'Inafecto – Retiro'),('33',1,0,1,'Inafecto – Retiro por Muestras Médicas'),('34',1,0,1,'Inafecto - Retiro por Convenio Colectivo'),('35',1,0,1,'Inafecto – Retiro por premio'),('36',1,0,1,'Inafecto - Retiro por publicidad'),('37',1,0,1,'Inafecto - Transferencia gratuita'),('40',1,1,0,'Exportación de bienes o servicios');
/*!40000 ALTER TABLE `cat_affectation_igv_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_attribute_types`
--

DROP TABLE IF EXISTS `cat_attribute_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_attribute_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_attribute_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_attribute_types`
--

LOCK TABLES `cat_attribute_types` WRITE;
/*!40000 ALTER TABLE `cat_attribute_types` DISABLE KEYS */;
INSERT INTO `cat_attribute_types` VALUES ('3001',1,'Detracciones: Recursos Hidrobiológicos-Matrícula de la embarcación'),('3002',1,'Detracciones: Recursos Hidrobiológicos-Nombre de la embarcación'),('3003',1,'Detracciones: Recursos Hidrobiológicos-Tipo de especie vendida'),('3004',1,'Detracciones: Recursos Hidrobiológicos-Lugar de descarga'),('3005',1,'Detracciones: Recursos Hidrobiológicos-Fecha de descarga'),('3006',1,'Detracciones: Recursos Hidrobiológicos-Cantidad de especie vendida'),('3050',1,'Transportre Terreste - Número de asiento'),('3051',1,'Transporte Terrestre - Información de manifiesto de pasajeros'),('3052',1,'Transporte Terrestre - Número de documento de identidad del pasajero'),('3053',1,'Transporte Terrestre - Tipo de documento de identidad del pasajero'),('3054',1,'Transporte Terrestre - Nombres y apellidos del pasajero'),('3055',1,'Transporte Terrestre - Ciudad o lugar de destino - Ubigeo'),('3056',1,'Transporte Terrestre - Ciudad o lugar de destino - Dirección detallada'),('3057',1,'Transporte Terrestre - Ciudad o lugar de origen - Ubigeo'),('3058',1,'Transporte Terrestre - Ciudad o lugar de origen - Dirección detallada'),('3059',1,'Transporte Terrestre - Fecha de inicio programado'),('3060',1,'Transporte Terrestre - Hora de inicio programado'),('4000',1,'Beneficio Hospedajes-Paquete turístico: Código de país de emisión del pasaporte'),('4001',1,'Beneficio Hospedajes: Código de país de residencia del sujeto no domiciliado'),('4002',1,'Beneficio Hospedajes: Fecha de ingreso al país'),('4003',1,'Beneficio Hospedajes: Fecha de Ingreso al Establecimiento'),('4004',1,'Beneficio Hospedajes: Fecha de Salida del Establecimiento'),('4005',1,'Beneficio Hospedajes: Número de Días de Permanencia'),('4006',1,'Beneficio Hospedajes: Fecha de Consumo'),('4007',1,'Beneficio Hospedajes-Paquete turístico: Nombres y apellidos del huesped'),('4008',1,'Beneficio Hospedajes-Paquete turístico: Tipo de documento de identidad del huesped'),('4009',1,'Beneficio Hospedajes-Paquete turístico: Número de documento de identidad del huesped'),('4030',1,'Carta Porte Aéreo:  Lugar de origen - Código de ubigeo'),('4031',1,'Carta Porte Aéreo:  Lugar de origen - Dirección detallada'),('4032',1,'Carta Porte Aéreo:  Lugar de destino - Código de ubigeo'),('4033',1,'Carta Porte Aéreo:  Lugar de destino - Dirección detallada'),('4040',1,'BVME transporte ferroviario: Pasajero - Apellidos y Nombres'),('4041',1,'BVME transporte ferroviario: Pasajero - Tipo de documento de identidad'),('4042',1,'BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de origen - Código de ubigeo'),('4043',1,'BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de origen - Dirección detallada'),('4044',1,'BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de destino - Código de ubigeo'),('4045',1,'BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de destino - Dirección detallada'),('4046',1,'BVME transporte ferroviario: Servicio transporte:Número de asiento'),('4047',1,'BVME transporte ferroviario: Servicio transporte: Hora programada de inicio de viaje'),('4048',1,'BVME transporte ferroviario: Servicio transporte: Fecha programada de inicio de viaje'),('4049',1,'BVME transporte ferroviario: Pasajero - Número de documento de identidad'),('4060',1,'Regalía Petrolera: Decreto Supremo de aprobación del contrato'),('4061',1,'Regalía Petrolera: Area de contrato (Lote)'),('4062',1,'Regalía Petrolera: Periodo de pago - Fecha de inicio'),('4063',1,'Regalía Petrolera: Periodo de pago - Fecha de fin'),('4064',1,'Regalía Petrolera: Fecha de Pago'),('5000',1,'Proveedores Estado: Número de Expediente'),('5001',1,'Proveedores Estado: Código de Unidad Ejecutora'),('5002',1,'Proveedores Estado: N° de Proceso de Selección'),('5003',1,'Proveedores Estado: N° de Contrato'),('5010',1,'Numero de Placa'),('5011',1,'Categoria'),('5012',1,'Marca'),('5013',1,'Modelo'),('5014',1,'Color'),('5015',1,'Motor'),('5016',1,'Combustible'),('5017',1,'Form. Rodante'),('5018',1,'VIN'),('5019',1,'Serie/Chasis'),('5020',1,'Año fabricacion'),('5021',1,'Año modelo'),('5022',1,'Version'),('5023',1,'Ejes'),('5024',1,'Asientos'),('5025',1,'Pasajeros'),('5026',1,'Ruedas'),('5027',1,'Carroceria'),('5028',1,'Potencia'),('5029',1,'Cilindros'),('5030',1,'Ciliindrada'),('5031',1,'Peso Bruto'),('5032',1,'Peso Neto'),('5033',1,'Carga Util'),('5034',1,'Longitud'),('5035',1,'Altura'),('5036',1,'Ancho'),('6000',1,'Comercialización de Oro:  Código Unico Concesión Minera'),('6001',1,'Comercialización de Oro:  N° declaración compromiso'),('6002',1,'Comercialización de Oro:  N° Reg. Especial .Comerci. Oro'),('6003',1,'Comercialización de Oro:  N° Resolución que autoriza Planta de Beneficio'),('6004',1,'Comercialización de Oro: Ley Mineral (% concent. oro)'),('7000',1,'Gastos Art. 37 Renta:  Número de Placa'),('7001',1,'Créditos Hipotecarios: Tipo de préstamo'),('7002',1,'Créditos Hipotecarios: Indicador de Primera Vivienda'),('7003',1,'Créditos Hipotecarios: Partida Registral'),('7004',1,'Créditos Hipotecarios: Número de contrato'),('7005',1,'Créditos Hipotecarios: Fecha de otorgamiento del crédito'),('7006',1,'Créditos Hipotecarios: Dirección del predio - Código de ubigeo'),('7007',1,'Créditos Hipotecarios: Dirección del predio - Dirección completa'),('7008',1,'Créditos Hipotecarios: Dirección del predio - Urbanización'),('7009',1,'Créditos Hipotecarios: Dirección del predio - Provincia'),('7010',1,'Créditos Hipotecarios: Dirección del predio - Distrito'),('7011',1,'Créditos Hipotecarios: Dirección del predio - Departamento'),('7020',1,'Partida Arancelaria');
/*!40000 ALTER TABLE `cat_attribute_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_charge_discount_types`
--

DROP TABLE IF EXISTS `cat_charge_discount_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_charge_discount_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `base` tinyint(1) NOT NULL,
  `level` enum('item','global') COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('discount','charge') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_charge_discount_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_charge_discount_types`
--

LOCK TABLES `cat_charge_discount_types` WRITE;
/*!40000 ALTER TABLE `cat_charge_discount_types` DISABLE KEYS */;
INSERT INTO `cat_charge_discount_types` VALUES ('00',1,1,'item','discount','Descuentos que afectan la base imponible del IGV/IVAP'),('01',1,0,'item','discount','Descuentos que no afectan la base imponible del IGV/IVAP'),('02',1,1,'global','discount','Descuentos globales que afectan la base imponible del IGV/IVAP'),('03',1,0,'global','discount','Descuentos globales que no afectan la base imponible del IGV/IVAP'),('04',0,1,'global','discount','Descuentos globales por anticipos gravados que afectan la base imponible del IGV/IVAP'),('05',0,0,'global','discount','Descuentos globales por anticipos exonerados'),('06',0,0,'global','discount','Descuentos globales por anticipos inafectos'),('45',0,1,'global','charge','FISE'),('46',1,0,'global','charge','Recargo al consumo y/o propinas'),('47',1,1,'item','charge','Cargos que afectan la base imponible del IGV/IVAP'),('48',1,0,'item','charge','Cargos que no afectan la base imponible del IGV/IVAP'),('49',1,1,'global','charge','Cargos globales que afectan la base imponible del IGV/IVAP'),('50',1,0,'global','charge','Cargos globales que no afectan la base imponible del IGV/IVAP'),('51',0,1,'global','charge','Percepción venta interna'),('52',0,1,'global','charge','Percepción a la adquisición de combustible'),('53',0,1,'global','charge','Percepción realizada al agente de percepción con tasa especial'),('62',1,0,'global','discount','Retención del IGV');
/*!40000 ALTER TABLE `cat_charge_discount_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_colors_items`
--

DROP TABLE IF EXISTS `cat_colors_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_colors_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del color',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_colors_items`
--

LOCK TABLES `cat_colors_items` WRITE;
/*!40000 ALTER TABLE `cat_colors_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_colors_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_currency_types`
--

DROP TABLE IF EXISTS `cat_currency_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_currency_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `symbol` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_currency_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_currency_types`
--

LOCK TABLES `cat_currency_types` WRITE;
/*!40000 ALTER TABLE `cat_currency_types` DISABLE KEYS */;
INSERT INTO `cat_currency_types` VALUES ('PEN',1,'S/','Soles'),('USD',1,'$','Dólares Americanos');
/*!40000 ALTER TABLE `cat_currency_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_detraction_types`
--

DROP TABLE IF EXISTS `cat_detraction_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_detraction_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` decimal(6,2) NOT NULL,
  `operation_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_detraction_types_operation_type_id_foreign` (`operation_type_id`),
  KEY `cat_detraction_types_id_index` (`id`),
  CONSTRAINT `cat_detraction_types_operation_type_id_foreign` FOREIGN KEY (`operation_type_id`) REFERENCES `cat_operation_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_detraction_types`
--

LOCK TABLES `cat_detraction_types` WRITE;
/*!40000 ALTER TABLE `cat_detraction_types` DISABLE KEYS */;
INSERT INTO `cat_detraction_types` VALUES ('001',1,'Azúcar y melaza de caña',10.00,'1001'),('003',1,'Alcohol etílico',10.00,'1001'),('005',1,'Maíz amarillo duro',4.00,'1001'),('008',1,'Madera',4.00,'1001'),('016',1,'Aceite de pescado',10.00,'1001'),('019',1,'Arrendamiento de bienes',10.00,'1001'),('020',1,'Mantenimiento y reparación de bienes muebles',12.00,'1001'),('022',1,'Otros servicios empresariales',12.00,'1001'),('023',1,'Leche',4.00,'1001'),('025',1,'Fabricación de bienes por encargo',10.00,'1001'),('027',1,'Servicio de transporte de carga',4.00,'1004');
/*!40000 ALTER TABLE `cat_detraction_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_digemid`
--

DROP TABLE IF EXISTS `cat_digemid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_digemid` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL COMMENT 'Id de la tabla de item',
  `cod_digemid` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Codigo digmid',
  `nom_prod` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre segun digemid',
  `concent` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Dosificacion segun digemid',
  `nom_form_farm` longtext COLLATE utf8mb4_unicode_ci,
  `nom_form_farm_simplif` longtext COLLATE utf8mb4_unicode_ci,
  `presentac` longtext COLLATE utf8mb4_unicode_ci,
  `fracciones` longtext COLLATE utf8mb4_unicode_ci,
  `fec_vcto_reg_sanitario` longtext COLLATE utf8mb4_unicode_ci,
  `num_reg_san` longtext COLLATE utf8mb4_unicode_ci,
  `nom_titular` longtext COLLATE utf8mb4_unicode_ci,
  `prices` longtext COLLATE utf8mb4_unicode_ci,
  `max_prices` int(10) unsigned DEFAULT '0',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `last_update` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_digemid`
--

LOCK TABLES `cat_digemid` WRITE;
/*!40000 ALTER TABLE `cat_digemid` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_digemid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_document_types`
--

DROP TABLE IF EXISTS `cat_document_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_document_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `short` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_document_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_document_types`
--

LOCK TABLES `cat_document_types` WRITE;
/*!40000 ALTER TABLE `cat_document_types` DISABLE KEYS */;
INSERT INTO `cat_document_types` VALUES ('01',1,'FT','FACTURA ELECTRÓNICA'),('03',1,'BV','BOLETA DE VENTA ELECTRÓNICA'),('07',1,'NC','NOTA DE CRÉDITO'),('08',1,'ND','NOTA DE DÉBITO'),('09',1,NULL,'GUIA DE REMISIÓN REMITENTE'),('20',1,NULL,'COMPROBANTE DE RETENCIÓN ELECTRÓNICA'),('31',1,NULL,'Guía de remisión transportista'),('40',1,NULL,'COMPROBANTE DE PERCEPCIÓN ELECTRÓNICA'),('71',0,NULL,'Guia de remisión remitente complementaria'),('72',0,NULL,'Guia de remisión transportista complementaria'),('GU75',1,NULL,'GUÍA'),('NE76',1,NULL,'NOTA DE ENTRADA'),('80',1,NULL,'NOTA DE VENTA'),('02',1,NULL,'RECIBO POR HONORARIOS'),('14',1,NULL,'SERVICIOS PÚBLICOS'),('04',1,NULL,'LIQUIDACIÓN DE COMPRA');
/*!40000 ALTER TABLE `cat_document_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_identity_document_types`
--

DROP TABLE IF EXISTS `cat_identity_document_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_identity_document_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_identity_document_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_identity_document_types`
--

LOCK TABLES `cat_identity_document_types` WRITE;
/*!40000 ALTER TABLE `cat_identity_document_types` DISABLE KEYS */;
INSERT INTO `cat_identity_document_types` VALUES ('0',1,'Doc.trib.no.dom.sin.ruc'),('1',1,'DNI'),('4',1,'CE'),('6',1,'RUC'),('7',1,'Pasaporte'),('A',0,'Ced. Diplomática de identidad'),('B',0,'Documento identidad país residencia-no.d'),('C',0,'Tax Identification Number - TIN – Doc Trib PP.NN'),('D',0,'Identification Number - IN – Doc Trib PP. JJ'),('E',0,'TAM- Tarjeta Andina de Migración');
/*!40000 ALTER TABLE `cat_identity_document_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_mold_cavities`
--

DROP TABLE IF EXISTS `cat_item_mold_cavities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_mold_cavities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de cavidades del molde',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_mold_cavities`
--

LOCK TABLES `cat_item_mold_cavities` WRITE;
/*!40000 ALTER TABLE `cat_item_mold_cavities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_mold_cavities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_mold_properties`
--

DROP TABLE IF EXISTS `cat_item_mold_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_mold_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de propiedades por molde',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_mold_properties`
--

LOCK TABLES `cat_item_mold_properties` WRITE;
/*!40000 ALTER TABLE `cat_item_mold_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_mold_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_package_measurements`
--

DROP TABLE IF EXISTS `cat_item_package_measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_package_measurements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de medidas del paquete',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_package_measurements`
--

LOCK TABLES `cat_item_package_measurements` WRITE;
/*!40000 ALTER TABLE `cat_item_package_measurements` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_package_measurements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_product_family`
--

DROP TABLE IF EXISTS `cat_item_product_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_product_family` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de familia d eproductos',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_product_family`
--

LOCK TABLES `cat_item_product_family` WRITE;
/*!40000 ALTER TABLE `cat_item_product_family` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_product_family` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_size`
--

DROP TABLE IF EXISTS `cat_item_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_size` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de unidad de medida',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_size`
--

LOCK TABLES `cat_item_size` WRITE;
/*!40000 ALTER TABLE `cat_item_size` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_status`
--

DROP TABLE IF EXISTS `cat_item_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_status`
--

LOCK TABLES `cat_item_status` WRITE;
/*!40000 ALTER TABLE `cat_item_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_unit_business`
--

DROP TABLE IF EXISTS `cat_item_unit_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_unit_business` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de unidad de negocio',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_unit_business`
--

LOCK TABLES `cat_item_unit_business` WRITE;
/*!40000 ALTER TABLE `cat_item_unit_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_unit_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_item_units_per_package`
--

DROP TABLE IF EXISTS `cat_item_units_per_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_item_units_per_package` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de unidades por paquete',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_item_units_per_package`
--

LOCK TABLES `cat_item_units_per_package` WRITE;
/*!40000 ALTER TABLE `cat_item_units_per_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_item_units_per_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_legend_types`
--

DROP TABLE IF EXISTS `cat_legend_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_legend_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_legend_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_legend_types`
--

LOCK TABLES `cat_legend_types` WRITE;
/*!40000 ALTER TABLE `cat_legend_types` DISABLE KEYS */;
INSERT INTO `cat_legend_types` VALUES ('1000',1,'Monto en Letras'),('1002',1,'TRANSFERENCIA GRATUITA DE UN BIEN Y/O SERVICIO PRESTADO GRATUITAMENTE'),('2000',1,'COMPROBANTE DE PERCEPCIÓN'),('2001',1,'BIENES TRANSFERIDOS EN LA AMAZONÍA REGIÓN SELVA PARA SER CONSUMIDOS EN LA MISMA'),('2002',1,'SERVICIOS PRESTADOS EN LA AMAZONÍA  REGIÓN SELVA PARA SER CONSUMIDOS EN LA MISMA'),('2003',1,'CONTRATOS DE CONSTRUCCIÓN EJECUTADOS  EN LA AMAZONÍA REGIÓN SELVA'),('2004',1,'Agencia de Viaje - Paquete turístico'),('2005',1,'Venta realizada por emisor itinerante'),('2006',1,'Operación sujeta a detracción'),('2007',1,'Operación sujeta al IVAP'),('2008',1,'VENTA EXONERADA DEL IGV-ISC-IPM. PROHIBIDA LA VENTA FUERA DE LA ZONA COMERCIAL DE TACNA'),('2009',1,'PRIMERA VENTA DE MERCANCÍA IDENTIFICABLE ENTRE USUARIOS DE LA ZONA COMERCIAL'),('2010',1,'Restitucion Simplificado de Derechos Arancelarios');
/*!40000 ALTER TABLE `cat_legend_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_note_credit_types`
--

DROP TABLE IF EXISTS `cat_note_credit_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_note_credit_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_note_credit_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_note_credit_types`
--

LOCK TABLES `cat_note_credit_types` WRITE;
/*!40000 ALTER TABLE `cat_note_credit_types` DISABLE KEYS */;
INSERT INTO `cat_note_credit_types` VALUES ('01',1,'Anulación de la operación'),('02',1,'Anulación por error en el RUC'),('03',1,'Corrección por error en la descripción'),('04',1,'Descuento global'),('05',1,'Descuento por ítem'),('06',1,'Devolución total'),('07',1,'Devolución por ítem'),('08',1,'Bonificación'),('09',1,'Disminución en el valor'),('10',1,'Otros Conceptos'),('11',1,'Ajustes de operaciones de exportación'),('12',1,'Ajustes afectos al IVAP'),('13',1,'Ajustes – montos y/o fechas de pago');
/*!40000 ALTER TABLE `cat_note_credit_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_note_debit_types`
--

DROP TABLE IF EXISTS `cat_note_debit_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_note_debit_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_note_debit_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_note_debit_types`
--

LOCK TABLES `cat_note_debit_types` WRITE;
/*!40000 ALTER TABLE `cat_note_debit_types` DISABLE KEYS */;
INSERT INTO `cat_note_debit_types` VALUES ('01',1,'Intereses por mora'),('02',1,'Aumento en el valor'),('03',1,'Penalidades/ otros conceptos'),('10',1,'Ajustes de operaciones de exportación'),('11',1,'Ajustes afectos al IVAP');
/*!40000 ALTER TABLE `cat_note_debit_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_operation_types`
--

DROP TABLE IF EXISTS `cat_operation_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_operation_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `exportation` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_operation_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_operation_types`
--

LOCK TABLES `cat_operation_types` WRITE;
/*!40000 ALTER TABLE `cat_operation_types` DISABLE KEYS */;
INSERT INTO `cat_operation_types` VALUES ('0101',1,0,'Venta interna'),('0112',0,0,'Venta Interna - Sustenta Gastos Deducibles Persona Natural'),('0113',0,0,'Venta Interna - NRUS'),('0200',1,1,'Exportación de Bienes'),('0201',0,1,'Exportación de Servicios – Prestación servicios realizados íntegramente en el país'),('0202',0,1,'Exportación de Servicios – Prestación de servicios de hospedaje No Domiciliado'),('0203',0,1,'Exportación de Servicios – Transporte de navieras'),('0204',0,1,'Exportación de Servicios – Servicios a naves y aeronaves de bandera extranjera'),('0205',0,1,'Exportación de Servicios - Servicios que conformen un Paquete Turístico'),('0206',0,1,'Exportación de Servicios – Servicios complementarios al transporte de carga'),('0207',0,1,'Exportación de Servicios – Suministro de energía eléctrica a favor de sujetos domiciliados en ZED'),('0208',0,1,'Exportación de Servicios – Prestación servicios realizados parcialmente en el extranjero'),('0301',0,0,'Operaciones con Carta de porte aéreo (emitidas en el ámbito nacional)'),('0302',0,0,'Operaciones de Transporte ferroviario de pasajeros'),('0303',0,0,'Operaciones de Pago de regalía petrolera'),('0401',1,0,'Ventas no domiciliados que no califican como exportación'),('1001',1,0,'Operación Sujeta a Detracción'),('1002',0,0,'Operación Sujeta a Detracción- Recursos Hidrobiológicos'),('1003',0,0,'Operación Sujeta a Detracción- Servicios de Transporte Pasajeros'),('1004',1,0,'Operación Sujeta a Detracción- Servicios de Transporte Carga'),('2001',0,0,'Operación Sujeta a Percepción'),('0501',1,0,'Compra interna');
/*!40000 ALTER TABLE `cat_operation_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_other_tax_concept_types`
--

DROP TABLE IF EXISTS `cat_other_tax_concept_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_other_tax_concept_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_other_tax_concept_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_other_tax_concept_types`
--

LOCK TABLES `cat_other_tax_concept_types` WRITE;
/*!40000 ALTER TABLE `cat_other_tax_concept_types` DISABLE KEYS */;
INSERT INTO `cat_other_tax_concept_types` VALUES ('1000',1,'Total valor de venta - operaciones exportadas'),('1001',1,'Total valor de venta - operaciones gravadas'),('1002',1,'Total valor de venta - operaciones inafectas'),('1003',1,'Total valor de venta - operaciones exoneradas'),('1004',1,'Total valor de venta – Operaciones gratuitas'),('1005',1,'Sub total de venta'),('2001',1,'Percepciones'),('2002',1,'Retenciones'),('2003',1,'Detracciones'),('2004',1,'Bonificaciones'),('2005',1,'Total descuentos'),('3001',1,'FISE (Ley 29852) Fondo Inclusión Social Energético');
/*!40000 ALTER TABLE `cat_other_tax_concept_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_payment_method_types`
--

DROP TABLE IF EXISTS `cat_payment_method_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_payment_method_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_payment_method_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_payment_method_types`
--

LOCK TABLES `cat_payment_method_types` WRITE;
/*!40000 ALTER TABLE `cat_payment_method_types` DISABLE KEYS */;
INSERT INTO `cat_payment_method_types` VALUES ('001',1,'Depósito en cuenta'),('002',1,'Giro'),('003',1,'Transferencia de fondos'),('004',1,'Orden de pago'),('005',1,'Tarjeta de débito'),('006',1,'Tarjeta de crédito emitida en el país por una empresa del sistema financiero'),('007',1,'Cheques con la cláusula de \"NO NEGOCIABLE\", \"INTRANSFERIBLES\", \"NO A LA ORDEN\" u otra equivalente, a que se refiere el inciso g) del artículo 5° de la ley'),('008',1,'Efectivo, por operaciones en las que no existe obligación de utilizar medio de pago'),('009',1,'Efectivo, en los demás casos'),('010',1,'Medios de pago usados en comercio exterior'),('011',1,'Documentos emitidos por las EDPYMES y las cooperativas de ahorro y crédito no autorizadas a captar depósitos del público'),('012',1,'Tarjeta de crédito emitida en el país o en el exterior por una empresa no perteneciente al sistema financiero, cuyo objeto principal sea la emisión y administración de tarjetas de crédito'),('013',1,'Tarjetas de crédito emitidas en el exterior por empresas bancarias o financieras no domiciliadas'),('101',1,'Transferencias – Comercio exterior'),('102',1,'Cheques bancarios - Comercio exterior'),('103',1,'Orden de pago simple - Comercio exterior'),('104',1,'Orden de pago documentario - Comercio exterior'),('105',1,'Remesa simple - Comercio exterior'),('106',1,'Remesa documentaria - Comercio exterior'),('107',1,'Carta de crédito simple - Comercio exterior'),('108',1,'Carta de crédito documentario - Comercio exterior'),('999',1,'Otros medios de pago');
/*!40000 ALTER TABLE `cat_payment_method_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_perception_types`
--

DROP TABLE IF EXISTS `cat_perception_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_perception_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `percentage` decimal(10,2) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_perception_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_perception_types`
--

LOCK TABLES `cat_perception_types` WRITE;
/*!40000 ALTER TABLE `cat_perception_types` DISABLE KEYS */;
INSERT INTO `cat_perception_types` VALUES ('01',1,2.00,'Percepción Venta Interna'),('02',1,1.00,'Percepción a la adquisición de combustible'),('03',1,0.50,'Percepción realizada al agente de percepción con tasa especial');
/*!40000 ALTER TABLE `cat_perception_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_periods`
--

DROP TABLE IF EXISTS `cat_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_periods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `period` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Define si es dia, mes o año - D/M/Y',
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del periodo',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si esta activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_periods`
--

LOCK TABLES `cat_periods` WRITE;
/*!40000 ALTER TABLE `cat_periods` DISABLE KEYS */;
INSERT INTO `cat_periods` VALUES (1,'M','Mensual',1,NULL,NULL),(2,'Y','Anual',1,NULL,NULL);
/*!40000 ALTER TABLE `cat_periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_price_types`
--

DROP TABLE IF EXISTS `cat_price_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_price_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_price_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_price_types`
--

LOCK TABLES `cat_price_types` WRITE;
/*!40000 ALTER TABLE `cat_price_types` DISABLE KEYS */;
INSERT INTO `cat_price_types` VALUES ('01',1,'Precio unitario (incluye el IGV)'),('02',1,'Valor referencial unitario en operaciones no onerosas');
/*!40000 ALTER TABLE `cat_price_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_related_documents_types`
--

DROP TABLE IF EXISTS `cat_related_documents_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_related_documents_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_related_documents_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_related_documents_types`
--

LOCK TABLES `cat_related_documents_types` WRITE;
/*!40000 ALTER TABLE `cat_related_documents_types` DISABLE KEYS */;
INSERT INTO `cat_related_documents_types` VALUES ('01',1,'Numeración DAM'),('02',1,'Número de orden de entrega'),('03',1,'Número SCOP'),('04',1,'Número de manifiesto de carga'),('05',1,'Número de constancia de detracción'),('06',1,'Otros');
/*!40000 ALTER TABLE `cat_related_documents_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_related_tax_document_types`
--

DROP TABLE IF EXISTS `cat_related_tax_document_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_related_tax_document_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_related_tax_document_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_related_tax_document_types`
--

LOCK TABLES `cat_related_tax_document_types` WRITE;
/*!40000 ALTER TABLE `cat_related_tax_document_types` DISABLE KEYS */;
INSERT INTO `cat_related_tax_document_types` VALUES ('01',1,'Factura – emitida para corregir error en el RUC'),('02',1,'Factura – emitida por anticipos'),('03',1,'Boleta de Venta – emitida por anticipos'),('04',1,'Ticket de Salida - ENAPU'),('05',1,'Código SCOP'),('99',1,'Otros');
/*!40000 ALTER TABLE `cat_related_tax_document_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_retention_types`
--

DROP TABLE IF EXISTS `cat_retention_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_retention_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `percentage` decimal(10,2) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_retention_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_retention_types`
--

LOCK TABLES `cat_retention_types` WRITE;
/*!40000 ALTER TABLE `cat_retention_types` DISABLE KEYS */;
INSERT INTO `cat_retention_types` VALUES ('01',1,3.00,'Tasa 3%'),('02',1,6.00,'Tasa 6%');
/*!40000 ALTER TABLE `cat_retention_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_summary_status_types`
--

DROP TABLE IF EXISTS `cat_summary_status_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_summary_status_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_summary_status_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_summary_status_types`
--

LOCK TABLES `cat_summary_status_types` WRITE;
/*!40000 ALTER TABLE `cat_summary_status_types` DISABLE KEYS */;
INSERT INTO `cat_summary_status_types` VALUES ('1',1,'Adicionar'),('2',1,'Modificar'),('3',1,'Anulado');
/*!40000 ALTER TABLE `cat_summary_status_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_system_isc_types`
--

DROP TABLE IF EXISTS `cat_system_isc_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_system_isc_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_system_isc_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_system_isc_types`
--

LOCK TABLES `cat_system_isc_types` WRITE;
/*!40000 ALTER TABLE `cat_system_isc_types` DISABLE KEYS */;
INSERT INTO `cat_system_isc_types` VALUES ('01',1,'Sistema al valor'),('02',1,'Aplicación del Monto Fijo'),('03',1,'Sistema de Precios de Venta al Público');
/*!40000 ALTER TABLE `cat_system_isc_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_transfer_reason_types`
--

DROP TABLE IF EXISTS `cat_transfer_reason_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_transfer_reason_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_stock` tinyint(1) DEFAULT '0',
  KEY `cat_transfer_reason_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_transfer_reason_types`
--

LOCK TABLES `cat_transfer_reason_types` WRITE;
/*!40000 ALTER TABLE `cat_transfer_reason_types` DISABLE KEYS */;
INSERT INTO `cat_transfer_reason_types` VALUES ('01',1,'Venta',0),('02',1,'Compra',0),('04',1,'Traslado entre establecimientos de la misma empresa',0),('08',1,'Importación',0),('09',1,'Exportación',0),('13',1,'Otros',0),('14',1,'Venta sujeta a confirmación del comprador',0),('18',1,'Traslado emisor itinerante CP',0),('19',1,'Traslado a zona primaria',0);
/*!40000 ALTER TABLE `cat_transfer_reason_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_transport_mode_types`
--

DROP TABLE IF EXISTS `cat_transport_mode_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_transport_mode_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_transport_mode_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_transport_mode_types`
--

LOCK TABLES `cat_transport_mode_types` WRITE;
/*!40000 ALTER TABLE `cat_transport_mode_types` DISABLE KEYS */;
INSERT INTO `cat_transport_mode_types` VALUES ('01',1,'Transporte público'),('02',1,'Transporte privado');
/*!40000 ALTER TABLE `cat_transport_mode_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_unit_types`
--

DROP TABLE IF EXISTS `cat_unit_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_unit_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `symbol` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `cat_unit_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_unit_types`
--

LOCK TABLES `cat_unit_types` WRITE;
/*!40000 ALTER TABLE `cat_unit_types` DISABLE KEYS */;
INSERT INTO `cat_unit_types` VALUES ('ZZ',1,NULL,'Servicio'),('BX',1,NULL,'Caja'),('GLL',1,NULL,'Galones'),('GRM',1,NULL,'Gramos'),('KGM',1,NULL,'Kilos'),('LTR',1,NULL,'Litros'),('MTR',1,NULL,'Metros'),('FOT',1,NULL,'Pies'),('INH',1,NULL,'Pulgadas'),('NIU',1,NULL,'Unidades'),('YRD',1,NULL,'Yardas'),('HUR',1,NULL,'Hora');
/*!40000 ALTER TABLE `cat_unit_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_padrones`
--

DROP TABLE IF EXISTS `charge_padrones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_padrones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_padrones`
--

LOCK TABLES `charge_padrones` WRITE;
/*!40000 ALTER TABLE `charge_padrones` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_padrones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_error_types`
--

DROP TABLE IF EXISTS `client_error_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_error_types` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_error_types`
--

LOCK TABLES `client_error_types` WRITE;
/*!40000 ALTER TABLE `client_error_types` DISABLE KEYS */;
INSERT INTO `client_error_types` VALUES ('data_entry','Errores de ingreso de datos'),('token_creation','Errores en la creación del token de tarjeta');
/*!40000 ALTER TABLE `client_error_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_errors`
--

DROP TABLE IF EXISTS `client_errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_errors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_error_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_errors_client_error_type_id_foreign` (`client_error_type_id`),
  KEY `client_errors_code_index` (`code`),
  CONSTRAINT `client_errors_client_error_type_id_foreign` FOREIGN KEY (`client_error_type_id`) REFERENCES `client_error_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_errors`
--

LOCK TABLES `client_errors` WRITE;
/*!40000 ALTER TABLE `client_errors` DISABLE KEYS */;
INSERT INTO `client_errors` VALUES (1,'205','data_entry','parameter cardNumber can not be null/empty','Ingresa el número de tu tarjeta.'),(2,'208','data_entry','parameter cardExpirationMonth can not be null/empty','Elige un mes.'),(3,'209','data_entry','parameter cardExpirationYear can not be null/empty','Elige un año.'),(4,'212','data_entry','parameter docType can not be null/empty','Ingresa tu tipo de documento.'),(5,'213','data_entry','The parameter cardholder.document.subtype can not be null or empty','Ingresa tu documento.'),(6,'214','data_entry','parameter docNumber can not be null/empty','Ingresa tu documento.'),(7,'220','data_entry','parameter cardIssuerId can not be null/empty','Ingresa tu banco.'),(8,'221','data_entry','parameter cardholderName can not be null/empty','Ingresa el nombre y apellido.'),(9,'224','data_entry','parameter securityCode can not be null/empty','Ingresa el código de seguridad.'),(10,'E301','data_entry','invalid parameter cardNumber','Ingresa un número de tarjeta válido.'),(11,'E302','data_entry','invalid parameter securityCode','Revisa el código de seguridad.'),(12,'316','data_entry','invalid parameter cardholderName','Ingresa un nombre válido.'),(13,'322','data_entry','	invalid parameter docType','El tipo de documento es inválido.'),(14,'323','data_entry','invalid parameter cardholder.document.subtype','Revisa tu documento.'),(15,'324','data_entry','invalid parameter docNumber','El documento es inválido.'),(16,'325','data_entry','invalid parameter cardExpirationMonth','El mes es inválido'),(17,'326','data_entry','invalid parameter cardExpirationYear','El año es inválido'),(18,'default','data_entry','Otro código de error','Revisa los datos.'),(19,'106','token_creation','Cannot operate between users from different countries','No puedes realizar pagos a otros países.'),(20,'109','token_creation','Invalid number of shares for this payment_method_id','El medio de pago no procesa pagos en installments cuotas. Elige otra tarjeta u otro medio de pago.'),(21,'126','token_creation','The action requested is not valid for the current payment state','No pudimos procesar tu pago.'),(22,'129','token_creation','Cannot pay this amount with this paymentMethod','El medio de pago no procesa pagos del monto seleccionado. Elige otra tarjeta u otro medio de pago.'),(23,'145','token_creation','Invalid users involved','Una de las partes con la que intentas hacer el pago es de prueba y la otra es usuario real.'),(24,'150','token_creation','The payer_id cannot do payments currently','No puedes realizar pagos.'),(25,'151','token_creation','The payer_id cannot do payments with this payment_method_id','No puedes realizar pagos.'),(26,'160','token_creation','Collector not allowed to operate','No pudimos procesar tu pago.'),(27,'204','token_creation','Unavailable payment_method','El medio de pago no está disponible en este momento. Elige otra tarjeta u otro medio de pago.'),(28,'801','token_creation','Already posted the same request in the last minute','Realizaste un pago similar hace instantes. Intenta de nuevo en unos minutos.'),(29,'default','token_creation','Otro código de error','No pudimos procesar tu pago.');
/*!40000 ALTER TABLE `client_errors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `columns_to_reports`
--

DROP TABLE IF EXISTS `columns_to_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns_to_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `report` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `columns` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `columns_to_reports_user_id_foreign` (`user_id`),
  CONSTRAINT `columns_to_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns_to_reports`
--

LOCK TABLES `columns_to_reports` WRITE;
/*!40000 ALTER TABLE `columns_to_reports` DISABLE KEYS */;
INSERT INTO `columns_to_reports` VALUES (1,1,'document_index','{\"notes\": {\"title\": \"Notas C/D\", \"visible\": false}, \"total\": {\"title\": \"Total\", \"visible\": false}, \"guides\": {\"title\": \"Guias\", \"visible\": false}, \"balance\": {\"title\": \"Saldo\", \"visible\": true}, \"send_it\": {\"title\": \"Correo enviado al destinatario\", \"visible\": false}, \"dispatch\": {\"title\": \"Guía de Remisión\", \"visible\": false}, \"soap_type\": {\"title\": \"Soap\", \"visible\": false}, \"user_name\": {\"title\": \"Usuario\", \"visible\": false}, \"order_note\": {\"title\": \"Pedidos\", \"visible\": false}, \"sales_note\": {\"title\": \"Nota de ventas\", \"visible\": false}, \"total_free\": {\"title\": \"T.Gratuito\", \"visible\": false}, \"date_of_due\": {\"title\": \"F. Vencimiento\", \"visible\": false}, \"total_charge\": {\"title\": \"T.Cargos\", \"visible\": false}, \"plate_numbers\": {\"title\": \"Placa\", \"visible\": false}, \"purchase_order\": {\"title\": \"Orden de Compra\", \"visible\": false}, \"currency_type_id\": {\"title\": \"Moneda\", \"visible\": false}, \"total_exonerated\": {\"title\": \"T.Exonerado\", \"visible\": false}, \"total_unaffected\": {\"title\": \"T.Inafecto\", \"visible\": false}, \"total_exportation\": {\"title\": \"T.Exportación\", \"visible\": false}}','2026-03-14 11:13:39','2026-03-14 11:13:39');
/*!40000 ALTER TABLE `columns_to_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_send_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '01',
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soap_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_due` date DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detraction_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_store` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_firm` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_amazonia` tinyint(1) NOT NULL DEFAULT '0',
  `integrated_query_client_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integrated_query_client_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id_pse` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '8',
  `send_document_to_pse` tinyint(1) NOT NULL DEFAULT '0',
  `url_send_cdr_pse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_signature_pse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cod_digemid` text COLLATE utf8mb4_unicode_ci COMMENT 'Codigo de establecimiento DIGEMID',
  PRIMARY KEY (`id`),
  KEY `companies_identity_document_type_id_foreign` (`identity_document_type_id`),
  KEY `companies_soap_type_id_foreign` (`soap_type_id`),
  CONSTRAINT `companies_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`),
  CONSTRAINT `companies_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'6','20600206011','INJUSERV','INJUSERV','01','01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'8',0,NULL,NULL,NULL,'2026-03-14 11:06:43',NULL);
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_accounts`
--

DROP TABLE IF EXISTS `company_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subtotal_pen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_pen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `igv_pen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtotal_usd` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_usd` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `igv_usd` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_accounts`
--

LOCK TABLES `company_accounts` WRITE;
/*!40000 ALTER TABLE `company_accounts` DISABLE KEYS */;
INSERT INTO `company_accounts` VALUES (1,'70111','12121','40111','70111','12122','40111');
/*!40000 ALTER TABLE `company_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration_ecommerce`
--

DROP TABLE IF EXISTS `configuration_ecommerce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration_ecommerce` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `information_contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `information_contact_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `information_contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `information_contact_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_whatsapp` text COLLATE utf8mb4_unicode_ci,
  `script_paypal` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_youtube` text COLLATE utf8mb4_unicode_ci,
  `link_twitter` text COLLATE utf8mb4_unicode_ci,
  `link_facebook` text COLLATE utf8mb4_unicode_ci,
  `tag_support` text COLLATE utf8mb4_unicode_ci,
  `tag_dollar` text COLLATE utf8mb4_unicode_ci,
  `tag_shipping` text COLLATE utf8mb4_unicode_ci,
  `token_public_culqui` text COLLATE utf8mb4_unicode_ci,
  `token_private_culqui` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration_ecommerce`
--

LOCK TABLES `configuration_ecommerce` WRITE;
/*!40000 ALTER TABLE `configuration_ecommerce` DISABLE KEYS */;
INSERT INTO `configuration_ecommerce` VALUES (1,'Admin','admin@mail.com','01 505-5555',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `configuration_ecommerce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration_mi_tienda_pe`
--

DROP TABLE IF EXISTS `configuration_mi_tienda_pe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration_mi_tienda_pe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `establishment_id` int(10) unsigned DEFAULT '1',
  `series_order_note_id` int(10) unsigned DEFAULT '0',
  `series_document_ft_id` int(10) unsigned DEFAULT '0',
  `series_document_bt_id` int(10) unsigned DEFAULT '0',
  `user_id` int(10) unsigned DEFAULT '0',
  `payment_destination_id` int(10) unsigned DEFAULT '0',
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `autogenerate` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration_mi_tienda_pe`
--

LOCK TABLES `configuration_mi_tienda_pe` WRITE;
/*!40000 ALTER TABLE `configuration_mi_tienda_pe` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuration_mi_tienda_pe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `send_auto` tinyint(1) NOT NULL,
  `formats` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `cron` tinyint(1) NOT NULL DEFAULT '1',
  `stock` tinyint(1) NOT NULL DEFAULT '1',
  `sunat_alternate_server` tinyint(1) NOT NULL DEFAULT '0',
  `limit_documents` bigint(20) NOT NULL DEFAULT '0',
  `limit_users` bigint(20) NOT NULL DEFAULT '10',
  `locked_emission` tinyint(1) NOT NULL DEFAULT '0',
  `permission_to_edit_cpe` tinyint(1) NOT NULL DEFAULT '0',
  `customer_filter_by_seller` tinyint(1) NOT NULL DEFAULT '0',
  `detraction_amount_rounded_int` tinyint(1) NOT NULL DEFAULT '0',
  `set_address_by_establishment` tinyint(1) NOT NULL DEFAULT '0',
  `plan` json DEFAULT NULL,
  `enable_whatsapp` tinyint(1) NOT NULL DEFAULT '1',
  `phone_whatsapp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apk_url` text COLLATE utf8mb4_unicode_ci,
  `visual` json DEFAULT NULL,
  `decimal_quantity` tinyint(4) NOT NULL DEFAULT '2',
  `locked_users` tinyint(1) NOT NULL DEFAULT '0',
  `date_time_start` datetime DEFAULT NULL,
  `quantity_documents` int(11) NOT NULL,
  `locked_tenant` tinyint(1) NOT NULL DEFAULT '0',
  `compact_sidebar` tinyint(1) NOT NULL DEFAULT '0',
  `amount_plastic_bag_taxes` decimal(6,2) NOT NULL DEFAULT '0.10',
  `config_system_env` tinyint(1) NOT NULL DEFAULT '1',
  `colums_grid_item` tinyint(4) DEFAULT '4',
  `options_pos` tinyint(1) NOT NULL DEFAULT '1',
  `edit_name_product` tinyint(1) NOT NULL DEFAULT '1',
  `restrict_receipt_date` tinyint(1) NOT NULL DEFAULT '1',
  `shipping_time_days` int(11) NOT NULL DEFAULT '4',
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '10',
  `global_discount_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '03',
  `include_igv` tinyint(1) DEFAULT NULL,
  `percentage_allowance_charge` decimal(12,2) DEFAULT '0.00',
  `igv_retention_percentage` decimal(8,5) NOT NULL DEFAULT '3.00000',
  `active_allowance_charge` tinyint(1) DEFAULT '0',
  `active_warehouse_prices` tinyint(1) DEFAULT '0',
  `product_only_location` tinyint(1) DEFAULT NULL,
  `terms_condition` text COLLATE utf8mb4_unicode_ci,
  `terms_condition_sale` text COLLATE utf8mb4_unicode_ci,
  `cotizaction_finance` tinyint(1) NOT NULL DEFAULT '1',
  `quotation_allow_seller_generate_sale` tinyint(1) NOT NULL DEFAULT '0',
  `allow_edit_unit_price_to_seller` tinyint(1) NOT NULL DEFAULT '0',
  `legend_footer` tinyint(1) NOT NULL DEFAULT '0',
  `header_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination_sale` tinyint(1) NOT NULL DEFAULT '1',
  `default_document_type_03` tinyint(1) NOT NULL DEFAULT '1',
  `default_document_type_80` tinyint(1) NOT NULL DEFAULT '0',
  `search_item_by_barcode` tinyint(1) NOT NULL DEFAULT '0',
  `login` text COLLATE utf8mb4_unicode_ci,
  `navbar` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `finances` text COLLATE utf8mb4_unicode_ci,
  `smtp_encryption` text COLLATE utf8mb4_unicode_ci COMMENT 'Tipo de cifrado de correo',
  `smtp_password` text COLLATE utf8mb4_unicode_ci COMMENT 'contraseña de usuario para el envio de correo',
  `smtp_user` text COLLATE utf8mb4_unicode_ci COMMENT 'Nombre de usuario para el envio de correo',
  `smtp_port` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Puerto de correo del cliente',
  `smtp_host` text COLLATE utf8mb4_unicode_ci COMMENT 'Host de correo del cliente',
  `ticket_58` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `url_apiruc` text COLLATE utf8mb4_unicode_ci,
  `token_apiruc` text COLLATE utf8mb4_unicode_ci,
  `seller_can_create_product` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Define si los vendedores pueden crear productos',
  `seller_can_view_balance` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Define si los vendedores pueden ver el balance en finanzas',
  `seller_can_generate_sale_opportunities` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Define si los vendedores pueden crear productos',
  `update_document_on_dispaches` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Si esta activo, al momento de crear una guia, se actualiza el pdf de documentos.',
  `is_pharmacy` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Establece si se activa el modulo de farmacia',
  `auto_send_dispatchs_to_sunat` tinyint(4) DEFAULT '1' COMMENT 'define si se mandan las guias automaticamente a sunat',
  `send_data_to_other_server` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Habilita la posibilidad de enviar datos a otro servidor',
  `search_item_by_series` tinyint(1) NOT NULL DEFAULT '0',
  `mi_tienda_pe` tinyint(1) NOT NULL DEFAULT '0',
  `group_items_generate_document` tinyint(1) NOT NULL DEFAULT '1',
  `change_free_affectation_igv` tinyint(1) NOT NULL DEFAULT '0',
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'PEN' COMMENT 'Id de cat_currency_types_id',
  `select_available_price_list` tinyint(1) NOT NULL DEFAULT '0',
  `show_extra_info_to_item` tinyint(3) unsigned DEFAULT '0' COMMENT 'Habilita datos extra para item',
  `enabled_global_igv_to_purchase` tinyint(3) unsigned DEFAULT '0' COMMENT 'Habilita el igv global en la compra. Sobreescribe has_igv del item',
  `show_pdf_name` tinyint(3) unsigned DEFAULT '0' COMMENT 'Muestra el nombre de pdf en vez del producto',
  `dispatches_address_text` tinyint(3) unsigned DEFAULT '0' COMMENT 'En guias, habilita colocar la direccion de destino como texto',
  `show_items_only_user_stablishment` int(10) unsigned DEFAULT '1' COMMENT 'permite mostrar stock del alamcen de usuario',
  `name_product_pdf_to_xml` tinyint(1) NOT NULL DEFAULT '0',
  `item_name_pdf_description` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si esta activado, el nombre de pdf será por defecto la descripcion del item',
  `auto_print` tinyint(1) NOT NULL DEFAULT '0',
  `show_service_on_pos` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Permite listar al inicio, los servicios en pos',
  `pos_cost_price` tinyint(1) NOT NULL DEFAULT '1',
  `pos_history` tinyint(1) NOT NULL DEFAULT '1',
  `show_totals_on_cpe_list` tinyint(1) NOT NULL DEFAULT '0',
  `show_terms_condition_pos` tinyint(1) NOT NULL DEFAULT '0',
  `show_ticket_80` tinyint(1) NOT NULL DEFAULT '1',
  `show_ticket_58` tinyint(1) NOT NULL DEFAULT '0',
  `show_ticket_50` tinyint(1) NOT NULL DEFAULT '0',
  `show_last_price_sale` tinyint(1) NOT NULL DEFAULT '0',
  `show_logo_by_establishment` tinyint(1) NOT NULL DEFAULT '0',
  `print_new_line_to_observation` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Añade la posiblidad de colocar salto de linea en observación de pdf',
  `new_validator_pagination` mediumint(8) unsigned DEFAULT '0',
  `validate_purchase_sale_unit_price` tinyint(1) NOT NULL DEFAULT '0',
  `checked_global_igv_to_purchase` tinyint(1) NOT NULL DEFAULT '0',
  `checked_update_purchase_price` tinyint(1) NOT NULL DEFAULT '0',
  `set_global_purchase_currency_items` tinyint(1) NOT NULL DEFAULT '0',
  `set_unit_price_dispatch_related_record` tinyint(1) NOT NULL DEFAULT '0',
  `restrict_voided_send` tinyint(1) NOT NULL DEFAULT '1',
  `shipping_time_days_voided` int(11) NOT NULL DEFAULT '7',
  `enabled_tips_pos` tinyint(1) NOT NULL DEFAULT '0',
  `top_menu_a_id` int(10) unsigned DEFAULT NULL,
  `top_menu_b_id` int(10) unsigned DEFAULT NULL,
  `top_menu_c_id` int(10) unsigned DEFAULT NULL,
  `top_menu_d_id` int(10) unsigned DEFAULT NULL,
  `skin_id` int(10) unsigned NOT NULL DEFAULT '1',
  `legend_forest_to_xml` tinyint(1) NOT NULL DEFAULT '0',
  `change_currency_item` tinyint(1) NOT NULL DEFAULT '0',
  `enabled_advanced_records_search` tinyint(1) NOT NULL DEFAULT '0',
  `change_decimal_quantity_unit_price_pdf` tinyint(1) NOT NULL DEFAULT '0',
  `decimal_quantity_unit_price_pdf` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` VALUES (1,1,'default',1,1,0,0,0,0,0,0,0,0,'{\"id\": 1, \"name\": \"Ilimitado\", \"locked\": 1, \"pricing\": 99, \"created_at\": \"2026-03-13 23:23:51\", \"updated_at\": \"2026-03-13 23:23:51\", \"limit_users\": 0, \"plan_documents\": {\"0\": 1, \"1\": 2, \"2\": 3, \"3\": 4}, \"limit_documents\": 0}',1,NULL,NULL,'{\"bg\": \"white\", \"header\": \"light\", \"navbar\": \"fixed\", \"sidebars\": \"light\", \"sidebar_theme\": \"dark\"}',2,0,'2026-03-13 23:35:23',3,0,0,0.10,1,4,1,1,1,4,'10','03',NULL,0.00,3.00000,0,0,NULL,NULL,NULL,1,0,0,0,NULL,1,1,0,0,'{\"type\":\"image\",\"image\":\"http:\\/\\/injuserv.localhost\\/images\\/fondo-5.svg\",\"position_form\":\"right\",\"show_logo_in_form\":false,\"position_logo\":\"top-left\",\"show_socials\":false,\"facebook\":null,\"twitter\":null,\"instagram\":null,\"linkedin\":null}','fixed',NULL,NULL,NULL,NULL,0,NULL,0,NULL,'2026-03-14 13:36:20',NULL,NULL,0,1,0,0,0,1,0,0,0,1,0,'PEN',0,0,0,0,0,1,0,0,0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,7,0,1,15,76,NULL,2,0,0,0,0,2);
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_items`
--

DROP TABLE IF EXISTS `contract_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `contract_items_contract_id_foreign` (`contract_id`),
  KEY `contract_items_item_id_foreign` (`item_id`),
  KEY `contract_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `contract_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `contract_items_price_type_id_foreign` (`price_type_id`),
  CONSTRAINT `contract_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `contract_items_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contract_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `contract_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `contract_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_items`
--

LOCK TABLES `contract_items` WRITE;
/*!40000 ALTER TABLE `contract_items` DISABLE KEYS */;
INSERT INTO `contract_items` VALUES (3,1,1,'{\"id\": 1, \"lots\": [], \"brand\": null, \"extra\": {\"colors\": null, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"stock\": \"-7.0000\", \"colors\": [], \"is_set\": false, \"barcode\": \"000000000001\", \"has_igv\": false, \"has_isc\": false, \"category\": null, \"lot_code\": null, \"item_code\": null, \"attributes\": [], \"lots_group\": [], \"unit_price\": 14.16, \"warehouses\": [{\"stock\": \"-7.0000\", \"checked\": true, \"warehouse_id\": 1, \"warehouse_description\": \"Almacén Oficina Principal\"}], \"CatItemSize\": [], \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"lots_enabled\": false, \"presentation\": [], \"unit_type_id\": \"NIU\", \"CatItemStatus\": [], \"percentage_isc\": \"0.00\", \"series_enabled\": false, \"stock_by_extra\": {\"total\": -107, \"colors\": {\"total\": null, \"detailed\": []}, \"CatItemSize\": {\"total\": null, \"detailed\": []}, \"CatItemStatus\": {\"total\": null, \"detailed\": []}, \"CatItemMoldCavity\": {\"total\": null, \"detailed\": []}, \"CatItemMoldProperty\": {\"total\": null, \"detailed\": []}, \"CatItemUnitBusiness\": {\"total\": null, \"detailed\": []}, \"CatItemProductFamily\": {\"total\": null, \"detailed\": []}, \"CatItemUnitsPerPackage\": {\"total\": null, \"detailed\": []}, \"CatItemPackageMeasurement\": {\"total\": null, \"detailed\": []}}, \"extra_attr_name\": \"Tiempo de entrega\", \"item_unit_types\": [], \"sale_unit_price\": \"12.0000\", \"currency_type_id\": \"PEN\", \"extra_attr_value\": null, \"full_description\": \"producto 1 -\", \"name_product_pdf\": null, \"CatItemMoldCavity\": [], \"is_for_production\": false, \"calculate_quantity\": false, \"system_isc_type_id\": null, \"CatItemMoldProperty\": [], \"CatItemUnitBusiness\": [], \"purchase_unit_price\": \"0.000000\", \"CatItemProductFamily\": [], \"currency_type_symbol\": \"S/\", \"has_plastic_bag_taxes\": false, \"original_unit_type_id\": \"NIU\", \"subject_to_detraction\": false, \"warehouse_description\": \"Almacén Oficina Principal\", \"CatItemUnitsPerPackage\": [], \"amount_plastic_bag_taxes\": \"0.10\", \"CatItemPackageMeasurement\": [], \"sale_affectation_igv_type\": {\"id\": \"10\", \"free\": 0, \"active\": 1, \"description\": \"Gravado - Operación Onerosa\", \"exportation\": 0}, \"change_free_affectation_igv\": false, \"sale_affectation_igv_type_id\": \"10\", \"original_affectation_igv_type_id\": \"10\", \"purchase_affectation_igv_type_id\": \"10\"}',1.0000,12.000000,'10',12.00,18.00,2.16,NULL,0.00,0.00,0.00,0.00,0.00,0.00,2.16,'01',14.160000,12.00,0.00,0.00,14.16,'[]','[]','[]',NULL),(4,1,1,'{\"id\": 1, \"lots\": [], \"brand\": null, \"extra\": {\"colors\": null, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"stock\": \"-7.0000\", \"colors\": [], \"is_set\": false, \"barcode\": \"000000000001\", \"has_igv\": false, \"has_isc\": false, \"category\": null, \"lot_code\": null, \"item_code\": null, \"attributes\": [], \"lots_group\": [], \"unit_price\": 14.16, \"warehouses\": [{\"stock\": \"-7.0000\", \"checked\": true, \"warehouse_id\": 1, \"warehouse_description\": \"Almacén Oficina Principal\"}], \"CatItemSize\": [], \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"lots_enabled\": false, \"presentation\": [], \"unit_type_id\": \"NIU\", \"CatItemStatus\": [], \"percentage_isc\": \"0.00\", \"series_enabled\": false, \"stock_by_extra\": {\"total\": -107, \"colors\": {\"total\": null, \"detailed\": []}, \"CatItemSize\": {\"total\": null, \"detailed\": []}, \"CatItemStatus\": {\"total\": null, \"detailed\": []}, \"CatItemMoldCavity\": {\"total\": null, \"detailed\": []}, \"CatItemMoldProperty\": {\"total\": null, \"detailed\": []}, \"CatItemUnitBusiness\": {\"total\": null, \"detailed\": []}, \"CatItemProductFamily\": {\"total\": null, \"detailed\": []}, \"CatItemUnitsPerPackage\": {\"total\": null, \"detailed\": []}, \"CatItemPackageMeasurement\": {\"total\": null, \"detailed\": []}}, \"extra_attr_name\": \"Tiempo de entrega\", \"item_unit_types\": [], \"sale_unit_price\": \"12.0000\", \"currency_type_id\": \"PEN\", \"extra_attr_value\": null, \"full_description\": \"producto 1 -\", \"name_product_pdf\": null, \"CatItemMoldCavity\": [], \"is_for_production\": false, \"calculate_quantity\": false, \"system_isc_type_id\": null, \"CatItemMoldProperty\": [], \"CatItemUnitBusiness\": [], \"purchase_unit_price\": \"0.000000\", \"CatItemProductFamily\": [], \"currency_type_symbol\": \"S/\", \"has_plastic_bag_taxes\": false, \"original_unit_type_id\": \"NIU\", \"subject_to_detraction\": false, \"warehouse_description\": \"Almacén Oficina Principal\", \"CatItemUnitsPerPackage\": [], \"amount_plastic_bag_taxes\": \"0.10\", \"CatItemPackageMeasurement\": [], \"sale_affectation_igv_type\": {\"id\": \"10\", \"free\": 0, \"active\": 1, \"description\": \"Gravado - Operación Onerosa\", \"exportation\": 0}, \"change_free_affectation_igv\": false, \"sale_affectation_igv_type_id\": \"10\", \"original_affectation_igv_type_id\": \"10\", \"purchase_affectation_igv_type_id\": \"10\"}',4.0000,12.000000,'10',48.00,18.00,8.64,NULL,0.00,0.00,0.00,0.00,0.00,0.00,8.64,'01',14.160000,48.00,0.00,0.00,56.64,'[]','[]','[]',NULL);
/*!40000 ALTER TABLE `contract_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_payments`
--

DROP TABLE IF EXISTS `contract_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` decimal(12,2) DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_payments_contract_id_foreign` (`contract_id`),
  KEY `contract_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `contract_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `contract_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `contract_payments_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contract_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_payments`
--

LOCK TABLES `contract_payments` WRITE;
/*!40000 ALTER TABLE `contract_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_state_types`
--

DROP TABLE IF EXISTS `contract_state_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_state_types` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `contract_state_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_state_types`
--

LOCK TABLES `contract_state_types` WRITE;
/*!40000 ALTER TABLE `contract_state_types` DISABLE KEYS */;
INSERT INTO `contract_state_types` VALUES ('01','Registrado'),('05','Entregado'),('09','Rechazado');
/*!40000 ALTER TABLE `contract_state_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `date_of_due` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms_condition` text COLLATE utf8mb4_unicode_ci,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `quotation_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contracts_user_id_foreign` (`user_id`),
  KEY `contracts_establishment_id_foreign` (`establishment_id`),
  KEY `contracts_customer_id_foreign` (`customer_id`),
  KEY `contracts_soap_type_id_foreign` (`soap_type_id`),
  KEY `contracts_currency_type_id_foreign` (`currency_type_id`),
  KEY `contracts_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `contracts_quotation_id_foreign` (`quotation_id`),
  KEY `contracts_state_type_id_foreign` (`state_type_id`),
  CONSTRAINT `contracts_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `contracts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `contracts_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `contracts_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `contracts_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`),
  CONSTRAINT `contracts_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `contracts_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `contract_state_types` (`id`),
  CONSTRAINT `contracts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (1,1,1,'18a76e5a-c3f0-41ce-a082-af9c00ee619e',1,'{\"code\": \"0000\", \"logo\": null, \"email\": \"admin@gmail.com\", \"address\": \"-\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150101\", \"description\": \"Lima\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": \"-\", \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"district_id\": \"150101\", \"province_id\": \"1501\", \"web_address\": null, \"urbanization\": null, \"department_id\": \"15\", \"trade_address\": null, \"aditional_information\": null}','01','01','CNT','2026-03-14','13:34:21',NULL,NULL,3,'{\"name\": \"prueba\", \"email\": null, \"number\": \"10292883432\", \"address\": null, \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": null, \"description\": null}, \"province\": {\"id\": null, \"description\": null}, \"telephone\": null, \"address_id\": null, \"country_id\": \"PE\", \"department\": {\"id\": null, \"description\": null}, \"trade_name\": null, \"district_id\": null, \"province_id\": null, \"address_type\": {\"id\": null, \"description\": null}, \"department_id\": null, \"internal_code\": null, \"address_type_id\": null, \"perception_agent\": false, \"identity_document_type\": {\"id\": \"6\", \"description\": \"RUC\"}, \"identity_document_type_id\": \"6\"}','hjhjgj','10','PEN',3.453,0.00,0.00,0.00,0.00,0.00,60.00,0.00,0.00,10.80,0.00,0.00,0.00,0.00,10.80,60.00,70.80,'[]','[]',NULL,'[]',NULL,NULL,NULL,NULL,'CNT-1-20260314',NULL,NULL,NULL,'0',2,'2026-03-14 13:34:37','2026-03-14 13:36:30');
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `countries_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES ('AX','AALAND ISLANDS',1),('AF','AFGHANISTAN',1),('AL','ALBANIA',1),('DZ','ALGERIA',1),('AS','AMERICAN SAMOA',1),('AD','ANDORRA',1),('AO','ANGOLA',1),('AI','ANGUILLA',1),('AQ','ANTARCTICA',1),('AG','ANTIGUA AND BARBUDA',1),('AR','ARGENTINA',1),('AM','ARMENIA',1),('AW','ARUBA',1),('AU','AUSTRALIA',1),('AT','AUSTRIA',1),('AZ','AZERBAIJAN',1),('BS','BAHAMAS',1),('BH','BAHRAIN',1),('BD','BANGLADESH',1),('BB','BARBADOS',1),('BY','BELARUS',1),('BE','BELGIUM',1),('BZ','BELIZE',1),('BJ','BENIN',1),('BM','BERMUDA',1),('BT','BHUTAN',1),('BO','BOLIVIA',1),('BA','BOSNIA AND HERZEGOWINA',1),('BW','BOTSWANA',1),('BV','BOUVET ISLAND',1),('BR','BRAZIL',1),('IO','BRITISH INDIAN OCEAN TERRITORY',1),('BN','BRUNEI DARUSSALAM',1),('BG','BULGARIA',1),('BF','BURKINA FASO',1),('BI','BURUNDI',1),('KH','CAMBODIA',1),('CM','CAMEROON',1),('CA','CANADA',1),('CV','CAPE VERDE',1),('KY','CAYMAN ISLANDS',1),('CF','CENTRAL AFRICAN REPUBLIC',1),('TD','CHAD',1),('CL','CHILE',1),('CN','CHINA',1),('CX','CHRISTMAS ISLAND',1),('CC','COCOS (KEELING) ISLANDS',1),('CO','COLOMBIA',1),('KM','COMOROS',1),('CD','CONGO, Democratic Republic of (was Zaire)',1),('CG','CONGO, Republic of',1),('CK','COOK ISLANDS',1),('CR','COSTA RICA',1),('CI','COTE D`IVOIRE',1),('HR','CROATIA (local name: Hrvatska)',1),('CU','CUBA',1),('CY','CYPRUS',1),('CZ','CZECH REPUBLIC',1),('DK','DENMARK',1),('DJ','DJIBOUTI',1),('DM','DOMINICA',1),('DO','DOMINICAN REPUBLIC',1),('EC','ECUADOR',1),('EG','EGYPT',1),('SV','EL SALVADOR',1),('GQ','EQUATORIAL GUINEA',1),('ER','ERITREA',1),('EE','ESTONIA',1),('ET','ETHIOPIA',1),('FK','FALKLAND ISLANDS (MALVINAS)',1),('FO','FAROE ISLANDS',1),('FJ','FIJI',1),('FI','FINLAND',1),('FR','FRANCE',1),('GF','FRENCH GUIANA',1),('PF','FRENCH POLYNESIA',1),('TF','FRENCH SOUTHERN TERRITORIES',1),('GA','GABON',1),('GM','GAMBIA',1),('GE','GEORGIA',1),('DE','GERMANY',1),('GH','GHANA',1),('GI','GIBRALTAR',1),('GR','GREECE',1),('GL','GREENLAND',1),('GD','GRENADA',1),('GP','GUADELOUPE',1),('GU','GUAM',1),('GT','GUATEMALA',1),('GN','GUINEA',1),('GW','GUINEA-BISSAU',1),('GY','GUYANA',1),('HT','HAITI',1),('HM','HEARD AND MC DONALD ISLANDS',1),('HN','HONDURAS',1),('HK','HONG KONG',1),('HU','HUNGARY',1),('IS','ICELAND',1),('IN','INDIA',1),('ID','INDONESIA',1),('IR','IRAN (ISLAMIC REPUBLIC OF)',1),('IQ','IRAQ',1),('IE','IRELAND',1),('IL','ISRAEL',1),('IT','ITALY',1),('JM','JAMAICA',1),('JP','JAPAN',1),('JO','JORDAN',1),('KZ','KAZAKHSTAN',1),('KE','KENYA',1),('KI','KIRIBATI',1),('KP','KOREA, DEMOCRATIC PEOPLE`S REPUBLIC OF',1),('KR','KOREA, REPUBLIC OF',1),('KW','KUWAIT',1),('KG','KYRGYZSTAN',1),('LA','LAO PEOPLE`S DEMOCRATIC REPUBLIC',1),('LV','LATVIA',1),('LB','LEBANON',1),('LS','LESOTHO',1),('LR','LIBERIA',1),('LY','LIBYAN ARAB JAMAHIRIYA',1),('LI','LIECHTENSTEIN',1),('LT','LITHUANIA',1),('LU','LUXEMBOURG',1),('MO','MACAU',1),('MK','MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF',1),('MG','MADAGASCAR',1),('MW','MALAWI',1),('MY','MALAYSIA',1),('MV','MALDIVES',1),('ML','MALI',1),('MT','MALTA',1),('MH','MARSHALL ISLANDS',1),('MQ','MARTINIQUE',1),('MR','MAURITANIA',1),('MU','MAURITIUS',1),('YT','MAYOTTE',1),('MX','MEXICO',1),('FM','MICRONESIA, FEDERATED STATES OF',1),('MD','MOLDOVA, REPUBLIC OF',1),('MC','MONACO',1),('MN','MONGOLIA',1),('MS','MONTSERRAT',1),('MA','MOROCCO',1),('MZ','MOZAMBIQUE',1),('MM','MYANMAR',1),('NA','NAMIBIA',1),('NR','NAURU',1),('NP','NEPAL',1),('NL','NETHERLANDS',1),('AN','NETHERLANDS ANTILLES',1),('NC','NEW CALEDONIA',1),('NZ','NEW ZEALAND',1),('NI','NICARAGUA',1),('NE','NIGER',1),('NG','NIGERIA',1),('NU','NIUE',1),('NF','NORFOLK ISLAND',1),('MP','NORTHERN MARIANA ISLANDS',1),('NO','NORWAY',1),('OM','OMAN',1),('PK','PAKISTAN',1),('PW','PALAU',1),('PS','PALESTINIAN TERRITORY, Occupied',1),('PA','PANAMA',1),('PG','PAPUA NEW GUINEA',1),('PY','PARAGUAY',1),('PE','PERU',1),('PH','PHILIPPINES',1),('PN','PITCAIRN',1),('PL','POLAND',1),('PT','PORTUGAL',1),('PR','PUERTO RICO',1),('QA','QATAR',1),('RE','REUNION',1),('RO','ROMANIA',1),('RU','RUSSIAN FEDERATION',1),('RW','RWANDA',1),('SH','SAINT HELENA',1),('KN','SAINT KITTS AND NEVIS',1),('LC','SAINT LUCIA',1),('PM','SAINT PIERRE AND MIQUELON',1),('VC','SAINT VINCENT AND THE GRENADINES',1),('WS','SAMOA',1),('SM','SAN MARINO',1),('ST','SAO TOME AND PRINCIPE',1),('SA','SAUDI ARABIA',1),('SN','SENEGAL',1),('CS','SERBIA AND MONTENEGRO',1),('SC','SEYCHELLES',1),('SL','SIERRA LEONE',1),('SG','SINGAPORE',1),('SK','SLOVAKIA',1),('SI','SLOVENIA',1),('SB','SOLOMON ISLANDS',1),('SO','SOMALIA',1),('ZA','SOUTH AFRICA',1),('GS','SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',1),('ES','SPAIN',1),('LK','SRI LANKA',1),('SD','SUDAN',1),('SR','SURINAME',1),('SJ','SVALBARD AND JAN MAYEN ISLANDS',1),('SZ','SWAZILAND',1),('SE','SWEDEN',1),('CH','SWITZERLAND',1),('SY','SYRIAN ARAB REPUBLIC',1),('TW','TAIWAN',1),('TJ','TAJIKISTAN',1),('TZ','TANZANIA, UNITED REPUBLIC OF',1),('TH','THAILAND',1),('TL','TIMOR-LESTE',1),('TG','TOGO',1),('TK','TOKELAU',1),('TO','TONGA',1),('TT','TRINIDAD AND TOBAGO',1),('TN','TUNISIA',1),('TR','TURKEY',1),('TM','TURKMENISTAN',1),('TC','TURKS AND CAICOS ISLANDS',1),('TV','TUVALU',1),('UG','UGANDA',1),('UA','UKRAINE',1),('AE','UNITED ARAB EMIRATES',1),('GB','UNITED KINGDOM',1),('US','UNITED STATES',1),('UM','UNITED STATES MINOR OUTLYING ISLANDS',1),('UY','URUGUAY',1),('UZ','UZBEKISTAN',1),('VU','VANUATU',1),('VA','VATICAN CITY STATE (HOLY SEE)',1),('VE','VENEZUELA',1),('VN','VIET NAM',1),('VG','VIRGIN ISLANDS (BRITISH)',1),('VI','VIRGIN ISLANDS (U.S.)',1),('WF','WALLIS AND FUTUNA ISLANDS',1),('EH','WESTERN SAHARA',1),('YE','YEMEN',1),('ZM','ZAMBIA',1),('ZW','ZIMBABWE',1);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `departments_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('01','AMAZONAS',1),('02','ÁNCASH',1),('03','APURIMAC',1),('04','AREQUIPA',1),('05','AYACUCHO',1),('06','CAJAMARCA',1),('07','CALLAO',1),('08','CUSCO',1),('09','HUANCAVELICA',1),('10','HUÁNUCO',1),('11','ICA',1),('12','JUNÍN',1),('13','LA LIBERTAD',1),('14','LAMBAYEQUE',1),('15','LIMA',1),('16','LORETO',1),('17','MADRE DE DIOS',1),('18','MOQUEGUA',1),('19','PASCO',1),('20','PIURA',1),('21','PUNO',1),('22','SAN MARTIN',1),('23','TACNA',1),('24','TUMBES',1),('25','UCAYALI',1);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolution_items`
--

DROP TABLE IF EXISTS `devolution_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolution_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `devolution_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `devolution_items_devolution_id_foreign` (`devolution_id`),
  KEY `devolution_items_item_id_foreign` (`item_id`),
  CONSTRAINT `devolution_items_devolution_id_foreign` FOREIGN KEY (`devolution_id`) REFERENCES `devolutions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `devolution_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolution_items`
--

LOCK TABLES `devolution_items` WRITE;
/*!40000 ALTER TABLE `devolution_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolution_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolution_reasons`
--

DROP TABLE IF EXISTS `devolution_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolution_reasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolution_reasons`
--

LOCK TABLES `devolution_reasons` WRITE;
/*!40000 ALTER TABLE `devolution_reasons` DISABLE KEYS */;
INSERT INTO `devolution_reasons` VALUES (1,'Productos vencidos',NULL,NULL),(2,'Productos dañados',NULL,NULL),(3,'Productos con errores de Fábrica',NULL,NULL);
/*!40000 ALTER TABLE `devolution_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolutions`
--

DROP TABLE IF EXISTS `devolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolutions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `devolution_reason_id` int(10) unsigned NOT NULL,
  `observation` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devolutions_user_id_foreign` (`user_id`),
  KEY `devolutions_establishment_id_foreign` (`establishment_id`),
  KEY `devolutions_devolution_reason_id_foreign` (`devolution_reason_id`),
  KEY `devolutions_soap_type_id_foreign` (`soap_type_id`),
  KEY `devolutions_state_type_id_foreign` (`state_type_id`),
  CONSTRAINT `devolutions_devolution_reason_id_foreign` FOREIGN KEY (`devolution_reason_id`) REFERENCES `devolution_reasons` (`id`),
  CONSTRAINT `devolutions_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `devolutions_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `devolutions_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `devolutions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolutions`
--

LOCK TABLES `devolutions` WRITE;
/*!40000 ALTER TABLE `devolutions` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispatch_items`
--

DROP TABLE IF EXISTS `dispatch_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispatch_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dispatch_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `dispatch_items_dispatch_id_foreign` (`dispatch_id`),
  KEY `dispatch_items_item_id_foreign` (`item_id`),
  CONSTRAINT `dispatch_items_dispatch_id_foreign` FOREIGN KEY (`dispatch_id`) REFERENCES `dispatches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dispatch_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispatch_items`
--

LOCK TABLES `dispatch_items` WRITE;
/*!40000 ALTER TABLE `dispatch_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatch_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispatchers`
--

DROP TABLE IF EXISTS `dispatchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispatchers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dispatchers_identity_document_type_id_foreign` (`identity_document_type_id`),
  KEY `dispatchers_number_index` (`number`),
  KEY `dispatchers_name_index` (`name`),
  CONSTRAINT `dispatchers_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispatchers`
--

LOCK TABLES `dispatchers` WRITE;
/*!40000 ALTER TABLE `dispatchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispatches`
--

DROP TABLE IF EXISTS `dispatches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispatches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_sale_note_id` int(10) unsigned DEFAULT NULL,
  `reference_document_id` int(10) unsigned DEFAULT NULL,
  `reference_quotation_id` int(10) unsigned DEFAULT NULL,
  `reference_order_form_id` int(10) unsigned DEFAULT NULL,
  `reference_order_note_id` int(10) unsigned DEFAULT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `transport_mode_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transfer_reason_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transfer_reason_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_shipping` date NOT NULL,
  `transshipment_indicator` tinyint(1) NOT NULL,
  `port_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_weight` decimal(10,2) NOT NULL,
  `packages_number` int(11) DEFAULT NULL,
  `container_number` int(11) DEFAULT NULL,
  `related` json DEFAULT NULL COMMENT 'Numero de DAM',
  `origin` json NOT NULL,
  `delivery` json NOT NULL,
  `dispatcher` json DEFAULT NULL,
  `driver` json DEFAULT NULL,
  `order_form_external` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_plate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secondary_license_plates` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `optional` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_shipping_response` json DEFAULT NULL,
  `send_to_pse` tinyint(1) NOT NULL DEFAULT '0',
  `response_signature_pse` json DEFAULT NULL,
  `response_send_cdr_pse` json DEFAULT NULL,
  `has_xml` tinyint(1) NOT NULL DEFAULT '0',
  `has_pdf` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `document_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `data_affected_document` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `dispatches_user_id_foreign` (`user_id`),
  KEY `dispatches_establishment_id_foreign` (`establishment_id`),
  KEY `dispatches_soap_type_id_foreign` (`soap_type_id`),
  KEY `dispatches_state_type_id_foreign` (`state_type_id`),
  KEY `dispatches_document_type_id_foreign` (`document_type_id`),
  KEY `dispatches_customer_id_foreign` (`customer_id`),
  KEY `dispatches_unit_type_id_foreign` (`unit_type_id`),
  KEY `dispatches_transport_mode_type_id_foreign` (`transport_mode_type_id`),
  KEY `dispatches_transfer_reason_type_id_foreign` (`transfer_reason_type_id`),
  KEY `dispatches_document_id_foreign` (`document_id`),
  CONSTRAINT `dispatches_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `dispatches_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dispatches_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `dispatches_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `dispatches_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `dispatches_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `dispatches_transfer_reason_type_id_foreign` FOREIGN KEY (`transfer_reason_type_id`) REFERENCES `cat_transfer_reason_types` (`id`),
  CONSTRAINT `dispatches_transport_mode_type_id_foreign` FOREIGN KEY (`transport_mode_type_id`) REFERENCES `cat_transport_mode_types` (`id`),
  CONSTRAINT `dispatches_unit_type_id_foreign` FOREIGN KEY (`unit_type_id`) REFERENCES `cat_unit_types` (`id`),
  CONSTRAINT `dispatches_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispatches`
--

LOCK TABLES `dispatches` WRITE;
/*!40000 ALTER TABLE `dispatches` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districts` (
  `id` char(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_id` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `districts_province_id_foreign` (`province_id`),
  KEY `districts_id_index` (`id`),
  CONSTRAINT `districts_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES ('010101','0101','Chachapoyas',1),('010102','0101','Asunción',1),('010103','0101','Balsas',1),('010104','0101','Cheto',1),('010105','0101','Chiliquin',1),('010106','0101','Chuquibamba',1),('010107','0101','Granada',1),('010108','0101','Huancas',1),('010109','0101','La Jalca',1),('010110','0101','Leimebamba',1),('010111','0101','Levanto',1),('010112','0101','Magdalena',1),('010113','0101','Mariscal Castilla',1),('010114','0101','Molinopampa',1),('010115','0101','Montevideo',1),('010116','0101','Olleros',1),('010117','0101','Quinjalca',1),('010118','0101','San Francisco de Daguas',1),('010119','0101','San Isidro de Maino',1),('010120','0101','Soloco',1),('010121','0101','Sonche',1),('010201','0102','Bagua',1),('010202','0102','Aramango',1),('010203','0102','Copallin',1),('010204','0102','El Parco',1),('010205','0102','Imaza',1),('010206','0102','La Peca',1),('010301','0103','Jumbilla',1),('010302','0103','Chisquilla',1),('010303','0103','Churuja',1),('010304','0103','Corosha',1),('010305','0103','Cuispes',1),('010306','0103','Florida',1),('010307','0103','Jazan',1),('010308','0103','Recta',1),('010309','0103','San Carlos',1),('010310','0103','Shipasbamba',1),('010311','0103','Valera',1),('010312','0103','Yambrasbamba',1),('010401','0104','Nieva',1),('010402','0104','El Cenepa',1),('010403','0104','Río Santiago',1),('010501','0105','Lamud',1),('010502','0105','Camporredondo',1),('010503','0105','Cocabamba',1),('010504','0105','Colcamar',1),('010505','0105','Conila',1),('010506','0105','Inguilpata',1),('010507','0105','Longuita',1),('010508','0105','Lonya Chico',1),('010509','0105','Luya',1),('010510','0105','Luya Viejo',1),('010511','0105','María',1),('010512','0105','Ocalli',1),('010513','0105','Ocumal',1),('010514','0105','Pisuquia',1),('010515','0105','Providencia',1),('010516','0105','San Cristóbal',1),('010517','0105','San Francisco de Yeso',1),('010518','0105','San Jerónimo',1),('010519','0105','San Juan de Lopecancha',1),('010520','0105','Santa Catalina',1),('010521','0105','Santo Tomas',1),('010522','0105','Tingo',1),('010523','0105','Trita',1),('010601','0106','San Nicolás',1),('010602','0106','Chirimoto',1),('010603','0106','Cochamal',1),('010604','0106','Huambo',1),('010605','0106','Limabamba',1),('010606','0106','Longar',1),('010607','0106','Mariscal Benavides',1),('010608','0106','Milpuc',1),('010609','0106','Omia',1),('010610','0106','Santa Rosa',1),('010611','0106','Totora',1),('010612','0106','Vista Alegre',1),('010701','0107','Bagua Grande',1),('010702','0107','Cajaruro',1),('010703','0107','Cumba',1),('010704','0107','El Milagro',1),('010705','0107','Jamalca',1),('010706','0107','Lonya Grande',1),('010707','0107','Yamon',1),('020101','0201','Huaraz',1),('020102','0201','Cochabamba',1),('020103','0201','Colcabamba',1),('020104','0201','Huanchay',1),('020105','0201','Independencia',1),('020106','0201','Jangas',1),('020107','0201','La Libertad',1),('020108','0201','Olleros',1),('020109','0201','Pampas Grande',1),('020110','0201','Pariacoto',1),('020111','0201','Pira',1),('020112','0201','Tarica',1),('020201','0202','Aija',1),('020202','0202','Coris',1),('020203','0202','Huacllan',1),('020204','0202','La Merced',1),('020205','0202','Succha',1),('020301','0203','Llamellin',1),('020302','0203','Aczo',1),('020303','0203','Chaccho',1),('020304','0203','Chingas',1),('020305','0203','Mirgas',1),('020306','0203','San Juan de Rontoy',1),('020401','0204','Chacas',1),('020402','0204','Acochaca',1),('020501','0205','Chiquian',1),('020502','0205','Abelardo Pardo Lezameta',1),('020503','0205','Antonio Raymondi',1),('020504','0205','Aquia',1),('020505','0205','Cajacay',1),('020506','0205','Canis',1),('020507','0205','Colquioc',1),('020508','0205','Huallanca',1),('020509','0205','Huasta',1),('020510','0205','Huayllacayan',1),('020511','0205','La Primavera',1),('020512','0205','Mangas',1),('020513','0205','Pacllon',1),('020514','0205','San Miguel de Corpanqui',1),('020515','0205','Ticllos',1),('020601','0206','Carhuaz',1),('020602','0206','Acopampa',1),('020603','0206','Amashca',1),('020604','0206','Anta',1),('020605','0206','Ataquero',1),('020606','0206','Marcara',1),('020607','0206','Pariahuanca',1),('020608','0206','San Miguel de Aco',1),('020609','0206','Shilla',1),('020610','0206','Tinco',1),('020611','0206','Yungar',1),('020701','0207','San Luis',1),('020702','0207','San Nicolás',1),('020703','0207','Yauya',1),('020801','0208','Casma',1),('020802','0208','Buena Vista Alta',1),('020803','0208','Comandante Noel',1),('020804','0208','Yautan',1),('020901','0209','Corongo',1),('020902','0209','Aco',1),('020903','0209','Bambas',1),('020904','0209','Cusca',1),('020905','0209','La Pampa',1),('020906','0209','Yanac',1),('020907','0209','Yupan',1),('021001','0210','Huari',1),('021002','0210','Anra',1),('021003','0210','Cajay',1),('021004','0210','Chavin de Huantar',1),('021005','0210','Huacachi',1),('021006','0210','Huacchis',1),('021007','0210','Huachis',1),('021008','0210','Huantar',1),('021009','0210','Masin',1),('021010','0210','Paucas',1),('021011','0210','Ponto',1),('021012','0210','Rahuapampa',1),('021013','0210','Rapayan',1),('021014','0210','San Marcos',1),('021015','0210','San Pedro de Chana',1),('021016','0210','Uco',1),('021101','0211','Huarmey',1),('021102','0211','Cochapeti',1),('021103','0211','Culebras',1),('021104','0211','Huayan',1),('021105','0211','Malvas',1),('021201','0212','Caraz',1),('021202','0212','Huallanca',1),('021203','0212','Huata',1),('021204','0212','Huaylas',1),('021205','0212','Mato',1),('021206','0212','Pamparomas',1),('021207','0212','Pueblo Libre',1),('021208','0212','Santa Cruz',1),('021209','0212','Santo Toribio',1),('021210','0212','Yuracmarca',1),('021301','0213','Piscobamba',1),('021302','0213','Casca',1),('021303','0213','Eleazar Guzmán Barron',1),('021304','0213','Fidel Olivas Escudero',1),('021305','0213','Llama',1),('021306','0213','Llumpa',1),('021307','0213','Lucma',1),('021308','0213','Musga',1),('021401','0214','Ocros',1),('021402','0214','Acas',1),('021403','0214','Cajamarquilla',1),('021404','0214','Carhuapampa',1),('021405','0214','Cochas',1),('021406','0214','Congas',1),('021407','0214','Llipa',1),('021408','0214','San Cristóbal de Rajan',1),('021409','0214','San Pedro',1),('021410','0214','Santiago de Chilcas',1),('021501','0215','Cabana',1),('021502','0215','Bolognesi',1),('021503','0215','Conchucos',1),('021504','0215','Huacaschuque',1),('021505','0215','Huandoval',1),('021506','0215','Lacabamba',1),('021507','0215','Llapo',1),('021508','0215','Pallasca',1),('021509','0215','Pampas',1),('021510','0215','Santa Rosa',1),('021511','0215','Tauca',1),('021601','0216','Pomabamba',1),('021602','0216','Huayllan',1),('021603','0216','Parobamba',1),('021604','0216','Quinuabamba',1),('021701','0217','Recuay',1),('021702','0217','Catac',1),('021703','0217','Cotaparaco',1),('021704','0217','Huayllapampa',1),('021705','0217','Llacllin',1),('021706','0217','Marca',1),('021707','0217','Pampas Chico',1),('021708','0217','Pararin',1),('021709','0217','Tapacocha',1),('021710','0217','Ticapampa',1),('021801','0218','Chimbote',1),('021802','0218','Cáceres del Perú',1),('021803','0218','Coishco',1),('021804','0218','Macate',1),('021805','0218','Moro',1),('021806','0218','Nepeña',1),('021807','0218','Samanco',1),('021808','0218','Santa',1),('021809','0218','Nuevo Chimbote',1),('021901','0219','Sihuas',1),('021902','0219','Acobamba',1),('021903','0219','Alfonso Ugarte',1),('021904','0219','Cashapampa',1),('021905','0219','Chingalpo',1),('021906','0219','Huayllabamba',1),('021907','0219','Quiches',1),('021908','0219','Ragash',1),('021909','0219','San Juan',1),('021910','0219','Sicsibamba',1),('022001','0220','Yungay',1),('022002','0220','Cascapara',1),('022003','0220','Mancos',1),('022004','0220','Matacoto',1),('022005','0220','Quillo',1),('022006','0220','Ranrahirca',1),('022007','0220','Shupluy',1),('022008','0220','Yanama',1),('030101','0301','Abancay',1),('030102','0301','Chacoche',1),('030103','0301','Circa',1),('030104','0301','Curahuasi',1),('030105','0301','Huanipaca',1),('030106','0301','Lambrama',1),('030107','0301','Pichirhua',1),('030108','0301','San Pedro de Cachora',1),('030109','0301','Tamburco',1),('030201','0302','Andahuaylas',1),('030202','0302','Andarapa',1),('030203','0302','Chiara',1),('030204','0302','Huancarama',1),('030205','0302','Huancaray',1),('030206','0302','Huayana',1),('030207','0302','Kishuara',1),('030208','0302','Pacobamba',1),('030209','0302','Pacucha',1),('030210','0302','Pampachiri',1),('030211','0302','Pomacocha',1),('030212','0302','San Antonio de Cachi',1),('030213','0302','San Jerónimo',1),('030214','0302','San Miguel de Chaccrampa',1),('030215','0302','Santa María de Chicmo',1),('030216','0302','Talavera',1),('030217','0302','Tumay Huaraca',1),('030218','0302','Turpo',1),('030219','0302','Kaquiabamba',1),('030220','0302','José María Arguedas',1),('030301','0303','Antabamba',1),('030302','0303','El Oro',1),('030303','0303','Huaquirca',1),('030304','0303','Juan Espinoza Medrano',1),('030305','0303','Oropesa',1),('030306','0303','Pachaconas',1),('030307','0303','Sabaino',1),('030401','0304','Chalhuanca',1),('030402','0304','Capaya',1),('030403','0304','Caraybamba',1),('030404','0304','Chapimarca',1),('030405','0304','Colcabamba',1),('030406','0304','Cotaruse',1),('030407','0304','Ihuayllo',1),('030408','0304','Justo Apu Sahuaraura',1),('030409','0304','Lucre',1),('030410','0304','Pocohuanca',1),('030411','0304','San Juan de Chacña',1),('030412','0304','Sañayca',1),('030413','0304','Soraya',1),('030414','0304','Tapairihua',1),('030415','0304','Tintay',1),('030416','0304','Toraya',1),('030417','0304','Yanaca',1),('030501','0305','Tambobamba',1),('030502','0305','Cotabambas',1),('030503','0305','Coyllurqui',1),('030504','0305','Haquira',1),('030505','0305','Mara',1),('030506','0305','Challhuahuacho',1),('030601','0306','Chincheros',1),('030602','0306','Anco_Huallo',1),('030603','0306','Cocharcas',1),('030604','0306','Huaccana',1),('030605','0306','Ocobamba',1),('030606','0306','Ongoy',1),('030607','0306','Uranmarca',1),('030608','0306','Ranracancha',1),('030609','0306','Rocchacc',1),('030610','0306','El Porvenir',1),('030701','0307','Chuquibambilla',1),('030702','0307','Curpahuasi',1),('030703','0307','Gamarra',1),('030704','0307','Huayllati',1),('030705','0307','Mamara',1),('030706','0307','Micaela Bastidas',1),('030707','0307','Pataypampa',1),('030708','0307','Progreso',1),('030709','0307','San Antonio',1),('030710','0307','Santa Rosa',1),('030711','0307','Turpay',1),('030712','0307','Vilcabamba',1),('030713','0307','Virundo',1),('030714','0307','Curasco',1),('040101','0401','Arequipa',1),('040102','0401','Alto Selva Alegre',1),('040103','0401','Cayma',1),('040104','0401','Cerro Colorado',1),('040105','0401','Characato',1),('040106','0401','Chiguata',1),('040107','0401','Jacobo Hunter',1),('040108','0401','La Joya',1),('040109','0401','Mariano Melgar',1),('040110','0401','Miraflores',1),('040111','0401','Mollebaya',1),('040112','0401','Paucarpata',1),('040113','0401','Pocsi',1),('040114','0401','Polobaya',1),('040115','0401','Quequeña',1),('040116','0401','Sabandia',1),('040117','0401','Sachaca',1),('040118','0401','San Juan de Siguas',1),('040119','0401','San Juan de Tarucani',1),('040120','0401','Santa Isabel de Siguas',1),('040121','0401','Santa Rita de Siguas',1),('040122','0401','Socabaya',1),('040123','0401','Tiabaya',1),('040124','0401','Uchumayo',1),('040125','0401','Vitor',1),('040126','0401','Yanahuara',1),('040127','0401','Yarabamba',1),('040128','0401','Yura',1),('040129','0401','José Luis Bustamante Y Rivero',1),('040201','0402','Camaná',1),('040202','0402','José María Quimper',1),('040203','0402','Mariano Nicolás Valcárcel',1),('040204','0402','Mariscal Cáceres',1),('040205','0402','Nicolás de Pierola',1),('040206','0402','Ocoña',1),('040207','0402','Quilca',1),('040208','0402','Samuel Pastor',1),('040301','0403','Caravelí',1),('040302','0403','Acarí',1),('040303','0403','Atico',1),('040304','0403','Atiquipa',1),('040305','0403','Bella Unión',1),('040306','0403','Cahuacho',1),('040307','0403','Chala',1),('040308','0403','Chaparra',1),('040309','0403','Huanuhuanu',1),('040310','0403','Jaqui',1),('040311','0403','Lomas',1),('040312','0403','Quicacha',1),('040313','0403','Yauca',1),('040401','0404','Aplao',1),('040402','0404','Andagua',1),('040403','0404','Ayo',1),('040404','0404','Chachas',1),('040405','0404','Chilcaymarca',1),('040406','0404','Choco',1),('040407','0404','Huancarqui',1),('040408','0404','Machaguay',1),('040409','0404','Orcopampa',1),('040410','0404','Pampacolca',1),('040411','0404','Tipan',1),('040412','0404','Uñon',1),('040413','0404','Uraca',1),('040414','0404','Viraco',1),('040501','0405','Chivay',1),('040502','0405','Achoma',1),('040503','0405','Cabanaconde',1),('040504','0405','Callalli',1),('040505','0405','Caylloma',1),('040506','0405','Coporaque',1),('040507','0405','Huambo',1),('040508','0405','Huanca',1),('040509','0405','Ichupampa',1),('040510','0405','Lari',1),('040511','0405','Lluta',1),('040512','0405','Maca',1),('040513','0405','Madrigal',1),('040514','0405','San Antonio de Chuca',1),('040515','0405','Sibayo',1),('040516','0405','Tapay',1),('040517','0405','Tisco',1),('040518','0405','Tuti',1),('040519','0405','Yanque',1),('040520','0405','Majes',1),('040601','0406','Chuquibamba',1),('040602','0406','Andaray',1),('040603','0406','Cayarani',1),('040604','0406','Chichas',1),('040605','0406','Iray',1),('040606','0406','Río Grande',1),('040607','0406','Salamanca',1),('040608','0406','Yanaquihua',1),('040701','0407','Mollendo',1),('040702','0407','Cocachacra',1),('040703','0407','Dean Valdivia',1),('040704','0407','Islay',1),('040705','0407','Mejia',1),('040706','0407','Punta de Bombón',1),('040801','0408','Cotahuasi',1),('040802','0408','Alca',1),('040803','0408','Charcana',1),('040804','0408','Huaynacotas',1),('040805','0408','Pampamarca',1),('040806','0408','Puyca',1),('040807','0408','Quechualla',1),('040808','0408','Sayla',1),('040809','0408','Tauria',1),('040810','0408','Tomepampa',1),('040811','0408','Toro',1),('050101','0501','Ayacucho',1),('050102','0501','Acocro',1),('050103','0501','Acos Vinchos',1),('050104','0501','Carmen Alto',1),('050105','0501','Chiara',1),('050106','0501','Ocros',1),('050107','0501','Pacaycasa',1),('050108','0501','Quinua',1),('050109','0501','San José de Ticllas',1),('050110','0501','San Juan Bautista',1),('050111','0501','Santiago de Pischa',1),('050112','0501','Socos',1),('050113','0501','Tambillo',1),('050114','0501','Vinchos',1),('050115','0501','Jesús Nazareno',1),('050116','0501','Andrés Avelino Cáceres Dorregaray',1),('050201','0502','Cangallo',1),('050202','0502','Chuschi',1),('050203','0502','Los Morochucos',1),('050204','0502','María Parado de Bellido',1),('050205','0502','Paras',1),('050206','0502','Totos',1),('050301','0503','Sancos',1),('050302','0503','Carapo',1),('050303','0503','Sacsamarca',1),('050304','0503','Santiago de Lucanamarca',1),('050401','0504','Huanta',1),('050402','0504','Ayahuanco',1),('050403','0504','Huamanguilla',1),('050404','0504','Iguain',1),('050405','0504','Luricocha',1),('050406','0504','Santillana',1),('050407','0504','Sivia',1),('050408','0504','Llochegua',1),('050409','0504','Canayre',1),('050410','0504','Uchuraccay',1),('050411','0504','Pucacolpa',1),('050412','0504','Chaca',1),('050501','0505','San Miguel',1),('050502','0505','Anco',1),('050503','0505','Ayna',1),('050504','0505','Chilcas',1),('050505','0505','Chungui',1),('050506','0505','Luis Carranza',1),('050507','0505','Santa Rosa',1),('050508','0505','Tambo',1),('050509','0505','Samugari',1),('050510','0505','Anchihuay',1),('050601','0506','Puquio',1),('050602','0506','Aucara',1),('050603','0506','Cabana',1),('050604','0506','Carmen Salcedo',1),('050605','0506','Chaviña',1),('050606','0506','Chipao',1),('050607','0506','Huac-Huas',1),('050608','0506','Laramate',1),('050609','0506','Leoncio Prado',1),('050610','0506','Llauta',1),('050611','0506','Lucanas',1),('050612','0506','Ocaña',1),('050613','0506','Otoca',1),('050614','0506','Saisa',1),('050615','0506','San Cristóbal',1),('050616','0506','San Juan',1),('050617','0506','San Pedro',1),('050618','0506','San Pedro de Palco',1),('050619','0506','Sancos',1),('050620','0506','Santa Ana de Huaycahuacho',1),('050621','0506','Santa Lucia',1),('050701','0507','Coracora',1),('050702','0507','Chumpi',1),('050703','0507','Coronel Castañeda',1),('050704','0507','Pacapausa',1),('050705','0507','Pullo',1),('050706','0507','Puyusca',1),('050707','0507','San Francisco de Ravacayco',1),('050708','0507','Upahuacho',1),('050801','0508','Pausa',1),('050802','0508','Colta',1),('050803','0508','Corculla',1),('050804','0508','Lampa',1),('050805','0508','Marcabamba',1),('050806','0508','Oyolo',1),('050807','0508','Pararca',1),('050808','0508','San Javier de Alpabamba',1),('050809','0508','San José de Ushua',1),('050810','0508','Sara Sara',1),('050901','0509','Querobamba',1),('050902','0509','Belén',1),('050903','0509','Chalcos',1),('050904','0509','Chilcayoc',1),('050905','0509','Huacaña',1),('050906','0509','Morcolla',1),('050907','0509','Paico',1),('050908','0509','San Pedro de Larcay',1),('050909','0509','San Salvador de Quije',1),('050910','0509','Santiago de Paucaray',1),('050911','0509','Soras',1),('051001','0510','Huancapi',1),('051002','0510','Alcamenca',1),('051003','0510','Apongo',1),('051004','0510','Asquipata',1),('051005','0510','Canaria',1),('051006','0510','Cayara',1),('051007','0510','Colca',1),('051008','0510','Huamanquiquia',1),('051009','0510','Huancaraylla',1),('051010','0510','Huaya',1),('051011','0510','Sarhua',1),('051012','0510','Vilcanchos',1),('051101','0511','Vilcas Huaman',1),('051102','0511','Accomarca',1),('051103','0511','Carhuanca',1),('051104','0511','Concepción',1),('051105','0511','Huambalpa',1),('051106','0511','Independencia',1),('051107','0511','Saurama',1),('051108','0511','Vischongo',1),('060101','0601','Cajamarca',1),('060102','0601','Asunción',1),('060103','0601','Chetilla',1),('060104','0601','Cospan',1),('060105','0601','Encañada',1),('060106','0601','Jesús',1),('060107','0601','Llacanora',1),('060108','0601','Los Baños del Inca',1),('060109','0601','Magdalena',1),('060110','0601','Matara',1),('060111','0601','Namora',1),('060112','0601','San Juan',1),('060201','0602','Cajabamba',1),('060202','0602','Cachachi',1),('060203','0602','Condebamba',1),('060204','0602','Sitacocha',1),('060301','0603','Celendín',1),('060302','0603','Chumuch',1),('060303','0603','Cortegana',1),('060304','0603','Huasmin',1),('060305','0603','Jorge Chávez',1),('060306','0603','José Gálvez',1),('060307','0603','Miguel Iglesias',1),('060308','0603','Oxamarca',1),('060309','0603','Sorochuco',1),('060310','0603','Sucre',1),('060311','0603','Utco',1),('060312','0603','La Libertad de Pallan',1),('060401','0604','Chota',1),('060402','0604','Anguia',1),('060403','0604','Chadin',1),('060404','0604','Chiguirip',1),('060405','0604','Chimban',1),('060406','0604','Choropampa',1),('060407','0604','Cochabamba',1),('060408','0604','Conchan',1),('060409','0604','Huambos',1),('060410','0604','Lajas',1),('060411','0604','Llama',1),('060412','0604','Miracosta',1),('060413','0604','Paccha',1),('060414','0604','Pion',1),('060415','0604','Querocoto',1),('060416','0604','San Juan de Licupis',1),('060417','0604','Tacabamba',1),('060418','0604','Tocmoche',1),('060419','0604','Chalamarca',1),('060501','0605','Contumaza',1),('060502','0605','Chilete',1),('060503','0605','Cupisnique',1),('060504','0605','Guzmango',1),('060505','0605','San Benito',1),('060506','0605','Santa Cruz de Toledo',1),('060507','0605','Tantarica',1),('060508','0605','Yonan',1),('060601','0606','Cutervo',1),('060602','0606','Callayuc',1),('060603','0606','Choros',1),('060604','0606','Cujillo',1),('060605','0606','La Ramada',1),('060606','0606','Pimpingos',1),('060607','0606','Querocotillo',1),('060608','0606','San Andrés de Cutervo',1),('060609','0606','San Juan de Cutervo',1),('060610','0606','San Luis de Lucma',1),('060611','0606','Santa Cruz',1),('060612','0606','Santo Domingo de la Capilla',1),('060613','0606','Santo Tomas',1),('060614','0606','Socota',1),('060615','0606','Toribio Casanova',1),('060701','0607','Bambamarca',1),('060702','0607','Chugur',1),('060703','0607','Hualgayoc',1),('060801','0608','Jaén',1),('060802','0608','Bellavista',1),('060803','0608','Chontali',1),('060804','0608','Colasay',1),('060805','0608','Huabal',1),('060806','0608','Las Pirias',1),('060807','0608','Pomahuaca',1),('060808','0608','Pucara',1),('060809','0608','Sallique',1),('060810','0608','San Felipe',1),('060811','0608','San José del Alto',1),('060812','0608','Santa Rosa',1),('060901','0609','San Ignacio',1),('060902','0609','Chirinos',1),('060903','0609','Huarango',1),('060904','0609','La Coipa',1),('060905','0609','Namballe',1),('060906','0609','San José de Lourdes',1),('060907','0609','Tabaconas',1),('061001','0610','Pedro Gálvez',1),('061002','0610','Chancay',1),('061003','0610','Eduardo Villanueva',1),('061004','0610','Gregorio Pita',1),('061005','0610','Ichocan',1),('061006','0610','José Manuel Quiroz',1),('061007','0610','José Sabogal',1),('061101','0611','San Miguel',1),('061102','0611','Bolívar',1),('061103','0611','Calquis',1),('061104','0611','Catilluc',1),('061105','0611','El Prado',1),('061106','0611','La Florida',1),('061107','0611','Llapa',1),('061108','0611','Nanchoc',1),('061109','0611','Niepos',1),('061110','0611','San Gregorio',1),('061111','0611','San Silvestre de Cochan',1),('061112','0611','Tongod',1),('061113','0611','Unión Agua Blanca',1),('061201','0612','San Pablo',1),('061202','0612','San Bernardino',1),('061203','0612','San Luis',1),('061204','0612','Tumbaden',1),('061301','0613','Santa Cruz',1),('061302','0613','Andabamba',1),('061303','0613','Catache',1),('061304','0613','Chancaybaños',1),('061305','0613','La Esperanza',1),('061306','0613','Ninabamba',1),('061307','0613','Pulan',1),('061308','0613','Saucepampa',1),('061309','0613','Sexi',1),('061310','0613','Uticyacu',1),('061311','0613','Yauyucan',1),('070101','0701','Callao',1),('070102','0701','Bellavista',1),('070103','0701','Carmen de la Legua Reynoso',1),('070104','0701','La Perla',1),('070105','0701','La Punta',1),('070106','0701','Ventanilla',1),('070107','0701','Mi Perú',1),('080101','0801','Cusco',1),('080102','0801','Ccorca',1),('080103','0801','Poroy',1),('080104','0801','San Jerónimo',1),('080105','0801','San Sebastian',1),('080106','0801','Santiago',1),('080107','0801','Saylla',1),('080108','0801','Wanchaq',1),('080201','0802','Acomayo',1),('080202','0802','Acopia',1),('080203','0802','Acos',1),('080204','0802','Mosoc Llacta',1),('080205','0802','Pomacanchi',1),('080206','0802','Rondocan',1),('080207','0802','Sangarara',1),('080301','0803','Anta',1),('080302','0803','Ancahuasi',1),('080303','0803','Cachimayo',1),('080304','0803','Chinchaypujio',1),('080305','0803','Huarocondo',1),('080306','0803','Limatambo',1),('080307','0803','Mollepata',1),('080308','0803','Pucyura',1),('080309','0803','Zurite',1),('080401','0804','Calca',1),('080402','0804','Coya',1),('080403','0804','Lamay',1),('080404','0804','Lares',1),('080405','0804','Pisac',1),('080406','0804','San Salvador',1),('080407','0804','Taray',1),('080408','0804','Yanatile',1),('080501','0805','Yanaoca',1),('080502','0805','Checca',1),('080503','0805','Kunturkanki',1),('080504','0805','Langui',1),('080505','0805','Layo',1),('080506','0805','Pampamarca',1),('080507','0805','Quehue',1),('080508','0805','Tupac Amaru',1),('080601','0806','Sicuani',1),('080602','0806','Checacupe',1),('080603','0806','Combapata',1),('080604','0806','Marangani',1),('080605','0806','Pitumarca',1),('080606','0806','San Pablo',1),('080607','0806','San Pedro',1),('080608','0806','Tinta',1),('080701','0807','Santo Tomas',1),('080702','0807','Capacmarca',1),('080703','0807','Chamaca',1),('080704','0807','Colquemarca',1),('080705','0807','Livitaca',1),('080706','0807','Llusco',1),('080707','0807','Quiñota',1),('080708','0807','Velille',1),('080801','0808','Espinar',1),('080802','0808','Condoroma',1),('080803','0808','Coporaque',1),('080804','0808','Ocoruro',1),('080805','0808','Pallpata',1),('080806','0808','Pichigua',1),('080807','0808','Suyckutambo',1),('080808','0808','Alto Pichigua',1),('080901','0809','Santa Ana',1),('080902','0809','Echarate',1),('080903','0809','Huayopata',1),('080904','0809','Maranura',1),('080905','0809','Ocobamba',1),('080906','0809','Quellouno',1),('080907','0809','Kimbiri',1),('080908','0809','Santa Teresa',1),('080909','0809','Vilcabamba',1),('080910','0809','Pichari',1),('080911','0809','Inkawasi',1),('080912','0809','Villa Virgen',1),('080913','0809','Villa Kintiarina',1),('081001','0810','Paruro',1),('081002','0810','Accha',1),('081003','0810','Ccapi',1),('081004','0810','Colcha',1),('081005','0810','Huanoquite',1),('081006','0810','Omacha',1),('081007','0810','Paccaritambo',1),('081008','0810','Pillpinto',1),('081009','0810','Yaurisque',1),('081101','0811','Paucartambo',1),('081102','0811','Caicay',1),('081103','0811','Challabamba',1),('081104','0811','Colquepata',1),('081105','0811','Huancarani',1),('081106','0811','Kosñipata',1),('081201','0812','Urcos',1),('081202','0812','Andahuaylillas',1),('081203','0812','Camanti',1),('081204','0812','Ccarhuayo',1),('081205','0812','Ccatca',1),('081206','0812','Cusipata',1),('081207','0812','Huaro',1),('081208','0812','Lucre',1),('081209','0812','Marcapata',1),('081210','0812','Ocongate',1),('081211','0812','Oropesa',1),('081212','0812','Quiquijana',1),('081301','0813','Urubamba',1),('081302','0813','Chinchero',1),('081303','0813','Huayllabamba',1),('081304','0813','Machupicchu',1),('081305','0813','Maras',1),('081306','0813','Ollantaytambo',1),('081307','0813','Yucay',1),('090101','0901','Huancavelica',1),('090102','0901','Acobambilla',1),('090103','0901','Acoria',1),('090104','0901','Conayca',1),('090105','0901','Cuenca',1),('090106','0901','Huachocolpa',1),('090107','0901','Huayllahuara',1),('090108','0901','Izcuchaca',1),('090109','0901','Laria',1),('090110','0901','Manta',1),('090111','0901','Mariscal Cáceres',1),('090112','0901','Moya',1),('090113','0901','Nuevo Occoro',1),('090114','0901','Palca',1),('090115','0901','Pilchaca',1),('090116','0901','Vilca',1),('090117','0901','Yauli',1),('090118','0901','Ascensión',1),('090119','0901','Huando',1),('090201','0902','Acobamba',1),('090202','0902','Andabamba',1),('090203','0902','Anta',1),('090204','0902','Caja',1),('090205','0902','Marcas',1),('090206','0902','Paucara',1),('090207','0902','Pomacocha',1),('090208','0902','Rosario',1),('090301','0903','Lircay',1),('090302','0903','Anchonga',1),('090303','0903','Callanmarca',1),('090304','0903','Ccochaccasa',1),('090305','0903','Chincho',1),('090306','0903','Congalla',1),('090307','0903','Huanca-Huanca',1),('090308','0903','Huayllay Grande',1),('090309','0903','Julcamarca',1),('090310','0903','San Antonio de Antaparco',1),('090311','0903','Santo Tomas de Pata',1),('090312','0903','Secclla',1),('090401','0904','Castrovirreyna',1),('090402','0904','Arma',1),('090403','0904','Aurahua',1),('090404','0904','Capillas',1),('090405','0904','Chupamarca',1),('090406','0904','Cocas',1),('090407','0904','Huachos',1),('090408','0904','Huamatambo',1),('090409','0904','Mollepampa',1),('090410','0904','San Juan',1),('090411','0904','Santa Ana',1),('090412','0904','Tantara',1),('090413','0904','Ticrapo',1),('090501','0905','Churcampa',1),('090502','0905','Anco',1),('090503','0905','Chinchihuasi',1),('090504','0905','El Carmen',1),('090505','0905','La Merced',1),('090506','0905','Locroja',1),('090507','0905','Paucarbamba',1),('090508','0905','San Miguel de Mayocc',1),('090509','0905','San Pedro de Coris',1),('090510','0905','Pachamarca',1),('090511','0905','Cosme',1),('090601','0906','Huaytara',1),('090602','0906','Ayavi',1),('090603','0906','Córdova',1),('090604','0906','Huayacundo Arma',1),('090605','0906','Laramarca',1),('090606','0906','Ocoyo',1),('090607','0906','Pilpichaca',1),('090608','0906','Querco',1),('090609','0906','Quito-Arma',1),('090610','0906','San Antonio de Cusicancha',1),('090611','0906','San Francisco de Sangayaico',1),('090612','0906','San Isidro',1),('090613','0906','Santiago de Chocorvos',1),('090614','0906','Santiago de Quirahuara',1),('090615','0906','Santo Domingo de Capillas',1),('090616','0906','Tambo',1),('090701','0907','Pampas',1),('090702','0907','Acostambo',1),('090703','0907','Acraquia',1),('090704','0907','Ahuaycha',1),('090705','0907','Colcabamba',1),('090706','0907','Daniel Hernández',1),('090707','0907','Huachocolpa',1),('090709','0907','Huaribamba',1),('090710','0907','Ñahuimpuquio',1),('090711','0907','Pazos',1),('090713','0907','Quishuar',1),('090714','0907','Salcabamba',1),('090715','0907','Salcahuasi',1),('090716','0907','San Marcos de Rocchac',1),('090717','0907','Surcubamba',1),('090718','0907','Tintay Puncu',1),('090719','0907','Quichuas',1),('090720','0907','Andaymarca',1),('090721','0907','Roble',1),('090722','0907','Pichos',1),('100101','1001','Huanuco',1),('100102','1001','Amarilis',1),('100103','1001','Chinchao',1),('100104','1001','Churubamba',1),('100105','1001','Margos',1),('100106','1001','Quisqui (Kichki)',1),('100107','1001','San Francisco de Cayran',1),('100108','1001','San Pedro de Chaulan',1),('100109','1001','Santa María del Valle',1),('100110','1001','Yarumayo',1),('100111','1001','Pillco Marca',1),('100112','1001','Yacus',1),('100113','1001','San Pablo de Pillao',1),('100201','1002','Ambo',1),('100202','1002','Cayna',1),('100203','1002','Colpas',1),('100204','1002','Conchamarca',1),('100205','1002','Huacar',1),('100206','1002','San Francisco',1),('100207','1002','San Rafael',1),('100208','1002','Tomay Kichwa',1),('100301','1003','La Unión',1),('100307','1003','Chuquis',1),('100311','1003','Marías',1),('100313','1003','Pachas',1),('100316','1003','Quivilla',1),('100317','1003','Ripan',1),('100321','1003','Shunqui',1),('100322','1003','Sillapata',1),('100323','1003','Yanas',1),('100401','1004','Huacaybamba',1),('100402','1004','Canchabamba',1),('100403','1004','Cochabamba',1),('100404','1004','Pinra',1),('100501','1005','Llata',1),('100502','1005','Arancay',1),('100503','1005','Chavín de Pariarca',1),('100504','1005','Jacas Grande',1),('100505','1005','Jircan',1),('100506','1005','Miraflores',1),('100507','1005','Monzón',1),('100508','1005','Punchao',1),('100509','1005','Puños',1),('100510','1005','Singa',1),('100511','1005','Tantamayo',1),('100601','1006','Rupa-Rupa',1),('100602','1006','Daniel Alomía Robles',1),('100603','1006','Hermílio Valdizan',1),('100604','1006','José Crespo y Castillo',1),('100605','1006','Luyando',1),('100606','1006','Mariano Damaso Beraun',1),('100607','1006','Pucayacu',1),('100608','1006','Castillo Grande',1),('100701','1007','Huacrachuco',1),('100702','1007','Cholon',1),('100703','1007','San Buenaventura',1),('100704','1007','La Morada',1),('100705','1007','Santa Rosa de Alto Yanajanca',1),('100801','1008','Panao',1),('100802','1008','Chaglla',1),('100803','1008','Molino',1),('100804','1008','Umari',1),('100901','1009','Puerto Inca',1),('100902','1009','Codo del Pozuzo',1),('100903','1009','Honoria',1),('100904','1009','Tournavista',1),('100905','1009','Yuyapichis',1),('101001','1010','Jesús',1),('101002','1010','Baños',1),('101003','1010','Jivia',1),('101004','1010','Queropalca',1),('101005','1010','Rondos',1),('101006','1010','San Francisco de Asís',1),('101007','1010','San Miguel de Cauri',1),('101101','1011','Chavinillo',1),('101102','1011','Cahuac',1),('101103','1011','Chacabamba',1),('101104','1011','Aparicio Pomares',1),('101105','1011','Jacas Chico',1),('101106','1011','Obas',1),('101107','1011','Pampamarca',1),('101108','1011','Choras',1),('110101','1101','Ica',1),('110102','1101','La Tinguiña',1),('110103','1101','Los Aquijes',1),('110104','1101','Ocucaje',1),('110105','1101','Pachacutec',1),('110106','1101','Parcona',1),('110107','1101','Pueblo Nuevo',1),('110108','1101','Salas',1),('110109','1101','San José de Los Molinos',1),('110110','1101','San Juan Bautista',1),('110111','1101','Santiago',1),('110112','1101','Subtanjalla',1),('110113','1101','Tate',1),('110114','1101','Yauca del Rosario',1),('110201','1102','Chincha Alta',1),('110202','1102','Alto Laran',1),('110203','1102','Chavin',1),('110204','1102','Chincha Baja',1),('110205','1102','El Carmen',1),('110206','1102','Grocio Prado',1),('110207','1102','Pueblo Nuevo',1),('110208','1102','San Juan de Yanac',1),('110209','1102','San Pedro de Huacarpana',1),('110210','1102','Sunampe',1),('110211','1102','Tambo de Mora',1),('110301','1103','Nasca',1),('110302','1103','Changuillo',1),('110303','1103','El Ingenio',1),('110304','1103','Marcona',1),('110305','1103','Vista Alegre',1),('110401','1104','Palpa',1),('110402','1104','Llipata',1),('110403','1104','Río Grande',1),('110404','1104','Santa Cruz',1),('110405','1104','Tibillo',1),('110501','1105','Pisco',1),('110502','1105','Huancano',1),('110503','1105','Humay',1),('110504','1105','Independencia',1),('110505','1105','Paracas',1),('110506','1105','San Andrés',1),('110507','1105','San Clemente',1),('110508','1105','Tupac Amaru Inca',1),('120101','1201','Huancayo',1),('120104','1201','Carhuacallanga',1),('120105','1201','Chacapampa',1),('120106','1201','Chicche',1),('120107','1201','Chilca',1),('120108','1201','Chongos Alto',1),('120111','1201','Chupuro',1),('120112','1201','Colca',1),('120113','1201','Cullhuas',1),('120114','1201','El Tambo',1),('120116','1201','Huacrapuquio',1),('120117','1201','Hualhuas',1),('120119','1201','Huancan',1),('120120','1201','Huasicancha',1),('120121','1201','Huayucachi',1),('120122','1201','Ingenio',1),('120124','1201','Pariahuanca',1),('120125','1201','Pilcomayo',1),('120126','1201','Pucara',1),('120127','1201','Quichuay',1),('120128','1201','Quilcas',1),('120129','1201','San Agustín',1),('120130','1201','San Jerónimo de Tunan',1),('120132','1201','Saño',1),('120133','1201','Sapallanga',1),('120134','1201','Sicaya',1),('120135','1201','Santo Domingo de Acobamba',1),('120136','1201','Viques',1),('120201','1202','Concepción',1),('120202','1202','Aco',1),('120203','1202','Andamarca',1),('120204','1202','Chambara',1),('120205','1202','Cochas',1),('120206','1202','Comas',1),('120207','1202','Heroínas Toledo',1),('120208','1202','Manzanares',1),('120209','1202','Mariscal Castilla',1),('120210','1202','Matahuasi',1),('120211','1202','Mito',1),('120212','1202','Nueve de Julio',1),('120213','1202','Orcotuna',1),('120214','1202','San José de Quero',1),('120215','1202','Santa Rosa de Ocopa',1),('120301','1203','Chanchamayo',1),('120302','1203','Perene',1),('120303','1203','Pichanaqui',1),('120304','1203','San Luis de Shuaro',1),('120305','1203','San Ramón',1),('120306','1203','Vitoc',1),('120401','1204','Jauja',1),('120402','1204','Acolla',1),('120403','1204','Apata',1),('120404','1204','Ataura',1),('120405','1204','Canchayllo',1),('120406','1204','Curicaca',1),('120407','1204','El Mantaro',1),('120408','1204','Huamali',1),('120409','1204','Huaripampa',1),('120410','1204','Huertas',1),('120411','1204','Janjaillo',1),('120412','1204','Julcán',1),('120413','1204','Leonor Ordóñez',1),('120414','1204','Llocllapampa',1),('120415','1204','Marco',1),('120416','1204','Masma',1),('120417','1204','Masma Chicche',1),('120418','1204','Molinos',1),('120419','1204','Monobamba',1),('120420','1204','Muqui',1),('120421','1204','Muquiyauyo',1),('120422','1204','Paca',1),('120423','1204','Paccha',1),('120424','1204','Pancan',1),('120425','1204','Parco',1),('120426','1204','Pomacancha',1),('120427','1204','Ricran',1),('120428','1204','San Lorenzo',1),('120429','1204','San Pedro de Chunan',1),('120430','1204','Sausa',1),('120431','1204','Sincos',1),('120432','1204','Tunan Marca',1),('120433','1204','Yauli',1),('120434','1204','Yauyos',1),('120501','1205','Junin',1),('120502','1205','Carhuamayo',1),('120503','1205','Ondores',1),('120504','1205','Ulcumayo',1),('120601','1206','Satipo',1),('120602','1206','Coviriali',1),('120603','1206','Llaylla',1),('120604','1206','Mazamari',1),('120605','1206','Pampa Hermosa',1),('120606','1206','Pangoa',1),('120607','1206','Río Negro',1),('120608','1206','Río Tambo',1),('120609','1206','Vizcatan del Ene',1),('120701','1207','Tarma',1),('120702','1207','Acobamba',1),('120703','1207','Huaricolca',1),('120704','1207','Huasahuasi',1),('120705','1207','La Unión',1),('120706','1207','Palca',1),('120707','1207','Palcamayo',1),('120708','1207','San Pedro de Cajas',1),('120709','1207','Tapo',1),('120801','1208','La Oroya',1),('120802','1208','Chacapalpa',1),('120803','1208','Huay-Huay',1),('120804','1208','Marcapomacocha',1),('120805','1208','Morococha',1),('120806','1208','Paccha',1),('120807','1208','Santa Bárbara de Carhuacayan',1),('120808','1208','Santa Rosa de Sacco',1),('120809','1208','Suitucancha',1),('120810','1208','Yauli',1),('120901','1209','Chupaca',1),('120902','1209','Ahuac',1),('120903','1209','Chongos Bajo',1),('120904','1209','Huachac',1),('120905','1209','Huamancaca Chico',1),('120906','1209','San Juan de Iscos',1),('120907','1209','San Juan de Jarpa',1),('120908','1209','Tres de Diciembre',1),('120909','1209','Yanacancha',1),('130101','1301','Trujillo',1),('130102','1301','El Porvenir',1),('130103','1301','Florencia de Mora',1),('130104','1301','Huanchaco',1),('130105','1301','La Esperanza',1),('130106','1301','Laredo',1),('130107','1301','Moche',1),('130108','1301','Poroto',1),('130109','1301','Salaverry',1),('130110','1301','Simbal',1),('130111','1301','Victor Larco Herrera',1),('130201','1302','Ascope',1),('130202','1302','Chicama',1),('130203','1302','Chocope',1),('130204','1302','Magdalena de Cao',1),('130205','1302','Paijan',1),('130206','1302','Rázuri',1),('130207','1302','Santiago de Cao',1),('130208','1302','Casa Grande',1),('130301','1303','Bolívar',1),('130302','1303','Bambamarca',1),('130303','1303','Condormarca',1),('130304','1303','Longotea',1),('130305','1303','Uchumarca',1),('130306','1303','Ucuncha',1),('130401','1304','Chepen',1),('130402','1304','Pacanga',1),('130403','1304','Pueblo Nuevo',1),('130501','1305','Julcan',1),('130502','1305','Calamarca',1),('130503','1305','Carabamba',1),('130504','1305','Huaso',1),('130601','1306','Otuzco',1),('130602','1306','Agallpampa',1),('130604','1306','Charat',1),('130605','1306','Huaranchal',1),('130606','1306','La Cuesta',1),('130608','1306','Mache',1),('130610','1306','Paranday',1),('130611','1306','Salpo',1),('130613','1306','Sinsicap',1),('130614','1306','Usquil',1),('130701','1307','San Pedro de Lloc',1),('130702','1307','Guadalupe',1),('130703','1307','Jequetepeque',1),('130704','1307','Pacasmayo',1),('130705','1307','San José',1),('130801','1308','Tayabamba',1),('130802','1308','Buldibuyo',1),('130803','1308','Chillia',1),('130804','1308','Huancaspata',1),('130805','1308','Huaylillas',1),('130806','1308','Huayo',1),('130807','1308','Ongon',1),('130808','1308','Parcoy',1),('130809','1308','Pataz',1),('130810','1308','Pias',1),('130811','1308','Santiago de Challas',1),('130812','1308','Taurija',1),('130813','1308','Urpay',1),('130901','1309','Huamachuco',1),('130902','1309','Chugay',1),('130903','1309','Cochorco',1),('130904','1309','Curgos',1),('130905','1309','Marcabal',1),('130906','1309','Sanagoran',1),('130907','1309','Sarin',1),('130908','1309','Sartimbamba',1),('131001','1310','Santiago de Chuco',1),('131002','1310','Angasmarca',1),('131003','1310','Cachicadan',1),('131004','1310','Mollebamba',1),('131005','1310','Mollepata',1),('131006','1310','Quiruvilca',1),('131007','1310','Santa Cruz de Chuca',1),('131008','1310','Sitabamba',1),('131101','1311','Cascas',1),('131102','1311','Lucma',1),('131103','1311','Marmot',1),('131104','1311','Sayapullo',1),('131201','1312','Viru',1),('131202','1312','Chao',1),('131203','1312','Guadalupito',1),('140101','1401','Chiclayo',1),('140102','1401','Chongoyape',1),('140103','1401','Eten',1),('140104','1401','Eten Puerto',1),('140105','1401','José Leonardo Ortiz',1),('140106','1401','La Victoria',1),('140107','1401','Lagunas',1),('140108','1401','Monsefu',1),('140109','1401','Nueva Arica',1),('140110','1401','Oyotun',1),('140111','1401','Picsi',1),('140112','1401','Pimentel',1),('140113','1401','Reque',1),('140114','1401','Santa Rosa',1),('140115','1401','Saña',1),('140116','1401','Cayalti',1),('140117','1401','Patapo',1),('140118','1401','Pomalca',1),('140119','1401','Pucala',1),('140120','1401','Tuman',1),('140201','1402','Ferreñafe',1),('140202','1402','Cañaris',1),('140203','1402','Incahuasi',1),('140204','1402','Manuel Antonio Mesones Muro',1),('140205','1402','Pitipo',1),('140206','1402','Pueblo Nuevo',1),('140301','1403','Lambayeque',1),('140302','1403','Chochope',1),('140303','1403','Illimo',1),('140304','1403','Jayanca',1),('140305','1403','Mochumi',1),('140306','1403','Morrope',1),('140307','1403','Motupe',1),('140308','1403','Olmos',1),('140309','1403','Pacora',1),('140310','1403','Salas',1),('140311','1403','San José',1),('140312','1403','Tucume',1),('150101','1501','Lima',1),('150102','1501','Ancón',1),('150103','1501','Ate',1),('150104','1501','Barranco',1),('150105','1501','Breña',1),('150106','1501','Carabayllo',1),('150107','1501','Chaclacayo',1),('150108','1501','Chorrillos',1),('150109','1501','Cieneguilla',1),('150110','1501','Comas',1),('150111','1501','El Agustino',1),('150112','1501','Independencia',1),('150113','1501','Jesús María',1),('150114','1501','La Molina',1),('150115','1501','La Victoria',1),('150116','1501','Lince',1),('150117','1501','Los Olivos',1),('150118','1501','Lurigancho',1),('150119','1501','Lurin',1),('150120','1501','Magdalena del Mar',1),('150121','1501','Pueblo Libre',1),('150122','1501','Miraflores',1),('150123','1501','Pachacamac',1),('150124','1501','Pucusana',1),('150125','1501','Puente Piedra',1),('150126','1501','Punta Hermosa',1),('150127','1501','Punta Negra',1),('150128','1501','Rímac',1),('150129','1501','San Bartolo',1),('150130','1501','San Borja',1),('150131','1501','San Isidro',1),('150132','1501','San Juan de Lurigancho',1),('150133','1501','San Juan de Miraflores',1),('150134','1501','San Luis',1),('150135','1501','San Martín de Porres',1),('150136','1501','San Miguel',1),('150137','1501','Santa Anita',1),('150138','1501','Santa María del Mar',1),('150139','1501','Santa Rosa',1),('150140','1501','Santiago de Surco',1),('150141','1501','Surquillo',1),('150142','1501','Villa El Salvador',1),('150143','1501','Villa María del Triunfo',1),('150201','1502','Barranca',1),('150202','1502','Paramonga',1),('150203','1502','Pativilca',1),('150204','1502','Supe',1),('150205','1502','Supe Puerto',1),('150301','1503','Cajatambo',1),('150302','1503','Copa',1),('150303','1503','Gorgor',1),('150304','1503','Huancapon',1),('150305','1503','Manas',1),('150401','1504','Canta',1),('150402','1504','Arahuay',1),('150403','1504','Huamantanga',1),('150404','1504','Huaros',1),('150405','1504','Lachaqui',1),('150406','1504','San Buenaventura',1),('150407','1504','Santa Rosa de Quives',1),('150501','1505','San Vicente de Cañete',1),('150502','1505','Asia',1),('150503','1505','Calango',1),('150504','1505','Cerro Azul',1),('150505','1505','Chilca',1),('150506','1505','Coayllo',1),('150507','1505','Imperial',1),('150508','1505','Lunahuana',1),('150509','1505','Mala',1),('150510','1505','Nuevo Imperial',1),('150511','1505','Pacaran',1),('150512','1505','Quilmana',1),('150513','1505','San Antonio',1),('150514','1505','San Luis',1),('150515','1505','Santa Cruz de Flores',1),('150516','1505','Zúñiga',1),('150601','1506','Huaral',1),('150602','1506','Atavillos Alto',1),('150603','1506','Atavillos Bajo',1),('150604','1506','Aucallama',1),('150605','1506','Chancay',1),('150606','1506','Ihuari',1),('150607','1506','Lampian',1),('150608','1506','Pacaraos',1),('150609','1506','San Miguel de Acos',1),('150610','1506','Santa Cruz de Andamarca',1),('150611','1506','Sumbilca',1),('150612','1506','Veintisiete de Noviembre',1),('150701','1507','Matucana',1),('150702','1507','Antioquia',1),('150703','1507','Callahuanca',1),('150704','1507','Carampoma',1),('150705','1507','Chicla',1),('150706','1507','Cuenca',1),('150707','1507','Huachupampa',1),('150708','1507','Huanza',1),('150709','1507','Huarochiri',1),('150710','1507','Lahuaytambo',1),('150711','1507','Langa',1),('150712','1507','Laraos',1),('150713','1507','Mariatana',1),('150714','1507','Ricardo Palma',1),('150715','1507','San Andrés de Tupicocha',1),('150716','1507','San Antonio',1),('150717','1507','San Bartolomé',1),('150718','1507','San Damian',1),('150719','1507','San Juan de Iris',1),('150720','1507','San Juan de Tantaranche',1),('150721','1507','San Lorenzo de Quinti',1),('150722','1507','San Mateo',1),('150723','1507','San Mateo de Otao',1),('150724','1507','San Pedro de Casta',1),('150725','1507','San Pedro de Huancayre',1),('150726','1507','Sangallaya',1),('150727','1507','Santa Cruz de Cocachacra',1),('150728','1507','Santa Eulalia',1),('150729','1507','Santiago de Anchucaya',1),('150730','1507','Santiago de Tuna',1),('150731','1507','Santo Domingo de Los Olleros',1),('150732','1507','Surco',1),('150801','1508','Huacho',1),('150802','1508','Ambar',1),('150803','1508','Caleta de Carquin',1),('150804','1508','Checras',1),('150805','1508','Hualmay',1),('150806','1508','Huaura',1),('150807','1508','Leoncio Prado',1),('150808','1508','Paccho',1),('150809','1508','Santa Leonor',1),('150810','1508','Santa María',1),('150811','1508','Sayan',1),('150812','1508','Vegueta',1),('150901','1509','Oyon',1),('150902','1509','Andajes',1),('150903','1509','Caujul',1),('150904','1509','Cochamarca',1),('150905','1509','Navan',1),('150906','1509','Pachangara',1),('151001','1510','Yauyos',1),('151002','1510','Alis',1),('151003','1510','Allauca',1),('151004','1510','Ayaviri',1),('151005','1510','Azángaro',1),('151006','1510','Cacra',1),('151007','1510','Carania',1),('151008','1510','Catahuasi',1),('151009','1510','Chocos',1),('151010','1510','Cochas',1),('151011','1510','Colonia',1),('151012','1510','Hongos',1),('151013','1510','Huampara',1),('151014','1510','Huancaya',1),('151015','1510','Huangascar',1),('151016','1510','Huantan',1),('151017','1510','Huañec',1),('151018','1510','Laraos',1),('151019','1510','Lincha',1),('151020','1510','Madean',1),('151021','1510','Miraflores',1),('151022','1510','Omas',1),('151023','1510','Putinza',1),('151024','1510','Quinches',1),('151025','1510','Quinocay',1),('151026','1510','San Joaquín',1),('151027','1510','San Pedro de Pilas',1),('151028','1510','Tanta',1),('151029','1510','Tauripampa',1),('151030','1510','Tomas',1),('151031','1510','Tupe',1),('151032','1510','Viñac',1),('151033','1510','Vitis',1),('160101','1601','Iquitos',1),('160102','1601','Alto Nanay',1),('160103','1601','Fernando Lores',1),('160104','1601','Indiana',1),('160105','1601','Las Amazonas',1),('160106','1601','Mazan',1),('160107','1601','Napo',1),('160108','1601','Punchana',1),('160110','1601','Torres Causana',1),('160112','1601','Belén',1),('160113','1601','San Juan Bautista',1),('160201','1602','Yurimaguas',1),('160202','1602','Balsapuerto',1),('160205','1602','Jeberos',1),('160206','1602','Lagunas',1),('160210','1602','Santa Cruz',1),('160211','1602','Teniente Cesar López Rojas',1),('160301','1603','Nauta',1),('160302','1603','Parinari',1),('160303','1603','Tigre',1),('160304','1603','Trompeteros',1),('160305','1603','Urarinas',1),('160401','1604','Ramón Castilla',1),('160402','1604','Pebas',1),('160403','1604','Yavari',1),('160404','1604','San Pablo',1),('160501','1605','Requena',1),('160502','1605','Alto Tapiche',1),('160503','1605','Capelo',1),('160504','1605','Emilio San Martín',1),('160505','1605','Maquia',1),('160506','1605','Puinahua',1),('160507','1605','Saquena',1),('160508','1605','Soplin',1),('160509','1605','Tapiche',1),('160510','1605','Jenaro Herrera',1),('160511','1605','Yaquerana',1),('160601','1606','Contamana',1),('160602','1606','Inahuaya',1),('160603','1606','Padre Márquez',1),('160604','1606','Pampa Hermosa',1),('160605','1606','Sarayacu',1),('160606','1606','Vargas Guerra',1),('160701','1607','Barranca',1),('160702','1607','Cahuapanas',1),('160703','1607','Manseriche',1),('160704','1607','Morona',1),('160705','1607','Pastaza',1),('160706','1607','Andoas',1),('160801','1608','Putumayo',1),('160802','1608','Rosa Panduro',1),('160803','1608','Teniente Manuel Clavero',1),('160804','1608','Yaguas',1),('170101','1701','Tambopata',1),('170102','1701','Inambari',1),('170103','1701','Las Piedras',1),('170104','1701','Laberinto',1),('170201','1702','Manu',1),('170202','1702','Fitzcarrald',1),('170203','1702','Madre de Dios',1),('170204','1702','Huepetuhe',1),('170301','1703','Iñapari',1),('170302','1703','Iberia',1),('170303','1703','Tahuamanu',1),('180101','1801','Moquegua',1),('180102','1801','Carumas',1),('180103','1801','Cuchumbaya',1),('180104','1801','Samegua',1),('180105','1801','San Cristóbal',1),('180106','1801','Torata',1),('180201','1802','Omate',1),('180202','1802','Chojata',1),('180203','1802','Coalaque',1),('180204','1802','Ichuña',1),('180205','1802','La Capilla',1),('180206','1802','Lloque',1),('180207','1802','Matalaque',1),('180208','1802','Puquina',1),('180209','1802','Quinistaquillas',1),('180210','1802','Ubinas',1),('180211','1802','Yunga',1),('180301','1803','Ilo',1),('180302','1803','El Algarrobal',1),('180303','1803','Pacocha',1),('190101','1901','Chaupimarca',1),('190102','1901','Huachon',1),('190103','1901','Huariaca',1),('190104','1901','Huayllay',1),('190105','1901','Ninacaca',1),('190106','1901','Pallanchacra',1),('190107','1901','Paucartambo',1),('190108','1901','San Francisco de Asís de Yarusyacan',1),('190109','1901','Simon Bolívar',1),('190110','1901','Ticlacayan',1),('190111','1901','Tinyahuarco',1),('190112','1901','Vicco',1),('190113','1901','Yanacancha',1),('190201','1902','Yanahuanca',1),('190202','1902','Chacayan',1),('190203','1902','Goyllarisquizga',1),('190204','1902','Paucar',1),('190205','1902','San Pedro de Pillao',1),('190206','1902','Santa Ana de Tusi',1),('190207','1902','Tapuc',1),('190208','1902','Vilcabamba',1),('190301','1903','Oxapampa',1),('190302','1903','Chontabamba',1),('190303','1903','Huancabamba',1),('190304','1903','Palcazu',1),('190305','1903','Pozuzo',1),('190306','1903','Puerto Bermúdez',1),('190307','1903','Villa Rica',1),('190308','1903','Constitución',1),('200101','2001','Piura',1),('200104','2001','Castilla',1),('200105','2001','Catacaos',1),('200107','2001','Cura Mori',1),('200108','2001','El Tallan',1),('200109','2001','La Arena',1),('200110','2001','La Unión',1),('200111','2001','Las Lomas',1),('200114','2001','Tambo Grande',1),('200115','2001','Veintiseis de Octubre',1),('200201','2002','Ayabaca',1),('200202','2002','Frias',1),('200203','2002','Jilili',1),('200204','2002','Lagunas',1),('200205','2002','Montero',1),('200206','2002','Pacaipampa',1),('200207','2002','Paimas',1),('200208','2002','Sapillica',1),('200209','2002','Sicchez',1),('200210','2002','Suyo',1),('200301','2003','Huancabamba',1),('200302','2003','Canchaque',1),('200303','2003','El Carmen de la Frontera',1),('200304','2003','Huarmaca',1),('200305','2003','Lalaquiz',1),('200306','2003','San Miguel de El Faique',1),('200307','2003','Sondor',1),('200308','2003','Sondorillo',1),('200401','2004','Chulucanas',1),('200402','2004','Buenos Aires',1),('200403','2004','Chalaco',1),('200404','2004','La Matanza',1),('200405','2004','Morropon',1),('200406','2004','Salitral',1),('200407','2004','San Juan de Bigote',1),('200408','2004','Santa Catalina de Mossa',1),('200409','2004','Santo Domingo',1),('200410','2004','YAMANGO',1),('200501','2005','PAITA',1),('200502','2005','AMOTAPE',1),('200503','2005','ARENAL',1),('200504','2005','COLAN',1),('200505','2005','LA HUACA',1),('200506','2005','Tamarindo',1),('200507','2005','Vichayal',1),('200601','2006','SULLANA',1),('200602','2006','Bellavista',1),('200603','2006','Ignacio Escudero',1),('200604','2006','Lancones',1),('200605','2006','Marcavelica',1),('200606','2006','Miguel Checa',1),('200607','2006','Querecotillo',1),('200608','2006','Salitral',1),('200701','2007','PARIÑAS',1),('200702','2007','EL ALTO',1),('200703','2007','LA BREA',1),('200704','2007','LOBITOS',1),('200705','2007','Los Organos',1),('200706','2007','MANCORA',1),('200801','2008','SECHURA',1),('200802','2008','Bellavista de la Unión',1),('200803','2008','BERNAL',1),('200804','2008','Cristo Nos Valga',1),('200805','2008','Vice',1),('200806','2008','Rinconada Llicuar',1),('210101','2101','Puno',1),('210102','2101','Acora',1),('210103','2101','Amantani',1),('210104','2101','Atuncolla',1),('210105','2101','Capachica',1),('210106','2101','Chucuito',1),('210107','2101','Coata',1),('210108','2101','Huata',1),('210109','2101','Mañazo',1),('210110','2101','Paucarcolla',1),('210111','2101','Pichacani',1),('210112','2101','Plateria',1),('210113','2101','San Antonio',1),('210114','2101','Tiquillaca',1),('210115','2101','Vilque',1),('210201','2102','Azángaro',1),('210202','2102','Achaya',1),('210203','2102','Arapa',1),('210204','2102','Asillo',1),('210205','2102','Caminaca',1),('210206','2102','Chupa',1),('210207','2102','José Domingo Choquehuanca',1),('210208','2102','Muñani',1),('210209','2102','Potoni',1),('210210','2102','Saman',1),('210211','2102','San Anton',1),('210212','2102','San José',1),('210213','2102','San Juan de Salinas',1),('210214','2102','Santiago de Pupuja',1),('210215','2102','Tirapata',1),('210301','2103','Macusani',1),('210302','2103','Ajoyani',1),('210303','2103','Ayapata',1),('210304','2103','Coasa',1),('210305','2103','Corani',1),('210306','2103','Crucero',1),('210307','2103','Ituata',1),('210308','2103','Ollachea',1),('210309','2103','San Gaban',1),('210310','2103','Usicayos',1),('210401','2104','Juli',1),('210402','2104','Desaguadero',1),('210403','2104','Huacullani',1),('210404','2104','Kelluyo',1),('210405','2104','Pisacoma',1),('210406','2104','Pomata',1),('210407','2104','Zepita',1),('210501','2105','Ilave',1),('210502','2105','Capazo',1),('210503','2105','Pilcuyo',1),('210504','2105','Santa Rosa',1),('210505','2105','Conduriri',1),('210601','2106','Huancane',1),('210602','2106','Cojata',1),('210603','2106','Huatasani',1),('210604','2106','Inchupalla',1),('210605','2106','Pusi',1),('210606','2106','Rosaspata',1),('210607','2106','Taraco',1),('210608','2106','Vilque Chico',1),('210701','2107','Lampa',1),('210702','2107','Cabanilla',1),('210703','2107','Calapuja',1),('210704','2107','Nicasio',1),('210705','2107','Ocuviri',1),('210706','2107','Palca',1),('210707','2107','Paratia',1),('210708','2107','Pucara',1),('210709','2107','Santa Lucia',1),('210710','2107','Vilavila',1),('210801','2108','Ayaviri',1),('210802','2108','Antauta',1),('210803','2108','Cupi',1),('210804','2108','Llalli',1),('210805','2108','Macari',1),('210806','2108','Nuñoa',1),('210807','2108','Orurillo',1),('210808','2108','Santa Rosa',1),('210809','2108','Umachiri',1),('210901','2109','Moho',1),('210902','2109','Conima',1),('210903','2109','Huayrapata',1),('210904','2109','Tilali',1),('211001','2110','Putina',1),('211002','2110','Ananea',1),('211003','2110','Pedro Vilca Apaza',1),('211004','2110','Quilcapuncu',1),('211005','2110','Sina',1),('211101','2111','Juliaca',1),('211102','2111','Cabana',1),('211103','2111','Cabanillas',1),('211104','2111','Caracoto',1),('211105','2111','San Miguel',1),('211201','2112','Sandia',1),('211202','2112','Cuyocuyo',1),('211203','2112','Limbani',1),('211204','2112','Patambuco',1),('211205','2112','Phara',1),('211206','2112','Quiaca',1),('211207','2112','San Juan del Oro',1),('211208','2112','Yanahuaya',1),('211209','2112','Alto Inambari',1),('211210','2112','San Pedro de Putina Punco',1),('211301','2113','Yunguyo',1),('211302','2113','Anapia',1),('211303','2113','Copani',1),('211304','2113','Cuturapi',1),('211305','2113','Ollaraya',1),('211306','2113','Tinicachi',1),('211307','2113','Unicachi',1),('220101','2201','Moyobamba',1),('220102','2201','Calzada',1),('220103','2201','Habana',1),('220104','2201','Jepelacio',1),('220105','2201','Soritor',1),('220106','2201','Yantalo',1),('220201','2202','Bellavista',1),('220202','2202','Alto Biavo',1),('220203','2202','Bajo Biavo',1),('220204','2202','Huallaga',1),('220205','2202','San Pablo',1),('220206','2202','San Rafael',1),('220301','2203','San José de Sisa',1),('220302','2203','Agua Blanca',1),('220303','2203','San Martín',1),('220304','2203','Santa Rosa',1),('220305','2203','Shatoja',1),('220401','2204','Saposoa',1),('220402','2204','Alto Saposoa',1),('220403','2204','El Eslabón',1),('220404','2204','Piscoyacu',1),('220405','2204','Sacanche',1),('220406','2204','Tingo de Saposoa',1),('220501','2205','Lamas',1),('220502','2205','Alonso de Alvarado',1),('220503','2205','Barranquita',1),('220504','2205','Caynarachi',1),('220505','2205','Cuñumbuqui',1),('220506','2205','Pinto Recodo',1),('220507','2205','Rumisapa',1),('220508','2205','San Roque de Cumbaza',1),('220509','2205','Shanao',1),('220510','2205','Tabalosos',1),('220511','2205','Zapatero',1),('220601','2206','Juanjuí',1),('220602','2206','Campanilla',1),('220603','2206','Huicungo',1),('220604','2206','Pachiza',1),('220605','2206','Pajarillo',1),('220701','2207','Picota',1),('220702','2207','Buenos Aires',1),('220703','2207','Caspisapa',1),('220704','2207','Pilluana',1),('220705','2207','Pucacaca',1),('220706','2207','San Cristóbal',1),('220707','2207','San Hilarión',1),('220708','2207','Shamboyacu',1),('220709','2207','Tingo de Ponasa',1),('220710','2207','Tres Unidos',1),('220801','2208','Rioja',1),('220802','2208','Awajun',1),('220803','2208','Elías Soplin Vargas',1),('220804','2208','Nueva Cajamarca',1),('220805','2208','Pardo Miguel',1),('220806','2208','Posic',1),('220807','2208','San Fernando',1),('220808','2208','Yorongos',1),('220809','2208','Yuracyacu',1),('220901','2209','Tarapoto',1),('220902','2209','Alberto Leveau',1),('220903','2209','Cacatachi',1),('220904','2209','Chazuta',1),('220905','2209','Chipurana',1),('220906','2209','El Porvenir',1),('220907','2209','Huimbayoc',1),('220908','2209','Juan Guerra',1),('220909','2209','La Banda de Shilcayo',1),('220910','2209','Morales',1),('220911','2209','Papaplaya',1),('220912','2209','San Antonio',1),('220913','2209','Sauce',1),('220914','2209','Shapaja',1),('221001','2210','Tocache',1),('221002','2210','Nuevo Progreso',1),('221003','2210','Polvora',1),('221004','2210','Shunte',1),('221005','2210','Uchiza',1),('230101','2301','Tacna',1),('230102','2301','Alto de la Alianza',1),('230103','2301','Calana',1),('230104','2301','Ciudad Nueva',1),('230105','2301','Inclan',1),('230106','2301','Pachia',1),('230107','2301','Palca',1),('230108','2301','Pocollay',1),('230109','2301','Sama',1),('230110','2301','Coronel Gregorio Albarracín Lanchipa',1),('230111','2301','La Yarada los Palos',1),('230201','2302','Candarave',1),('230202','2302','Cairani',1),('230203','2302','Camilaca',1),('230204','2302','Curibaya',1),('230205','2302','Huanuara',1),('230206','2302','Quilahuani',1),('230301','2303','Locumba',1),('230302','2303','Ilabaya',1),('230303','2303','Ite',1),('230401','2304','Tarata',1),('230402','2304','Héroes Albarracín',1),('230403','2304','Estique',1),('230404','2304','Estique-Pampa',1),('230405','2304','Sitajara',1),('230406','2304','Susapaya',1),('230407','2304','Tarucachi',1),('230408','2304','Ticaco',1),('240101','2401','Tumbes',1),('240102','2401','Corrales',1),('240103','2401','La Cruz',1),('240104','2401','Pampas de Hospital',1),('240105','2401','San Jacinto',1),('240106','2401','San Juan de la Virgen',1),('240201','2402','Zorritos',1),('240202','2402','Casitas',1),('240203','2402','Canoas de Punta Sal',1),('240301','2403','Zarumilla',1),('240302','2403','Aguas Verdes',1),('240303','2403','Matapalo',1),('240304','2403','Papayal',1),('250101','2501','Calleria',1),('250102','2501','Campoverde',1),('250103','2501','Iparia',1),('250104','2501','Masisea',1),('250105','2501','Yarinacocha',1),('250106','2501','Nueva Requena',1),('250107','2501','Manantay',1),('250201','2502','Raymondi',1),('250202','2502','Sepahua',1),('250203','2502','Tahuania',1),('250204','2502','Yurua',1),('250301','2503','Padre Abad',1),('250302','2503','Irazola',1),('250303','2503','Curimana',1),('250304','2503','Neshuya',1),('250305','2503','Alexander Von Humboldt',1),('250401','2504','Purus',1),('250307','2503','Boqueron',1);
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_fee`
--

DROP TABLE IF EXISTS `document_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_fee` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Relacion con el metodo de pago, Nulo es pago a cuotas',
  PRIMARY KEY (`id`),
  KEY `document_fee_document_id_foreign` (`document_id`),
  KEY `document_fee_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `document_fee_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `document_fee_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_fee`
--

LOCK TABLES `document_fee` WRITE;
/*!40000 ALTER TABLE `document_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_hotels`
--

DROP TABLE IF EXISTS `document_hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_hotels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int(11) NOT NULL,
  `civil_status` enum('S','C','V','D') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nacionality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origin` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_number` int(11) NOT NULL,
  `date_entry` date NOT NULL,
  `time_entry` time NOT NULL,
  `date_exit` date NOT NULL,
  `time_exit` time NOT NULL,
  `ocupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guests` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `document_hotels_document_id_foreign` (`document_id`),
  KEY `document_hotels_identity_document_type_id_foreign` (`identity_document_type_id`),
  CONSTRAINT `document_hotels_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `document_hotels_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_hotels`
--

LOCK TABLES `document_hotels` WRITE;
/*!40000 ALTER TABLE `document_hotels` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_items`
--

DROP TABLE IF EXISTS `document_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_plastic_bag_taxes` decimal(6,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `additional_information` text COLLATE utf8mb4_unicode_ci,
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci,
  `name_product_xml` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `document_items_document_id_foreign` (`document_id`),
  KEY `document_items_item_id_foreign` (`item_id`),
  KEY `document_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `document_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `document_items_price_type_id_foreign` (`price_type_id`),
  KEY `document_items_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `document_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `document_items_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `document_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `document_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `document_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`),
  CONSTRAINT `document_items_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_items`
--

LOCK TABLES `document_items` WRITE;
/*!40000 ALTER TABLE `document_items` DISABLE KEYS */;
INSERT INTO `document_items` VALUES (3,3,1,'{\"lots\": [], \"extra\": {\"colors\": null, \"string\": {\"colors\": \"\", \"CatItemSize\": \"\", \"CatItemStatus\": \"\", \"CatItemMoldCavity\": \"\", \"CatItemMoldProperty\": \"\", \"CatItemUnitBusiness\": \"\", \"CatItemProductFamily\": \"\", \"CatItemUnitsPerPackage\": \"\", \"CatItemPackageMeasurement\": \"\"}, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"is_set\": 0, \"has_igv\": false, \"sanitary\": null, \"item_code\": \"\", \"unit_price\": 14.16, \"cod_digemid\": null, \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"item_type_id\": \"01\", \"presentation\": [], \"unit_type_id\": \"NIU\", \"item_code_gs1\": null, \"IdLoteSelected\": null, \"purchase_unit_price\": \"0.000000\", \"amount_plastic_bag_taxes\": \"0.10\"}',1.0000,12.000000,'10',12.00,18.00,2.16,NULL,0.00,0.00,0.00,0.00,0.00,0.00,0.00,2.16,'01',14.160000,12.00,0.00,0.00,14.16,NULL,NULL,NULL,NULL,1,'<p>hjkhhjhkhjkhkhkhkhk</p><p>probando pdf</p>',NULL),(4,4,1,'{\"lots\": [], \"extra\": {\"colors\": null, \"string\": {\"colors\": \"\", \"CatItemSize\": \"\", \"CatItemStatus\": \"\", \"CatItemMoldCavity\": \"\", \"CatItemMoldProperty\": \"\", \"CatItemUnitBusiness\": \"\", \"CatItemProductFamily\": \"\", \"CatItemUnitsPerPackage\": \"\", \"CatItemPackageMeasurement\": \"\"}, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"is_set\": 0, \"has_igv\": false, \"sanitary\": null, \"item_code\": \"\", \"unit_price\": \"16.708800\", \"cod_digemid\": null, \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"item_type_id\": \"01\", \"presentation\": [], \"unit_type_id\": \"NIU\", \"item_code_gs1\": null, \"IdLoteSelected\": null, \"purchase_unit_price\": \"0.000000\", \"amount_plastic_bag_taxes\": \"0.10\"}',100.0000,14.160000,'10',1416.00,18.00,254.88,NULL,0.00,0.00,0.00,0.00,0.00,0.00,0.00,254.88,'01',16.708800,1416.00,0.00,0.00,1670.88,NULL,NULL,NULL,NULL,1,NULL,NULL),(5,5,1,'{\"lots\": [], \"extra\": {\"colors\": null, \"string\": {\"colors\": \"\", \"CatItemSize\": \"\", \"CatItemStatus\": \"\", \"CatItemMoldCavity\": \"\", \"CatItemMoldProperty\": \"\", \"CatItemUnitBusiness\": \"\", \"CatItemProductFamily\": \"\", \"CatItemUnitsPerPackage\": \"\", \"CatItemPackageMeasurement\": \"\"}, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"is_set\": 0, \"has_igv\": false, \"sanitary\": null, \"item_code\": \"\", \"unit_price\": 14.16, \"cod_digemid\": null, \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"item_type_id\": \"01\", \"presentation\": [], \"unit_type_id\": \"NIU\", \"item_code_gs1\": null, \"IdLoteSelected\": null, \"purchase_unit_price\": \"0.000000\", \"amount_plastic_bag_taxes\": \"0.10\"}',6.0000,12.000000,'10',72.00,18.00,12.96,NULL,0.00,0.00,0.00,0.00,0.00,0.00,0.00,12.96,'01',14.160000,72.00,0.00,0.00,84.96,NULL,NULL,NULL,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `document_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_payments`
--

DROP TABLE IF EXISTS `document_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` decimal(12,2) DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `document_payments_document_id_foreign` (`document_id`),
  KEY `document_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `document_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `document_payments_date_of_payment_index` (`date_of_payment`),
  CONSTRAINT `document_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `document_payments_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `document_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_payments`
--

LOCK TABLES `document_payments` WRITE;
/*!40000 ALTER TABLE `document_payments` DISABLE KEYS */;
INSERT INTO `document_payments` VALUES (3,3,'2026-03-14','04',0,NULL,NULL,NULL,14.16),(4,4,'2026-03-14','01',0,NULL,NULL,NULL,1670.88),(5,5,'2026-03-14','01',0,NULL,NULL,NULL,84.96);
/*!40000 ALTER TABLE `document_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_transports`
--

DROP TABLE IF EXISTS `document_transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_transports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `seat_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passenger_manifest` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_identity_document` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passenger_fullname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origin_district_id` json NOT NULL,
  `origin_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destinatation_district_id` json NOT NULL,
  `destinatation_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `document_transports_document_id_foreign` (`document_id`),
  KEY `document_transports_identity_document_type_id_foreign` (`identity_document_type_id`),
  CONSTRAINT `document_transports_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `document_transports_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_transports`
--

LOCK TABLES `document_transports` WRITE;
/*!40000 ALTER TABLE `document_transports` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_transports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_actions`
--

DROP TABLE IF EXISTS `documentary_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_actions`
--

LOCK TABLES `documentary_actions` WRITE;
/*!40000 ALTER TABLE `documentary_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_documents`
--

DROP TABLE IF EXISTS `documentary_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_documents`
--

LOCK TABLES `documentary_documents` WRITE;
/*!40000 ALTER TABLE `documentary_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_file_offices`
--

DROP TABLE IF EXISTS `documentary_file_offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_file_offices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentary_file_id` int(10) unsigned NOT NULL,
  `documentary_office_id` int(10) unsigned NOT NULL,
  `documentary_action_id` int(10) unsigned NOT NULL DEFAULT '0',
  `status` enum('POR DERIVAR','POR RECIBIR','EN PROCESO','FINALIZADO','ARCHIVADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'POR DERIVAR',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `office_name` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre de la etapa',
  `process_name` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre del tramite',
  `documentary_process_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tramite relacionado',
  `complete` int(11) NOT NULL DEFAULT '0' COMMENT 'Define si la etapa esta completa',
  `start_date` datetime DEFAULT NULL COMMENT 'Fecha de inicio',
  `end_date` datetime DEFAULT NULL COMMENT 'Fecha de finalizacion',
  `days` int(10) unsigned DEFAULT '0' COMMENT 'dias para el tramite',
  `observation` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `documentary_file_offices_documentary_file_id_foreign` (`documentary_file_id`),
  KEY `documentary_file_offices_documentary_office_id_foreign` (`documentary_office_id`),
  KEY `documentary_file_offices_documentary_action_id_foreign` (`documentary_action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_file_offices`
--

LOCK TABLES `documentary_file_offices` WRITE;
/*!40000 ALTER TABLE `documentary_file_offices` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_file_offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_files`
--

DROP TABLE IF EXISTS `documentary_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `documentary_document_id` int(10) unsigned DEFAULT '0',
  `documentary_process_id` int(10) unsigned NOT NULL,
  `number` mediumtext COLLATE utf8mb4_unicode_ci,
  `year` int(10) unsigned NOT NULL,
  `invoice` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_register` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_register` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `person_id` int(10) unsigned NOT NULL,
  `sender` longtext COLLATE utf8mb4_unicode_ci,
  `subject` longtext COLLATE utf8mb4_unicode_ci,
  `attached_file` longtext COLLATE utf8mb4_unicode_ci,
  `observation` text COLLATE utf8mb4_unicode_ci,
  `status` enum('RECIBIDO','DERIVADO','FINALIZADO','ARCHIVADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RECIBIDO',
  `documentary_office_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Define el ultimo proceso',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `requirements` longtext COLLATE utf8mb4_unicode_ci,
  `is_archive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'define si el tramite es simplificado',
  `is_simplify` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'define si el tramite es simplificado',
  `documentary_guides_number_status_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Cuando es simplificado, se usará este status',
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `establishment_id` int(10) unsigned NOT NULL DEFAULT '0',
  `date_end` datetime DEFAULT NULL COMMENT 'Fecha de finalización',
  PRIMARY KEY (`id`),
  KEY `documentary_files_documentary_document_id_foreign` (`documentary_document_id`),
  KEY `documentary_files_documentary_process_id_foreign` (`documentary_process_id`),
  KEY `documentary_files_person_id_foreign` (`person_id`),
  KEY `documentary_files_user_id_foreign` (`user_id`),
  CONSTRAINT `documentary_files_documentary_process_id_foreign` FOREIGN KEY (`documentary_process_id`) REFERENCES `documentary_processes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `documentary_files_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `documentary_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_files`
--

LOCK TABLES `documentary_files` WRITE;
/*!40000 ALTER TABLE `documentary_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_files_archives`
--

DROP TABLE IF EXISTS `documentary_files_archives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_files_archives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'usuario asociado',
  `documentary_file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Solicitud asociada',
  `documentary_office_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'etapa asociada',
  `observation` longtext COLLATE utf8mb4_unicode_ci COMMENT 'observacion',
  `attached_file` longtext COLLATE utf8mb4_unicode_ci COMMENT 'etapa asociada',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `documentary_guides_number_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_files_archives`
--

LOCK TABLES `documentary_files_archives` WRITE;
/*!40000 ALTER TABLE `documentary_files_archives` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_files_archives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_files_requirements`
--

DROP TABLE IF EXISTS `documentary_files_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_files_requirements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre a mostrar',
  `file` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Define si tiene archivo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_files_requirements`
--

LOCK TABLES `documentary_files_requirements` WRITE;
/*!40000 ALTER TABLE `documentary_files_requirements` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_files_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_guides_number`
--

DROP TABLE IF EXISTS `documentary_guides_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_guides_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_file_id` int(10) unsigned DEFAULT '0' COMMENT 'Expediente relacionado',
  `doc_office_id` int(10) unsigned DEFAULT '0' COMMENT 'Etapa observada',
  `guide` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Especifica la guia',
  `origin` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Especifica la instucion',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date_of_due` datetime DEFAULT NULL,
  `observation` longtext COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `date_take` datetime DEFAULT NULL COMMENT 'Fecha estimada de finalización',
  `date_end` datetime DEFAULT NULL COMMENT 'Fecha de finalización',
  `documentary_guides_number_status_id` int(10) unsigned DEFAULT '0' COMMENT 'relacionado con documentary_guides_number_status',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Responsable',
  `total_day` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_guides_number`
--

LOCK TABLES `documentary_guides_number` WRITE;
/*!40000 ALTER TABLE `documentary_guides_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_guides_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_guides_number_status`
--

DROP TABLE IF EXISTS `documentary_guides_number_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_guides_number_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_guides_number_status`
--

LOCK TABLES `documentary_guides_number_status` WRITE;
/*!40000 ALTER TABLE `documentary_guides_number_status` DISABLE KEYS */;
INSERT INTO `documentary_guides_number_status` VALUES (1,'En Calificación',NULL),(2,'Concluidos',NULL),(3,'Observados',NULL),(4,'Archivados',NULL);
/*!40000 ALTER TABLE `documentary_guides_number_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_observation`
--

DROP TABLE IF EXISTS `documentary_observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_observation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_file_id` int(10) unsigned DEFAULT '0' COMMENT 'Expediente relacionado',
  `observation` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Conjunto de etapas.',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_observation`
--

LOCK TABLES `documentary_observation` WRITE;
/*!40000 ALTER TABLE `documentary_observation` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_observation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_offices`
--

DROP TABLE IF EXISTS `documentary_offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_offices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `days` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_offices`
--

LOCK TABLES `documentary_offices` WRITE;
/*!40000 ALTER TABLE `documentary_offices` DISABLE KEYS */;
INSERT INTO `documentary_offices` VALUES (1,'Caja','',1,'2026-03-13 23:34:30','2026-03-13 23:34:30',0,0,NULL),(2,'Procesos','',1,'2026-03-13 23:34:30','2026-03-13 23:34:30',0,0,NULL),(3,'Seguimiento','',1,'2026-03-13 23:34:31','2026-03-13 23:34:31',0,0,NULL),(4,'Validacion','',1,'2026-03-13 23:34:31','2026-03-13 23:34:31',0,0,NULL);
/*!40000 ALTER TABLE `documentary_offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_processes`
--

DROP TABLE IF EXISTS `documentary_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_processes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,5) NOT NULL DEFAULT '0.00000',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `documentary_offices` longtext COLLATE utf8mb4_unicode_ci COMMENT 'etapas que contiene',
  `documentary_offices_order` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_processes`
--

LOCK TABLES `documentary_processes` WRITE;
/*!40000 ALTER TABLE `documentary_processes` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_processes_rel_file`
--

DROP TABLE IF EXISTS `documentary_processes_rel_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_processes_rel_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_processes_id` int(10) unsigned DEFAULT '0' COMMENT 'Requerimiento relacionado',
  `doc_file_id` int(10) unsigned DEFAULT '0' COMMENT 'Expediente relacionado',
  `doc_office_id` int(10) unsigned DEFAULT '0' COMMENT 'Etapa actual',
  `stages` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Conjunto de etapas.',
  `complete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Define si se ha completado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_processes_rel_file`
--

LOCK TABLES `documentary_processes_rel_file` WRITE;
/*!40000 ALTER TABLE `documentary_processes_rel_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_processes_rel_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_processes_rel_off`
--

DROP TABLE IF EXISTS `documentary_processes_rel_off`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_processes_rel_off` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_processes_id` int(10) unsigned DEFAULT '0' COMMENT 'Requerimiento relacionado',
  `doc_offices_id` int(10) unsigned DEFAULT '0' COMMENT 'Proceso relacionado',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Status de la relacion',
  `order` int(10) unsigned DEFAULT '1' COMMENT 'Establece el orden del proceso',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_processes_rel_off`
--

LOCK TABLES `documentary_processes_rel_off` WRITE;
/*!40000 ALTER TABLE `documentary_processes_rel_off` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_processes_rel_off` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentary_processes_rel_req`
--

DROP TABLE IF EXISTS `documentary_processes_rel_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentary_processes_rel_req` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_processes_id` int(10) unsigned DEFAULT '0' COMMENT 'Requerimiento relacionado',
  `doc_files_requirements_id` int(10) unsigned DEFAULT '0' COMMENT 'Proceso relacionado',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Status de la relacion',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentary_processes_rel_req`
--

LOCK TABLES `documentary_processes_rel_req` WRITE;
/*!40000 ALTER TABLE `documentary_processes_rel_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentary_processes_rel_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_condition_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_order` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plate_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_id` int(10) unsigned DEFAULT NULL,
  `sale_note_id` int(10) unsigned DEFAULT NULL,
  `user_rel_suscription_plan_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con suscripciones',
  `technical_service_id` int(10) unsigned DEFAULT NULL,
  `order_note_id` int(10) unsigned DEFAULT NULL,
  `dispatch_id` int(10) unsigned DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `automatic_date_of_issue` date DEFAULT NULL,
  `type_period` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity_period` int(11) DEFAULT NULL,
  `enabled_concurrency` tinyint(3) unsigned DEFAULT '0',
  `apply_concurrency` tinyint(3) unsigned DEFAULT '0',
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_plastic_bag_taxes` decimal(6,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `has_prepayment` tinyint(1) NOT NULL DEFAULT '0',
  `affectation_type_prepayment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `was_deducted_prepayment` tinyint(1) NOT NULL DEFAULT '0',
  `pending_amount_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_pending_payment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `retention` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `additional_information` text COLLATE utf8mb4_unicode_ci,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unique_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr` longtext COLLATE utf8mb4_unicode_ci COMMENT ' ',
  `reference_data` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_xml` tinyint(1) NOT NULL DEFAULT '0',
  `has_pdf` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `data_json` json DEFAULT NULL,
  `send_server` tinyint(1) NOT NULL DEFAULT '1',
  `success_shipping_status` tinyint(1) NOT NULL DEFAULT '0',
  `shipping_status` json DEFAULT NULL,
  `success_sunat_shipping_status` tinyint(1) NOT NULL DEFAULT '0',
  `sunat_shipping_status` json DEFAULT NULL,
  `query_status` json DEFAULT NULL,
  `success_query_status` tinyint(1) NOT NULL DEFAULT '0',
  `total_canceled` tinyint(1) NOT NULL DEFAULT '0',
  `soap_shipping_response` json DEFAULT NULL,
  `regularize_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `response_regularize_shipping` json DEFAULT NULL,
  `send_to_pse` tinyint(1) NOT NULL DEFAULT '0',
  `response_signature_pse` json DEFAULT NULL,
  `response_send_cdr_pse` json DEFAULT NULL,
  `sale_notes_relateds` json DEFAULT NULL COMMENT 'registros asociados cuando se genera cpe desde multiples notas de venta',
  `terms_condition` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_editable` tinyint(1) NOT NULL DEFAULT '0',
  `grade` text COLLATE utf8mb4_unicode_ci COMMENT 'Grado designado - utilizado en matricula',
  `section` text COLLATE utf8mb4_unicode_ci COMMENT 'Seccion designado - utilizado en matricula',
  PRIMARY KEY (`id`),
  UNIQUE KEY `documents_unique_filename_unique` (`unique_filename`),
  KEY `documents_user_id_foreign` (`user_id`),
  KEY `documents_establishment_id_foreign` (`establishment_id`),
  KEY `documents_customer_id_foreign` (`customer_id`),
  KEY `documents_soap_type_id_foreign` (`soap_type_id`),
  KEY `documents_state_type_id_foreign` (`state_type_id`),
  KEY `documents_group_id_foreign` (`group_id`),
  KEY `documents_document_type_id_foreign` (`document_type_id`),
  KEY `documents_currency_type_id_foreign` (`currency_type_id`),
  KEY `documents_quotation_id_foreign` (`quotation_id`),
  KEY `documents_external_id_index` (`external_id`),
  KEY `documents_sale_note_id_foreign` (`sale_note_id`),
  KEY `documents_series_index` (`series`),
  KEY `documents_number_index` (`number`),
  KEY `documents_date_of_issue_index` (`date_of_issue`),
  KEY `documents_order_note_id_foreign` (`order_note_id`),
  KEY `documents_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `documents_seller_id_foreign` (`seller_id`),
  KEY `documents_payment_condition_id_foreign` (`payment_condition_id`),
  KEY `documents_dispatch_id_foreign` (`dispatch_id`),
  KEY `documents_technical_service_id_foreign` (`technical_service_id`),
  KEY `documents_type_period_index` (`type_period`),
  KEY `documents_regularize_shipping_index` (`regularize_shipping`),
  CONSTRAINT `documents_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `documents_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `documents_dispatch_id_foreign` FOREIGN KEY (`dispatch_id`) REFERENCES `dispatches` (`id`),
  CONSTRAINT `documents_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `documents_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `documents_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `documents_order_note_id_foreign` FOREIGN KEY (`order_note_id`) REFERENCES `order_notes` (`id`),
  CONSTRAINT `documents_payment_condition_id_foreign` FOREIGN KEY (`payment_condition_id`) REFERENCES `payment_conditions` (`id`),
  CONSTRAINT `documents_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `documents_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`),
  CONSTRAINT `documents_sale_note_id_foreign` FOREIGN KEY (`sale_note_id`) REFERENCES `sale_notes` (`id`),
  CONSTRAINT `documents_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`),
  CONSTRAINT `documents_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `documents_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `documents_technical_service_id_foreign` FOREIGN KEY (`technical_service_id`) REFERENCES `technical_services` (`id`),
  CONSTRAINT `documents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (3,1,'59ef2d15-d3b6-416b-af70-883f168722aa',1,'{\"code\": \"0000\", \"logo\": null, \"email\": \"admin@gmail.com\", \"address\": \"-\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150101\", \"description\": \"Lima\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": \"-\", \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"district_id\": \"150101\", \"province_id\": \"1501\", \"web_address\": null, \"urbanization\": null, \"department_id\": \"15\", \"trade_address\": null, \"aditional_information\": null}','01','05','2.1','01','01','F001',1,'2026-03-14','11:19:09',1,'{\"name\": \"San Fernando\", \"email\": null, \"number\": \"20100154308\", \"address\": \"Ate Vitarte\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150103\", \"description\": \"Ate\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": null, \"address_id\": null, \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"trade_name\": null, \"district_id\": \"150103\", \"province_id\": \"1501\", \"address_type\": {\"id\": null, \"description\": null}, \"department_id\": \"15\", \"internal_code\": null, \"address_type_id\": null, \"perception_agent\": false, \"identity_document_type\": {\"id\": \"6\", \"description\": \"RUC\"}, \"identity_document_type_id\": \"6\"}','PEN','01',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,3.453,NULL,NULL,NULL,0,0,0.00,0.00,0.00,0.00,0.00,12.00,0.00,0.00,2.16,0.00,0.00,0.00,0.00,0.00,0.00,2.16,12.00,14.16,14.16,0,NULL,0,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"code\": 1000, \"value\": \"Catorce  con 16/100 \"}]',NULL,'20600206011-01-F001-1','20600206011-01-F001-1','VdfLTi7Aw+dYBpCTFc1Wo+clGRQ=','iVBORw0KGgoAAAANSUhEUgAAAJYAAACWCAIAAACzY+a1AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAgAElEQVR4AQCbgGR/Af///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANLcMRYAACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAv/wBkAAAIABJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAsQpKMAAAgAElEQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYVgZwAACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACbgGR/BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAnS0ZgQAAIABJREFUAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD8Z8WAAAAgAElEQVQAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABVu2m4AACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJrN3CwAACFdJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEMB/P4AgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhcpl3rlDQDAAAAAElFTkSuQmCC',NULL,0,0,0,NULL,0,0,NULL,0,NULL,NULL,0,1,'{\"code\": \"0\", \"sent\": true, \"notes\": [], \"description\": \"La Factura numero F001-1, ha sido aceptada\"}',0,NULL,0,NULL,NULL,NULL,'','2026-03-14 11:21:18','2026-03-14 11:21:19',1,NULL,NULL),(4,1,'36b8d609-328b-4b0c-900b-26af91fc7af6',1,'{\"code\": \"0000\", \"logo\": null, \"email\": \"admin@gmail.com\", \"address\": \"-\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150101\", \"description\": \"Lima\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": \"-\", \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"district_id\": \"150101\", \"province_id\": \"1501\", \"web_address\": null, \"urbanization\": null, \"department_id\": \"15\", \"trade_address\": null, \"aditional_information\": null}','01','05','2.1','01','01','F001',2,'2026-03-14','11:59:39',2,'{\"name\": \"Jean\", \"email\": null, \"number\": \"10417663431\", \"address\": null, \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": null, \"description\": null}, \"province\": {\"id\": null, \"description\": null}, \"telephone\": null, \"address_id\": null, \"country_id\": \"PE\", \"department\": {\"id\": null, \"description\": null}, \"trade_name\": null, \"district_id\": null, \"province_id\": null, \"address_type\": {\"id\": null, \"description\": null}, \"department_id\": null, \"internal_code\": null, \"address_type_id\": null, \"perception_agent\": false, \"identity_document_type\": {\"id\": \"6\", \"description\": \"RUC\"}, \"identity_document_type_id\": \"6\"}','PEN','01',NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,1,3.453,NULL,NULL,NULL,0,0,0.00,0.00,0.00,0.00,0.00,1416.00,0.00,0.00,254.88,0.00,0.00,0.00,0.00,0.00,0.00,254.88,1416.00,1670.88,1670.88,0,NULL,0,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"base\": \"1670.88\", \"code\": \"62\", \"amount\": 50.13, \"percentage\": 0.03}','[{\"code\": 1000, \"value\": \"Mil seiscientos setenta  con 88/100 \"}]',NULL,'20600206011-01-F001-2','20600206011-01-F001-2','l9HSEhNzcOAPlVYkabxWA/ukXyk=','iVBORw0KGgoAAAANSUhEUgAAAJYAAACWCAIAAACzY+a1AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAgAElEQVR4AQCbgGR/Af///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGO0assAACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa5pa4AAAIABJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADUOcxfAAAgAElEQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPWW4e0AACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACbgGR/BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAA////AAAAAAAAAAAAAAAAAAAAJnN8CQAAIABJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACcCGRcAAAgAElEQVQAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACTn64AACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVOy7RQAACFdJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEMB/P4AgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFZorFqHr3z3AAAAAElFTkSuQmCC',NULL,0,0,0,NULL,0,0,NULL,0,NULL,NULL,0,1,'{\"code\": \"0\", \"sent\": true, \"notes\": [], \"description\": \"La Factura numero F001-2, ha sido aceptada\"}',0,NULL,0,NULL,NULL,NULL,'','2026-03-14 11:59:39','2026-03-14 11:59:39',1,NULL,NULL),(5,1,'06521e6b-0d3e-40c5-8773-8182eee66c8b',1,'{\"code\": \"0000\", \"logo\": null, \"email\": \"admin@gmail.com\", \"address\": \"-\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150101\", \"description\": \"Lima\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": \"-\", \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"district_id\": \"150101\", \"province_id\": \"1501\", \"web_address\": null, \"urbanization\": null, \"department_id\": \"15\", \"trade_address\": null, \"aditional_information\": null}','01','05','2.1','01','01','F001',3,'2026-03-14','13:25:30',3,'{\"name\": \"prueba\", \"email\": null, \"number\": \"10292883432\", \"address\": null, \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": null, \"description\": null}, \"province\": {\"id\": null, \"description\": null}, \"telephone\": null, \"address_id\": null, \"country_id\": \"PE\", \"department\": {\"id\": null, \"description\": null}, \"trade_name\": null, \"district_id\": null, \"province_id\": null, \"address_type\": {\"id\": null, \"description\": null}, \"department_id\": null, \"internal_code\": null, \"address_type_id\": null, \"perception_agent\": false, \"identity_document_type\": {\"id\": \"6\", \"description\": \"RUC\"}, \"identity_document_type_id\": \"6\"}','PEN','01',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,3.453,NULL,NULL,NULL,0,0,0.00,0.00,0.00,0.00,0.00,72.00,0.00,0.00,12.96,0.00,0.00,0.00,0.00,0.00,0.00,12.96,72.00,84.96,84.96,0,NULL,0,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[{\"code\": 1000, \"value\": \"Ochenta y cuatro  con 96/100 \"}]',NULL,'20600206011-01-F001-3','20600206011-01-F001-3','plrg0E0RMzkD6XubM7HKOZMfj2k=','iVBORw0KGgoAAAANSUhEUgAAAJYAAACWCAIAAACzY+a1AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAgAElEQVR4AQCbgGR/Af///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACryPM0AACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEWmL0gAAIABJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD0wJucAAAgAElEQVQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAK/862oAACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACbgGR/BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAb8gTlQAAIABJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADt+XrSAAAgAElEQVQAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAD///8AAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAABAQEAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEAAAAAAAAAAAD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AAAAAAAAAAAAAQEBAAAAAAAAAAAAAAAAAAAAAQEBAAAAAAAAAAAA////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKuTAIkAACAASURBVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAEBAQAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAvrlJRgAACFdJREFUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEMB/P4AgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAN4bvkUMCUkMAAAAAElFTkSuQmCC',NULL,0,0,0,NULL,0,0,NULL,0,NULL,NULL,0,1,'{\"code\": \"0\", \"sent\": true, \"notes\": [], \"description\": \"La Factura numero F001-3, ha sido aceptada\"}',0,NULL,0,NULL,NULL,NULL,'','2026-03-14 13:26:43','2026-03-14 13:26:44',1,NULL,NULL);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `download_tray`
--

DROP TABLE IF EXISTS `download_tray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `download_tray` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'IN_PROCESS',
  `date_init` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `payload_request` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `download_tray_user_id_foreign` (`user_id`),
  CONSTRAINT `download_tray_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download_tray`
--

LOCK TABLES `download_tray` WRITE;
/*!40000 ALTER TABLE `download_tray` DISABLE KEYS */;
/*!40000 ALTER TABLE `download_tray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drivers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `license` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drivers_identity_document_type_id_foreign` (`identity_document_type_id`),
  KEY `drivers_number_index` (`number`),
  KEY `drivers_name_index` (`name`),
  CONSTRAINT `drivers_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_send_log`
--

DROP TABLE IF EXISTS `email_send_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_send_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `relation_id` int(10) unsigned DEFAULT '0' COMMENT 'Id de modelo',
  `type` int(10) unsigned DEFAULT '0' COMMENT 'Tipo de relacion',
  `relation_model` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Modelo a relacion',
  `file_line` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Archivo qu elo llama',
  `sendit` tinyint(3) unsigned DEFAULT '1' COMMENT 'Booleano para envio de correo',
  `email` text COLLATE utf8mb4_unicode_ci COMMENT 'Correo de destino',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_send_log`
--

LOCK TABLES `email_send_log` WRITE;
/*!40000 ALTER TABLE `email_send_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_send_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `establishments`
--

DROP TABLE IF EXISTS `establishments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `establishments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_id` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` char(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aditional_information` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trade_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `logo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_pdf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `template_ticket_pdf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `establishments_country_id_foreign` (`country_id`),
  KEY `establishments_department_id_foreign` (`department_id`),
  KEY `establishments_province_id_foreign` (`province_id`),
  KEY `establishments_district_id_foreign` (`district_id`),
  CONSTRAINT `establishments_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `establishments_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `establishments_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`),
  CONSTRAINT `establishments_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `establishments`
--

LOCK TABLES `establishments` WRITE;
/*!40000 ALTER TABLE `establishments` DISABLE KEYS */;
INSERT INTO `establishments` VALUES (1,'Oficina Principal','PE','15','1501','150101','-','admin@gmail.com','-','0000',NULL,NULL,NULL,NULL,NULL,'default','default',NULL,NULL);
/*!40000 ALTER TABLE `establishments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_rates` (
  `date` date NOT NULL,
  `sale_original` decimal(13,3) NOT NULL,
  `purchase_original` decimal(13,3) NOT NULL,
  `purchase` decimal(13,3) NOT NULL,
  `sale` decimal(13,3) NOT NULL,
  `date_original` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_rates`
--

LOCK TABLES `exchange_rates` WRITE;
/*!40000 ALTER TABLE `exchange_rates` DISABLE KEYS */;
INSERT INTO `exchange_rates` VALUES ('2026-03-13',3.449,3.440,3.440,3.449,'2026-03-13','2026-03-13 23:45:59','2026-03-13 23:45:59'),('2026-03-14',3.453,3.446,3.446,3.453,'2026-03-14','2026-03-14 11:06:51','2026-03-14 11:06:51');
/*!40000 ALTER TABLE `exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_items`
--

DROP TABLE IF EXISTS `expense_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `expense_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_items_expense_id_foreign` (`expense_id`),
  CONSTRAINT `expense_items_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_items`
--

LOCK TABLES `expense_items` WRITE;
/*!40000 ALTER TABLE `expense_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_method_types`
--

DROP TABLE IF EXISTS `expense_method_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_method_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_method_types`
--

LOCK TABLES `expense_method_types` WRITE;
/*!40000 ALTER TABLE `expense_method_types` DISABLE KEYS */;
INSERT INTO `expense_method_types` VALUES (1,'CAJA GENERAL',0),(2,'Tarjeta de crédito',1),(3,'Tarjeta de débito',1);
/*!40000 ALTER TABLE `expense_method_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_payments`
--

DROP TABLE IF EXISTS `expense_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `expense_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `expense_method_type_id` int(10) unsigned NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_payments_expense_id_foreign` (`expense_id`),
  KEY `expense_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `expense_payments_expense_method_type_id_foreign` (`expense_method_type_id`),
  KEY `expense_payments_date_of_payment_index` (`date_of_payment`),
  CONSTRAINT `expense_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `expense_payments_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `expense_payments_expense_method_type_id_foreign` FOREIGN KEY (`expense_method_type_id`) REFERENCES `expense_method_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_payments`
--

LOCK TABLES `expense_payments` WRITE;
/*!40000 ALTER TABLE `expense_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_reasons`
--

DROP TABLE IF EXISTS `expense_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_reasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_reasons`
--

LOCK TABLES `expense_reasons` WRITE;
/*!40000 ALTER TABLE `expense_reasons` DISABLE KEYS */;
INSERT INTO `expense_reasons` VALUES (1,'Varios'),(2,'Representación de la organización'),(3,'Trabajo de campo');
/*!40000 ALTER TABLE `expense_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_types`
--

DROP TABLE IF EXISTS `expense_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_types`
--

LOCK TABLES `expense_types` WRITE;
/*!40000 ALTER TABLE `expense_types` DISABLE KEYS */;
INSERT INTO `expense_types` VALUES (1,'PLANILLA','2026-03-13 23:32:39','2026-03-13 23:32:39'),(2,'RECIBO POR HONORARIO','2026-03-13 23:32:39','2026-03-13 23:32:39'),(3,'SERVICIO PÚBLICO','2026-03-13 23:32:39','2026-03-13 23:32:39'),(4,'OTROS','2026-03-13 23:32:39','2026-03-13 23:32:39');
/*!40000 ALTER TABLE `expense_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_type_id` int(10) unsigned NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `expense_reason_id` int(10) unsigned NOT NULL DEFAULT '1',
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `supplier` json NOT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_user_id_foreign` (`user_id`),
  KEY `expenses_establishment_id_foreign` (`establishment_id`),
  KEY `expenses_supplier_id_foreign` (`supplier_id`),
  KEY `expenses_expense_type_id_foreign` (`expense_type_id`),
  KEY `expenses_currency_type_id_foreign` (`currency_type_id`),
  KEY `expenses_expense_reason_id_foreign` (`expense_reason_id`),
  KEY `expenses_soap_type_id_foreign` (`soap_type_id`),
  KEY `expenses_state_type_id_foreign` (`state_type_id`),
  CONSTRAINT `expenses_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `expenses_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `expenses_expense_reason_id_foreign` FOREIGN KEY (`expense_reason_id`) REFERENCES `expense_reasons` (`id`),
  CONSTRAINT `expenses_expense_type_id_foreign` FOREIGN KEY (`expense_type_id`) REFERENCES `expense_types` (`id`),
  CONSTRAINT `expenses_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `expenses_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `expenses_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_asset_items`
--

DROP TABLE IF EXISTS `fixed_asset_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixed_asset_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `internal_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_unit_price` decimal(16,6) NOT NULL,
  `purchase_affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fixed_asset_items_item_type_id_foreign` (`item_type_id`),
  KEY `fixed_asset_items_unit_type_id_foreign` (`unit_type_id`),
  KEY `fixed_asset_items_currency_type_id_foreign` (`currency_type_id`),
  KEY `fixed_asset_items_purchase_affectation_igv_type_id_foreign` (`purchase_affectation_igv_type_id`),
  CONSTRAINT `fixed_asset_items_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `fixed_asset_items_item_type_id_foreign` FOREIGN KEY (`item_type_id`) REFERENCES `item_types` (`id`),
  CONSTRAINT `fixed_asset_items_purchase_affectation_igv_type_id_foreign` FOREIGN KEY (`purchase_affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `fixed_asset_items_unit_type_id_foreign` FOREIGN KEY (`unit_type_id`) REFERENCES `cat_unit_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_asset_items`
--

LOCK TABLES `fixed_asset_items` WRITE;
/*!40000 ALTER TABLE `fixed_asset_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_asset_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_asset_purchase_items`
--

DROP TABLE IF EXISTS `fixed_asset_purchase_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixed_asset_purchase_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fixed_asset_purchase_id` int(10) unsigned NOT NULL,
  `fixed_asset_item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fixed_asset_purchase_items_fixed_asset_purchase_id_foreign` (`fixed_asset_purchase_id`),
  KEY `fixed_asset_purchase_items_fixed_asset_item_id_foreign` (`fixed_asset_item_id`),
  KEY `fixed_asset_purchase_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `fixed_asset_purchase_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `fixed_asset_purchase_items_price_type_id_foreign` (`price_type_id`),
  CONSTRAINT `fixed_asset_purchase_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `fixed_asset_purchase_items_fixed_asset_item_id_foreign` FOREIGN KEY (`fixed_asset_item_id`) REFERENCES `fixed_asset_items` (`id`),
  CONSTRAINT `fixed_asset_purchase_items_fixed_asset_purchase_id_foreign` FOREIGN KEY (`fixed_asset_purchase_id`) REFERENCES `fixed_asset_purchases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fixed_asset_purchase_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `fixed_asset_purchase_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_asset_purchase_items`
--

LOCK TABLES `fixed_asset_purchase_items` WRITE;
/*!40000 ALTER TABLE `fixed_asset_purchase_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_asset_purchase_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_asset_purchases`
--

DROP TABLE IF EXISTS `fixed_asset_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixed_asset_purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `date_of_due` date DEFAULT NULL,
  `time_of_issue` time NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `supplier` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `perception_date` date DEFAULT NULL,
  `perception_number` int(11) DEFAULT NULL,
  `total_perception` decimal(12,2) DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fixed_asset_purchases_user_id_foreign` (`user_id`),
  KEY `fixed_asset_purchases_establishment_id_foreign` (`establishment_id`),
  KEY `fixed_asset_purchases_supplier_id_foreign` (`supplier_id`),
  KEY `fixed_asset_purchases_customer_id_foreign` (`customer_id`),
  KEY `fixed_asset_purchases_soap_type_id_foreign` (`soap_type_id`),
  KEY `fixed_asset_purchases_state_type_id_foreign` (`state_type_id`),
  KEY `fixed_asset_purchases_group_id_foreign` (`group_id`),
  KEY `fixed_asset_purchases_document_type_id_foreign` (`document_type_id`),
  KEY `fixed_asset_purchases_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `fixed_asset_purchases_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `fixed_asset_purchases_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fixed_asset_purchases_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `fixed_asset_purchases_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `fixed_asset_purchases_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `fixed_asset_purchases_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `fixed_asset_purchases_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `fixed_asset_purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `fixed_asset_purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_asset_purchases`
--

LOCK TABLES `fixed_asset_purchases` WRITE;
/*!40000 ALTER TABLE `fixed_asset_purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_asset_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `format_templates`
--

DROP TABLE IF EXISTS `format_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `format_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `formats` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `urls` json DEFAULT NULL,
  `is_custom_ticket` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `format_templates`
--

LOCK TABLES `format_templates` WRITE;
/*!40000 ALTER TABLE `format_templates` DISABLE KEYS */;
INSERT INTO `format_templates` VALUES (1,'con_valor_unitario',NULL,0),(2,'default',NULL,0),(3,'default2',NULL,0),(4,'font_sm',NULL,0),(5,'font_sw2',NULL,0),(6,'legend_amazonia',NULL,0),(7,'model1',NULL,0),(8,'model2',NULL,0),(9,'model3',NULL,0),(10,'model4',NULL,0),(11,'modelw80',NULL,0),(12,'santiago',NULL,0),(13,'top_placa',NULL,0),(14,'unit_types_desc',NULL,0);
/*!40000 ALTER TABLE `format_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `full_suscription_server_data`
--

DROP TABLE IF EXISTS `full_suscription_server_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `full_suscription_server_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int(10) unsigned DEFAULT '0',
  `host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `full_suscription_server_data`
--

LOCK TABLES `full_suscription_server_data` WRITE;
/*!40000 ALTER TABLE `full_suscription_server_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `full_suscription_server_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `full_suscription_user_data`
--

DROP TABLE IF EXISTS `full_suscription_user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `full_suscription_user_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int(10) unsigned DEFAULT '0',
  `discord_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slack_channel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discord_channel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gitlab_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `full_suscription_user_data`
--

LOCK TABLES `full_suscription_user_data` WRITE;
/*!40000 ALTER TABLE `full_suscription_user_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `full_suscription_user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_payment_conditions`
--

DROP TABLE IF EXISTS `general_payment_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_payment_conditions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_payment_conditions`
--

LOCK TABLES `general_payment_conditions` WRITE;
/*!40000 ALTER TABLE `general_payment_conditions` DISABLE KEYS */;
INSERT INTO `general_payment_conditions` VALUES ('01','Contado'),('02','Crédito'),('03','Crédito con cuotas');
/*!40000 ALTER TABLE `general_payment_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_payments`
--

DROP TABLE IF EXISTS `global_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `destination_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` int(11) NOT NULL,
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `destination_index` (`destination_id`,`destination_type`),
  KEY `payment_index` (`payment_id`,`payment_type`),
  KEY `global_payments_soap_type_id_foreign` (`soap_type_id`),
  KEY `global_payments_user_id_foreign` (`user_id`),
  CONSTRAINT `global_payments_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `global_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_payments`
--

LOCK TABLES `global_payments` WRITE;
/*!40000 ALTER TABLE `global_payments` DISABLE KEYS */;
INSERT INTO `global_payments` VALUES (1,'01',1,'App\\Models\\Tenant\\Cash',1,'Modules\\Pos\\Models\\CashTransaction',1,'2026-03-14 11:17:51','2026-03-14 11:17:51'),(4,'01',1,'App\\Models\\Tenant\\BankAccount',3,'App\\Models\\Tenant\\DocumentPayment',1,'2026-03-14 11:21:18','2026-03-14 11:21:18'),(5,'01',1,'App\\Models\\Tenant\\Cash',1,'Modules\\Sale\\Models\\QuotationPayment',1,'2026-03-14 11:51:50','2026-03-14 11:51:50'),(6,'01',1,'App\\Models\\Tenant\\Cash',4,'App\\Models\\Tenant\\DocumentPayment',1,'2026-03-14 11:59:39','2026-03-14 11:59:39'),(7,'01',1,'App\\Models\\Tenant\\Cash',5,'App\\Models\\Tenant\\DocumentPayment',1,'2026-03-14 13:26:43','2026-03-14 13:26:43');
/*!40000 ALTER TABLE `global_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `groups_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES ('01','Facturas'),('02','Boletas');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guide_files`
--

DROP TABLE IF EXISTS `guide_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guide_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` text COLLATE utf8mb4_unicode_ci COMMENT 'Nombre de archivo',
  `purchase_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con purchases',
  `document_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con documents',
  `order_note_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con order_notes',
  `quotation_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con quotations',
  `sale_note_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con sale_notes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guide_files`
--

LOCK TABLES `guide_files` WRITE;
/*!40000 ALTER TABLE `guide_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `guide_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_categories`
--

DROP TABLE IF EXISTS `hotel_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_categories`
--

LOCK TABLES `hotel_categories` WRITE;
/*!40000 ALTER TABLE `hotel_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_floors`
--

DROP TABLE IF EXISTS `hotel_floors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_floors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_floors`
--

LOCK TABLES `hotel_floors` WRITE;
/*!40000 ALTER TABLE `hotel_floors` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_floors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_rates`
--

DROP TABLE IF EXISTS `hotel_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_rates`
--

LOCK TABLES `hotel_rates` WRITE;
/*!40000 ALTER TABLE `hotel_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_rent_items`
--

DROP TABLE IF EXISTS `hotel_rent_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_rent_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hotel_rent_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` text COLLATE utf8mb4_unicode_ci,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_rent_items_hotel_rent_id_foreign` (`hotel_rent_id`),
  KEY `hotel_rent_items_item_id_foreign` (`item_id`),
  CONSTRAINT `hotel_rent_items_hotel_rent_id_foreign` FOREIGN KEY (`hotel_rent_id`) REFERENCES `hotel_rents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hotel_rent_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_rent_items`
--

LOCK TABLES `hotel_rent_items` WRITE;
/*!40000 ALTER TABLE `hotel_rent_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_rent_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_rents`
--

DROP TABLE IF EXISTS `hotel_rents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_rents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `towels` int(11) NOT NULL DEFAULT '1',
  `hotel_room_id` int(10) unsigned NOT NULL,
  `duration` int(11) NOT NULL DEFAULT '1',
  `quantity_persons` int(11) NOT NULL DEFAULT '1',
  `input_date` date DEFAULT NULL,
  `input_time` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `output_date` date NOT NULL,
  `output_time` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `arrears` int(11) NOT NULL DEFAULT '0',
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INICIADO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_rents`
--

LOCK TABLES `hotel_rents` WRITE;
/*!40000 ALTER TABLE `hotel_rents` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_rents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_room_rates`
--

DROP TABLE IF EXISTS `hotel_room_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_room_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hotel_room_id` int(10) unsigned NOT NULL,
  `hotel_rate_id` int(10) unsigned NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_room_rates_hotel_room_id_foreign` (`hotel_room_id`),
  KEY `hotel_room_rates_hotel_rate_id_foreign` (`hotel_rate_id`),
  CONSTRAINT `hotel_room_rates_hotel_rate_id_foreign` FOREIGN KEY (`hotel_rate_id`) REFERENCES `hotel_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hotel_room_rates_hotel_room_id_foreign` FOREIGN KEY (`hotel_room_id`) REFERENCES `hotel_rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_room_rates`
--

LOCK TABLES `hotel_room_rates` WRITE;
/*!40000 ALTER TABLE `hotel_room_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_room_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_rooms`
--

DROP TABLE IF EXISTS `hotel_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT NULL,
  `hotel_category_id` int(10) unsigned NOT NULL,
  `hotel_floor_id` int(10) unsigned NOT NULL,
  `name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DISPONIBLE',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_rooms_hotel_category_id_foreign` (`hotel_category_id`),
  KEY `hotel_rooms_hotel_floor_id_foreign` (`hotel_floor_id`),
  KEY `hotel_rooms_item_id_foreign` (`item_id`),
  CONSTRAINT `hotel_rooms_hotel_category_id_foreign` FOREIGN KEY (`hotel_category_id`) REFERENCES `hotel_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hotel_rooms_hotel_floor_id_foreign` FOREIGN KEY (`hotel_floor_id`) REFERENCES `hotel_floors` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hotel_rooms_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_rooms`
--

LOCK TABLES `hotel_rooms` WRITE;
/*!40000 ALTER TABLE `hotel_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income`
--

DROP TABLE IF EXISTS `income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `income_type_id` int(10) unsigned NOT NULL,
  `income_reason_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `customer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `income_user_id_foreign` (`user_id`),
  KEY `income_establishment_id_foreign` (`establishment_id`),
  KEY `income_income_type_id_foreign` (`income_type_id`),
  KEY `income_income_reason_id_foreign` (`income_reason_id`),
  KEY `income_state_type_id_foreign` (`state_type_id`),
  KEY `income_soap_type_id_foreign` (`soap_type_id`),
  KEY `income_currency_type_id_foreign` (`currency_type_id`),
  KEY `income_number_index` (`number`),
  KEY `income_date_of_issue_index` (`date_of_issue`),
  CONSTRAINT `income_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `income_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `income_income_reason_id_foreign` FOREIGN KEY (`income_reason_id`) REFERENCES `income_reasons` (`id`),
  CONSTRAINT `income_income_type_id_foreign` FOREIGN KEY (`income_type_id`) REFERENCES `income_types` (`id`),
  CONSTRAINT `income_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `income_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `income_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income`
--

LOCK TABLES `income` WRITE;
/*!40000 ALTER TABLE `income` DISABLE KEYS */;
/*!40000 ALTER TABLE `income` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_items`
--

DROP TABLE IF EXISTS `income_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `income_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `income_items_income_id_foreign` (`income_id`),
  CONSTRAINT `income_items_income_id_foreign` FOREIGN KEY (`income_id`) REFERENCES `income` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_items`
--

LOCK TABLES `income_items` WRITE;
/*!40000 ALTER TABLE `income_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_payments`
--

DROP TABLE IF EXISTS `income_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `income_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` decimal(12,2) DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `income_payments_income_id_foreign` (`income_id`),
  KEY `income_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `income_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `income_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `income_payments_income_id_foreign` FOREIGN KEY (`income_id`) REFERENCES `income` (`id`) ON DELETE CASCADE,
  CONSTRAINT `income_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_payments`
--

LOCK TABLES `income_payments` WRITE;
/*!40000 ALTER TABLE `income_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_reasons`
--

DROP TABLE IF EXISTS `income_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_reasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_reasons`
--

LOCK TABLES `income_reasons` WRITE;
/*!40000 ALTER TABLE `income_reasons` DISABLE KEYS */;
INSERT INTO `income_reasons` VALUES (1,'Varios');
/*!40000 ALTER TABLE `income_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_types`
--

DROP TABLE IF EXISTS `income_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_types`
--

LOCK TABLES `income_types` WRITE;
/*!40000 ALTER TABLE `income_types` DISABLE KEYS */;
INSERT INTO `income_types` VALUES (1,'INGRESOS FINANCIEROS','2026-03-13 23:33:48','2026-03-13 23:33:48'),(2,'PRESTAMOS','2026-03-13 23:33:48','2026-03-13 23:33:48'),(3,'OTROS','2026-03-13 23:33:48','2026-03-13 23:33:48');
/*!40000 ALTER TABLE `income_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventories`
--

DROP TABLE IF EXISTS `inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('1','2','3') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `warehouse_id` int(10) unsigned NOT NULL,
  `warehouse_destination_id` int(10) unsigned DEFAULT NULL,
  `inventory_transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `lot_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventories_transfer_id` int(10) unsigned DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventories_item_id_foreign` (`item_id`),
  KEY `inventories_warehouse_id_foreign` (`warehouse_id`),
  KEY `inventories_inventory_transaction_id_foreign` (`inventory_transaction_id`),
  KEY `inventories_inventories_transfer_id_foreign` (`inventories_transfer_id`),
  CONSTRAINT `inventories_inventories_transfer_id_foreign` FOREIGN KEY (`inventories_transfer_id`) REFERENCES `inventories_transfer` (`id`),
  CONSTRAINT `inventories_inventory_transaction_id_foreign` FOREIGN KEY (`inventory_transaction_id`) REFERENCES `inventory_transactions` (`id`),
  CONSTRAINT `inventories_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventories_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventories`
--

LOCK TABLES `inventories` WRITE;
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT INTO `inventories` VALUES (1,'1','Stock inicial',NULL,1,1,NULL,NULL,100.0000,NULL,NULL,NULL,'2026-03-14 11:13:29','2026-03-14 11:13:29');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventories_transfer`
--

DROP TABLE IF EXISTS `inventories_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventories_transfer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` int(10) unsigned NOT NULL,
  `warehouse_destination_id` int(10) unsigned NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT '0' COMMENT 'usuario que crea el registro',
  PRIMARY KEY (`id`),
  KEY `inventories_transfer_warehouse_id_foreign` (`warehouse_id`),
  KEY `inventories_transfer_warehouse_destination_id_foreign` (`warehouse_destination_id`),
  CONSTRAINT `inventories_transfer_warehouse_destination_id_foreign` FOREIGN KEY (`warehouse_destination_id`) REFERENCES `warehouses` (`id`),
  CONSTRAINT `inventories_transfer_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventories_transfer`
--

LOCK TABLES `inventories_transfer` WRITE;
/*!40000 ALTER TABLE `inventories_transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventories_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_configurations`
--

DROP TABLE IF EXISTS `inventory_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stock_control` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `generate_internal_id` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_configurations`
--

LOCK TABLES `inventory_configurations` WRITE;
/*!40000 ALTER TABLE `inventory_configurations` DISABLE KEYS */;
INSERT INTO `inventory_configurations` VALUES (1,0,NULL,NULL,0);
/*!40000 ALTER TABLE `inventory_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_kardex`
--

DROP TABLE IF EXISTS `inventory_kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_kardex` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_of_issue` date NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `inventory_kardexable_id` int(10) unsigned NOT NULL,
  `inventory_kardexable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(10) unsigned NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_kardex_item_id_foreign` (`item_id`),
  KEY `inventory_kardex_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `inventory_kardex_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventory_kardex_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_kardex`
--

LOCK TABLES `inventory_kardex` WRITE;
/*!40000 ALTER TABLE `inventory_kardex` DISABLE KEYS */;
INSERT INTO `inventory_kardex` VALUES (1,'2026-03-14',1,1,'Modules\\Inventory\\Models\\Inventory',1,100.0000,'2026-03-14 11:13:29','2026-03-14 11:13:29'),(4,'2026-03-14',1,3,'App\\Models\\Tenant\\Document',1,-1.0000,'2026-03-14 11:21:18','2026-03-14 11:21:18'),(5,'2026-03-14',1,4,'App\\Models\\Tenant\\Document',1,-100.0000,'2026-03-14 11:59:39','2026-03-14 11:59:39'),(6,'2026-03-14',1,5,'App\\Models\\Tenant\\Document',1,-6.0000,'2026-03-14 13:26:43','2026-03-14 13:26:43');
/*!40000 ALTER TABLE `inventory_kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_transactions`
--

DROP TABLE IF EXISTS `inventory_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_transactions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('input','output') COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `inventory_transactions_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_transactions`
--

LOCK TABLES `inventory_transactions` WRITE;
/*!40000 ALTER TABLE `inventory_transactions` DISABLE KEYS */;
INSERT INTO `inventory_transactions` VALUES ('02','Compra nacional','input'),('03','Consignación recibida','input'),('05','Devolución recibida','input'),('16','Inventario inicial','input'),('18','Entrada de importación','input'),('19','Ingreso de producción','input'),('20','Entrada por devolución de producción','input'),('21','Entrada por transferencia entre almacenes','input'),('22','Entrada por identificación erronea','input'),('24','Entrada por devolución del cliente','input'),('26','Entrada para servicio de producción','input'),('29','Entrada de bienes en prestamo','input'),('31','Entrada de bienes en custodia','input'),('50','Ingreso temporal','input'),('52','Ingreso por transformación','input'),('54','Ingreso de producción','input'),('55','Entrada de importación','input'),('57','Entrada por conversión de medida','input'),('91','Ingreso por transformación','input'),('93','Ingreso temporal','input'),('96','Entrada por conversión de medida','input'),('99','Otros','input'),('01','Venta nacional','output'),('04','Consignación entregada','output'),('06','Devolución entregada','output'),('07','Bonificación','output'),('08','Premio','output'),('09','Donación','output'),('10','Salida a producción','output'),('11','Salida por transferencia entre almacenes','output'),('12','Retiro','output'),('13','Mermas','output'),('14','Desmedros','output'),('15','Destrucción','output'),('17','Exportación','output'),('23','Salida por identificación erronea','output'),('25','Salida por devolución al proveedor','output'),('27','Salida por servicio de producción','output'),('28','Ajuste por diferencia de inventario','output'),('30','Salida de bienes en prestamo','output'),('32','Salida de bienes en custodia','output'),('33','Muestras médicas','output'),('34','Publicidad','output'),('35','Gastos de representación','output'),('36','Retiro para entrega a trabajadores','output'),('37','Retiro por convenio colectivo','output'),('38','Retiro por sustitución de bien siniestrado','output'),('51','Salida temporal','output'),('53','Salida para servicios terceros','output'),('56','Salida por conversión de medida','output'),('100','Ingreso insumos por molino','input'),('101','Salida por insumo','output'),('102','Entrada por importacion masiva (xlsx)','input');
/*!40000 ALTER TABLE `inventory_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `operation_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_due` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_document_id_foreign` (`document_id`),
  KEY `invoices_operation_type_id_foreign` (`operation_type_id`),
  CONSTRAINT `invoices_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_operation_type_id_foreign` FOREIGN KEY (`operation_type_id`) REFERENCES `cat_operation_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (3,3,'0101','2026-03-14'),(4,4,'0101','2026-03-14'),(5,5,'0101','2026-03-14');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_color`
--

DROP TABLE IF EXISTS `item_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_color` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_colors_item_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_color`
--

LOCK TABLES `item_color` WRITE;
/*!40000 ALTER TABLE `item_color` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_images`
--

DROP TABLE IF EXISTS `item_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_images_item_id_foreign` (`item_id`),
  CONSTRAINT `item_images_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_images`
--

LOCK TABLES `item_images` WRITE;
/*!40000 ALTER TABLE `item_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_lots`
--

DROP TABLE IF EXISTS `item_lots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_lots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `series` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  `item_loteable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_loteable_id` int(10) unsigned NOT NULL,
  `has_sale` tinyint(1) NOT NULL DEFAULT '0',
  `state` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_lots_item_id_foreign` (`item_id`),
  KEY `item_lots_warehouse_id_foreign` (`warehouse_id`),
  KEY `item_lots_series_index` (`series`),
  KEY `item_lots_date_index` (`date`),
  KEY `item_lots_has_sale_index` (`has_sale`),
  KEY `item_lots_item_loteable_type_index` (`item_loteable_type`),
  KEY `item_lots_item_loteable_id_index` (`item_loteable_id`),
  CONSTRAINT `item_lots_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `item_lots_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_lots`
--

LOCK TABLES `item_lots` WRITE;
/*!40000 ALTER TABLE `item_lots` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_lots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_lots_group`
--

DROP TABLE IF EXISTS `item_lots_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_lots_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `old_quantity` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `date_of_due` date NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_lots_group_item_id_foreign` (`item_id`),
  CONSTRAINT `item_lots_group_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_lots_group`
--

LOCK TABLES `item_lots_group` WRITE;
/*!40000 ALTER TABLE `item_lots_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_lots_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_mold_cavities`
--

DROP TABLE IF EXISTS `item_mold_cavities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_mold_cavities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_mold_cavities_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_mold_cavities`
--

LOCK TABLES `item_mold_cavities` WRITE;
/*!40000 ALTER TABLE `item_mold_cavities` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_mold_cavities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_mold_properties`
--

DROP TABLE IF EXISTS `item_mold_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_mold_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_mold_properties_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_mold_properties`
--

LOCK TABLES `item_mold_properties` WRITE;
/*!40000 ALTER TABLE `item_mold_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_mold_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_movement`
--

DROP TABLE IF EXISTS `item_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_movement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con item',
  `quantity` decimal(12,4) DEFAULT '0.0000' COMMENT 'Cantidad de venta del item',
  `date_of_movement` timestamp NULL DEFAULT NULL,
  `countable` tinyint(3) unsigned DEFAULT '0' COMMENT 'Define si se toma en cuenta para el conteo de inventario',
  `establishment_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `contract_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `devolution_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `dispatch_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `document_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `expense_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `fixed_asset_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `fixed_asset_purchase_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `order_form_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `order_note_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `purchase_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `purchase_order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `purchase_quotation_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `quotation_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `sale_note_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `sale_opportunity_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `technical_service_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con la tabla',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_movement`
--

LOCK TABLES `item_movement` WRITE;
/*!40000 ALTER TABLE `item_movement` DISABLE KEYS */;
INSERT INTO `item_movement` VALUES (3,1,-1.0000,'2026-03-14 11:21:18',1,1,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 11:21:18','2026-03-14 11:21:18'),(4,1,0.0000,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,'2026-03-14 11:51:50','2026-03-14 11:51:50'),(5,1,-100.0000,'2026-03-14 11:59:39',1,1,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 11:59:39','2026-03-14 11:59:39'),(6,1,-6.0000,'2026-03-14 13:26:43',1,1,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 13:26:43','2026-03-14 13:26:43'),(7,1,0.0000,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,'2026-03-14 13:32:24','2026-03-14 13:32:24'),(8,1,0.0000,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,'2026-03-14 13:32:24','2026-03-14 13:32:24'),(9,1,0.0000,NULL,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 13:34:37','2026-03-14 13:34:37'),(10,1,0.0000,NULL,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 13:34:37','2026-03-14 13:34:37'),(11,1,0.0000,NULL,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 13:36:30','2026-03-14 13:36:30'),(12,1,0.0000,NULL,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2026-03-14 13:36:30','2026-03-14 13:36:30');
/*!40000 ALTER TABLE `item_movement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_movement_rel_extra`
--

DROP TABLE IF EXISTS `item_movement_rel_extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_movement_rel_extra` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT '0',
  `item_movement_id` int(10) unsigned DEFAULT '0',
  `item_color_id` int(10) unsigned DEFAULT '0',
  `item_status_id` int(10) unsigned DEFAULT '0',
  `item_unit_business_id` int(10) unsigned DEFAULT '0',
  `item_mold_cavities_id` int(10) unsigned DEFAULT '0',
  `item_package_measurements_id` int(10) unsigned DEFAULT '0',
  `item_units_per_package_id` int(10) unsigned DEFAULT '0',
  `item_mold_properties_id` int(10) unsigned DEFAULT '0',
  `item_product_family_id` int(10) unsigned DEFAULT '0',
  `item_size_id` int(10) unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_movement_rel_extra_item_movement_id_foreign` (`item_movement_id`),
  KEY `index_item_status_id` (`item_status_id`),
  KEY `index_item_unit_business_id` (`item_unit_business_id`),
  KEY `index_item_mold_cavities_id` (`item_mold_cavities_id`),
  KEY `index_item_package_measurements_id` (`item_package_measurements_id`),
  KEY `index_item_units_per_package_id` (`item_units_per_package_id`),
  KEY `index_item_mold_properties_id` (`item_mold_properties_id`),
  KEY `index_item_product_family_id` (`item_product_family_id`),
  KEY `index_item_size_id` (`item_size_id`),
  CONSTRAINT `item_movement_rel_extra_item_movement_id_foreign` FOREIGN KEY (`item_movement_id`) REFERENCES `item_movement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_movement_rel_extra`
--

LOCK TABLES `item_movement_rel_extra` WRITE;
/*!40000 ALTER TABLE `item_movement_rel_extra` DISABLE KEYS */;
INSERT INTO `item_movement_rel_extra` VALUES (3,1,3,0,0,0,0,0,0,0,0,0,'2026-03-14 11:21:18','2026-03-14 11:21:18'),(4,1,5,0,0,0,0,0,0,0,0,0,'2026-03-14 11:59:39','2026-03-14 11:59:39'),(5,1,6,0,0,0,0,0,0,0,0,0,'2026-03-14 13:26:43','2026-03-14 13:26:43');
/*!40000 ALTER TABLE `item_movement_rel_extra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_package_measurements`
--

DROP TABLE IF EXISTS `item_package_measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_package_measurements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_package_measurements_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_package_measurements`
--

LOCK TABLES `item_package_measurements` WRITE;
/*!40000 ALTER TABLE `item_package_measurements` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_package_measurements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_product_family`
--

DROP TABLE IF EXISTS `item_product_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_product_family` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_product_family_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_product_family`
--

LOCK TABLES `item_product_family` WRITE;
/*!40000 ALTER TABLE `item_product_family` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_product_family` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_rel_suscription_plans`
--

DROP TABLE IF EXISTS `item_rel_suscription_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_rel_suscription_plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con items',
  `item` json DEFAULT NULL,
  `suscription_plan_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con planes de suscripcion',
  `quantity` decimal(12,2) DEFAULT '0.00',
  `unit_value` decimal(16,2) DEFAULT '0.00',
  `affectation_igv_type_id` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_igv` decimal(12,2) DEFAULT '0.00',
  `percentage_igv` decimal(12,2) DEFAULT '0.00',
  `total_igv` decimal(12,2) DEFAULT '0.00',
  `system_isc_type_id` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) DEFAULT '0.00',
  `percentage_isc` decimal(12,2) DEFAULT '0.00',
  `total_isc` decimal(12,2) DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) DEFAULT '0.00',
  `total_taxes` decimal(12,2) DEFAULT '0.00',
  `price_type_id` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_price` decimal(16,6) DEFAULT '0.000000',
  `total_value` decimal(12,2) DEFAULT '0.00',
  `total_charge` decimal(12,2) DEFAULT '0.00',
  `total_discount` decimal(12,2) DEFAULT '0.00',
  `total` decimal(12,2) DEFAULT '0.00',
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `additional_information` text COLLATE utf8mb4_unicode_ci,
  `warehouse_id` int(10) unsigned DEFAULT '0',
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_rel_suscription_plans`
--

LOCK TABLES `item_rel_suscription_plans` WRITE;
/*!40000 ALTER TABLE `item_rel_suscription_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_rel_suscription_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_sets`
--

DROP TABLE IF EXISTS `item_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_sets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `individual_item_id` int(10) unsigned NOT NULL,
  `quantity` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_sets_item_id_foreign` (`item_id`),
  KEY `item_sets_individual_item_id_foreign` (`individual_item_id`),
  CONSTRAINT `item_sets_individual_item_id_foreign` FOREIGN KEY (`individual_item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `item_sets_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_sets`
--

LOCK TABLES `item_sets` WRITE;
/*!40000 ALTER TABLE `item_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_size`
--

DROP TABLE IF EXISTS `item_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_size` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_size_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_size`
--

LOCK TABLES `item_size` WRITE;
/*!40000 ALTER TABLE `item_size` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_status`
--

DROP TABLE IF EXISTS `item_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_status_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_status`
--

LOCK TABLES `item_status` WRITE;
/*!40000 ALTER TABLE `item_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_supplies`
--

DROP TABLE IF EXISTS `item_supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_supplies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `individual_item_id` int(10) unsigned NOT NULL,
  `quantity` decimal(13,3) DEFAULT '0.000',
  `unit_price` decimal(12,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_supplies_item_id_foreign` (`item_id`),
  KEY `item_supplies_individual_item_id_foreign` (`individual_item_id`),
  CONSTRAINT `item_supplies_individual_item_id_foreign` FOREIGN KEY (`individual_item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `item_supplies_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_supplies`
--

LOCK TABLES `item_supplies` WRITE;
/*!40000 ALTER TABLE `item_supplies` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_tags`
--

DROP TABLE IF EXISTS `item_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_tags_item_id_foreign` (`item_id`),
  KEY `item_tags_tag_id_foreign` (`tag_id`),
  CONSTRAINT `item_tags_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_tags`
--

LOCK TABLES `item_tags` WRITE;
/*!40000 ALTER TABLE `item_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_types`
--

DROP TABLE IF EXISTS `item_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_types` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `item_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_types`
--

LOCK TABLES `item_types` WRITE;
/*!40000 ALTER TABLE `item_types` DISABLE KEYS */;
INSERT INTO `item_types` VALUES ('01','Producto'),('02','Servicio');
/*!40000 ALTER TABLE `item_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_unit_business`
--

DROP TABLE IF EXISTS `item_unit_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_unit_business` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_unit_business_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_unit_business`
--

LOCK TABLES `item_unit_business` WRITE;
/*!40000 ALTER TABLE `item_unit_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_unit_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_unit_types`
--

DROP TABLE IF EXISTS `item_unit_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_unit_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `unit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity_unit` decimal(12,4) NOT NULL,
  `price1` decimal(12,4) NOT NULL,
  `price2` decimal(12,4) NOT NULL,
  `price3` decimal(12,4) NOT NULL,
  `price_default` tinyint(1) NOT NULL DEFAULT '2',
  `barcode` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_unit_types_unit_type_id_foreign` (`unit_type_id`),
  KEY `item_unit_types_item_id_foreign` (`item_id`),
  KEY `item_unit_types_barcode_index` (`barcode`),
  CONSTRAINT `item_unit_types_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `item_unit_types_unit_type_id_foreign` FOREIGN KEY (`unit_type_id`) REFERENCES `cat_unit_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_unit_types`
--

LOCK TABLES `item_unit_types` WRITE;
/*!40000 ALTER TABLE `item_unit_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_unit_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_units_per_package`
--

DROP TABLE IF EXISTS `item_units_per_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_units_per_package` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `cat_item_units_per_package_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) DEFAULT '1' COMMENT 'Define si se encuentra activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_units_per_package`
--

LOCK TABLES `item_units_per_package` WRITE;
/*!40000 ALTER TABLE `item_units_per_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_units_per_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_warehouse`
--

DROP TABLE IF EXISTS `item_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_warehouse` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `warehouse_id` int(10) unsigned NOT NULL,
  `stock` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_warehouse_item_id_foreign` (`item_id`),
  KEY `item_warehouse_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `item_warehouse_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_warehouse_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_warehouse`
--

LOCK TABLES `item_warehouse` WRITE;
/*!40000 ALTER TABLE `item_warehouse` DISABLE KEYS */;
INSERT INTO `item_warehouse` VALUES (1,1,1,-7.0000,'2026-03-14 11:13:29','2026-03-14 13:26:43');
/*!40000 ALTER TABLE `item_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_warehouse_prices`
--

DROP TABLE IF EXISTS `item_warehouse_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_warehouse_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `warehouse_id` int(10) unsigned NOT NULL,
  `price` decimal(16,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id`),
  KEY `item_warehouse_prices_item_id_foreign` (`item_id`),
  KEY `item_warehouse_prices_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `item_warehouse_prices_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_warehouse_prices_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_warehouse_prices`
--

LOCK TABLES `item_warehouse_prices` WRITE;
/*!40000 ALTER TABLE `item_warehouse_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_warehouse_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_name` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `technical_specifications` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `internal_id` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_due` date DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `item_code_gs1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_unit_price` decimal(16,6) NOT NULL,
  `purchase_has_igv` tinyint(1) NOT NULL DEFAULT '1',
  `has_igv` tinyint(1) NOT NULL DEFAULT '1',
  `subject_to_detraction` tinyint(1) NOT NULL DEFAULT '0',
  `purchase_unit_price` decimal(16,6) NOT NULL DEFAULT '0.000000',
  `has_isc` tinyint(1) NOT NULL DEFAULT '0',
  `commission_amount` decimal(8,2) DEFAULT NULL,
  `line` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_plastic_bag_taxes` decimal(6,2) NOT NULL DEFAULT '0.10',
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `suggested_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `purchase_has_isc` tinyint(1) NOT NULL DEFAULT '0',
  `purchase_system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `sale_affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `calculate_quantity` tinyint(1) NOT NULL DEFAULT '0',
  `sale_unit_price_set` decimal(16,6) DEFAULT NULL,
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned DEFAULT NULL,
  `brand_id` int(10) unsigned DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'imagen-no-disponible.jpg',
  `image_medium` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'imagen-no-disponible.jpg',
  `image_small` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'imagen-no-disponible.jpg',
  `stock` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `stock_min` decimal(12,2) NOT NULL DEFAULT '0.00',
  `has_plastic_bag_taxes` tinyint(1) NOT NULL DEFAULT '0',
  `lot_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lots_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `series_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `percentage_of_profit` decimal(12,2) NOT NULL DEFAULT '0.00',
  `has_perception` tinyint(1) NOT NULL DEFAULT '0',
  `percentage_perception` decimal(12,2) DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `web_platform_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `apply_store` tinyint(1) NOT NULL DEFAULT '0',
  `apply_restaurant` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'visible en menu restaurante',
  `cod_digemid` text COLLATE utf8mb4_unicode_ci COMMENT 'Codigo de producto DIGEMID',
  `sanitary` text COLLATE utf8mb4_unicode_ci COMMENT 'Registro sanitario',
  `is_for_production` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Define si es compuesto para produccion',
  PRIMARY KEY (`id`),
  KEY `items_item_type_id_foreign` (`item_type_id`),
  KEY `items_unit_type_id_foreign` (`unit_type_id`),
  KEY `items_currency_type_id_foreign` (`currency_type_id`),
  KEY `items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `items_sale_affectation_igv_type_id_foreign` (`sale_affectation_igv_type_id`),
  KEY `items_purchase_affectation_igv_type_id_foreign` (`purchase_affectation_igv_type_id`),
  KEY `items_warehouse_id_foreign` (`warehouse_id`),
  KEY `items_account_id_foreign` (`account_id`),
  KEY `items_brand_id_foreign` (`brand_id`),
  KEY `items_category_id_foreign` (`category_id`),
  KEY `items_name_index` (`name`),
  KEY `items_second_name_index` (`second_name`),
  KEY `items_description_index` (`description`),
  KEY `items_internal_id_index` (`internal_id`),
  KEY `items_item_code_index` (`item_code`),
  KEY `items_web_platform_id_foreign` (`web_platform_id`),
  KEY `items_purchase_system_isc_type_id_foreign` (`purchase_system_isc_type_id`),
  CONSTRAINT `items_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `items_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `items_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `items_item_type_id_foreign` FOREIGN KEY (`item_type_id`) REFERENCES `item_types` (`id`),
  CONSTRAINT `items_purchase_affectation_igv_type_id_foreign` FOREIGN KEY (`purchase_affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `items_purchase_system_isc_type_id_foreign` FOREIGN KEY (`purchase_system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`),
  CONSTRAINT `items_sale_affectation_igv_type_id_foreign` FOREIGN KEY (`sale_affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`),
  CONSTRAINT `items_unit_type_id_foreign` FOREIGN KEY (`unit_type_id`) REFERENCES `cat_unit_types` (`id`),
  CONSTRAINT `items_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`),
  CONSTRAINT `items_web_platform_id_foreign` FOREIGN KEY (`web_platform_id`) REFERENCES `web_platforms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'prd01',NULL,'producto 1',NULL,'000000000001',NULL,'01',NULL,NULL,NULL,NULL,NULL,'NIU','PEN',12.000000,0,0,0,0.000000,0,NULL,NULL,NULL,0.10,NULL,0.00,0.00,0,NULL,0.00,'10','10',0,NULL,0,NULL,NULL,'imagen-no-disponible.jpg','imagen-no-disponible.jpg','imagen-no-disponible.jpg',-7.0000,1.00,0,NULL,0,0,0.00,0,NULL,'[]',1,NULL,'2026-03-14 11:13:29','2026-03-14 13:26:43',1,1,0,0,NULL,NULL,0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_rating`
--

DROP TABLE IF EXISTS `items_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `value` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `items_rating_user_id_foreign` (`user_id`),
  KEY `items_rating_item_id_foreign` (`item_id`),
  CONSTRAINT `items_rating_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `items_rating_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_rating`
--

LOCK TABLES `items_rating` WRITE;
/*!40000 ALTER TABLE `items_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kardex`
--

DROP TABLE IF EXISTS `kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kardex` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_of_issue` date NOT NULL,
  `type` enum('sale','purchase') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `document_id` int(10) unsigned DEFAULT NULL,
  `purchase_id` int(10) unsigned DEFAULT NULL,
  `sale_note_id` int(10) unsigned DEFAULT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kardex_purchase_id_foreign` (`purchase_id`),
  KEY `kardex_document_id_foreign` (`document_id`),
  KEY `kardex_item_id_foreign` (`item_id`),
  KEY `kardex_sale_note_id_foreign` (`sale_note_id`),
  CONSTRAINT `kardex_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kardex_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `kardex_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kardex_sale_note_id_foreign` FOREIGN KEY (`sale_note_id`) REFERENCES `sale_notes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kardex`
--

LOCK TABLES `kardex` WRITE;
/*!40000 ALTER TABLE `kardex` DISABLE KEYS */;
INSERT INTO `kardex` VALUES (1,'2026-03-14',NULL,1,NULL,NULL,NULL,100.0000,'2026-03-14 11:13:29','2026-03-14 11:13:29'),(4,'2026-03-14','sale',1,3,NULL,NULL,1.0000,'2026-03-14 11:21:18','2026-03-14 11:21:18'),(5,'2026-03-14','sale',1,4,NULL,NULL,100.0000,'2026-03-14 11:59:39','2026-03-14 11:59:39'),(6,'2026-03-14','sale',1,5,NULL,NULL,6.0000,'2026-03-14 13:26:43','2026-03-14 13:26:43');
/*!40000 ALTER TABLE `kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `machine_types`
--

DROP TABLE IF EXISTS `machine_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `machine_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `machine_types`
--

LOCK TABLES `machine_types` WRITE;
/*!40000 ALTER TABLE `machine_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `machine_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `machines`
--

DROP TABLE IF EXISTS `machines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `machines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `machine_type_id` int(10) unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `brand` text COLLATE utf8mb4_unicode_ci,
  `model` text COLLATE utf8mb4_unicode_ci,
  `closing_force` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `machines`
--

LOCK TABLES `machines` WRITE;
/*!40000 ALTER TABLE `machines` DISABLE KEYS */;
/*!40000 ALTER TABLE `machines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mi_tienda_pe`
--

DROP TABLE IF EXISTS `mi_tienda_pe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mi_tienda_pe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_number` text COLLATE utf8mb4_unicode_ci COMMENT 'Numero de pedido',
  `transaction_code` text COLLATE utf8mb4_unicode_ci COMMENT 'Codigo de pasareña',
  `order_note_id` int(10) unsigned DEFAULT '0',
  `document_id` int(10) unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mi_tienda_pe`
--

LOCK TABLES `mi_tienda_pe` WRITE;
/*!40000 ALTER TABLE `mi_tienda_pe` DISABLE KEYS */;
/*!40000 ALTER TABLE `mi_tienda_pe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_configuration`
--

DROP TABLE IF EXISTS `migration_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration_configuration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_configuration`
--

LOCK TABLES `migration_configuration` WRITE;
/*!40000 ALTER TABLE `migration_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `migration_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2018_00_00_000000_tenant_catalogs_table',1),(2,'2018_01_00_000000_tenant_system_table',1),(3,'2018_01_01_000000_tenant_users_table',1),(4,'2018_01_01_000001_tenant_password_resets_table',1),(5,'2018_01_01_000004_tenant_modules_table',1),(6,'2018_01_01_000006_tenant_module_user_table',1),(7,'2018_01_01_000013_tenant_location_table',1),(8,'2018_05_16_000800_tenant_companies_table',1),(9,'2018_05_16_000810_tenant_establishments_table',1),(10,'2018_05_16_000900_tenant_configurations_table',1),(11,'2018_05_17_000002_tenant_series_table',1),(12,'2018_05_17_000101_tenant_persons_table',1),(13,'2018_06_17_000001_tenant_items_table',1),(14,'2018_06_17_000002_tenant_documents_table',1),(15,'2018_06_17_000005_tenant_document_items_table',1),(16,'2018_06_19_000020_tenant_invoices_table',1),(17,'2018_06_19_000021_tenant_notes_table',1),(18,'2018_06_21_000002_tenant_summaries_table',1),(19,'2018_06_21_000003_tenant_summary_documents_table',1),(20,'2018_06_21_000004_tenant_voided_table',1),(21,'2018_06_21_000005_tenant_voided_documents_table',1),(22,'2018_06_22_000022_tenant_retentions_table',1),(23,'2018_06_22_000023_tenant_retention_documents_table',1),(24,'2018_06_22_000024_tenant_perceptions_table',1),(25,'2018_06_22_000026_tenant_perception_details_table',1),(26,'2018_07_22_000024_tenant_dispatches_table',1),(27,'2018_07_22_000030_tenant_dispatch_items_table',1),(28,'2019_02_12_000002_tenant_purchases_table',1),(29,'2019_02_12_000005_tenant_purchase_items_table',1),(30,'2019_02_12_000007_tenant_kardex_table',1),(31,'2019_02_13_150334_tenant_add_cront_to_configurations',1),(32,'2019_02_13_175903_tenant_change_type_column_quantity_to_document_items',1),(33,'2019_02_13_190940_tenant_add_information_to_documents',1),(34,'2019_02_14_100645_tenant_add_establishment_id_to_users',1),(35,'2019_02_19_150123_tenant_change_columns_to_exchange_rates',1),(36,'2019_02_25_074400_tenant_add_data_json_to_documents',1),(37,'2019_02_26_084922_tenant_change_columns_offline_to_documents',1),(38,'2019_02_27_093803_tenant_add_send_online_to_documents',1),(39,'2019_02_27_150015_create_tasks_table',1),(40,'2019_02_28_100503_tenant_add_calculate_quantity_to_items',1),(41,'2019_02_28_154355_tenant_delete_unique_class_to_tasks',1),(42,'2019_02_28_215128_tenant_change_decimal_column_quantity_to_document_items',1),(43,'2019_03_01_100028_tenant_change_decimal_column_stock_to_items',1),(44,'2019_03_01_100550_tenant_change_type_column_quantity_to_purchase_items',1),(45,'2019_03_01_100938_tenant_change_type_column_quantity_to_kardex',1),(46,'2019_03_01_163938_tenant_add_locked_to_users',1),(47,'2019_03_16_095539_tenant_quotations_table',1),(48,'2019_03_16_095620_tenant_quotation_items_table',1),(49,'2019_03_19_155345_tenant_sale_notes_table',1),(50,'2019_03_19_155546_tenant_sale_note_items_table',1),(51,'2019_03_20_152101_tenant_add_sale_note_id_to_kardex',1),(52,'2019_03_22_095723_tenant_change_nullable_colum_type_to_kardex',1),(53,'2019_03_23_114011_tenant_warehouses_table',1),(54,'2019_03_23_134515_add_warehouse_id_to_items',1),(55,'2019_03_23_154011_tenant_item_warehouse_table',1),(56,'2019_03_25_120709_tenant_inventories_table',1),(57,'2019_03_26_120709_tenant_inventory_kardex_table',1),(58,'2019_03_27_104823_tenant_add_record_to_warehouses',1),(59,'2019_03_28_102106_tenant_add_quotation_id_to_documents',1),(60,'2019_03_28_112106_tenant_add_foreign_establishment_id_to_warehouses',1),(61,'2019_03_29_100403_tenant_add_foreign_to_item_warehouse',1),(62,'2019_03_29_100413_tenant_add_foreign_to_inventories',1),(63,'2019_03_29_100433_tenant_add_foreign_to_inventory_kardex',1),(64,'2019_03_29_100503_tenant_add_has_igv_to_items',1),(65,'2019_04_24_151702_tenant_add_stock_to_configurations',1),(66,'2019_04_26_105302_tenant_add_contingency_to_series',1),(67,'2019_04_29_111659_tenant_inventory_configurations_table',1),(68,'2019_04_29_164935_tenant_add_record_to_inventory_configurations',1),(69,'2019_04_30_140509_tenant_add_type_to_users',1),(70,'2019_05_06_174801_tenant_change_column_type_to_users',1),(71,'2019_05_07_160954_tenant_item_unit_types_table',1),(72,'2019_05_10_172128_tenant_add_price_default_to_item_unit_types',1),(73,'2019_05_13_145524_tenant_fix_error_to_inventories',1),(74,'2019_05_14_091046_tenant_description_to_item_unit_types',1),(75,'2019_05_27_185903_tenant_change_type_column_qr_to_documents',1),(76,'2019_05_28_172128_tenant_add_percentage_of_profit_to_items',1),(77,'2019_06_12_000005_tenant_document_payments_table',1),(78,'2019_06_12_000015_tenant_sale_note_payments_table',1),(79,'2019_06_12_172128_tenant_add_total_canceled_to_sale_notes',1),(80,'2019_06_13_100503_tenant_change_unit_price_to_items',1),(81,'2019_06_14_100503_tenant_person_address_table',1),(82,'2019_06_24_122116_tenant_add_changed_to_sale_notes',1),(83,'2019_07_09_141248_tenant_expense_types_table',1),(84,'2019_07_09_141408_tenant_expenses_table',1),(85,'2019_07_09_141508_tenant_expense_items_table',1),(86,'2019_07_09_172826_tenant_add_perception_agent_to_persons',1),(87,'2019_07_10_092347_tenant_add_percentage_perception_to_items',1),(88,'2019_07_10_103811_tenant_add_columns_perceptions_to_purchases',1),(89,'2019_07_10_120610_tenant_add_columns_purchases_to_payment_method_types',1),(90,'2019_07_10_123325_tenant_purchase_payments_table',1),(91,'2019_07_10_140636_tenant_add_date_of_due_to_purchases',1),(92,'2019_07_10_151332_tenant_add_warehouse_id_to_purchase_items',1),(93,'2019_07_12_181618_tenant_add_columns_aditional_to_establishments',1),(94,'2019_07_19_163617_tenant_add_columns_system_to_configurations',1),(95,'2019_07_22_094601_tenant_cash_table',1),(96,'2019_07_22_094658_tenant_cash_documents_table',1),(97,'2019_07_22_094725_tenant_add_image_to_items',1),(98,'2019_07_22_094803_tenant_modify_document_id_to_cash_documents',1),(99,'2019_07_22_102243_tenant_accounts_table',1),(100,'2019_07_22_103459_tenant_add_account_id_to_items',1),(101,'2019_07_23_175808_tenant_modify_decimals_to_item_unit_types',1),(102,'2019_07_24_162847_tenant_add_data_module_for_pos',1),(103,'2019_07_25_144505_tenant_add_ose_to_companies',1),(104,'2019_07_27_181623_tenant_add_name_name2_to_items',1),(105,'2019_07_31_165537_tenant_add_subtotal_account_to_configurations',1),(106,'2019_08_01_002801_tenant_add_status_to_item',1),(107,'2019_08_01_005553_tenant_add_status_to_persons',1),(108,'2019_08_01_011908_tenant_add_description_to_quotations',1),(109,'2019_08_01_095140_tenant_add_status_to_bank_accounts',1),(110,'2019_08_01_101234_tenant_add_active_to_banks',1),(111,'2019_08_01_102419_tenant_add_active_to_card_brands',1),(112,'2019_08_01_105836_tenant_delete_subtotal_account_to_configurations',1),(113,'2019_08_01_110045_tenant_company_accounts_table',1),(114,'2019_08_03_162431_tenant_add_data_modules_for_dashboard',1),(115,'2019_08_05_130830_tenant_add_index_external_id_to_documents',1),(116,'2019_08_12_125016_tenant_up_unit_price_to_items',1),(117,'2019_08_13_082230_tenant_add_column_limit_user_to_configurations',1),(118,'2019_08_16_153648_tenant_add_more_decimal_column_stock_to_items',1),(119,'2019_08_16_161756_tenant_add_total_plastic_bag_taxes_to_documents',1),(120,'2019_08_16_161824_tenant_add_total_plastic_bag_taxes_to_document_items',1),(121,'2019_08_16_161854_tenant_add_amount_plastic_bag_taxes_to_items',1),(122,'2019_08_19_112540_tenant_add_quotation_id_to_sale_notes',1),(123,'2019_08_19_115344_tenant_add_sale_note_id_to_documents',1),(124,'2019_08_19_124610_tenant_add_state_condition_to_persons',1),(125,'2019_08_20_121326_tenant_add_indexes_to_documents',1),(126,'2019_08_20_144511_tenant_add_indexes_to_summaries',1),(127,'2019_08_20_151037_tenant_add_indexes_to_persons',1),(128,'2019_08_21_145954_tenant_modify_name_name2_to_items',1),(129,'2019_08_23_115358_tenant_add_data_accounnting_inventory_to_modules',1),(130,'2019_08_23_160411_tenant_modify_description_to_items',1),(131,'2019_09_03_153427_tenant_change_nullable_column_affected_document_id_to_notes',1),(132,'2019_09_03_153656_tenant_add_data_affected_document_to_notes',1),(133,'2019_09_09_153206_tenant_add_sale_note_id_to_cash_documents',1),(134,'2019_09_09_174848_tenant_modify_columns_to_perceptions',1),(135,'2019_09_09_174916_tenant_modify_columns_to_perception_details',1),(136,'2019_09_10_102854_tenant_modify_series_id_to_perceptions',1),(137,'2019_09_11_131559_tenant_add_apply_store_to_items',1),(138,'2019_09_11_154949_tenant_expense_method_types',1),(139,'2019_09_11_155535_tenant_expense_payments',1),(140,'2019_09_11_174858_tenant_expense_reasons',1),(141,'2019_09_11_174929_tenant_add_expense_reason_id_to_expenses',1),(142,'2019_09_13_112026_tenant_add_column_image_medium_and_image_small_to_items',1),(143,'2019_09_15_233528_tenant_create_table_tag',1),(144,'2019_09_15_233537_tenant_create_table_item_tag',1),(145,'2019_09_16_121938_tenant_add_date_of_due_to_items',1),(146,'2019_09_16_133219_tenant_add_data_ecommerce_to_modules',1),(147,'2019_09_16_160453_tenant_add_timestamps_to_tag',1),(148,'2019_09_16_161726_tenant_add_status_to_tags',1),(149,'2019_09_17_131050_tenant_add_type_client_to_users',1),(150,'2019_09_17_202003_tenant_promotions_table',1),(151,'2019_09_18_152416_tenant_add_percentage_perception_to_persons',1),(152,'2019_09_18_160838_tenant_add_has_perception_to_items',1),(153,'2019_09_30_151349_tenant_add_has_prepayment_to_documents',1),(154,'2019_09_30_160541_tenant_inventory_transactions_table',1),(155,'2019_09_30_160919_tenant_change_columns_to_inventories',1),(156,'2019_10_04_092658_tenant_business_turns_table',1),(157,'2019_10_04_094841_tenant_document_hotels_table',1),(158,'2019_10_09_101229_tenant_add_locked_tenant_to_configurations',1),(159,'2019_10_10_155554_tenant_add_quantity_documents_date_time_start_to_configurations',1),(160,'2019_10_11_095050_tenant_billing_cycles_table',1),(161,'2019_10_11_153948_tenant_add_locked_users_to_configurations',1),(162,'2019_10_14_101501_tenant_add_column_set_to_items',1),(163,'2019_10_14_102317_tenant_item_sets_table',1),(164,'2019_10_14_235308_tenant_orders_table',1),(165,'2019_10_15_122633_tenant_person_types_table',1),(166,'2019_10_15_123201_tenant_add_person_types_to_persons',1),(167,'2019_10_16_001052_tenant_add_identity_and_number_to_users',1),(168,'2019_10_17_100307_tenant_add_data_to_document_types',1),(169,'2019_10_18_150004_tenant_categories_table',1),(170,'2019_10_18_150414_tenant_brands_table',1),(171,'2019_10_18_150604_tenant_brand_category_to_items',1),(172,'2019_10_18_194622_tenant_add_soft_delete_to_purchases',1),(173,'2019_10_20_190039_tenant_add_plan_to_configurations',1),(174,'2019_10_20_195730_tenant_add_cuenta_to_modules',1),(175,'2019_10_20_200958_tenant_account_payments_table',1),(176,'2019_10_22_173407_tenant_add_was_deducted_prepayment_to_documents',1),(177,'2019_10_24_103947_tenant_add_sunat_alternate_server_to_configurations',1),(178,'2019_10_24_183250_tenant_add_document_id_to_orders',1),(179,'2019_10_24_210806_tenant_items_rating_table',1),(180,'2019_10_26_213130_tenant_add_logo_store_to_companies',1),(181,'2019_10_28_202116_tenant_add_reference_number_to_cash',1),(182,'2019_11_05_113236_create_padrones_table',1),(183,'2019_11_05_113320_create_charge_padrones_table',1),(184,'2019_11_06_095251_tenant_add_success_shipping_status_to_documents',1),(185,'2019_11_06_102422_tenant_add_success_sunat_shipping_status_to_documents',1),(186,'2019_11_06_110606_tenant_add_success_query_status_to_documents',1),(187,'2019_11_06_113035_tenant_offline_configurations_table',1),(188,'2019_11_11_102124_tenant_series_configurations_table',1),(189,'2019_11_12_223340_tenant_add_reference_document_id_to_dispatches',1),(190,'2019_11_13_124821_tenant_add_document_type_id_to_series_configurations',1),(191,'2019_11_18_154307_tenant_create_congiguration_ecommerce_table',1),(192,'2019_11_19_113132_tenant_cat_detraction_types_table',1),(193,'2019_11_20_175549_tenant_add_inventory_kardex_id_to_sale_note_items',1),(194,'2019_11_20_221547_tenant_add_address_to_configuration_ecommerce',1),(195,'2019_11_25_213648_tenant_add_social_to_configuration_ecommerce',1),(196,'2019_11_29_093342_tenant_add_detraction_account_to_companies',1),(197,'2019_12_02_105910_tenant_add_purchase_expense_to_cash_documents',1),(198,'2019_12_02_111743_tenant_change_expense_reason_id_to_expenses',1),(199,'2019_12_02_111837_tenant_add_soap_type_id_to_expenses',1),(200,'2019_12_02_152128_tenant_add_date_of_due_to_quotations',1),(201,'2019_12_02_161856_tenant_add_data_to_payment_method_types',1),(202,'2019_12_02_163726_tenant_add_payment_method_type_id_to_quotations',1),(203,'2019_12_05_104120_tenant_fixed_columns_to_cash_documents',1),(204,'2019_12_06_114132_tenant_add_shipping_address_to_quotations',1),(205,'2019_12_06_120917_tenant_add_commission_amount_to_items',1),(206,'2019_12_11_111224_tenant_purchase_quotations_table',1),(207,'2019_12_11_112209_tenant_purchase_quotation_items_table',1),(208,'2019_12_11_122830_tenant_add_reference_quotation_id_to_dispatches',1),(209,'2019_12_11_174726_tenant_purchase_orders_table',1),(210,'2019_12_11_175353_tenant_purchase_order_items_table',1),(211,'2019_12_16_103759_tenant_add_decimal_quantity_to_configurations',1),(212,'2019_12_16_181022_tenant_add_prefix_to_purchase_orders',1),(213,'2019_12_17_101130_tenant_add_purchase_order_id_to_purchases',1),(214,'2019_12_19_102946_tenant_item_lots_table',1),(215,'2019_12_19_105644_tenant_add_lot_code_to_items',1),(216,'2019_12_19_141604_tenant_add_operation_amazonia_to_companies',1),(217,'2019_12_20_123931_tenant_module_levels_table',1),(218,'2019_12_20_123945_tenant_module_level_user_table',1),(219,'2019_12_23_144236_tenant_add_apply_concurrency_to_sale_notes',1),(220,'2019_12_23_171335_tenant_add_columns_periods_to_sale_notes',1),(221,'2019_12_24_114350_tenant_add_columns_lots_to_item_lots',1),(222,'2019_12_24_123601_tenant_add_lot_code_to_purchase_items',1),(223,'2019_12_27_111848_tenant_add_lot_code_to_inventories',1),(224,'2019_12_30_095201_tenant_add_lots_enabled_to_items',1),(225,'2020_01_03_111747_tenant_add_amount_plastic_bag_taxes_to_configurations',1),(226,'2020_01_08_102051_tenant_add_total_canceled_to_documents',1),(227,'2020_01_09_094728_tenant_change_decimal_column_quantity_to_dispatch_items',1),(228,'2020_01_09_102017_tenant_change_type_decimal_column_quantity_to_dispatch_items',1),(229,'2020_01_09_153023_tenant_add_compact_sidebar_to_configurations',1),(230,'2020_01_10_095143_tenant_add_cci_to_bank_accounts',1),(231,'2020_01_10_121518_tenant_add_warehouse_id_to_document_items',1),(232,'2020_01_15_095621_tenant_add_change_decimal_exchange_rate_sale_tables',1),(233,'2020_01_15_100032_tenant_add_data_to_cat_document_types',1),(234,'2020_01_15_144606_tenant_add_series_number_to_sale_notes',1),(235,'2020_01_15_172447_tenant_add_paid_to_sale_notes',1),(236,'2020_01_15_181229_tenant_add_plate_to_sale_notes',1),(237,'2020_01_16_101424_tenant_add_detail_to_inventories',1),(238,'2020_01_16_103741_tenant_change_decimals_unit_price_tables',1),(239,'2020_01_16_121313_tenant_add_state_to_item_lots',1),(240,'2020_01_17_095233_tenant_document_transports_table',1),(241,'2020_01_17_115328_tenant_add_plate_number_to_documents',1),(242,'2020_01_17_175217_tenant_add_state_type_to_expenses',1),(243,'2020_01_21_153921_tenant_inventories_transfer_table',1),(244,'2020_01_21_155245_tenant_add_inventories_transfer_id_to_inventories',1),(245,'2020_01_23_120700_tenant_drop_compact_sidebar_to_configurations',1),(246,'2020_01_23_120830_tenant_re_create_compact_sidebar_to_configurations',1),(247,'2020_01_23_123235_tenant_add_columns_to_document_hotels',1),(248,'2020_01_27_121553_tenant_add_commission_type_to_items',1),(249,'2020_01_27_150915_tenant_change_column_number_to_sale_notes',1),(250,'2020_01_28_135422_tenant_add_tag_to_configuration_ecommerce',1),(251,'2020_01_31_122444_tenant_add_config_system_to_configurations',1),(252,'2020_02_05_124542_tenant_add_guests_to_document_hotels',1),(253,'2020_02_07_164026_tenant_create_person_addresses',1),(254,'2020_02_10_111943_tenant_add_affectation_type_prepayment_to_documents',1),(255,'2020_02_11_210535_tenant_add_active_to_items',1),(256,'2020_02_12_203736_tenant_add_contact_to_users',1),(257,'2020_02_17_115050_tenant_add_delivery_date_to_quotations',1),(258,'2020_02_17_141658_tenant_create_format_templates_table',1),(259,'2020_02_17_194731_tenant_add_formats_to_configurations',1),(260,'2020_02_17_202910_tenant_item_images_table',1),(261,'2020_02_19_102018_tenant_order_notes_table',1),(262,'2020_02_19_121619_tenant_order_note_items_table',1),(263,'2020_02_19_150814_tenant_add_order_note_id_to_documents',1),(264,'2020_02_19_150828_tenant_add_order_note_id_to_sale_notes',1),(265,'2020_02_19_160926_tenant_add_reference_order_note_id_to_dispatches',1),(266,'2020_02_20_224501_tenant_add_colums_grid_items_to_configurations',1),(267,'2020_02_21_172411_tenant_add_soap_shipping_response_to_documents',1),(268,'2020_02_24_213558_tenant_date_of_due_column_to_purchase_items',1),(269,'2020_02_25_103837_tenant_add_options_pos_to_configurations',1),(270,'2020_02_25_154338_tenant_add_change_to_document_payments',1),(271,'2020_02_26_201604_tenant_item_lots_group_table',1),(272,'2020_02_26_203030_tenant_add_series_enabled_to_items',1),(273,'2020_02_27_113111_tenant_add_change_to_sale_note_payments',1),(274,'2020_03_03_172821_tenant_add_additional_information_to_document_items',1),(275,'2020_03_06_101730_tenant_global_payments_table',1),(276,'2020_03_10_165850_tenant_add_data_module_for_finance',1),(277,'2020_03_11_151338_tenant_add_edit_name_product_purchase',1),(278,'2020_03_13_110238_add_column_name_product_pdf',1),(279,'2020_03_13_134951_add_column_name_product_pdf_update',1),(280,'2020_03_13_134955_add_column_name_product_pdf_change',1),(281,'2020_03_16_152939_tenant_add_indexes_to_payments_tables_for_finances',1),(282,'2020_03_16_162652_tenant_add_enabled_to_persons',1),(283,'2020_03_20_030559_add_columna_restrict_receipt_date',1),(284,'2020_03_20_174637_tenant_add_affectation_igv_type_id_to_configurations',1),(285,'2020_03_25_173128_tenant_sale_opportunities_table',1),(286,'2020_03_25_173442_tenant_sale_opportunity_items_table',1),(287,'2020_03_26_121642_tenant_add_sale_opportunity_id_to_quotations',1),(288,'2020_03_26_170415_tenant_sale_opportunity_files_table',1),(289,'2020_03_27_111133_tenant_quotation_payments_table',1),(290,'2020_03_27_123343_tenant_add_changed_to_quotations',1),(291,'2020_03_27_141008_tenant_add_column_visual_to_configurations',1),(292,'2020_03_27_143825_tenant_add_account_number_to_quotations',1),(293,'2020_03_27_150024_tenant_add_terms_condition_to_quotations',1),(294,'2020_03_30_112859_tenant_payment_files_table',1),(295,'2020_03_31_111522_tenant_add_customer_id_to_purchases',1),(296,'2020_03_31_122445_tenant_fixed_asset_items_table',1),(297,'2020_03_31_141008_tenant_add_column_show_ws_to_configurations',1),(298,'2020_03_31_151057_tenant_fixed_asset_purchases_table',1),(299,'2020_03_31_151323_tenant_fixed_asset_purchase_items_table',1),(300,'2020_04_01_150413_tenant_add_terms_condition_to_configurations',1),(301,'2020_04_02_124023_tenant_add_sale_opportunity_id_to_purchase_orders',1),(302,'2020_04_02_151534_tenant_add_total_canceled_to_purchases',1),(303,'2020_04_02_154134_tenant_contracts_table',1),(304,'2020_04_02_154147_tenant_contract_items_table',1),(305,'2020_04_02_154244_tenant_contract_payments_table',1),(306,'2020_04_03_111019_tenant_income_types_table',1),(307,'2020_04_03_111139_tenant_income_reasons_table',1),(308,'2020_04_03_111209_tenant_income_table',1),(309,'2020_04_03_111703_tenant_income_items_table',1),(310,'2020_04_03_124629_tenant_income_payments_table',1),(311,'2020_04_03_143703_tenant_insert_internal_to_soap_types',1),(312,'2020_05_06_205001_create_status_orders_table',1),(313,'2020_05_06_210451_tenant_add_status_orders_to_orders',1),(314,'2020_05_07_123152_tenant_technical_services_table',1),(315,'2020_05_07_164323_tenant_user_commissions_table',1),(316,'2020_05_12_131218_add_product_to_configurations',1),(317,'2020_05_12_204311_tenant_add_cotizaction_finance_configurations',1),(318,'2020_05_19_162014_tenant_add_contact_to_persons',1),(319,'2020_05_25_140825_tenant_add_column_plate_number_to_sales_note',1),(320,'2020_05_30_132013_tenant_add_certificate_due_to_companies',1),(321,'2020_06_05_111820_tenant_add_line_to_items',1),(322,'2020_06_10_102549_tenant_add_columns_technical_specifications_items',1),(323,'2020_06_11_093739_tenant_add_columns_header_image_legend_footer_to_configurations',1),(324,'2020_06_11_152155_tenant_add_purchase_orders',1),(325,'2020_06_23_122822_tenant_drivers_table',1),(326,'2020_06_23_122938_tenant_dispatchers_table',1),(327,'2020_06_23_123012_tenant_order_forms_table',1),(328,'2020_06_23_123126_tenant_order_form_items_table',1),(329,'2020_06_24_173951_tenant_add_reference_order_form_id_to_dispatches',1),(330,'2020_07_03_124017_tenant_add_purchase_has_igv_to_items',1),(331,'2020_07_08_163451_tenant_change_column_name_product_pdf_to_document_items',1),(332,'2020_07_21_213555_tenant_add_columns_to_technical_services',1),(333,'2020_07_23_153920_tenant_add_user_id_to_global_payments',1),(334,'2020_07_23_215548_tenant_add_img_firm_to_companies',1),(335,'2020_07_23_221614_tenant_add_qr_to_order_forms',1),(336,'2020_07_27_184250_add_apiruc_to_configurations',1),(337,'2020_07_30_101311_tenant_add_soap_shipping_response_to_summaries',1),(338,'2020_07_30_105514_tenant_add_soap_shipping_response_to_voided',1),(339,'2020_08_03_123426_tenant_add_secondary_license_plates_to_dispatches',1),(340,'2020_08_04_104159_tenant_add_initial_balance_to_bank_accounts',1),(341,'2020_08_04_123149_tenant_add_pending_amount_prepayment_to_documents',1),(342,'2020_08_05_104849_tenant_add_payment_method_type_id_to_documents',1),(343,'2020_08_05_125307_tenant_add_filename_to_purchases',1),(344,'2020_08_06_101100_tenant_change_columns_delivery_date_date_of_due_to_quotations',1),(345,'2020_08_06_120140_tenant_add_data_to_module_levels',1),(346,'2020_08_20_151205_tenant_change_column_terms_condition_to_quotations',1),(347,'2020_08_20_151856_tenant_change_column_terms_condition_to_configurations',1),(348,'2020_08_20_172938_tenant_change_decimal_column_quantity_to_item_lots_group',1),(349,'2020_08_26_142025_tenant_add_indexes_to_items',1),(350,'2020_08_27_101335_tenant_add_indexes_to_item_lots',1),(351,'2020_08_28_100623_tenant_change_type_column_terms_condition_to_contracts',1),(352,'2020_09_01_160245_tenant_add_warehouse_id_to_sale_note_items',1),(353,'2020_09_02_103127_tenant_add_warehouse_id_to_order_note_items',1),(354,'2020_09_02_124906_tenant_add_customer_id_to_establishments',1),(355,'2020_09_04_094513_tenant_add_quantity_to_item_sets',1),(356,'2020_09_04_165849_tenant_active_data_to_cat_operation_types',1),(357,'2020_09_07_110546_tenant_add_data_module_for_establishments_users',1),(358,'2020_09_08_141513_tenant_add_regularize_shipping_to_documents',1),(359,'2020_09_08_142658_tenant_add_response_regularize_shipping_to_documents',1),(360,'2020_09_09_144419_tenant_modify_text_description_to_expense_method_types',1),(361,'2020_09_09_151848_tenant_change_column_number_to_expenses',1),(362,'2020_09_09_160249_tenant_contract_state_types_table',1),(363,'2020_09_09_161329_tenant_change_state_type_id_to_contracts',1),(364,'2020_09_11_105705_tenant_cash_transactions_table',1),(365,'2020_09_14_123539_tenant_technical_service_payments_table',1),(366,'2020_09_25_113553_tenant_add_data_rh_to_cat_document_types',1),(367,'2020_09_29_110506_tenant_change_description_to_items',1),(368,'2020_10_09_153402_tenant_add_default_document_type_03_to_configurations',1),(369,'2020_10_13_095308_tenant_add_data_public_services_to_cat_document_types',1),(370,'2020_10_13_111740_tenant_web_platforms_table',1),(371,'2020_10_13_112548_tenant_add_destination_default_to_configurations',1),(372,'2020_10_13_120454_tenant_add_web_platform_id_to_items',1),(373,'2020_10_15_120313_tenant_active_transport_1004_to_cat_operation_types',1),(374,'2020_10_15_173515_tenant_add_contact_phone_to_quotations',1),(375,'2020_10_16_101845_teanant_add_data_to_module_levels',1),(376,'2020_10_16_143042_tenant_add_columns_aditional_to_modules',1),(377,'2020_10_26_151606_tenant_change_columns_nullable_to_dispatches',1),(378,'2020_11_05_103808_tenant_add_seller_to_documents',1),(379,'2020_11_05_120923_tenant_add_payment_method_type_id_to_sale_notes',1),(380,'2020_11_06_104926_tenant_add_soap_shipping_response_to_retentions',1),(381,'2020_11_10_101728_tenant_change_column_name_to_items',1),(382,'2020_11_12_143726_tenant_add_observation_to_sale_notes',1),(383,'2020_11_12_164451_tenant_add_reference_sale_note_id_to_dispatches',1),(384,'2020_11_18_123948_tenant_add_soap_shipping_response_to_dispatches',1),(385,'2020_11_19_115728_tenant_devolution_reasons_table',1),(386,'2020_11_19_115848_tenant_devolutions_table',1),(387,'2020_11_19_115944_tenant_devolution_items_table',1),(388,'2020_11_25_115944_tenant_create_preprinted_format_templates_table',1),(389,'2020_12_01_172908_tenant_add_reference_data_to_documents_sale_notes',1),(390,'2020_12_03_141335_tenant_change_text_description_to_cat_document_types',1),(391,'2020_12_31_103348_tenant_add_has_plastic_bag_taxes_to_items',1),(392,'2021_01_05_145928_add_model_column_to_items_table',1),(393,'2021_01_08_095018_add_barcode_column_to_items_table',1),(394,'2021_01_08_103402_update_barcode_column_to_items_table',1),(395,'2021_01_18_143008_change_lenght_to_items_table',1),(396,'2021_01_19_111533_add_internal_code_column_to_persons_table',1),(397,'2021_01_21_181843_add_terms_condition_sale_to_configurations_table',1),(398,'2021_01_21_183856_add_terms_condition_column_to_documents_table',1),(399,'2021_01_26_102448_create_hotel_rates_table',1),(400,'2021_01_26_152649_create_hotel_categories_table',1),(401,'2021_01_26_161851_create_hotel_floors_table',1),(402,'2021_01_26_171515_create_hotel_rooms_table',1),(403,'2021_01_27_155235_create_hotel_room_rates_table',1),(404,'2021_01_28_205134_create_hotel_rents_table',1),(405,'2021_01_31_163211_create_hotel_rent_items_table',1),(406,'2021_02_01_102051_add_columns_to_hotel_rents_table',1),(407,'2021_02_01_112617_add_column_item_id_to_hotel_rooms_table',1),(408,'2021_02_02_180153_add_arrears_column_to_hotel_rents_table',1),(409,'2021_02_04_215327_add_show_in_document_column_to_bank_accounts_table',1),(410,'2021_02_08_111945_add_document_id_column_to_dispatches_table',1),(411,'2021_02_10_153546_add_login_column_to_configurations_table',1),(412,'2021_02_11_113008_change_destination_to_global_payments_table',1),(413,'2021_02_15_101110_add_favicon_column_to_companies_table',1),(414,'2021_02_15_175921_add_navbar_column_to_configurations_table',1),(415,'2021_02_19_165318_add_finances_column_to_configurations_table',1),(416,'2021_02_25_165224_create_documentary_offices_table',1),(417,'2021_02_25_180958_create_documentary_processes_table',1),(418,'2021_02_25_183124_create_documentary_documents_table',1),(419,'2021_02_26_102851_create_documentary_actions_table',1),(420,'2021_02_26_102900_create_documentary_files_table',1),(421,'2021_03_01_120554_add_user_id_column_to_documentary_files_table',1),(422,'2021_03_01_120931_create_documentary_file_offices_table',1),(423,'2021_03_10_163436_add_extra_modules_to_modules_table',1),(424,'2021_03_11_111743_add_logo_column_to_establishments_table',1),(425,'2021_03_19_204148_add_items_to_modules_table',1),(426,'2021_03_19_221614_add_referential_information_to_quotations_table',1),(427,'2021_03_20_112202_change_order_items_to_modules_table',1),(428,'2021_03_20_115648_add_seller_id_column_to_quotations_table',1),(429,'2021_03_20_132104_add_seller_id_column_to_contracts_table',1),(430,'2021_03_21_165318_add_quotation_allow_seller_generate_sale_column_to_configurations_table',1),(431,'2021_03_24_111209_tenant_payment_conditions_table',1),(432,'2021_03_24_111211_tenant_add_payment_condition_to_documents',1),(433,'2021_03_24_141211_tenant_document_fee_table',1),(434,'2021_03_25_162827_add_purchase_order_column_to_sale_notes_table',1),(435,'2021_03_31_212318_add_document_id_column_to_sale_notes_table',1),(436,'2021_04_01_113520_add_levels_to_module_levels_table',1),(437,'2021_04_05_115318_add_allow_edit_unit_price_to_seller_column_to_configurations_table',1),(438,'2021_04_06_172009_create_item_warehouse_prices_table',1),(439,'2021_04_08_175347_change_electronico_at_cat_document_type',1),(440,'2021_04_17_163456_add_technical_service_id_to_cash_documents_table',1),(441,'2021_04_22_170915_add_template_pdf_to_establishments_table',1),(442,'2021_04_23_143433_add_edit_flag_to_documents_table',1),(443,'2021_04_27_105557_add_payment_type_to_payment_method',1),(444,'2021_04_29_122333_add_visual_ticket_58_to_configurations_table',1),(445,'2021_05_03_131833_add_mail_configuration',1),(446,'2021_05_06_152551_add_due_date_to_sales_note',1),(447,'2021_05_07_154207_add_soft_delete_to_document',1),(448,'2021_05_07_154207_remove_soft_delete_to_document',1),(449,'2021_05_12_163406_add_seller_can_create_porduct_to_configuration',1),(450,'2021_05_13_120615_add_seller_can_view_balance_on_finance_to_configuration',1),(451,'2021_05_27_124620_add_generate_option_to_sale_opportunities',1),(452,'2021_06_03_122337_add_method_type_to_documents_fee',1),(453,'2021_06_03_165209_add_serie_and_document_to_user',1),(454,'2021_06_07_140759_change_format_number_to_expenses_table',1),(455,'2021_06_09_124243_add_update_documents_by_dispaches_to_configurations',1),(456,'2021_06_10_092525_add_pharmacy_to_items',1),(457,'2021_06_15_094333_add_name_product_pdf_to_order_note_items',1),(458,'2021_06_16_154233_add_send_auto_sunat_to_dispatches',1),(459,'2021_06_18_141048_add_modules_digemid',1),(460,'2021_06_22_112855_add_fields_to_client',1),(461,'2021_06_23_130016_create_digemid_catalog',1),(462,'2021_06_28_125907_add_fields_to_documentary_office',1),(463,'2021_06_28_142358_tenant_add_active_warehouse_prices_to_configurations',1),(464,'2021_06_29_173743_tenant_add_allowance_charge_to_configurations',1),(465,'2021_06_29_184419_remove_key_from_documentary',1),(466,'2021_06_30_174147_create_adjust_to_docymentary_offices',1),(467,'2021_06_30_175311_tenant_add_purchase_to_cash_documents',1),(468,'2021_07_01_171620_adjust_to_docymentary_procedure',1),(469,'2021_07_02_133558_add_office_to_process',1),(470,'2021_07_05_091229_change_data_to',1),(471,'2021_07_05_094927_create_documentary_guides_number',1),(472,'2021_07_05_125811_add_field_to_documentary_file',1),(473,'2021_07_05_141048_add_modules_docymentary_requirements',1),(474,'2021_07_05_213052_change_observation_from_file_offices',1),(475,'2021_07_05_220241_add_requirements_to_documentary_file',1),(476,'2021_07_06_114113_tenant_add_discount_stock_to_cat_transfer_reason_types',1),(477,'2021_07_06_173358_tenant_add_dispatch_id_to_documents',1),(478,'2021_07_06_174510_add_name_pdf_to_sale_note_item',1),(479,'2021_07_14_103324_add_data_affected_document',1),(480,'2021_07_16_204722_add_phone_to_configuration_ecommerce',1),(481,'2021_07_19_132554_add_days_to_client',1),(482,'2021_08_03_115743_add_field_to_send_sale_note_to_other_site',1),(483,'2021_08_05_143043_add_quotation_to_order_note',1),(484,'2021_08_05_144042_tenant_add_search_item_by_series_to_configurations',1),(485,'2021_08_06_094151_tenant_add_change_free_affectation_igv_to_configurations',1),(486,'2021_08_09_115837_add_currency_to_configuration',1),(487,'2021_08_09_131738_tenant_add_select_available_price_list_to_configurations',1),(488,'2021_08_16_111909_create_colors_for_items',1),(489,'2021_08_17_091109_add_more_propertys_to_item',1),(490,'2021_08_20_153033_add_extra_data_of_product_to_configuration',1),(491,'2021_08_20_161555_add_extra_data_item_menu',1),(492,'2021_08_23_105050_tenant_add_group_items_generate_document_to_configurations',1),(493,'2021_08_23_172828_adjust_inventory_item_extra_data',1),(494,'2021_08_24_153219_tenant_add_columns_unknown_error_to_summaries',1),(495,'2021_08_25_155900_tenant_add_columns_integrated_query_to_companies',1),(496,'2021_09_08_165136_add_optional_emails_to_person',1),(497,'2021_09_10_120216_create_email_send_log',1),(498,'2021_09_10_143648_tenant_add_subtotal_to_documents',1),(499,'2021_09_13_171757_tenat_add_total_igv_free_to_documents',1),(500,'2021_09_15_115746_add_global_igv_to_purchase',1),(501,'2021_09_15_170619_tenant_change_length_description_to_quotations',1),(502,'2021_09_16_144202_add_app_to_modules',1),(503,'2021_09_17_120309_add_url_apk_to_configurations',1),(504,'2021_09_17_150025_transfer_accounts_payment',1),(505,'2021_09_21_172056_add_file_to_format_templates',1),(506,'2021_09_22_120834_add_fields_technical_services',1),(507,'2021_09_22_120835_create_technical_service_items',1),(508,'2021_09_24_114832_add_configuration_to_show_name_of_pdf',1),(509,'2021_09_28_183535_add_name_pdf_to_quotation_items',1),(510,'2021_09_29_123827_add_text_to_address_in_configuration',1),(511,'2021_09_29_180607_tenant_add_set_address_by_establishment_to_configurations',1),(512,'2021_09_30_135325_tenant_add_order_id_to_sale_notes',1),(513,'2021_09_30_170149_tenant_add_permission_to_edit_cpe_to_configurations',1),(514,'2021_09_30_171912_tenant_add_permission_edit_cpe_to_users',1),(515,'2021_10_04_154837_tenant_change_nullable_packages_number_to_dispatches',1),(516,'2021_10_05_171912_add_configuration_module_to_user',1),(517,'2021_10_05_174410_tenant_add_total_igv_free_to_quotations',1),(518,'2021_10_06_132920_tenant_add_total_igv_free_to_order_notes',1),(519,'2021_10_07_144354_create_guide_file',1),(520,'2021_10_11_110825_create_item_movement_table',1),(521,'2021_10_12_111345_create_item_movement_rel_extra_table',1),(522,'2021_10_13_113504_add_only_user_warehouse_item_to_config',1),(523,'2021_10_18_110547_tenant_add_technical_service_id_to_documents',1),(524,'2021_10_18_110700_change_default_show_items_only_user_stablishment',1),(525,'2021_10_18_110700_change_value_show_items_only_user_stablishment',1),(526,'2021_10_18_110907_tenant_add_technical_service_id_to_sale_notes',1),(527,'2021_10_18_150100_tenant_add_document_type_04_to_cat_document_types',1),(528,'2021_10_18_150136_tenant_add_data_operation_type_0501_to_cat_operation_types',1),(529,'2021_10_18_150154_tenant_cat_address_types_table',1),(530,'2021_10_18_150215_tenant_add_address_type_id_to_persons',1),(531,'2021_10_18_150306_tenant_purchase_settlements_table',1),(532,'2021_10_18_150324_tenant_purchase_settlement_items_table',1),(533,'2021_10_18_153949_tenant_add_data_purchase_settlements_to_module_levels',1),(534,'2021_10_18_174146_tenant_add_subtotal_to_purchase_settlements',1),(535,'2021_10_19_150956_tenant_add_pending_amount_detraction_to_documents',1),(536,'2021_10_20_160503_tenant_add_retention_to_documents',1),(537,'2021_10_20_161035_tenant_add_data_retention_to_cat_charge_discount_types',1),(538,'2021_10_20_174401_tenant_rename_pending_amount_detraction_to_documents',1),(539,'2021_10_21_093921_tenant_add_igv_retention_percentage_to_configurations',1),(540,'2021_10_22_130040_create_app_suscription',1),(541,'2021_10_25_112316_tenant_add_subtotal_to_quotations',1),(542,'2021_10_25_142908_create_suscription_plans_table',1),(543,'2021_10_25_154009_tenant_add_option_13_to_cat_note_credit_types',1),(544,'2021_10_27_105710_tenant_add_subtotal_to_sale_notes',1),(545,'2021_10_27_133333_add_parent_id_field_to_persons',1),(546,'2021_10_28_110438_alter_sale_notes_and_documents',1),(547,'2021_10_28_173041_tenant_add_name_product_xml_to_document_items',1),(548,'2021_10_29_110421_tenant_add_name_product_pdf_to_xml_to_configurations',1),(549,'2021_10_29_114826_change_value_alternate_server_to_configurations',1),(550,'2021_11_09_113608_tenant_add_default_document_type_80_to_configurations',1),(551,'2021_11_09_143629_tenant_add_search_item_by_barcode_to_configurations',1),(552,'2021_11_09_173326_add_grade_and_section_touser_rel_suscription_plan',1),(553,'2021_11_11_113443_tenant_general_payment_conditions_table',1),(554,'2021_11_11_114229_tenant_add_payment_condition_id_to_purchases',1),(555,'2021_11_11_152521_tenant_purchase_fee_table',1),(556,'2021_11_11_180653_tenant_add_recreate_documents_to_users',1),(557,'2021_11_12_102347_add_grade_and_section_tables',1),(558,'2021_11_15_152956_additem_description_default_pdf_name_configuration',1),(559,'2021_11_16_150657_add_user_id_to_inventories_transfer',1),(560,'2021_11_25_105300_create_accounting_ledger_table',1),(561,'2021_11_25_154025_add_auto_print_to_configurations',1),(562,'2021_12_01_113756_add_show_services_on_pos',1),(563,'2021_12_02_141408_tenant_bank_loans_table',1),(564,'2021_12_08_211200_add_pos_history_and_cost_to_configuration',1),(565,'2021_12_09_182924_add_flag_to_production_for_item',1),(566,'2021_12_10_122529_add_zone_id_to_person',1),(567,'2021_12_10_130040_create_app_production',1),(568,'2021_12_10_172959_add_name_to_mill',1),(569,'2021_12_11_101624_add_data_to_inventory_transactions',1),(570,'2021_12_11_114856_add_item_to_mill_item',1),(571,'2021_12_11_170251_create_item_supplies',1),(572,'2021_12_15_112106_create_columns_to_show_by_user',1),(573,'2021_12_16_144057_add_show_totals_on_c_p_e_list',1),(574,'2021_12_21_134408_add_simplify_to_documentary',1),(575,'2021_12_22_150753_add_guide_to_documentary_archive',1),(576,'2021_12_25_163345_add_colors_to_documentary',1),(577,'2021_12_31_105910_change_documentary_process_characters',1),(578,'2022_01_05_170742_create_machine_for_production',1),(579,'2022_01_07_124919_add_complete_to_documentary_files',1),(580,'2022_01_11_140319_tenant_add_columns_send_pse_to_documents',1),(581,'2022_01_11_174033_tenant_add_columns_send_pse_to_companies',1),(582,'2022_01_12_180810_tenant_add_detraction_amount_rounded_int_to_configurations',1),(583,'2022_01_13_141051_tenant_add_sale_notes_relateds_to_documents',1),(584,'2022_01_15_130321_add_old_quantity_to_item_lot_group',1),(585,'2022_01_18_094821_tenant_add_data_to_inventory_transactions',1),(586,'2022_01_18_120000_add_show_term_condition_pos_to_configurations',1),(587,'2022_01_18_213317_tenant_create_cash_documents_credit',1),(588,'2022_01_20_202655_tenant_add_unique_filename_to_documents',1),(589,'2022_01_22_001715_add_date_end_to_documentary_files',1),(590,'2022_01_25_150315_add_apply_restaurant_to_items',1),(591,'2022_01_25_152940_create_app_restaurant',1),(592,'2022_01_26_175429_create_mi_tienda_pe',1),(593,'2022_01_28_110155_tenant_add_related_to_dispatches',1),(594,'2022_01_29_141957_add_purchase_order_and_observation_to_purchase',1),(595,'2022_01_29_191503_create_packaging_table',1),(596,'2022_01_30_120653_create_configuration_to_mi_tienda_pe',1),(597,'2022_02_02_203403_add_autogenerate_c_p_e_to_mi_tienda_pe',1),(598,'2022_02_07_110836_add_ticket_template_pdf_to_establishments_table',1),(599,'2022_02_07_121152_add_is_custom_ticket_to_format_templates',1),(600,'2022_02_07_142617_add_format_tickets_to_configurations',1),(601,'2022_02_07_161128_tenant_add_data_to_promotions_table',1),(602,'2022_02_08_213251_tenant_add_restaurant_to_orders',1),(603,'2022_02_11_162919_tenant_add_last_sale_price_to_configurations',1),(604,'2022_02_14_222010_tenant_add_flasg_to_inventory_configurations',1),(605,'2022_02_14_224820_tenant_add_barcode_to_item_unit_types',1),(606,'2022_02_16_150615_tenant_add_show_logo_establishment_to_configuration',1),(607,'2022_02_17_195824_add_colaborator_to_production_as_text',1),(608,'2022_02_22_111659_tenant_add_columns_send_pse_to_voided',1),(609,'2022_02_24_134926_tenant_add_columns_purchase_isc_to_items',1),(610,'2022_02_24_201345_tenant_download_tray_table',1),(611,'2022_02_25_172811_add_print_next_line_to_pdf_on_observation',1),(612,'2022_02_27_120405_tenant_add_comments_to_inventories',1),(613,'2022_03_03_110115_tenant_add_global_discount_type_id_to_configurations',1),(614,'2022_03_04_003932_tenant_add_quotation_to_cash_documents',1),(615,'2022_03_08_112351_tenant_add_columns_send_pse_to_dispatches',1),(616,'2022_03_09_111107_tenant_add_restaurant_to_cash',1),(617,'2022_03_10_094902_tenant_add_shipping_time_days_to_configurations',1),(618,'2022_03_11_120508_add_trace_to_api_peru_service',1),(619,'2022_03_14_221802_tenant_add_type_to_download_tray',1),(620,'2022_03_18_140238_tenant_add_total_igv_free_to_sale_notes',1),(621,'2022_03_21_110605_create_restaurant_configuration',1),(622,'2022_03_21_161851_add_configuration_new_valdiator_pagination',1),(623,'2022_03_25_134555_tenant_add_customer_filter_by_seller_to_configurations',1),(624,'2022_03_25_143916_tenant_add_index_seller_id_to_persons',1),(625,'2022_03_25_170158_tenant_add_validate_purchase_sale_unit_price_to_configurations',1),(626,'2022_03_28_174245_add_barcode_column_to_persons_table',1),(627,'2022_03_29_101534_add_quantity_to_restaurant_configuration',1),(628,'2022_03_31_132849_create_app_pos_garage',1),(629,'2022_04_04_151234_add_commands_to_restaurant_configurations',1),(630,'2022_04_06_111531_create_restaurant_roles_table',1),(631,'2022_04_06_112454_add_restaurant_role_to_users',1),(632,'2022_04_06_170626_tenant_add_unique_filename_to_sale_notes',1),(633,'2022_04_11_143145_tenant_add_name_product_pdf_to_contract_items',1),(634,'2022_04_11_152502_tenant_add_name_product_pdf_to_dispatch_items',1),(635,'2022_04_12_111023_tenant_add_columns_igv_unit_price_purchases_to_configurations',1),(636,'2022_04_12_121903_addindex_to_item_movement_rel_extra',1),(637,'2022_04_12_162742_tenant_report_configurations_table',1),(638,'2022_04_18_153331_tenant_add_payment_permissions_to_users',1),(639,'2022_04_19_114422_tenant_add_set_global_purchase_currency_items_to_configurations',1),(640,'2022_04_20_115118_tenant_add_subject_to_detraction_to_items',1),(641,'2022_04_22_101547_tenant_change_type_observation_to_sale_notes',1),(642,'2022_04_22_133909_tenant_add_set_unit_price_dispatch_related_record_to_configurations',1),(643,'2022_04_25_151827_tenant_add_index_barcode_to_item_unit_types',1),(644,'2022_04_26_175613_tenant_add_columns_restrict_voided_to_configurations',1),(645,'2022_04_28_175537_tenant_add_order_form_external_to_dispatches',1),(646,'2022_04_29_140515_tenant_add_enabled_tips_pos_to_configurations',1),(647,'2022_04_29_144947_tenant_tips_table',1),(648,'2022_05_02_135252_tenant_add_fields_to_module_levels',1),(649,'2022_05_02_152925_tenant_add_top_menu_to_configurations',1),(650,'2022_05_02_170654_tenant_add_data_district_250307_to_districts',1),(651,'2022_05_03_143911_tenant_create_skins_table',1),(652,'2022_05_04_150922_tenant_change_type_column_quantity_to_item_supplies',1),(653,'2022_05_04_155103_tenant_workers_table',1),(654,'2022_05_04_174017_tenant_add_unique_filename_to_summaries',1),(655,'2022_05_05_110908_tenant_add_soap_type_id_to_production',1),(656,'2022_05_05_115054_tenant_add_soap_type_id_to_mill',1),(657,'2022_05_05_134703_tenant_add_soap_type_id_to_packaging',1),(658,'2022_05_06_162034_add_fields_to_person',1),(659,'2022_05_08_122934_tenant_add_route_path_to_module_levels',1),(660,'2022_05_08_130040_create_app_full_suscription',1),(661,'2022_05_08_130054_tenant_update_data_to_skins',1),(662,'2022_05_09_105130_tenant_payment_configurations_table',1),(663,'2022_05_09_122150_tenant_add_defaults_to_configurations',1),(664,'2022_05_09_141114_tenant_payment_link_types_table',1),(665,'2022_05_09_143633_tenant_payment_links_table',1),(666,'2022_05_09_212753_tenant_register_app_generate_link_to_modules',1),(667,'2022_05_10_113515_tenant_transaction_states_table',1),(668,'2022_05_10_113608_tenant_transactions_table',1),(669,'2022_05_10_113734_tenant_transaction_queries_table',1),(670,'2022_05_10_113800_tenant_client_error_types_table',1),(671,'2022_05_10_113813_tenant_client_errors_table',1),(672,'2022_05_10_163722_tenant_config_default_to_configurations',1),(673,'2022_05_11_104030_tenant_add_soap_type_id_to_transactions',1),(674,'2022_05_11_115321_tenant_add_query_transaction_to_payment_links',1),(675,'2022_05_11_161435_tenant_change_nullable_payment_to_payment_links',1),(676,'2022_05_12_180154_tenant_add_legend_forest_to_xml_to_configurations',1),(677,'2022_05_13_162912_tenant_add_index_regularize_shipping_to_documents',1),(678,'2022_05_13_172504_tenant_add_change_currency_item_to_configurations',1),(679,'2022_05_17_164646_tenant_add_enabled_advanced_records_search_to_configurations',1),(680,'2022_05_23_133515_tenant_add_decimal_quantity_unit_price_pdf_to_configurations',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mill`
--

DROP TABLE IF EXISTS `mill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_start` date DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT '0',
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci,
  `mill_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lot_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mill_soap_type_id_foreign` (`soap_type_id`),
  CONSTRAINT `mill_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mill`
--

LOCK TABLES `mill` WRITE;
/*!40000 ALTER TABLE `mill` DISABLE KEYS */;
/*!40000 ALTER TABLE `mill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mill_items`
--

DROP TABLE IF EXISTS `mill_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mill_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT '0',
  `mill_id` int(10) unsigned DEFAULT '0',
  `height_to_mill` decimal(12,3) DEFAULT '0.000' COMMENT 'Peso de entrada',
  `total_height` decimal(12,3) DEFAULT '0.000' COMMENT 'Peso dle insumo ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,3) DEFAULT '0.000' COMMENT 'Peso dle insumo ',
  `item_extra_data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mill_items`
--

LOCK TABLES `mill_items` WRITE;
/*!40000 ALTER TABLE `mill_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `mill_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_level_user`
--

DROP TABLE IF EXISTS `module_level_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_level_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_level_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_level_user`
--

LOCK TABLES `module_level_user` WRITE;
/*!40000 ALTER TABLE `module_level_user` DISABLE KEYS */;
INSERT INTO `module_level_user` VALUES (1,76,0),(2,77,0),(3,78,0),(4,1,1),(5,2,1),(6,3,1),(7,4,1),(8,5,1),(9,6,1),(10,7,1),(11,8,1),(12,9,1),(13,10,1),(14,11,1),(15,12,1),(16,13,1),(17,14,1),(18,15,1),(19,16,1),(20,84,1),(21,17,1),(22,18,1),(23,19,1),(24,20,1),(25,21,1),(26,22,1),(27,23,1),(28,24,1),(29,25,1),(30,26,1),(31,27,1),(32,28,1),(33,29,1),(34,30,1),(35,31,1),(36,32,1),(37,33,1),(38,34,1),(39,35,1),(40,36,1),(41,37,1),(42,38,1),(43,39,1),(44,40,1),(45,41,1),(46,42,1),(47,43,1),(48,44,1),(49,75,1),(50,45,1),(51,46,1),(52,47,1),(53,48,1),(54,49,1),(55,50,1),(56,79,1),(57,51,1),(58,52,1),(59,53,1),(60,54,1),(61,55,1),(62,56,1),(63,57,1),(64,58,1),(65,59,1),(66,60,1),(67,76,1),(68,77,1),(69,78,1),(70,61,1),(71,62,1),(72,63,1),(73,64,1),(74,65,1),(75,66,1),(76,67,1),(77,68,1),(78,69,1),(79,70,1),(80,71,1),(81,72,1),(82,74,1),(83,73,1),(84,80,1),(85,81,1),(86,82,1),(87,83,1);
/*!40000 ALTER TABLE `module_level_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_levels`
--

DROP TABLE IF EXISTS `module_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_levels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `route_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label_menu` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_levels_module_id_foreign` (`module_id`),
  CONSTRAINT `module_levels_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_levels`
--

LOCK TABLES `module_levels` WRITE;
/*!40000 ALTER TABLE `module_levels` DISABLE KEYS */;
INSERT INTO `module_levels` VALUES (1,'new_document','Nuevo comprobante',1,'tenant.documents.create','/documents/create','NC',NULL,NULL),(2,'list_document','L. Comprobantes',1,NULL,NULL,NULL,NULL,NULL),(3,'document_not_sent','Doc. No enviados',1,NULL,NULL,NULL,NULL,NULL),(4,'document_contingengy','Doc. Contingencia',1,NULL,NULL,NULL,NULL,NULL),(5,'catalogs','Catálogos',1,NULL,NULL,NULL,NULL,NULL),(6,'summary_voided','Resúmenes y Anulaciones',1,NULL,NULL,NULL,NULL,NULL),(7,'quotations','Cotizaciones',1,NULL,NULL,NULL,NULL,NULL),(8,'sale_notes','Notas de Venta',1,'tenant.sale_notes.index','/sale-notes','NV',NULL,NULL),(9,'incentives','Comisiones',1,NULL,NULL,NULL,NULL,NULL),(10,'sale-opportunity','Oportunidad de venta',1,NULL,NULL,NULL,NULL,NULL),(11,'contracts','Contratos',1,NULL,NULL,NULL,NULL,NULL),(12,'order-note','Pedidos',1,'tenant.order_notes.index','/order-notes','PED',NULL,NULL),(13,'technical-service','Servicios de soporte técnico',1,NULL,NULL,NULL,NULL,NULL),(14,'regularize_shipping','CPE pendientes de rectificación',1,NULL,NULL,NULL,NULL,NULL),(15,'pos','Punto de venta',6,'tenant.pos.index','/pos','POS',NULL,NULL),(16,'cash','Caja chica POS',6,NULL,NULL,NULL,NULL,NULL),(17,'ecommerce','Ir a la tienda',10,NULL,NULL,NULL,NULL,NULL),(18,'ecommerce_orders','Pedidos',10,NULL,NULL,NULL,NULL,NULL),(19,'ecommerce_items','Productos tienda virtual',10,NULL,NULL,NULL,NULL,NULL),(20,'ecommerce_tags','Etiquetas',10,NULL,NULL,NULL,NULL,NULL),(21,'ecommerce_promotions','Promociones - Banners',10,NULL,NULL,NULL,NULL,NULL),(22,'ecommerce_settings','Configuración',10,NULL,NULL,NULL,NULL,NULL),(23,'items','Productos',17,'tenant.items.index','/items','PRO',NULL,NULL),(24,'items_packs','Packs',17,NULL,NULL,NULL,NULL,NULL),(25,'items_services','Servicios',17,NULL,NULL,NULL,NULL,NULL),(26,'items_categories','Categorías',17,NULL,NULL,NULL,NULL,NULL),(27,'items_brands','Marcas',17,NULL,NULL,NULL,NULL,NULL),(28,'items_lots','Series',17,NULL,NULL,NULL,NULL,NULL),(29,'clients','Clientes',18,NULL,NULL,NULL,NULL,NULL),(30,'clients_types','Tipos de clientes',18,NULL,NULL,NULL,NULL,NULL),(31,'purchases_create','Nueva Compra',2,'tenant.purchases.create','/purchases/create','NC',NULL,NULL),(32,'purchases_list','Listado',2,NULL,NULL,NULL,NULL,NULL),(33,'purchases_orders','Ordenes de compra',2,NULL,NULL,NULL,NULL,NULL),(34,'purchases_expenses','Gastos diversos',2,NULL,NULL,NULL,NULL,NULL),(35,'purchases_suppliers','Proveedores',2,NULL,NULL,NULL,NULL,NULL),(36,'purchases_quotations','Solicitar cotización',2,NULL,NULL,NULL,NULL,NULL),(37,'purchases_fixed_assets_items','Activos fijos - Ítems',2,NULL,NULL,NULL,NULL,NULL),(38,'purchases_fixed_assets_purchases','Activos fijos - Compras',2,NULL,NULL,NULL,NULL,NULL),(39,'inventory','Movimientos',8,'inventory.index','/inventory','INV',NULL,NULL),(40,'inventory_transfers','Traslados',8,NULL,NULL,NULL,NULL,NULL),(41,'inventory_devolutions','Devoluciones',8,NULL,NULL,NULL,NULL,NULL),(42,'inventory_report_kardex','Reporte kardex',8,NULL,NULL,NULL,NULL,NULL),(43,'inventory_report','Reporte inventario',8,NULL,NULL,NULL,NULL,NULL),(44,'inventory_report_kardex','Kardex valorizado',8,NULL,NULL,NULL,NULL,NULL),(45,'users','Usuarios',14,'tenant.users.index','/users','USR',NULL,NULL),(46,'users_establishments','Establecimientos',14,'tenant.establishments.index','/establishments','ES',NULL,NULL),(47,'advanced_retentions','Retenciones',3,NULL,NULL,NULL,NULL,NULL),(48,'advanced_dispatches','Guías de remisión',3,NULL,NULL,NULL,NULL,NULL),(49,'advanced_perceptions','Percepciones',3,NULL,NULL,NULL,NULL,NULL),(50,'advanced_order_forms','Ordenes de pedido',3,NULL,NULL,NULL,NULL,NULL),(51,'account_report','Exportar reporte',9,NULL,NULL,NULL,NULL,NULL),(52,'account_formats','Exportar formatos',9,NULL,NULL,NULL,NULL,NULL),(53,'account_summary','Reporte resumido - Ventas',9,NULL,NULL,NULL,NULL,NULL),(54,'finances_movements','Movimientos',12,NULL,NULL,NULL,NULL,NULL),(55,'finances_incomes','Ingresos',12,NULL,NULL,NULL,NULL,NULL),(56,'finances_unpaid','Cuentas por cobrar',12,NULL,NULL,NULL,NULL,NULL),(57,'finances_to_pay','Cuentas por pagar',12,NULL,NULL,NULL,NULL,NULL),(58,'finances_payments','Pagos',12,NULL,NULL,NULL,NULL,NULL),(59,'finances_balance','Balance',12,NULL,NULL,NULL,NULL,NULL),(60,'finances_payment_method_types','Ingresos y Egresos - M. Pago',12,NULL,NULL,NULL,NULL,NULL),(61,'account_users_settings','Configuración',11,NULL,NULL,NULL,NULL,NULL),(62,'account_users_list','Lista de pagos',11,NULL,NULL,NULL,NULL,NULL),(63,'hotels_reception','Recepción',15,NULL,NULL,NULL,NULL,NULL),(64,'hotels_rates','Tarifas',15,NULL,NULL,NULL,NULL,NULL),(65,'hotels_floors','Pisos',15,NULL,NULL,NULL,NULL,NULL),(66,'hotels_cats','Categorías',15,NULL,NULL,NULL,NULL,NULL),(67,'hotels_rooms','Habitaciones',15,NULL,NULL,NULL,NULL,NULL),(68,'documentary_offices','Oficinas',16,NULL,NULL,NULL,NULL,NULL),(69,'documentary_process','Procesos',16,NULL,NULL,NULL,NULL,NULL),(70,'documentary_documents','Tipos de documento',16,NULL,NULL,NULL,NULL,NULL),(71,'documentary_actions','Acciones',16,NULL,NULL,NULL,NULL,NULL),(72,'documentary_files','Expedientes',16,NULL,NULL,NULL,NULL,NULL),(73,'digemid','Productos',19,NULL,NULL,NULL,'2026-03-13 23:34:29','2026-03-13 23:34:29'),(74,'documentary_requirements','Requerimientos',16,NULL,NULL,NULL,'2026-03-13 23:34:32','2026-03-13 23:34:32'),(75,'inventory_item_extra_data','Datos extra de items',8,NULL,NULL,NULL,NULL,NULL),(76,'configuration_company','Empresa',5,'tenant.companies.create','/companies/create','ME',NULL,NULL),(77,'configuration_advance','Avanzado',5,NULL,NULL,NULL,NULL,NULL),(78,'configuration_visual','Visual',5,NULL,NULL,NULL,NULL,NULL),(79,'advanced_purchase_settlements','Liquidaciones de compra',3,NULL,NULL,NULL,NULL,NULL),(80,'suscription_app_client','Cliente',21,NULL,NULL,NULL,NULL,NULL),(81,'suscription_app_service','Servicio',21,NULL,NULL,NULL,NULL,NULL),(82,'suscription_app_payments','Pagos',21,NULL,NULL,NULL,NULL,NULL),(83,'suscription_app_plans','Planes',21,NULL,NULL,NULL,NULL,NULL),(84,'pos_garage','Venta rapida',6,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `module_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_user`
--

DROP TABLE IF EXISTS `module_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_user`
--

LOCK TABLES `module_user` WRITE;
/*!40000 ALTER TABLE `module_user` DISABLE KEYS */;
INSERT INTO `module_user` VALUES (1,7,1),(2,20,1),(3,1,1),(4,6,1),(5,10,1),(6,17,1),(7,18,1),(8,2,1),(9,8,1),(10,14,1),(11,3,1),(12,4,1),(13,9,1),(14,12,1),(15,5,1),(16,11,1),(17,15,1),(18,16,1),(19,19,1),(20,21,1),(21,22,1),(22,24,1),(23,23,1),(24,25,1);
/*!40000 ALTER TABLE `module_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_menu` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'documents','Ventas',2,NULL,NULL),(2,'purchases','Compras',7,NULL,NULL),(3,'advanced','Documentos Avanzados',8,NULL,NULL),(4,'reports','Reportes',9,NULL,NULL),(5,'configuration','Configuration',12,NULL,NULL),(6,'pos','Punto de venta (POS)',3,NULL,NULL),(7,'dashboard','Dashboard',1,NULL,NULL),(8,'inventory','Inventario',7,NULL,NULL),(9,'accounting','Contabilidad',10,NULL,NULL),(10,'ecommerce','Ecommerce',4,NULL,NULL),(11,'cuenta','Cuenta',13,NULL,NULL),(12,'finance','Finanzas',11,NULL,NULL),(14,'establishments','Usuarios/Locales & Series',7,NULL,NULL),(15,'hotels','Hoteles',14,NULL,NULL),(16,'documentary-procedure','Trámite documentario',15,NULL,NULL),(17,'items','Productos/Servicios',5,NULL,NULL),(18,'persons','Clientes',6,NULL,NULL),(19,'digemid','Farmacia',15,'2026-03-13 23:34:29','2026-03-13 23:34:29'),(20,'apps','Apps',13,NULL,NULL),(21,'suscription_app','Suscriptiones',16,NULL,NULL),(22,'production_app','Producción',17,NULL,NULL),(23,'restaurant_app','Restaurante',18,NULL,NULL),(24,'full_suscription_app','Suscripción Servicios SAAS',17,NULL,NULL),(25,'generate_link_app','Generador de link de pago',19,NULL,NULL);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(10) unsigned NOT NULL,
  `note_type` enum('credit','debit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `note_credit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note_debit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `affected_document_id` int(10) unsigned DEFAULT NULL,
  `data_affected_document` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notes_document_id_foreign` (`document_id`),
  KEY `notes_note_credit_type_id_foreign` (`note_credit_type_id`),
  KEY `notes_note_debit_type_id_foreign` (`note_debit_type_id`),
  KEY `notes_affected_document_id_foreign` (`affected_document_id`),
  CONSTRAINT `notes_affected_document_id_foreign` FOREIGN KEY (`affected_document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `notes_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_note_credit_type_id_foreign` FOREIGN KEY (`note_credit_type_id`) REFERENCES `cat_note_credit_types` (`id`),
  CONSTRAINT `notes_note_debit_type_id_foreign` FOREIGN KEY (`note_debit_type_id`) REFERENCES `cat_note_debit_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offline_configurations`
--

DROP TABLE IF EXISTS `offline_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offline_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_client` tinyint(1) NOT NULL DEFAULT '0',
  `token_server` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_server` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offline_configurations`
--

LOCK TABLES `offline_configurations` WRITE;
/*!40000 ALTER TABLE `offline_configurations` DISABLE KEYS */;
INSERT INTO `offline_configurations` VALUES (1,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `offline_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_form_items`
--

DROP TABLE IF EXISTS `order_form_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_form_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_form_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_form_items_order_form_id_foreign` (`order_form_id`),
  KEY `order_form_items_item_id_foreign` (`item_id`),
  CONSTRAINT `order_form_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `order_form_items_order_form_id_foreign` FOREIGN KEY (`order_form_id`) REFERENCES `order_forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_form_items`
--

LOCK TABLES `order_form_items` WRITE;
/*!40000 ALTER TABLE `order_form_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_form_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_forms`
--

DROP TABLE IF EXISTS `order_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `transport_mode_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transfer_reason_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transfer_reason_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_shipping` date NOT NULL,
  `transshipment_indicator` tinyint(1) NOT NULL,
  `port_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_weight` decimal(10,2) NOT NULL,
  `packages_number` int(11) NOT NULL,
  `container_number` int(11) DEFAULT NULL,
  `origin` json NOT NULL,
  `delivery` json NOT NULL,
  `dispatcher_id` int(10) unsigned NOT NULL,
  `driver_id` int(10) unsigned NOT NULL,
  `license_plates` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `optional` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_forms_dispatcher_id_foreign` (`dispatcher_id`),
  KEY `order_forms_driver_id_foreign` (`driver_id`),
  KEY `order_forms_user_id_foreign` (`user_id`),
  KEY `order_forms_establishment_id_foreign` (`establishment_id`),
  KEY `order_forms_soap_type_id_foreign` (`soap_type_id`),
  KEY `order_forms_state_type_id_foreign` (`state_type_id`),
  KEY `order_forms_customer_id_foreign` (`customer_id`),
  KEY `order_forms_unit_type_id_foreign` (`unit_type_id`),
  KEY `order_forms_transport_mode_type_id_foreign` (`transport_mode_type_id`),
  KEY `order_forms_transfer_reason_type_id_foreign` (`transfer_reason_type_id`),
  KEY `order_forms_date_of_issue_index` (`date_of_issue`),
  CONSTRAINT `order_forms_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `order_forms_dispatcher_id_foreign` FOREIGN KEY (`dispatcher_id`) REFERENCES `dispatchers` (`id`),
  CONSTRAINT `order_forms_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`),
  CONSTRAINT `order_forms_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `order_forms_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `order_forms_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `order_forms_transfer_reason_type_id_foreign` FOREIGN KEY (`transfer_reason_type_id`) REFERENCES `cat_transfer_reason_types` (`id`),
  CONSTRAINT `order_forms_transport_mode_type_id_foreign` FOREIGN KEY (`transport_mode_type_id`) REFERENCES `cat_transport_mode_types` (`id`),
  CONSTRAINT `order_forms_unit_type_id_foreign` FOREIGN KEY (`unit_type_id`) REFERENCES `cat_unit_types` (`id`),
  CONSTRAINT `order_forms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_forms`
--

LOCK TABLES `order_forms` WRITE;
/*!40000 ALTER TABLE `order_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_note_items`
--

DROP TABLE IF EXISTS `order_note_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_note_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_note_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_plastic_bag_taxes` decimal(6,2) DEFAULT '0.00' COMMENT 'Impuesto bolsa plastica',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `additional_information` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Informacion adcional',
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre del producto para el pdf',
  PRIMARY KEY (`id`),
  KEY `order_note_items_order_note_id_foreign` (`order_note_id`),
  KEY `order_note_items_item_id_foreign` (`item_id`),
  KEY `order_note_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `order_note_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `order_note_items_price_type_id_foreign` (`price_type_id`),
  KEY `order_note_items_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `order_note_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `order_note_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `order_note_items_order_note_id_foreign` FOREIGN KEY (`order_note_id`) REFERENCES `order_notes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_note_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `order_note_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`),
  CONSTRAINT `order_note_items_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_note_items`
--

LOCK TABLES `order_note_items` WRITE;
/*!40000 ALTER TABLE `order_note_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_note_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_notes`
--

DROP TABLE IF EXISTS `order_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `date_of_due` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observation` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `quotation_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con cotizaciones',
  PRIMARY KEY (`id`),
  KEY `order_notes_user_id_foreign` (`user_id`),
  KEY `order_notes_establishment_id_foreign` (`establishment_id`),
  KEY `order_notes_customer_id_foreign` (`customer_id`),
  KEY `order_notes_soap_type_id_foreign` (`soap_type_id`),
  KEY `order_notes_state_type_id_foreign` (`state_type_id`),
  KEY `order_notes_currency_type_id_foreign` (`currency_type_id`),
  KEY `order_notes_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `order_notes_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `order_notes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `order_notes_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `order_notes_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `order_notes_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `order_notes_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `order_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_notes`
--

LOCK TABLES `order_notes` WRITE;
/*!40000 ALTER TABLE `order_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer` json NOT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `items` json NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `reference_payment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_external_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_order_id` tinyint(3) unsigned DEFAULT NULL,
  `purchase` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `apply_restaurant` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `orders_status_order_id_foreign` (`status_order_id`),
  CONSTRAINT `orders_status_order_id_foreign` FOREIGN KEY (`status_order_id`) REFERENCES `status_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packaging`
--

DROP TABLE IF EXISTS `packaging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packaging` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_extra_data` json DEFAULT NULL,
  `establishment_id` int(10) unsigned DEFAULT NULL,
  `quantity` decimal(8,2) DEFAULT '0.00',
  `number_packages` decimal(8,2) DEFAULT '0.00',
  `item` json DEFAULT NULL,
  `observation` longtext COLLATE utf8mb4_unicode_ci,
  `lot_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `packaging_collaborator` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `packaging_soap_type_id_foreign` (`soap_type_id`),
  CONSTRAINT `packaging_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packaging`
--

LOCK TABLES `packaging` WRITE;
/*!40000 ALTER TABLE `packaging` DISABLE KEYS */;
/*!40000 ALTER TABLE `packaging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `padrones`
--

DROP TABLE IF EXISTS `padrones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `padrones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ruc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_razon_social` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado_contribuyente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion_domicilio` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubigeo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_via` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_via` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_zona` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_zona` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interior` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lote` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departamento` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manzana` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kilometro` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `padrones_ruc_index` (`ruc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `padrones`
--

LOCK TABLES `padrones` WRITE;
/*!40000 ALTER TABLE `padrones` DISABLE KEYS */;
/*!40000 ALTER TABLE `padrones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_conditions`
--

DROP TABLE IF EXISTS `payment_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_conditions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `days` int(11) NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `payment_conditions_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_conditions`
--

LOCK TABLES `payment_conditions` WRITE;
/*!40000 ALTER TABLE `payment_conditions` DISABLE KEYS */;
INSERT INTO `payment_conditions` VALUES ('01','Contado',0,1,1),('02','Crédito',0,1,1);
/*!40000 ALTER TABLE `payment_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_configurations`
--

DROP TABLE IF EXISTS `payment_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `enabled_yape` tinyint(1) NOT NULL,
  `qrcode_yape` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_yape` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone_yape` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled_mp` tinyint(1) NOT NULL DEFAULT '0',
  `access_token_mp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_key_mp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_configurations`
--

LOCK TABLES `payment_configurations` WRITE;
/*!40000 ALTER TABLE `payment_configurations` DISABLE KEYS */;
INSERT INTO `payment_configurations` VALUES (1,0,NULL,NULL,NULL,0,NULL,NULL,'2026-03-13 23:35:18','2026-03-13 23:35:18');
/*!40000 ALTER TABLE `payment_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_files`
--

DROP TABLE IF EXISTS `payment_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` int(11) NOT NULL,
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_index` (`payment_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_files`
--

LOCK TABLES `payment_files` WRITE;
/*!40000 ALTER TABLE `payment_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_link_types`
--

DROP TABLE IF EXISTS `payment_link_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_link_types` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_link_types`
--

LOCK TABLES `payment_link_types` WRITE;
/*!40000 ALTER TABLE `payment_link_types` DISABLE KEYS */;
INSERT INTO `payment_link_types` VALUES ('01','Yape'),('02','Mercado Pago');
/*!40000 ALTER TABLE `payment_link_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_links`
--

DROP TABLE IF EXISTS `payment_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `payment_link_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(12,2) NOT NULL,
  `uploaded_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `query_transaction` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_links_uuid_unique` (`uuid`),
  KEY `payment_index` (`payment_id`,`payment_type`),
  KEY `payment_links_user_id_foreign` (`user_id`),
  KEY `payment_links_soap_type_id_foreign` (`soap_type_id`),
  KEY `payment_links_payment_link_type_id_foreign` (`payment_link_type_id`),
  CONSTRAINT `payment_links_payment_link_type_id_foreign` FOREIGN KEY (`payment_link_type_id`) REFERENCES `payment_link_types` (`id`),
  CONSTRAINT `payment_links_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `payment_links_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_links`
--

LOCK TABLES `payment_links` WRITE;
/*!40000 ALTER TABLE `payment_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method_types`
--

DROP TABLE IF EXISTS `payment_method_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_method_types` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `charge` decimal(12,2) DEFAULT NULL,
  `number_days` int(11) DEFAULT NULL,
  `is_credit` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Define si es tipo credito',
  `is_cash` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Define si es es efectivo',
  KEY `payment_method_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method_types`
--

LOCK TABLES `payment_method_types` WRITE;
/*!40000 ALTER TABLE `payment_method_types` DISABLE KEYS */;
INSERT INTO `payment_method_types` VALUES ('01','Efectivo',0,NULL,NULL,0,1),('02','Tarjeta de crédito',1,NULL,NULL,0,0),('03','Tarjeta de débito',1,NULL,NULL,0,0),('04','Transferencia',0,NULL,NULL,0,0),('05','Factura a 30 días',0,NULL,30,1,0),('06','Tarjeta crédito visa',1,3.68,NULL,0,0),('07','Contado contraentrega',0,NULL,NULL,0,0),('08','A 30 días',0,NULL,30,1,0),('09','Crédito',1,NULL,NULL,1,0),('10','Contado',0,NULL,NULL,0,1);
/*!40000 ALTER TABLE `payment_method_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perception_documents`
--

DROP TABLE IF EXISTS `perception_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perception_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `perception_id` int(10) unsigned NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `date_of_perception` date NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_document` decimal(10,2) NOT NULL,
  `total_perception` decimal(10,2) NOT NULL,
  `payments` json NOT NULL,
  `series` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` json NOT NULL,
  `total_to_pay` decimal(10,2) NOT NULL,
  `total_payment` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `perception_details_perception_id_foreign` (`perception_id`),
  KEY `perception_documents_document_type_id_foreign` (`document_type_id`),
  KEY `perception_documents_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `perception_details_perception_id_foreign` FOREIGN KEY (`perception_id`) REFERENCES `perceptions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `perception_documents_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `perception_documents_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perception_documents`
--

LOCK TABLES `perception_documents` WRITE;
/*!40000 ALTER TABLE `perception_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `perception_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perceptions`
--

DROP TABLE IF EXISTS `perceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perceptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `perception_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `total_perception` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `optional` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_of_issue` time NOT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_xml` tinyint(1) NOT NULL DEFAULT '0',
  `has_pdf` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `perceptions_user_id_foreign` (`user_id`),
  KEY `perceptions_establishment_id_foreign` (`establishment_id`),
  KEY `perceptions_soap_type_id_foreign` (`soap_type_id`),
  KEY `perceptions_state_type_id_foreign` (`state_type_id`),
  KEY `perceptions_document_type_id_foreign` (`document_type_id`),
  KEY `perceptions_currency_type_id_foreign` (`currency_type_id`),
  KEY `perceptions_perception_type_id_foreign` (`perception_type_id`),
  KEY `perceptions_customer_id_foreign` (`customer_id`),
  KEY `perceptions_number_index` (`number`),
  KEY `perceptions_series_index` (`series`),
  CONSTRAINT `perceptions_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `perceptions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `perceptions_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `perceptions_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `perceptions_perception_type_id_foreign` FOREIGN KEY (`perception_type_id`) REFERENCES `cat_perception_types` (`id`),
  CONSTRAINT `perceptions_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `perceptions_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `perceptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perceptions`
--

LOCK TABLES `perceptions` WRITE;
/*!40000 ALTER TABLE `perceptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `perceptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int(10) unsigned NOT NULL,
  `department_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_id` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_id` char(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_address_person_id_foreign` (`person_id`),
  KEY `person_address_department_id_foreign` (`department_id`),
  KEY `person_address_province_id_foreign` (`province_id`),
  KEY `person_address_district_id_foreign` (`district_id`),
  CONSTRAINT `person_address_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `person_address_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`),
  CONSTRAINT `person_address_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `person_address_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_addresses`
--

DROP TABLE IF EXISTS `person_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int(10) unsigned NOT NULL,
  `country_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_id` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_id` char(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `person_addresses_person_id_foreign` (`person_id`),
  KEY `person_addresses_country_id_foreign` (`country_id`),
  KEY `person_addresses_department_id_foreign` (`department_id`),
  KEY `person_addresses_province_id_foreign` (`province_id`),
  KEY `person_addresses_district_id_foreign` (`district_id`),
  CONSTRAINT `person_addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `person_addresses_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `person_addresses_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`),
  CONSTRAINT `person_addresses_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `person_addresses_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_addresses`
--

LOCK TABLES `person_addresses` WRITE;
/*!40000 ALTER TABLE `person_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_types`
--

DROP TABLE IF EXISTS `person_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_types`
--

LOCK TABLES `person_types` WRITE;
/*!40000 ALTER TABLE `person_types` DISABLE KEYS */;
INSERT INTO `person_types` VALUES (1,'Interno','2026-03-13 23:32:59','2026-03-13 23:32:59'),(2,'Distribuidor','2026-03-13 23:32:59','2026-03-13 23:32:59');
/*!40000 ALTER TABLE `person_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('customers','suppliers') COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `internal_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_id` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_id` char(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perception_agent` tinyint(1) NOT NULL DEFAULT '0',
  `person_type_id` int(10) unsigned DEFAULT NULL,
  `contact` json DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentage_perception` decimal(12,2) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `website` text COLLATE utf8mb4_unicode_ci COMMENT 'Sitio Web',
  `zone` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Zona',
  `observation` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Observaciones',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `credit_days` int(10) unsigned DEFAULT '0' COMMENT 'establece los dias de credito',
  `optional_email` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Conjunto de correos de envio',
  `parent_id` int(10) unsigned DEFAULT '0' COMMENT 'Se relaciona con si mismo, numero mayor a 0 es el id del padre.',
  `zone_id` int(10) unsigned DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `persons_identity_document_type_id_foreign` (`identity_document_type_id`),
  KEY `persons_country_id_foreign` (`country_id`),
  KEY `persons_department_id_foreign` (`department_id`),
  KEY `persons_province_id_foreign` (`province_id`),
  KEY `persons_district_id_foreign` (`district_id`),
  KEY `persons_name_index` (`name`),
  KEY `persons_number_index` (`number`),
  KEY `persons_type_index` (`type`),
  KEY `persons_person_type_id_foreign` (`person_type_id`),
  KEY `persons_enabled_index` (`enabled`),
  KEY `persons_address_type_id_foreign` (`address_type_id`),
  KEY `persons_seller_id_index` (`seller_id`),
  CONSTRAINT `persons_address_type_id_foreign` FOREIGN KEY (`address_type_id`) REFERENCES `cat_address_types` (`id`),
  CONSTRAINT `persons_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `persons_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `persons_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`),
  CONSTRAINT `persons_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`),
  CONSTRAINT `persons_person_type_id_foreign` FOREIGN KEY (`person_type_id`) REFERENCES `person_types` (`id`),
  CONSTRAINT `persons_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` VALUES (1,'customers','6','20100154308','San Fernando',NULL,NULL,NULL,'PE','15','1501','150103',NULL,'Ate Vitarte',NULL,NULL,NULL,NULL,0,1,'{\"phone\": null, \"full_name\": null}',NULL,0.00,1,NULL,NULL,NULL,'2026-03-14 11:07:59','2026-03-14 11:07:59',1,0,NULL,0,NULL,NULL),(2,'customers','6','10417663431','Jean',NULL,NULL,NULL,'PE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,'{\"phone\": null, \"full_name\": null}',NULL,0.00,1,NULL,NULL,NULL,'2026-03-14 11:51:01','2026-03-14 11:51:01',1,0,NULL,0,NULL,NULL),(3,'customers','6','10292883432','prueba',NULL,NULL,NULL,'PE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,'{\"phone\": null, \"full_name\": null}',NULL,0.00,1,NULL,NULL,NULL,'2026-03-14 13:26:40','2026-03-14 13:26:40',1,0,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preprinted_format_templates`
--

DROP TABLE IF EXISTS `preprinted_format_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preprinted_format_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `formats` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preprinted_format_templates`
--

LOCK TABLES `preprinted_format_templates` WRITE;
/*!40000 ALTER TABLE `preprinted_format_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `preprinted_format_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production`
--

DROP TABLE IF EXISTS `production`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT '0',
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` int(10) unsigned DEFAULT '0',
  `inventory_id_reference` int(10) unsigned DEFAULT NULL,
  `quantity` decimal(12,4) DEFAULT '0.0000' COMMENT 'Peso dle insumo ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `machine_id` int(10) unsigned NOT NULL DEFAULT '0',
  `production_order` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci,
  `date_start` date DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `lot_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_extra_data` json DEFAULT NULL,
  `mix_date_start` date DEFAULT NULL,
  `mix_time_start` time DEFAULT NULL,
  `mix_date_end` date DEFAULT NULL,
  `mix_time_end` time DEFAULT NULL,
  `informative` tinyint(3) unsigned DEFAULT '0',
  `agreed` decimal(8,2) DEFAULT '0.00',
  `imperfect` decimal(8,2) DEFAULT '0.00',
  `proccess_type` longtext COLLATE utf8mb4_unicode_ci,
  `production_collaborator` text COLLATE utf8mb4_unicode_ci,
  `mix_collaborator` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `production_soap_type_id_foreign` (`soap_type_id`),
  CONSTRAINT `production_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production`
--

LOCK TABLES `production` WRITE;
/*!40000 ALTER TABLE `production` DISABLE KEYS */;
/*!40000 ALTER TABLE `production` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `apply_restaurant` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `promotions_item_id_foreign` (`item_id`),
  CONSTRAINT `promotions_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provinces` (
  `id` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  KEY `provinces_department_id_foreign` (`department_id`),
  KEY `provinces_id_index` (`id`),
  CONSTRAINT `provinces_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` VALUES ('0101','01','Chachapoyas',1),('0102','01','Bagua',1),('0103','01','Bongará',1),('0104','01','Condorcanqui',1),('0105','01','Luya',1),('0106','01','Rodríguez de Mendoza',1),('0107','01','Utcubamba',1),('0201','02','Huaraz',1),('0202','02','Aija',1),('0203','02','Antonio Raymondi',1),('0204','02','Asunción',1),('0205','02','Bolognesi',1),('0206','02','Carhuaz',1),('0207','02','Carlos Fermín Fitzcarrald',1),('0208','02','Casma',1),('0209','02','Corongo',1),('0210','02','Huari',1),('0211','02','Huarmey',1),('0212','02','Huaylas',1),('0213','02','Mariscal Luzuriaga',1),('0214','02','Ocros',1),('0215','02','Pallasca',1),('0216','02','Pomabamba',1),('0217','02','Recuay',1),('0218','02','Santa',1),('0219','02','Sihuas',1),('0220','02','Yungay',1),('0301','03','Abancay',1),('0302','03','Andahuaylas',1),('0303','03','Antabamba',1),('0304','03','Aymaraes',1),('0305','03','Cotabambas',1),('0306','03','Chincheros',1),('0307','03','Grau',1),('0401','04','Arequipa',1),('0402','04','Camaná',1),('0403','04','Caravelí',1),('0404','04','Castilla',1),('0405','04','Caylloma',1),('0406','04','Condesuyos',1),('0407','04','Islay',1),('0408','04','La Uniòn',1),('0501','05','Huamanga',1),('0502','05','Cangallo',1),('0503','05','Huanca Sancos',1),('0504','05','Huanta',1),('0505','05','La Mar',1),('0506','05','Lucanas',1),('0507','05','Parinacochas',1),('0508','05','Pàucar del Sara Sara',1),('0509','05','Sucre',1),('0510','05','Víctor Fajardo',1),('0511','05','Vilcas Huamán',1),('0601','06','Cajamarca',1),('0602','06','Cajabamba',1),('0603','06','Celendín',1),('0604','06','Chota',1),('0605','06','Contumazá',1),('0606','06','Cutervo',1),('0607','06','Hualgayoc',1),('0608','06','Jaén',1),('0609','06','San Ignacio',1),('0610','06','San Marcos',1),('0611','06','San Miguel',1),('0612','06','San Pablo',1),('0613','06','Santa Cruz',1),('0701','07','Prov. Const. del Callao',1),('0801','08','Cusco',1),('0802','08','Acomayo',1),('0803','08','Anta',1),('0804','08','Calca',1),('0805','08','Canas',1),('0806','08','Canchis',1),('0807','08','Chumbivilcas',1),('0808','08','Espinar',1),('0809','08','La Convención',1),('0810','08','Paruro',1),('0811','08','Paucartambo',1),('0812','08','Quispicanchi',1),('0813','08','Urubamba',1),('0901','09','Huancavelica',1),('0902','09','Acobamba',1),('0903','09','Angaraes',1),('0904','09','Castrovirreyna',1),('0905','09','Churcampa',1),('0906','09','Huaytará',1),('0907','09','Tayacaja',1),('1001','10','Huánuco',1),('1002','10','Ambo',1),('1003','10','Dos de Mayo',1),('1004','10','Huacaybamba',1),('1005','10','Huamalíes',1),('1006','10','Leoncio Prado',1),('1007','10','Marañón',1),('1008','10','Pachitea',1),('1009','10','Puerto Inca',1),('1010','10','Lauricocha',1),('1011','10','Yarowilca',1),('1101','11','Ica',1),('1102','11','Chincha',1),('1103','11','Nasca',1),('1104','11','Palpa',1),('1105','11','Pisco',1),('1201','12','Huancayo',1),('1202','12','Concepción',1),('1203','12','Chanchamayo',1),('1204','12','Jauja',1),('1205','12','Junín',1),('1206','12','Satipo',1),('1207','12','Tarma',1),('1208','12','Yauli',1),('1209','12','Chupaca',1),('1301','13','Trujillo',1),('1302','13','Ascope',1),('1303','13','Bolívar',1),('1304','13','Chepén',1),('1305','13','Julcán',1),('1306','13','Otuzco',1),('1307','13','Pacasmayo',1),('1308','13','Pataz',1),('1309','13','Sánchez Carrión',1),('1310','13','Santiago de Chuco',1),('1311','13','Gran Chimú',1),('1312','13','Virú',1),('1401','14','Chiclayo',1),('1402','14','Ferreñafe',1),('1403','14','Lambayeque',1),('1501','15','Lima',1),('1502','15','Barranca',1),('1503','15','Cajatambo',1),('1504','15','Canta',1),('1505','15','Cañete',1),('1506','15','Huaral',1),('1507','15','Huarochirí',1),('1508','15','Huaura',1),('1509','15','Oyón',1),('1510','15','Yauyos',1),('1601','16','Maynas',1),('1602','16','Alto Amazonas',1),('1603','16','Loreto',1),('1604','16','Mariscal Ramón Castilla',1),('1605','16','Requena',1),('1606','16','Ucayali',1),('1607','16','Datem del Marañón',1),('1608','16','Putumayo',1),('1701','17','Tambopata',1),('1702','17','Manu',1),('1703','17','Tahuamanu',1),('1801','18','Mariscal Nieto',1),('1802','18','General Sánchez Cerro',1),('1803','18','Ilo',1),('1901','19','Pasco',1),('1902','19','Daniel Alcides Carrión',1),('1903','19','Oxapampa',1),('2001','20','Piura',1),('2002','20','Ayabaca',1),('2003','20','Huancabamba',1),('2004','20','Morropón',1),('2005','20','Paita',1),('2006','20','Sullana',1),('2007','20','Talara',1),('2008','20','Sechura',1),('2101','21','Puno',1),('2102','21','Azángaro',1),('2103','21','Carabaya',1),('2104','21','Chucuito',1),('2105','21','El Collao',1),('2106','21','Huancané',1),('2107','21','Lampa',1),('2108','21','Melgar',1),('2109','21','Moho',1),('2110','21','San Antonio de Putina',1),('2111','21','San Román',1),('2112','21','Sandia',1),('2113','21','Yunguyo',1),('2201','22','Moyobamba',1),('2202','22','Bellavista',1),('2203','22','El Dorado',1),('2204','22','Huallaga',1),('2205','22','Lamas',1),('2206','22','Mariscal Cáceres',1),('2207','22','Picota',1),('2208','22','Rioja',1),('2209','22','San Martín',1),('2210','22','Tocache',1),('2301','23','Tacna',1),('2302','23','Candarave',1),('2303','23','Jorge Basadre',1),('2304','23','Tarata',1),('2401','24','Tumbes',1),('2402','24','Contralmirante Villar',1),('2403','24','Zarumilla',1),('2501','25','Coronel Portillo',1),('2502','25','Atalaya',1),('2503','25','Padre Abad',1),('2504','25','Purús',1);
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_fee`
--

DROP TABLE IF EXISTS `purchase_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_fee` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_fee_purchase_id_foreign` (`purchase_id`),
  KEY `purchase_fee_currency_type_id_foreign` (`currency_type_id`),
  KEY `purchase_fee_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `purchase_fee_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `purchase_fee_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `purchase_fee_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_fee`
--

LOCK TABLES `purchase_fee` WRITE;
/*!40000 ALTER TABLE `purchase_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_items`
--

DROP TABLE IF EXISTS `purchase_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `lot_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `date_of_due` date DEFAULT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_items_purchase_id_foreign` (`purchase_id`),
  KEY `purchase_items_item_id_foreign` (`item_id`),
  KEY `purchase_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `purchase_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `purchase_items_price_type_id_foreign` (`price_type_id`),
  KEY `purchase_items_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `purchase_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `purchase_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `purchase_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `purchase_items_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`),
  CONSTRAINT `purchase_items_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_items`
--

LOCK TABLES `purchase_items` WRITE;
/*!40000 ALTER TABLE `purchase_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_items`
--

DROP TABLE IF EXISTS `purchase_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_items_purchase_order_id_foreign` (`purchase_order_id`),
  KEY `purchase_order_items_item_id_foreign` (`item_id`),
  KEY `purchase_order_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `purchase_order_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `purchase_order_items_price_type_id_foreign` (`price_type_id`),
  CONSTRAINT `purchase_order_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `purchase_order_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `purchase_order_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `purchase_order_items_purchase_order_id_foreign` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_items`
--

LOCK TABLES `purchase_order_items` WRITE;
/*!40000 ALTER TABLE `purchase_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_orders`
--

DROP TABLE IF EXISTS `purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OC',
  `date_of_issue` date NOT NULL,
  `date_of_due` date DEFAULT NULL,
  `time_of_issue` time NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `supplier` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_quotation_id` int(10) unsigned DEFAULT NULL,
  `sale_opportunity_id` int(10) unsigned DEFAULT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_orders_purchase_quotation_id_foreign` (`purchase_quotation_id`),
  KEY `purchase_orders_user_id_foreign` (`user_id`),
  KEY `purchase_orders_establishment_id_foreign` (`establishment_id`),
  KEY `purchase_orders_supplier_id_foreign` (`supplier_id`),
  KEY `purchase_orders_soap_type_id_foreign` (`soap_type_id`),
  KEY `purchase_orders_state_type_id_foreign` (`state_type_id`),
  KEY `purchase_orders_currency_type_id_foreign` (`currency_type_id`),
  KEY `purchase_orders_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `purchase_orders_sale_opportunity_id_foreign` (`sale_opportunity_id`),
  CONSTRAINT `purchase_orders_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `purchase_orders_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `purchase_orders_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `purchase_orders_purchase_quotation_id_foreign` FOREIGN KEY (`purchase_quotation_id`) REFERENCES `purchase_quotations` (`id`),
  CONSTRAINT `purchase_orders_sale_opportunity_id_foreign` FOREIGN KEY (`sale_opportunity_id`) REFERENCES `sale_opportunities` (`id`),
  CONSTRAINT `purchase_orders_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `purchase_orders_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `purchase_orders_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `purchase_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_orders`
--

LOCK TABLES `purchase_orders` WRITE;
/*!40000 ALTER TABLE `purchase_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_payments`
--

DROP TABLE IF EXISTS `purchase_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_payments_purchase_id_foreign` (`purchase_id`),
  KEY `purchase_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `purchase_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `purchase_payments_date_of_payment_index` (`date_of_payment`),
  CONSTRAINT `purchase_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `purchase_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `purchase_payments_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_payments`
--

LOCK TABLES `purchase_payments` WRITE;
/*!40000 ALTER TABLE `purchase_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_quotation_items`
--

DROP TABLE IF EXISTS `purchase_quotation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_quotation_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_quotation_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_quotation_items_purchase_quotation_id_foreign` (`purchase_quotation_id`),
  KEY `purchase_quotation_items_item_id_foreign` (`item_id`),
  CONSTRAINT `purchase_quotation_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `purchase_quotation_items_purchase_quotation_id_foreign` FOREIGN KEY (`purchase_quotation_id`) REFERENCES `purchase_quotations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_quotation_items`
--

LOCK TABLES `purchase_quotation_items` WRITE;
/*!40000 ALTER TABLE `purchase_quotation_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_quotation_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_quotations`
--

DROP TABLE IF EXISTS `purchase_quotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_quotations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `suppliers` json NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_quotations_user_id_foreign` (`user_id`),
  KEY `purchase_quotations_establishment_id_foreign` (`establishment_id`),
  KEY `purchase_quotations_soap_type_id_foreign` (`soap_type_id`),
  KEY `purchase_quotations_state_type_id_foreign` (`state_type_id`),
  CONSTRAINT `purchase_quotations_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `purchase_quotations_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `purchase_quotations_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `purchase_quotations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_quotations`
--

LOCK TABLES `purchase_quotations` WRITE;
/*!40000 ALTER TABLE `purchase_quotations` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_quotations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_settlement_items`
--

DROP TABLE IF EXISTS `purchase_settlement_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_settlement_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_settlement_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `unit_value` decimal(12,2) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `income_tax_affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `income_retention_percentage` decimal(12,2) NOT NULL DEFAULT '0.00',
  `income_retention_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `purchase_settlement_items_purchase_settlement_id_foreign` (`purchase_settlement_id`),
  KEY `purchase_settlement_items_item_id_foreign` (`item_id`),
  KEY `p_s_i_income_tax_affectation_igv_type_id_fk` (`income_tax_affectation_igv_type_id`),
  KEY `purchase_settlement_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `purchase_settlement_items_price_type_id_foreign` (`price_type_id`),
  CONSTRAINT `p_s_i_income_tax_affectation_igv_type_id_fk` FOREIGN KEY (`income_tax_affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `purchase_settlement_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `purchase_settlement_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `purchase_settlement_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `purchase_settlement_items_purchase_settlement_id_foreign` FOREIGN KEY (`purchase_settlement_id`) REFERENCES `purchase_settlements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_settlement_items`
--

LOCK TABLES `purchase_settlement_items` WRITE;
/*!40000 ALTER TABLE `purchase_settlement_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_settlement_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_settlements`
--

DROP TABLE IF EXISTS `purchase_settlements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_settlements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `supplier` json NOT NULL,
  `operation_data` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate_sale` decimal(12,2) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `legends` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_xml` tinyint(1) NOT NULL DEFAULT '0',
  `has_pdf` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `purchase_settlements_filename_unique` (`filename`),
  KEY `purchase_settlements_user_id_foreign` (`user_id`),
  KEY `purchase_settlements_establishment_id_foreign` (`establishment_id`),
  KEY `purchase_settlements_supplier_id_foreign` (`supplier_id`),
  KEY `purchase_settlements_soap_type_id_foreign` (`soap_type_id`),
  KEY `purchase_settlements_state_type_id_foreign` (`state_type_id`),
  KEY `purchase_settlements_document_type_id_foreign` (`document_type_id`),
  KEY `purchase_settlements_currency_type_id_foreign` (`currency_type_id`),
  KEY `purchase_settlements_operation_type_id_foreign` (`operation_type_id`),
  KEY `purchase_settlements_series_index` (`series`),
  KEY `purchase_settlements_number_index` (`number`),
  KEY `purchase_settlements_date_of_issue_index` (`date_of_issue`),
  CONSTRAINT `purchase_settlements_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `purchase_settlements_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `purchase_settlements_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `purchase_settlements_operation_type_id_foreign` FOREIGN KEY (`operation_type_id`) REFERENCES `cat_operation_types` (`id`),
  CONSTRAINT `purchase_settlements_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `purchase_settlements_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `purchase_settlements_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `purchase_settlements_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_settlements`
--

LOCK TABLES `purchase_settlements` WRITE;
/*!40000 ALTER TABLE `purchase_settlements` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_settlements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `date_of_due` date DEFAULT NULL,
  `time_of_issue` time NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `supplier` json NOT NULL,
  `purchase_order_id` int(10) unsigned DEFAULT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_condition_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observation` text COLLATE utf8mb4_unicode_ci,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_canceled` tinyint(1) NOT NULL DEFAULT '0',
  `customer_id` int(10) unsigned DEFAULT NULL,
  `perception_date` date DEFAULT NULL,
  `perception_number` int(11) DEFAULT NULL,
  `total_perception` decimal(12,2) DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchases_user_id_foreign` (`user_id`),
  KEY `purchases_establishment_id_foreign` (`establishment_id`),
  KEY `purchases_supplier_id_foreign` (`supplier_id`),
  KEY `purchases_soap_type_id_foreign` (`soap_type_id`),
  KEY `purchases_state_type_id_foreign` (`state_type_id`),
  KEY `purchases_group_id_foreign` (`group_id`),
  KEY `purchases_document_type_id_foreign` (`document_type_id`),
  KEY `purchases_currency_type_id_foreign` (`currency_type_id`),
  KEY `purchases_purchase_order_id_foreign` (`purchase_order_id`),
  KEY `purchases_customer_id_foreign` (`customer_id`),
  KEY `purchases_payment_condition_id_foreign` (`payment_condition_id`),
  CONSTRAINT `purchases_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `purchases_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `purchases_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `purchases_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `purchases_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `purchases_payment_condition_id_foreign` FOREIGN KEY (`payment_condition_id`) REFERENCES `general_payment_conditions` (`id`),
  CONSTRAINT `purchases_purchase_order_id_foreign` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`),
  CONSTRAINT `purchases_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `purchases_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation_items`
--

DROP TABLE IF EXISTS `quotation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotation_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quotation_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `additional_information` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Informacion adicional',
  `warehouse_id` int(10) unsigned DEFAULT '0' COMMENT 'Id de warehouse',
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre de producto en el pdf',
  PRIMARY KEY (`id`),
  KEY `quotation_items_quotation_id_foreign` (`quotation_id`),
  KEY `quotation_items_item_id_foreign` (`item_id`),
  KEY `quotation_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `quotation_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `quotation_items_price_type_id_foreign` (`price_type_id`),
  CONSTRAINT `quotation_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `quotation_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `quotation_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `quotation_items_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quotation_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation_items`
--

LOCK TABLES `quotation_items` WRITE;
/*!40000 ALTER TABLE `quotation_items` DISABLE KEYS */;
INSERT INTO `quotation_items` VALUES (1,1,1,'{\"id\": 1, \"lots\": [], \"brand\": null, \"extra\": {\"colors\": null, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"stock\": \"99.0000\", \"colors\": [], \"is_set\": false, \"barcode\": \"000000000001\", \"has_igv\": false, \"has_isc\": false, \"category\": null, \"lot_code\": null, \"item_code\": null, \"attributes\": [], \"lots_group\": [], \"unit_price\": 16.7088, \"warehouses\": [{\"stock\": \"99.0000\", \"checked\": true, \"warehouse_id\": 1, \"warehouse_description\": \"Almacén Oficina Principal\"}], \"CatItemSize\": [], \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"lots_enabled\": false, \"presentation\": [], \"unit_type_id\": \"NIU\", \"CatItemStatus\": [], \"percentage_isc\": \"0.00\", \"series_enabled\": false, \"stock_by_extra\": {\"total\": -1, \"colors\": {\"total\": null, \"detailed\": []}, \"CatItemSize\": {\"total\": null, \"detailed\": []}, \"CatItemStatus\": {\"total\": null, \"detailed\": []}, \"CatItemMoldCavity\": {\"total\": null, \"detailed\": []}, \"CatItemMoldProperty\": {\"total\": null, \"detailed\": []}, \"CatItemUnitBusiness\": {\"total\": null, \"detailed\": []}, \"CatItemProductFamily\": {\"total\": null, \"detailed\": []}, \"CatItemUnitsPerPackage\": {\"total\": null, \"detailed\": []}, \"CatItemPackageMeasurement\": {\"total\": null, \"detailed\": []}}, \"extra_attr_name\": \"Tiempo de entrega\", \"item_unit_types\": [], \"sale_unit_price\": \"12.0000\", \"currency_type_id\": \"PEN\", \"extra_attr_value\": null, \"full_description\": \"producto 1 -\", \"name_product_pdf\": null, \"CatItemMoldCavity\": [], \"is_for_production\": false, \"calculate_quantity\": false, \"system_isc_type_id\": null, \"CatItemMoldProperty\": [], \"CatItemUnitBusiness\": [], \"purchase_unit_price\": \"0.000000\", \"CatItemProductFamily\": [], \"currency_type_symbol\": \"S/\", \"has_plastic_bag_taxes\": false, \"original_unit_type_id\": \"NIU\", \"subject_to_detraction\": false, \"warehouse_description\": \"Almacén Oficina Principal\", \"CatItemUnitsPerPackage\": [], \"amount_plastic_bag_taxes\": \"0.10\", \"CatItemPackageMeasurement\": [], \"sale_affectation_igv_type\": {\"id\": \"10\", \"free\": 0, \"active\": 1, \"description\": \"Gravado - Operación Onerosa\", \"exportation\": 0}, \"change_free_affectation_igv\": false, \"sale_affectation_igv_type_id\": \"10\", \"original_affectation_igv_type_id\": \"10\", \"purchase_affectation_igv_type_id\": \"10\"}',100.0000,14.160000,'10',1416.00,18.00,254.88,NULL,0.00,0.00,0.00,0.00,0.00,0.00,254.88,'01',16.708800,1416.00,0.00,0.00,1670.88,'[]','[]','[]',NULL,NULL,NULL),(2,2,1,'{\"id\": 1, \"lots\": [], \"brand\": null, \"extra\": {\"colors\": null, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"stock\": \"-7.0000\", \"colors\": [], \"is_set\": false, \"barcode\": \"000000000001\", \"has_igv\": false, \"has_isc\": false, \"category\": null, \"lot_code\": null, \"item_code\": null, \"attributes\": [], \"lots_group\": [], \"unit_price\": 14.16, \"warehouses\": [{\"stock\": \"-7.0000\", \"checked\": true, \"warehouse_id\": 1, \"warehouse_description\": \"Almacén Oficina Principal\"}], \"CatItemSize\": [], \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"lots_enabled\": false, \"presentation\": [], \"unit_type_id\": \"NIU\", \"CatItemStatus\": [], \"percentage_isc\": \"0.00\", \"series_enabled\": false, \"stock_by_extra\": {\"total\": -107, \"colors\": {\"total\": null, \"detailed\": []}, \"CatItemSize\": {\"total\": null, \"detailed\": []}, \"CatItemStatus\": {\"total\": null, \"detailed\": []}, \"CatItemMoldCavity\": {\"total\": null, \"detailed\": []}, \"CatItemMoldProperty\": {\"total\": null, \"detailed\": []}, \"CatItemUnitBusiness\": {\"total\": null, \"detailed\": []}, \"CatItemProductFamily\": {\"total\": null, \"detailed\": []}, \"CatItemUnitsPerPackage\": {\"total\": null, \"detailed\": []}, \"CatItemPackageMeasurement\": {\"total\": null, \"detailed\": []}}, \"extra_attr_name\": \"Tiempo de entrega\", \"item_unit_types\": [], \"sale_unit_price\": \"12.0000\", \"currency_type_id\": \"PEN\", \"extra_attr_value\": null, \"full_description\": \"producto 1 -\", \"name_product_pdf\": null, \"CatItemMoldCavity\": [], \"is_for_production\": false, \"calculate_quantity\": false, \"system_isc_type_id\": null, \"CatItemMoldProperty\": [], \"CatItemUnitBusiness\": [], \"purchase_unit_price\": \"0.000000\", \"CatItemProductFamily\": [], \"currency_type_symbol\": \"S/\", \"has_plastic_bag_taxes\": false, \"original_unit_type_id\": \"NIU\", \"subject_to_detraction\": false, \"warehouse_description\": \"Almacén Oficina Principal\", \"CatItemUnitsPerPackage\": [], \"amount_plastic_bag_taxes\": \"0.10\", \"CatItemPackageMeasurement\": [], \"sale_affectation_igv_type\": {\"id\": \"10\", \"free\": 0, \"active\": 1, \"description\": \"Gravado - Operación Onerosa\", \"exportation\": 0}, \"change_free_affectation_igv\": false, \"sale_affectation_igv_type_id\": \"10\", \"original_affectation_igv_type_id\": \"10\", \"purchase_affectation_igv_type_id\": \"10\"}',1.0000,12.000000,'10',12.00,18.00,2.16,NULL,0.00,0.00,0.00,0.00,0.00,0.00,2.16,'01',14.160000,12.00,0.00,0.00,14.16,'[]','[]','[]',NULL,NULL,NULL),(3,2,1,'{\"id\": 1, \"lots\": [], \"brand\": null, \"extra\": {\"colors\": null, \"CatItemSize\": null, \"CatItemStatus\": null, \"CatItemMoldCavity\": null, \"CatItemMoldProperty\": null, \"CatItemUnitBusiness\": null, \"CatItemProductFamily\": null, \"CatItemUnitsPerPackage\": null, \"CatItemPackageMeasurement\": null}, \"model\": null, \"stock\": \"-7.0000\", \"colors\": [], \"is_set\": false, \"barcode\": \"000000000001\", \"has_igv\": false, \"has_isc\": false, \"category\": null, \"lot_code\": null, \"item_code\": null, \"attributes\": [], \"lots_group\": [], \"unit_price\": 14.16, \"warehouses\": [{\"stock\": \"-7.0000\", \"checked\": true, \"warehouse_id\": 1, \"warehouse_description\": \"Almacén Oficina Principal\"}], \"CatItemSize\": [], \"date_of_due\": null, \"description\": \"producto 1\", \"internal_id\": null, \"lots_enabled\": false, \"presentation\": [], \"unit_type_id\": \"NIU\", \"CatItemStatus\": [], \"percentage_isc\": \"0.00\", \"series_enabled\": false, \"stock_by_extra\": {\"total\": -107, \"colors\": {\"total\": null, \"detailed\": []}, \"CatItemSize\": {\"total\": null, \"detailed\": []}, \"CatItemStatus\": {\"total\": null, \"detailed\": []}, \"CatItemMoldCavity\": {\"total\": null, \"detailed\": []}, \"CatItemMoldProperty\": {\"total\": null, \"detailed\": []}, \"CatItemUnitBusiness\": {\"total\": null, \"detailed\": []}, \"CatItemProductFamily\": {\"total\": null, \"detailed\": []}, \"CatItemUnitsPerPackage\": {\"total\": null, \"detailed\": []}, \"CatItemPackageMeasurement\": {\"total\": null, \"detailed\": []}}, \"extra_attr_name\": \"Tiempo de entrega\", \"item_unit_types\": [], \"sale_unit_price\": \"12.0000\", \"currency_type_id\": \"PEN\", \"extra_attr_value\": null, \"full_description\": \"producto 1 -\", \"name_product_pdf\": null, \"CatItemMoldCavity\": [], \"is_for_production\": false, \"calculate_quantity\": false, \"system_isc_type_id\": null, \"CatItemMoldProperty\": [], \"CatItemUnitBusiness\": [], \"purchase_unit_price\": \"0.000000\", \"CatItemProductFamily\": [], \"currency_type_symbol\": \"S/\", \"has_plastic_bag_taxes\": false, \"original_unit_type_id\": \"NIU\", \"subject_to_detraction\": false, \"warehouse_description\": \"Almacén Oficina Principal\", \"CatItemUnitsPerPackage\": [], \"amount_plastic_bag_taxes\": \"0.10\", \"CatItemPackageMeasurement\": [], \"sale_affectation_igv_type\": {\"id\": \"10\", \"free\": 0, \"active\": 1, \"description\": \"Gravado - Operación Onerosa\", \"exportation\": 0}, \"change_free_affectation_igv\": false, \"sale_affectation_igv_type_id\": \"10\", \"original_affectation_igv_type_id\": \"10\", \"purchase_affectation_igv_type_id\": \"10\"}',4.0000,12.000000,'10',48.00,18.00,8.64,NULL,0.00,0.00,0.00,0.00,0.00,0.00,8.64,'01',14.160000,48.00,0.00,0.00,56.64,'[]','[]','[]',NULL,NULL,NULL);
/*!40000 ALTER TABLE `quotation_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation_payments`
--

DROP TABLE IF EXISTS `quotation_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotation_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quotation_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` decimal(12,2) DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quotation_payments_quotation_id_foreign` (`quotation_id`),
  KEY `quotation_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `quotation_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `quotation_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `quotation_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `quotation_payments_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation_payments`
--

LOCK TABLES `quotation_payments` WRITE;
/*!40000 ALTER TABLE `quotation_payments` DISABLE KEYS */;
INSERT INTO `quotation_payments` VALUES (1,1,'2026-03-14','01',0,NULL,NULL,NULL,1670.88);
/*!40000 ALTER TABLE `quotation_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotations`
--

DROP TABLE IF EXISTS `quotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `date_of_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms_condition` text COLLATE utf8mb4_unicode_ci,
  `referential_information` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `sale_opportunity_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quotations_user_id_foreign` (`user_id`),
  KEY `quotations_establishment_id_foreign` (`establishment_id`),
  KEY `quotations_customer_id_foreign` (`customer_id`),
  KEY `quotations_soap_type_id_foreign` (`soap_type_id`),
  KEY `quotations_state_type_id_foreign` (`state_type_id`),
  KEY `quotations_currency_type_id_foreign` (`currency_type_id`),
  KEY `quotations_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `quotations_sale_opportunity_id_foreign` (`sale_opportunity_id`),
  CONSTRAINT `quotations_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `quotations_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `quotations_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `quotations_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `quotations_sale_opportunity_id_foreign` FOREIGN KEY (`sale_opportunity_id`) REFERENCES `sale_opportunities` (`id`),
  CONSTRAINT `quotations_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `quotations_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `quotations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotations`
--

LOCK TABLES `quotations` WRITE;
/*!40000 ALTER TABLE `quotations` DISABLE KEYS */;
INSERT INTO `quotations` VALUES (1,1,1,'0993cbc6-2b65-406f-8a80-afd6a343f3a0',1,'{\"code\": \"0000\", \"logo\": null, \"email\": \"admin@gmail.com\", \"address\": \"-\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150101\", \"description\": \"Lima\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": \"-\", \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"district_id\": \"150101\", \"province_id\": \"1501\", \"web_address\": null, \"urbanization\": null, \"department_id\": \"15\", \"trade_address\": null, \"aditional_information\": null}','01','05','COT','2026-03-14','11:50:33',NULL,NULL,2,'{\"name\": \"Jean\", \"email\": null, \"number\": \"10417663431\", \"address\": null, \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": null, \"description\": null}, \"province\": {\"id\": null, \"description\": null}, \"telephone\": null, \"address_id\": null, \"country_id\": \"PE\", \"department\": {\"id\": null, \"description\": null}, \"trade_name\": null, \"district_id\": null, \"province_id\": null, \"address_type\": {\"id\": null, \"description\": null}, \"department_id\": null, \"internal_code\": null, \"address_type_id\": null, \"perception_agent\": false, \"identity_document_type\": {\"id\": \"6\", \"description\": \"RUC\"}, \"identity_document_type_id\": \"6\"}','Los Olivos','PEN','10',3.453,0.00,0.00,0.00,0.00,0.00,1416.00,0.00,0.00,254.88,0.00,0.00,0.00,0.00,0.00,254.88,1416.00,1670.88,1670.88,'[]','[]',NULL,'[]',NULL,NULL,NULL,NULL,'COT-1-20260314',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-03-14 11:51:50','2026-03-14 11:59:40',NULL),(2,1,1,'82b23f01-eb1e-4879-a9f8-f134dce82260',1,'{\"code\": \"0000\", \"logo\": null, \"email\": \"admin@gmail.com\", \"address\": \"-\", \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": \"150101\", \"description\": \"Lima\"}, \"province\": {\"id\": \"1501\", \"description\": \"Lima\"}, \"telephone\": \"-\", \"country_id\": \"PE\", \"department\": {\"id\": \"15\", \"description\": \"LIMA\"}, \"district_id\": \"150101\", \"province_id\": \"1501\", \"web_address\": null, \"urbanization\": null, \"department_id\": \"15\", \"trade_address\": null, \"aditional_information\": null}','01','05','COT','2026-03-14','13:31:54',NULL,NULL,3,'{\"name\": \"prueba\", \"email\": null, \"number\": \"10292883432\", \"address\": null, \"country\": {\"id\": \"PE\", \"description\": \"PERU\"}, \"district\": {\"id\": null, \"description\": null}, \"province\": {\"id\": null, \"description\": null}, \"telephone\": null, \"address_id\": null, \"country_id\": \"PE\", \"department\": {\"id\": null, \"description\": null}, \"trade_name\": null, \"district_id\": null, \"province_id\": null, \"address_type\": {\"id\": null, \"description\": null}, \"department_id\": null, \"internal_code\": null, \"address_type_id\": null, \"perception_agent\": false, \"identity_document_type\": {\"id\": \"6\", \"description\": \"RUC\"}, \"identity_document_type_id\": \"6\"}',NULL,'PEN','10',3.453,0.00,0.00,0.00,0.00,0.00,60.00,0.00,0.00,10.80,0.00,0.00,0.00,0.00,0.00,10.80,60.00,70.80,70.80,'[]','[]',NULL,'[]',NULL,NULL,NULL,NULL,'COT-2-20260314',NULL,NULL,NULL,NULL,NULL,0,NULL,'2026-03-14 13:32:24','2026-03-14 13:33:18',NULL);
/*!40000 ALTER TABLE `quotations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_user_to_documentary_offices`
--

DROP TABLE IF EXISTS `rel_user_to_documentary_offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_user_to_documentary_offices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'usuario asociado',
  `documentary_office_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'etapa asociada',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_user_to_documentary_offices`
--

LOCK TABLES `rel_user_to_documentary_offices` WRITE;
/*!40000 ALTER TABLE `rel_user_to_documentary_offices` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_user_to_documentary_offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_configurations`
--

DROP TABLE IF EXISTS `report_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `route_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `convert_pen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_configurations_route_name_unique` (`route_name`),
  UNIQUE KEY `report_configurations_route_path_unique` (`route_path`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_configurations`
--

LOCK TABLES `report_configurations` WRITE;
/*!40000 ALTER TABLE `report_configurations` DISABLE KEYS */;
INSERT INTO `report_configurations` VALUES (1,'tenant.reports.general_items.index','reports/general-items','Ventas - Reporte general de productos',0,'2026-03-13 23:35:13','2026-03-13 23:35:13'),(2,'tenant.reports.purchases.general_items.index','reports/purchases/general_items','Compras - Reporte general de productos',0,'2026-03-13 23:35:13','2026-03-13 23:35:13'),(3,'tenant.reports.purchases.index','reports/purchases','Compras - Compras totales',0,'2026-03-13 23:35:13','2026-03-13 23:35:13');
/*!40000 ALTER TABLE `report_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_configurations`
--

DROP TABLE IF EXISTS `restaurant_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_pos` tinyint(1) NOT NULL,
  `menu_order` tinyint(1) NOT NULL,
  `menu_tables` tinyint(1) NOT NULL,
  `first_menu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tables_quantity` int(11) NOT NULL DEFAULT '15',
  `menu_bar` tinyint(1) NOT NULL DEFAULT '1',
  `menu_kitchen` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_configurations`
--

LOCK TABLES `restaurant_configurations` WRITE;
/*!40000 ALTER TABLE `restaurant_configurations` DISABLE KEYS */;
INSERT INTO `restaurant_configurations` VALUES (1,1,1,1,'POS',15,1,1);
/*!40000 ALTER TABLE `restaurant_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_roles`
--

DROP TABLE IF EXISTS `restaurant_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_roles`
--

LOCK TABLES `restaurant_roles` WRITE;
/*!40000 ALTER TABLE `restaurant_roles` DISABLE KEYS */;
INSERT INTO `restaurant_roles` VALUES (1,'MOZO','Mozo','Usuario que genera pedidos en mesas',NULL,NULL),(2,'CAJA','Caja','Usuario que genera pago de pedidos',NULL,NULL),(3,'ADM','Administrador','Usuario con permisos totales',NULL,NULL),(4,'KIT','Comanda/Cocina','Usuario con acceso a cocina',NULL,NULL),(5,'BAR','Comanda/Bar','Usuario con acceso a bar',NULL,NULL);
/*!40000 ALTER TABLE `restaurant_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retention_documents`
--

DROP TABLE IF EXISTS `retention_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retention_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `retention_id` int(10) unsigned NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_document` decimal(10,2) NOT NULL,
  `payments` json NOT NULL,
  `exchange_rate` json NOT NULL,
  `date_of_retention` date NOT NULL,
  `total_retention` decimal(10,2) NOT NULL,
  `total_to_pay` decimal(10,2) NOT NULL,
  `total_payment` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `retention_documents_retention_id_foreign` (`retention_id`),
  KEY `retention_documents_document_type_id_foreign` (`document_type_id`),
  KEY `retention_documents_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `retention_documents_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `retention_documents_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `retention_documents_retention_id_foreign` FOREIGN KEY (`retention_id`) REFERENCES `retentions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retention_documents`
--

LOCK TABLES `retention_documents` WRITE;
/*!40000 ALTER TABLE `retention_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `retention_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retentions`
--

DROP TABLE IF EXISTS `retentions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retentions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `supplier` json NOT NULL,
  `retention_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_retention` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `legends` json DEFAULT NULL,
  `optional` json DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soap_shipping_response` json DEFAULT NULL,
  `has_xml` tinyint(1) NOT NULL DEFAULT '0',
  `has_pdf` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retentions_user_id_foreign` (`user_id`),
  KEY `retentions_establishment_id_foreign` (`establishment_id`),
  KEY `retentions_soap_type_id_foreign` (`soap_type_id`),
  KEY `retentions_state_type_id_foreign` (`state_type_id`),
  KEY `retentions_document_type_id_foreign` (`document_type_id`),
  KEY `retentions_supplier_id_foreign` (`supplier_id`),
  KEY `retentions_retention_type_id_foreign` (`retention_type_id`),
  KEY `retentions_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `retentions_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `retentions_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `retentions_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `retentions_retention_type_id_foreign` FOREIGN KEY (`retention_type_id`) REFERENCES `cat_retention_types` (`id`),
  CONSTRAINT `retentions_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `retentions_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `retentions_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `retentions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retentions`
--

LOCK TABLES `retentions` WRITE;
/*!40000 ALTER TABLE `retentions` DISABLE KEYS */;
/*!40000 ALTER TABLE `retentions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_note_items`
--

DROP TABLE IF EXISTS `sale_note_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_note_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_note_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `system_isc_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `percentage_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_plastic_bag_taxes` decimal(6,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  `additional_information` text COLLATE utf8mb4_unicode_ci,
  `inventory_kardex_id` int(10) unsigned DEFAULT NULL,
  `warehouse_id` int(10) unsigned DEFAULT NULL,
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `sale_note_items_sale_note_id_foreign` (`sale_note_id`),
  KEY `sale_note_items_item_id_foreign` (`item_id`),
  KEY `sale_note_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `sale_note_items_system_isc_type_id_foreign` (`system_isc_type_id`),
  KEY `sale_note_items_price_type_id_foreign` (`price_type_id`),
  KEY `sale_note_items_inventory_kardex_id_foreign` (`inventory_kardex_id`),
  KEY `sale_note_items_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `sale_note_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `sale_note_items_inventory_kardex_id_foreign` FOREIGN KEY (`inventory_kardex_id`) REFERENCES `inventory_kardex` (`id`),
  CONSTRAINT `sale_note_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `sale_note_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `sale_note_items_sale_note_id_foreign` FOREIGN KEY (`sale_note_id`) REFERENCES `sale_notes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sale_note_items_system_isc_type_id_foreign` FOREIGN KEY (`system_isc_type_id`) REFERENCES `cat_system_isc_types` (`id`),
  CONSTRAINT `sale_note_items_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_note_items`
--

LOCK TABLES `sale_note_items` WRITE;
/*!40000 ALTER TABLE `sale_note_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_note_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_note_migration`
--

DROP TABLE IF EXISTS `sale_note_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_note_migration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_notes_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `success` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remote_id` int(10) unsigned NOT NULL DEFAULT '0',
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_note_migration`
--

LOCK TABLES `sale_note_migration` WRITE;
/*!40000 ALTER TABLE `sale_note_migration` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_note_migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_note_payments`
--

DROP TABLE IF EXISTS `sale_note_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_note_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_note_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_card` tinyint(1) NOT NULL DEFAULT '0',
  `card_brand_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` decimal(12,2) DEFAULT NULL,
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_note_payments_sale_note_id_foreign` (`sale_note_id`),
  KEY `sale_note_payments_card_brand_id_foreign` (`card_brand_id`),
  KEY `sale_note_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `sale_note_payments_date_of_payment_index` (`date_of_payment`),
  CONSTRAINT `sale_note_payments_card_brand_id_foreign` FOREIGN KEY (`card_brand_id`) REFERENCES `card_brands` (`id`),
  CONSTRAINT `sale_note_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `sale_note_payments_sale_note_id_foreign` FOREIGN KEY (`sale_note_id`) REFERENCES `sale_notes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_note_payments`
--

LOCK TABLES `sale_note_payments` WRITE;
/*!40000 ALTER TABLE `sale_note_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_note_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_notes`
--

DROP TABLE IF EXISTS `sale_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `apply_concurrency` tinyint(1) NOT NULL DEFAULT '0',
  `enabled_concurrency` tinyint(1) NOT NULL DEFAULT '0',
  `automatic_date_of_issue` date DEFAULT NULL,
  `quantity_period` int(11) DEFAULT NULL,
  `type_period` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_isc` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_plastic_bag_taxes` decimal(6,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `charges` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `guides` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `additional_information` text COLLATE utf8mb4_unicode_ci,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unique_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_id` int(10) unsigned DEFAULT NULL,
  `order_note_id` int(10) unsigned DEFAULT NULL,
  `technical_service_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `total_canceled` tinyint(1) NOT NULL DEFAULT '0',
  `changed` tinyint(1) NOT NULL DEFAULT '0',
  `paid` tinyint(1) NOT NULL DEFAULT '0',
  `license_plate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plate_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_data` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observation` text COLLATE utf8mb4_unicode_ci,
  `purchase_order` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_id` int(10) unsigned DEFAULT NULL,
  `user_rel_suscription_plan_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con suscripciones',
  `due_date` date DEFAULT NULL COMMENT 'Fecha de vencimiento',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT '0',
  `grade` text COLLATE utf8mb4_unicode_ci COMMENT 'Grado designado - utilizado en matricula',
  `section` text COLLATE utf8mb4_unicode_ci COMMENT 'Seccion designado - utilizado en matricula',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_notes_unique_filename_unique` (`unique_filename`),
  KEY `sale_notes_user_id_foreign` (`user_id`),
  KEY `sale_notes_establishment_id_foreign` (`establishment_id`),
  KEY `sale_notes_customer_id_foreign` (`customer_id`),
  KEY `sale_notes_soap_type_id_foreign` (`soap_type_id`),
  KEY `sale_notes_state_type_id_foreign` (`state_type_id`),
  KEY `sale_notes_currency_type_id_foreign` (`currency_type_id`),
  KEY `sale_notes_quotation_id_foreign` (`quotation_id`),
  KEY `sale_notes_apply_concurrency_index` (`apply_concurrency`),
  KEY `sale_notes_type_period_index` (`type_period`),
  KEY `sale_notes_quantity_period_index` (`quantity_period`),
  KEY `sale_notes_automatic_date_of_issue_index` (`automatic_date_of_issue`),
  KEY `sale_notes_enabled_concurrency_index` (`enabled_concurrency`),
  KEY `sale_notes_order_note_id_foreign` (`order_note_id`),
  KEY `sale_notes_payment_method_type_id_foreign` (`payment_method_type_id`),
  KEY `sale_notes_order_id_foreign` (`order_id`),
  KEY `sale_notes_technical_service_id_foreign` (`technical_service_id`),
  CONSTRAINT `sale_notes_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `sale_notes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `sale_notes_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `sale_notes_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `sale_notes_order_note_id_foreign` FOREIGN KEY (`order_note_id`) REFERENCES `order_notes` (`id`),
  CONSTRAINT `sale_notes_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `sale_notes_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`),
  CONSTRAINT `sale_notes_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `sale_notes_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `sale_notes_technical_service_id_foreign` FOREIGN KEY (`technical_service_id`) REFERENCES `technical_services` (`id`),
  CONSTRAINT `sale_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_notes`
--

LOCK TABLES `sale_notes` WRITE;
/*!40000 ALTER TABLE `sale_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_opportunities`
--

DROP TABLE IF EXISTS `sale_opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_opportunities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned NOT NULL,
  `establishment` json NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate_sale` decimal(13,3) NOT NULL,
  `total_exportation` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_free` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_unaffected` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_exonerated` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_igv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_taxes` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci,
  `observation` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_opportunities_user_id_foreign` (`user_id`),
  KEY `sale_opportunities_establishment_id_foreign` (`establishment_id`),
  KEY `sale_opportunities_customer_id_foreign` (`customer_id`),
  KEY `sale_opportunities_soap_type_id_foreign` (`soap_type_id`),
  KEY `sale_opportunities_state_type_id_foreign` (`state_type_id`),
  KEY `sale_opportunities_currency_type_id_foreign` (`currency_type_id`),
  CONSTRAINT `sale_opportunities_currency_type_id_foreign` FOREIGN KEY (`currency_type_id`) REFERENCES `cat_currency_types` (`id`),
  CONSTRAINT `sale_opportunities_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `sale_opportunities_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `sale_opportunities_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `sale_opportunities_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `sale_opportunities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_opportunities`
--

LOCK TABLES `sale_opportunities` WRITE;
/*!40000 ALTER TABLE `sale_opportunities` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_opportunities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_opportunity_files`
--

DROP TABLE IF EXISTS `sale_opportunity_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_opportunity_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_opportunity_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_opportunity_files_sale_opportunity_id_foreign` (`sale_opportunity_id`),
  CONSTRAINT `sale_opportunity_files_sale_opportunity_id_foreign` FOREIGN KEY (`sale_opportunity_id`) REFERENCES `sale_opportunities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_opportunity_files`
--

LOCK TABLES `sale_opportunity_files` WRITE;
/*!40000 ALTER TABLE `sale_opportunity_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_opportunity_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_opportunity_items`
--

DROP TABLE IF EXISTS `sale_opportunity_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_opportunity_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_opportunity_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item` json NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_value` decimal(16,6) NOT NULL,
  `affectation_igv_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_base_igv` decimal(12,2) NOT NULL,
  `percentage_igv` decimal(12,2) NOT NULL,
  `total_igv` decimal(12,2) NOT NULL,
  `total_taxes` decimal(12,2) NOT NULL,
  `price_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(16,6) NOT NULL,
  `total_value` decimal(12,2) NOT NULL,
  `total_charge` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `charges` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_opportunity_items_sale_opportunity_id_foreign` (`sale_opportunity_id`),
  KEY `sale_opportunity_items_item_id_foreign` (`item_id`),
  KEY `sale_opportunity_items_affectation_igv_type_id_foreign` (`affectation_igv_type_id`),
  KEY `sale_opportunity_items_price_type_id_foreign` (`price_type_id`),
  CONSTRAINT `sale_opportunity_items_affectation_igv_type_id_foreign` FOREIGN KEY (`affectation_igv_type_id`) REFERENCES `cat_affectation_igv_types` (`id`),
  CONSTRAINT `sale_opportunity_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `sale_opportunity_items_price_type_id_foreign` FOREIGN KEY (`price_type_id`) REFERENCES `cat_price_types` (`id`),
  CONSTRAINT `sale_opportunity_items_sale_opportunity_id_foreign` FOREIGN KEY (`sale_opportunity_id`) REFERENCES `sale_opportunities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_opportunity_items`
--

LOCK TABLES `sale_opportunity_items` WRITE;
/*!40000 ALTER TABLE `sale_opportunity_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_opportunity_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `series` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `establishment_id` int(10) unsigned NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contingency` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `series_establishment_id_foreign` (`establishment_id`),
  KEY `series_document_type_id_foreign` (`document_type_id`),
  CONSTRAINT `series_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `series_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series`
--

LOCK TABLES `series` WRITE;
/*!40000 ALTER TABLE `series` DISABLE KEYS */;
INSERT INTO `series` VALUES (1,1,'01','F001',0,NULL,NULL),(2,1,'03','B001',0,NULL,NULL),(3,1,'07','FC01',0,NULL,NULL),(4,1,'07','BC01',0,NULL,NULL),(5,1,'08','FD01',0,NULL,NULL),(6,1,'08','BD01',0,NULL,NULL),(7,1,'20','R001',0,NULL,NULL),(8,1,'09','T001',0,NULL,NULL),(9,1,'40','P001',0,NULL,NULL),(10,1,'80','NV01',0,NULL,NULL),(11,1,'04','L001',0,NULL,NULL);
/*!40000 ALTER TABLE `series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `series_configurations`
--

DROP TABLE IF EXISTS `series_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `series_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `series_id` int(10) unsigned NOT NULL,
  `document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `series_configurations_series_id_foreign` (`series_id`),
  KEY `series_configurations_series_index` (`series`),
  KEY `series_configurations_number_index` (`number`),
  KEY `series_configurations_document_type_id_foreign` (`document_type_id`),
  CONSTRAINT `series_configurations_document_type_id_foreign` FOREIGN KEY (`document_type_id`) REFERENCES `cat_document_types` (`id`),
  CONSTRAINT `series_configurations_series_id_foreign` FOREIGN KEY (`series_id`) REFERENCES `series` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series_configurations`
--

LOCK TABLES `series_configurations` WRITE;
/*!40000 ALTER TABLE `series_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `series_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skins`
--

DROP TABLE IF EXISTS `skins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skins`
--

LOCK TABLES `skins` WRITE;
/*!40000 ALTER TABLE `skins` DISABLE KEYS */;
INSERT INTO `skins` VALUES (1,'Default','default.css',1,NULL,NULL),(2,'Light','light.css',1,NULL,NULL);
/*!40000 ALTER TABLE `skins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soap_types`
--

DROP TABLE IF EXISTS `soap_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soap_types` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `soap_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soap_types`
--

LOCK TABLES `soap_types` WRITE;
/*!40000 ALTER TABLE `soap_types` DISABLE KEYS */;
INSERT INTO `soap_types` VALUES ('01','Demo'),('02','Producción'),('03','Interno');
/*!40000 ALTER TABLE `soap_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state_types`
--

DROP TABLE IF EXISTS `state_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_types` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `state_types_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state_types`
--

LOCK TABLES `state_types` WRITE;
/*!40000 ALTER TABLE `state_types` DISABLE KEYS */;
INSERT INTO `state_types` VALUES ('01','Registrado'),('03','Enviado'),('05','Aceptado'),('07','Observado'),('09','Rechazado'),('11','Anulado'),('13','Por anular');
/*!40000 ALTER TABLE `state_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_orders`
--

DROP TABLE IF EXISTS `status_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_orders` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_orders`
--

LOCK TABLES `status_orders` WRITE;
/*!40000 ALTER TABLE `status_orders` DISABLE KEYS */;
INSERT INTO `status_orders` VALUES (1,'Pago sin verificar','2026-03-13 23:33:51',NULL),(2,'Pago verificado','2026-03-13 23:33:51',NULL),(3,'Despachado','2026-03-13 23:33:51',NULL),(4,'Confirmado por el cliente','2026-03-13 23:33:51',NULL);
/*!40000 ALTER TABLE `status_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `summaries`
--

DROP TABLE IF EXISTS `summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summaries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary_status_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `date_of_reference` date NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unique_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_ticket` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `soap_shipping_response` json DEFAULT NULL,
  `unknown_error_status_response` tinyint(1) NOT NULL DEFAULT '0',
  `manually_regularized` tinyint(1) NOT NULL DEFAULT '0',
  `error_manually_regularized` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `summaries_unique_filename_unique` (`unique_filename`),
  KEY `summaries_user_id_foreign` (`user_id`),
  KEY `summaries_soap_type_id_foreign` (`soap_type_id`),
  KEY `summaries_state_type_id_foreign` (`state_type_id`),
  KEY `summaries_summary_status_type_id_foreign` (`summary_status_type_id`),
  KEY `summaries_date_of_issue_index` (`date_of_issue`),
  CONSTRAINT `summaries_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `summaries_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `summaries_summary_status_type_id_foreign` FOREIGN KEY (`summary_status_type_id`) REFERENCES `cat_summary_status_types` (`id`),
  CONSTRAINT `summaries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `summaries`
--

LOCK TABLES `summaries` WRITE;
/*!40000 ALTER TABLE `summaries` DISABLE KEYS */;
/*!40000 ALTER TABLE `summaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `summary_documents`
--

DROP TABLE IF EXISTS `summary_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `summary_id` int(10) unsigned NOT NULL,
  `document_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `summary_documents_summary_id_foreign` (`summary_id`),
  KEY `summary_documents_document_id_foreign` (`document_id`),
  CONSTRAINT `summary_documents_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `summary_documents_summary_id_foreign` FOREIGN KEY (`summary_id`) REFERENCES `summaries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `summary_documents`
--

LOCK TABLES `summary_documents` WRITE;
/*!40000 ALTER TABLE `summary_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `summary_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscription_grade`
--

DROP TABLE IF EXISTS `suscription_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscription_grade` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscription_grade`
--

LOCK TABLES `suscription_grade` WRITE;
/*!40000 ALTER TABLE `suscription_grade` DISABLE KEYS */;
INSERT INTO `suscription_grade` VALUES (1,'1er'),(2,'2do'),(3,'3ro'),(4,'4to'),(5,'5to'),(6,'6to'),(7,'7mo'),(8,'8vo');
/*!40000 ALTER TABLE `suscription_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscription_plans`
--

DROP TABLE IF EXISTS `suscription_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscription_plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_period_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con el periodo de tiempo',
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del plan',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Descripcion del plan',
  `total` double(12,2) DEFAULT '0.00' COMMENT 'El total del costo del plan',
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity_period` int(10) unsigned DEFAULT NULL,
  `exchange_rate_sale` double(13,3) DEFAULT '0.000',
  `total_prepayment` double(12,2) DEFAULT '0.00',
  `total_charge` double(12,2) DEFAULT '0.00',
  `total_discount` double(12,2) DEFAULT '0.00',
  `total_exportation` double(12,2) DEFAULT '0.00',
  `total_free` double(12,2) DEFAULT '0.00',
  `total_taxed` double(12,2) DEFAULT '0.00',
  `total_unaffected` double(12,2) DEFAULT '0.00',
  `total_exonerated` double(12,2) DEFAULT '0.00',
  `total_igv` double(12,2) DEFAULT '0.00',
  `total_igv_free` double(12,2) DEFAULT '0.00',
  `total_base_isc` double(12,2) DEFAULT '0.00',
  `total_isc` double(12,2) DEFAULT '0.00',
  `total_base_other_taxes` double(12,2) DEFAULT '0.00',
  `total_other_taxes` double(12,2) DEFAULT '0.00',
  `total_taxes` double(12,2) DEFAULT '0.00',
  `total_value` double(12,2) DEFAULT '0.00',
  `charges` json DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `terms_condition` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscription_plans`
--

LOCK TABLES `suscription_plans` WRITE;
/*!40000 ALTER TABLE `suscription_plans` DISABLE KEYS */;
INSERT INTO `suscription_plans` VALUES (1,1,'Matricula Escolar','Demostración de matricula escolar',1.00,'PEN','01',12,0.000,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `suscription_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscription_section`
--

DROP TABLE IF EXISTS `suscription_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscription_section` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscription_section`
--

LOCK TABLES `suscription_section` WRITE;
/*!40000 ALTER TABLE `suscription_section` DISABLE KEYS */;
INSERT INTO `suscription_section` VALUES (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E'),(6,'F'),(7,'G'),(8,'H');
/*!40000 ALTER TABLE `suscription_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `execution_time` time NOT NULL,
  `output` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technical_service_items`
--

DROP TABLE IF EXISTS `technical_service_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `technical_service_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `technical_services_id` int(10) unsigned DEFAULT '0' COMMENT 'Id de technical_services',
  `item_id` int(10) unsigned DEFAULT '0' COMMENT 'Id de item',
  `item` json DEFAULT NULL COMMENT 'Json con el contenido de item',
  `quantity` double(12,4) DEFAULT '0.0000' COMMENT 'Cantidad de item usado',
  `unit_value` double(16,6) DEFAULT '0.000000' COMMENT 'unit_value',
  `affectation_igv_type_id` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Tipo de afectacion dde igv. cat_affectation_igv_types',
  `total_base_igv` double(12,2) DEFAULT '0.00' COMMENT 'Monto base del IGV',
  `percentage_igv` double(12,2) DEFAULT '0.00',
  `total_igv` double(12,2) DEFAULT '0.00',
  `system_isc_type_id` longtext COLLATE utf8mb4_unicode_ci,
  `total_base_isc` double(12,2) DEFAULT '0.00',
  `percentage_isc` double(12,2) DEFAULT '0.00',
  `total_isc` double(12,2) DEFAULT '0.00',
  `total_base_other_taxes` double(12,2) DEFAULT '0.00',
  `percentage_other_taxes` double(12,2) DEFAULT '0.00',
  `total_other_taxes` double(12,2) DEFAULT '0.00',
  `total_plastic_bag_taxes` double(6,2) DEFAULT '0.00',
  `total_taxes` double(12,2) DEFAULT '0.00',
  `price_type_id` longtext COLLATE utf8mb4_unicode_ci,
  `unit_price` double(16,6) DEFAULT '0.000000',
  `total_value` double(12,2) DEFAULT '0.00',
  `total_charge` double(12,2) DEFAULT '0.00',
  `total_discount` double(12,2) DEFAULT '0.00',
  `total` double(12,2) DEFAULT '0.00',
  `attributes` json DEFAULT NULL COMMENT 'Atributos',
  `discounts` json DEFAULT NULL COMMENT 'Descuentos',
  `charges` json DEFAULT NULL COMMENT 'Cargos',
  `additional_information` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Informacion adicional',
  `warehouse_id` int(10) unsigned DEFAULT '0' COMMENT 'Id de item',
  `name_product_pdf` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Nombre de producto en el pdf',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technical_service_items`
--

LOCK TABLES `technical_service_items` WRITE;
/*!40000 ALTER TABLE `technical_service_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `technical_service_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technical_service_payments`
--

DROP TABLE IF EXISTS `technical_service_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `technical_service_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `technical_service_id` int(10) unsigned NOT NULL,
  `date_of_payment` date NOT NULL,
  `payment_method_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `technical_service_payments_technical_service_id_foreign` (`technical_service_id`),
  KEY `technical_service_payments_payment_method_type_id_foreign` (`payment_method_type_id`),
  CONSTRAINT `technical_service_payments_payment_method_type_id_foreign` FOREIGN KEY (`payment_method_type_id`) REFERENCES `payment_method_types` (`id`),
  CONSTRAINT `technical_service_payments_technical_service_id_foreign` FOREIGN KEY (`technical_service_id`) REFERENCES `technical_services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technical_service_payments`
--

LOCK TABLES `technical_service_payments` WRITE;
/*!40000 ALTER TABLE `technical_service_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `technical_service_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technical_services`
--

DROP TABLE IF EXISTS `technical_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `technical_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `establishment_id` int(10) unsigned DEFAULT '0',
  `establishment` json DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `customer` json NOT NULL,
  `currency_type_id` text COLLATE utf8mb4_unicode_ci,
  `payment_condition_id` text COLLATE utf8mb4_unicode_ci,
  `payment_method_type_id` text COLLATE utf8mb4_unicode_ci,
  `seller_id` int(10) unsigned DEFAULT '0',
  `exchange_rate_sale` decimal(13,3) DEFAULT '0.000',
  `total_prepayment` decimal(12,2) DEFAULT '0.00',
  `total_charge` decimal(12,2) DEFAULT '0.00',
  `total_discount` decimal(12,2) DEFAULT '0.00',
  `total_exportation` decimal(12,2) DEFAULT '0.00',
  `total_free` decimal(12,2) DEFAULT '0.00',
  `total_taxed` decimal(12,2) DEFAULT '0.00',
  `total_unaffected` decimal(12,2) DEFAULT '0.00',
  `total_exonerated` decimal(12,2) DEFAULT '0.00',
  `total_igv` decimal(12,2) DEFAULT '0.00',
  `total_igv_free` decimal(12,2) DEFAULT '0.00',
  `total_base_isc` decimal(12,2) DEFAULT '0.00',
  `total_isc` decimal(12,2) DEFAULT '0.00',
  `total_base_other_taxes` decimal(12,2) DEFAULT '0.00',
  `total_other_taxes` decimal(12,2) DEFAULT '0.00',
  `total_plastic_bag_taxes` decimal(6,2) DEFAULT '0.00',
  `total_taxes` decimal(12,2) DEFAULT '0.00',
  `total_value` decimal(12,2) DEFAULT '0.00',
  `subtotal` decimal(12,2) DEFAULT '0.00',
  `total` decimal(12,2) DEFAULT '0.00',
  `is_editable` tinyint(3) unsigned DEFAULT '0',
  `cellphone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `time_of_issue` time NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `prepayment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `activities` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `equipment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `important_note` text COLLATE utf8mb4_unicode_ci,
  `repair` tinyint(1) NOT NULL DEFAULT '0',
  `warranty` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `diagnosis` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `technical_services_user_id_foreign` (`user_id`),
  KEY `technical_services_soap_type_id_foreign` (`soap_type_id`),
  KEY `technical_services_customer_id_foreign` (`customer_id`),
  KEY `technical_services_date_of_issue_index` (`date_of_issue`),
  KEY `technical_services_serial_number_index` (`serial_number`),
  CONSTRAINT `technical_services_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  CONSTRAINT `technical_services_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `technical_services_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technical_services`
--

LOCK TABLES `technical_services` WRITE;
/*!40000 ALTER TABLE `technical_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `technical_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL COMMENT 'Fecha de registro',
  `origin_date_of_issue` date NOT NULL COMMENT 'Fecha del documento origen de la propina',
  `origin_id` int(11) NOT NULL,
  `origin_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `worker_full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `origin_index` (`origin_id`,`origin_type`),
  KEY `tips_soap_type_id_foreign` (`soap_type_id`),
  KEY `tips_date_index` (`date`),
  KEY `tips_origin_date_of_issue_index` (`origin_date_of_issue`),
  KEY `tips_worker_full_name_index` (`worker_full_name`),
  CONSTRAINT `tips_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tips`
--

LOCK TABLES `tips` WRITE;
/*!40000 ALTER TABLE `tips` DISABLE KEYS */;
/*!40000 ALTER TABLE `tips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track_api_peru_services`
--

DROP TABLE IF EXISTS `track_api_peru_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track_api_peru_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service` int(10) unsigned DEFAULT '0' COMMENT 'Tipo de servicio  1 => sunat/dni, 2 => validacion_multiple_cpe, 3 => CPE, 4 => tipo_de_cambio, 5 => printer_ticket',
  `date_of_issue` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_api_peru_services`
--

LOCK TABLES `track_api_peru_services` WRITE;
/*!40000 ALTER TABLE `track_api_peru_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `track_api_peru_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_queries`
--

DROP TABLE IF EXISTS `transaction_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_queries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `response` json NOT NULL,
  `transaction_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_queries_transaction_id_foreign` (`transaction_id`),
  CONSTRAINT `transaction_queries_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_queries`
--

LOCK TABLES `transaction_queries` WRITE;
/*!40000 ALTER TABLE `transaction_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_states`
--

DROP TABLE IF EXISTS `transaction_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_states` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `success` tinyint(1) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_states_name_index` (`name`),
  KEY `transaction_states_success_index` (`success`),
  KEY `transaction_states_status_index` (`status`),
  KEY `transaction_states_status_detail_index` (`status_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_states`
--

LOCK TABLES `transaction_states` WRITE;
/*!40000 ALTER TABLE `transaction_states` DISABLE KEYS */;
INSERT INTO `transaction_states` VALUES ('00','Rechazado (Error desconocido)',0,'other','other','Error desconocido','Lo sentimos, ocurrió un error inesperado.'),('01','Aceptado',1,'approved','accredited','¡Listo! Se acreditó tu pago. En tu resumen verás el cargo de amount como statement_descriptor.','¡Listo! Se acreditó tu pago. En tu resumen verás el cargo del pago.'),('02','En proceso',1,'in_process','pending_contingency','Estamos procesando tu pago. No te preocupes, menos de 2 días hábiles te avisaremos por e-mail si se acreditó.','Estamos procesando tu pago. No te preocupes, en menos de 2 días hábiles te avisaremos por e-mail si se acreditó.'),('03','En proceso',1,'in_process','pending_review_manual','Estamos procesando tu pago. No te preocupes, menos de 2 días hábiles te avisaremos por e-mail si se acreditó o si necesitamos más información.','Estamos procesando tu pago. No te preocupes, en menos de 2 días hábiles te avisaremos por e-mail si se acreditó o si necesitamos más información.'),('04','Rechazado',0,'rejected','cc_rejected_bad_filled_card_number','Revisa el número de tarjeta.','Lo sentimos, ocurrió un inconveniente. Revisa el número de tarjeta.'),('05','Rechazado',0,'rejected','cc_rejected_bad_filled_date','Revisa la fecha de vencimiento.','Lo sentimos, ocurrió un inconveniente. Revisa la fecha de vencimiento.'),('06','Rechazado',0,'rejected','cc_rejected_bad_filled_other','Revisa los datos.','Lo sentimos, ocurrió un inconveniente. Revisa los datos.'),('07','Rechazado',0,'rejected','cc_rejected_bad_filled_security_code','Revisa el código de seguridad de la tarjeta.','Lo sentimos, ocurrió un inconveniente. Revisa el código de seguridad de la tarjeta.'),('08','Rechazado',0,'rejected','cc_rejected_blacklist','No pudimos procesar tu pago.','Lo sentimos, ocurrió un inconveniente. No pudimos procesar tu pago.'),('09','Rechazado',0,'rejected','cc_rejected_call_for_authorize','Debes autorizar ante payment_method_id el pago de amount.','Debes autorizar ante el medio de pago, el pago a realizar.'),('10','Rechazado',0,'rejected','cc_rejected_card_disabled','Llama a payment_method_id para activar tu tarjeta o usa otro medio de pago. El teléfono está al dorso de tu tarjeta.','Llama a la entidad para activar tu tarjeta o usa otro medio de pago. El teléfono está al dorso de tu tarjeta.'),('11','Rechazado',0,'rejected','cc_rejected_card_error','No pudimos procesar tu pago.','Lo sentimos, ocurrió un inconveniente. No pudimos procesar tu pago.'),('12','Rechazado',0,'rejected','cc_rejected_duplicated_payment','Ya hiciste un pago por ese valor. Si necesitas volver a pagar usa otra tarjeta u otro medio de pago.','Ya hiciste un pago por ese valor. Si necesitas volver a pagar usa otra tarjeta u otro medio de pago.'),('13','Rechazado',0,'rejected','cc_rejected_high_risk','Tu pago fue rechazado. Elige otro de los medios de pago, te recomendamos con medios en efectivo.','Tu pago fue rechazado. Elige otro de los medios de pago, te recomendamos con medios en efectivo.'),('14','Rechazado',0,'rejected','cc_rejected_insufficient_amount','Tu payment_method_id no tiene fondos suficientes.','Lo sentimos, ocurrió un inconveniente. Tu medio de pago no tiene fondos suficientes.'),('15','Rechazado',0,'rejected','cc_rejected_invalid_installments','payment_method_id no procesa pagos en installments cuotas.','Para el medio de pago ingresado, no se puede procesar los pagos en la cantidad de cuotas seleccionadas.'),('16','Rechazado',0,'rejected','cc_rejected_max_attempts','Llegaste al límite de intentos permitidos. Elige otra tarjeta u otro medio de pago.','Llegaste al límite de intentos permitidos. Elige otra tarjeta u otro medio de pago.'),('17','Rechazado',0,'rejected','cc_rejected_other_reason','payment_method_id no procesó el pago.','Lo sentimos, ocurrió un inconveniente. El pago no pudo ser procesado por el medio usado');
/*!40000 ALTER TABLE `transaction_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_link_id` int(10) unsigned NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `transaction_state_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactions_uuid_unique` (`uuid`),
  KEY `transactions_payment_link_id_foreign` (`payment_link_id`),
  KEY `transactions_transaction_state_id_foreign` (`transaction_state_id`),
  KEY `transactions_date_index` (`date`),
  KEY `transactions_time_index` (`time`),
  KEY `transactions_description_index` (`description`),
  KEY `transactions_payment_id_index` (`payment_id`),
  KEY `transactions_amount_index` (`amount`),
  KEY `transactions_soap_type_id_foreign` (`soap_type_id`),
  CONSTRAINT `transactions_payment_link_id_foreign` FOREIGN KEY (`payment_link_id`) REFERENCES `payment_links` (`id`),
  CONSTRAINT `transactions_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `transactions_transaction_state_id_foreign` FOREIGN KEY (`transaction_state_id`) REFERENCES `transaction_states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer_account_payments`
--

DROP TABLE IF EXISTS `transfer_account_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfer_account_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `origin_id` int(10) unsigned DEFAULT '0' COMMENT 'id Cuenta de origen',
  `origin_type` text COLLATE utf8mb4_unicode_ci COMMENT 'Modelo de origen',
  `destiny_id` int(10) unsigned DEFAULT '0' COMMENT 'id Cuenta de destino',
  `destiny_type` text COLLATE utf8mb4_unicode_ci COMMENT 'Modelo de destino',
  `amount` decimal(9,2) DEFAULT '0.00' COMMENT 'Monto a transferir',
  `date_of_movement` datetime DEFAULT NULL COMMENT 'Fecha de movimiento',
  `user_id` int(10) unsigned DEFAULT '0' COMMENT 'Usuario que realiza el movimiento',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer_account_payments`
--

LOCK TABLES `transfer_account_payments` WRITE;
/*!40000 ALTER TABLE `transfer_account_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfer_account_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_commissions`
--

DROP TABLE IF EXISTS `user_commissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_commissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_commissions_user_id_foreign` (`user_id`),
  CONSTRAINT `user_commissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_commissions`
--

LOCK TABLES `user_commissions` WRITE;
/*!40000 ALTER TABLE `user_commissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_commissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_rel_suscription_plans`
--

DROP TABLE IF EXISTS `user_rel_suscription_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_rel_suscription_plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con usuario',
  `suscription_plan_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con planes de suscripcion',
  `cat_period_id` int(10) unsigned DEFAULT '0' COMMENT 'Relacion con el periodo de tiempo',
  `items` json NOT NULL COMMENT 'Pega los items relacionados a modo de standar',
  `editable` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si ya ha sido adquirido, no puede ser modificado',
  `deletable` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Si ya ha sido adquirido, no puede ser borrado',
  `start_date` date DEFAULT NULL COMMENT 'Fecha de inicio',
  `sale_notes` text COLLATE utf8mb4_unicode_ci,
  `documents` text COLLATE utf8mb4_unicode_ci,
  `dates_of_documents` text COLLATE utf8mb4_unicode_ci,
  `automatic_date_of_issue` date DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT '0',
  `customer` json NOT NULL,
  `parent_customer_id` int(10) unsigned DEFAULT '0',
  `parent_customer` json NOT NULL,
  `children_customer_id` int(10) unsigned DEFAULT '0',
  `children_customer` longtext COLLATE utf8mb4_unicode_ci,
  `quantity_period` int(10) unsigned DEFAULT '0',
  `apply_concurrency` int(10) unsigned NOT NULL DEFAULT '0',
  `enabled_concurrency` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Se pasará a nota de ventas como activo',
  `currency_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_rate_sale` double(13,3) DEFAULT '0.000',
  `total_prepayment` double(12,2) DEFAULT '0.00',
  `total_charge` double(12,2) DEFAULT '0.00',
  `total_discount` double(12,2) DEFAULT '0.00',
  `total_exportation` double(12,2) DEFAULT '0.00',
  `total_free` double(12,2) DEFAULT '0.00',
  `total_taxed` double(12,2) DEFAULT '0.00',
  `total_unaffected` double(12,2) DEFAULT '0.00',
  `total_exonerated` double(12,2) DEFAULT '0.00',
  `total_igv` double(12,2) DEFAULT '0.00',
  `total_igv_free` double(12,2) DEFAULT '0.00',
  `total_base_isc` double(12,2) DEFAULT '0.00',
  `total_isc` double(12,2) DEFAULT '0.00',
  `total_base_other_taxes` double(12,2) DEFAULT '0.00',
  `total_other_taxes` double(12,2) DEFAULT '0.00',
  `total_taxes` double(12,2) DEFAULT '0.00',
  `total_value` double(12,2) DEFAULT '0.00',
  `total` decimal(12,2) DEFAULT '0.00',
  `charges` json DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `discounts` json DEFAULT NULL,
  `prepayments` json DEFAULT NULL,
  `related` json DEFAULT NULL,
  `perception` json DEFAULT NULL,
  `detraction` json DEFAULT NULL,
  `legends` json DEFAULT NULL,
  `terms_condition` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `grade` text COLLATE utf8mb4_unicode_ci COMMENT 'Grado designado - utilizado en matricula',
  `section` text COLLATE utf8mb4_unicode_ci COMMENT 'Seccion designado - utilizado en matricula',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_rel_suscription_plans`
--

LOCK TABLES `user_rel_suscription_plans` WRITE;
/*!40000 ALTER TABLE `user_rel_suscription_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_rel_suscription_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `establishment_id` int(10) unsigned DEFAULT NULL,
  `type` enum('admin','seller','integrator','client') COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_edit_cpe` tinyint(1) NOT NULL DEFAULT '0',
  `create_payment` tinyint(1) NOT NULL DEFAULT '1',
  `delete_payment` tinyint(1) NOT NULL DEFAULT '1',
  `recreate_documents` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `restaurant_role_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `document_id` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Relacion con tipo de documentos',
  `series_id` int(10) unsigned DEFAULT NULL COMMENT 'Relacion con series',
  `zone_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_api_token_unique` (`api_token`),
  KEY `users_establishment_id_foreign` (`establishment_id`),
  KEY `users_restaurant_role_id_foreign` (`restaurant_role_id`),
  CONSTRAINT `users_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`),
  CONSTRAINT `users_restaurant_role_id_foreign` FOREIGN KEY (`restaurant_role_id`) REFERENCES `restaurant_roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrador','admin@gmail.com',NULL,'$2y$10$CLGfIxFHsYeKkOhmcyI7e.Xz8HP/DzIRGOrn7mIUIFreQEaeKiWI.','xIwvmnwqDARxHAAXvcjlAeqLM4GJ7wmt8LUcgXjB3IGXNj6FjE',1,'admin',1,1,1,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voided`
--

DROP TABLE IF EXISTS `voided`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voided` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `external_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soap_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_type_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubl_version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_issue` date NOT NULL,
  `date_of_reference` date NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ticket` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_ticket` tinyint(1) NOT NULL DEFAULT '0',
  `has_cdr` tinyint(1) NOT NULL DEFAULT '0',
  `soap_shipping_response` json DEFAULT NULL,
  `send_to_pse` tinyint(1) NOT NULL DEFAULT '0',
  `response_signature_pse` json DEFAULT NULL,
  `response_send_cdr_pse` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voided_user_id_foreign` (`user_id`),
  KEY `voided_soap_type_id_foreign` (`soap_type_id`),
  KEY `voided_state_type_id_foreign` (`state_type_id`),
  CONSTRAINT `voided_soap_type_id_foreign` FOREIGN KEY (`soap_type_id`) REFERENCES `soap_types` (`id`),
  CONSTRAINT `voided_state_type_id_foreign` FOREIGN KEY (`state_type_id`) REFERENCES `state_types` (`id`),
  CONSTRAINT `voided_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voided`
--

LOCK TABLES `voided` WRITE;
/*!40000 ALTER TABLE `voided` DISABLE KEYS */;
/*!40000 ALTER TABLE `voided` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voided_documents`
--

DROP TABLE IF EXISTS `voided_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voided_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voided_id` int(10) unsigned NOT NULL,
  `document_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `voided_documents_voided_id_foreign` (`voided_id`),
  KEY `voided_documents_document_id_foreign` (`document_id`),
  CONSTRAINT `voided_documents_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `voided_documents_voided_id_foreign` FOREIGN KEY (`voided_id`) REFERENCES `voided` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voided_documents`
--

LOCK TABLES `voided_documents` WRITE;
/*!40000 ALTER TABLE `voided_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `voided_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `establishment_id` int(10) unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `warehouses_establishment_id_foreign` (`establishment_id`),
  CONSTRAINT `warehouses_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (1,1,'Almacén Oficina Principal','2026-03-13 23:35:23','2026-03-13 23:35:23');
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_platforms`
--

DROP TABLE IF EXISTS `web_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_platforms`
--

LOCK TABLES `web_platforms` WRITE;
/*!40000 ALTER TABLE `web_platforms` DISABLE KEYS */;
INSERT INTO `web_platforms` VALUES (1,'Saga Falabella',NULL,NULL),(2,'Mercado Libre ',NULL,NULL),(3,'Linio',NULL,NULL);
/*!40000 ALTER TABLE `web_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identity_document_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `admission_date` date NOT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workers_identity_document_type_id_foreign` (`identity_document_type_id`),
  KEY `workers_number_index` (`number`),
  KEY `workers_name_index` (`name`),
  CONSTRAINT `workers_identity_document_type_id_foreign` FOREIGN KEY (`identity_document_type_id`) REFERENCES `cat_identity_document_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tenancy_injuserv'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15  4:57:30
