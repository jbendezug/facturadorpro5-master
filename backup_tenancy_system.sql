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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15  5:08:33
