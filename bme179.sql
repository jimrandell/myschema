-- MariaDB dump 10.19  Distrib 10.5.15-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: businessman1711base
-- ------------------------------------------------------
-- Server version	10.5.15-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `absence`
--

DROP TABLE IF EXISTS `absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.absence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `absence_type_id` bigint(20) DEFAULT NULL,
  `absence_note_id` bigint(20) DEFAULT NULL,
  `draft` tinyint(4) DEFAULT 0,
  `pending` tinyint(4) DEFAULT 0,
  `approved` tinyint(4) DEFAULT 0,
  `declined` tinyint(4) DEFAULT 0,
  `absence_start` datetime NOT NULL,
  `absence_end` datetime NOT NULL,
  `additional_information` varchar(100) DEFAULT NULL,
  `doctor_note` tinyint(4) DEFAULT 0,
  `doctor_note_required` tinyint(4) DEFAULT 0,
  `doctor_note_received` datetime DEFAULT NULL,
  `is_paid` tinyint(4) DEFAULT 0,
  `is_entitlement` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `absence_type_id` (`absence_type_id`),
  KEY `absence_note_id` (`absence_note_id`),
  CONSTRAINT `absence_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `absence_ibfk_5` FOREIGN KEY (`absence_type_id`) REFERENCES `absence_type` (`id`),
  CONSTRAINT `absence_ibfk_6` FOREIGN KEY (`absence_note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `absence_approval`
--

DROP TABLE IF EXISTS `absence_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.absence_approval` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `approver_id` bigint(20) NOT NULL,
  `absence_id` bigint(20) NOT NULL,
  `approved` tinyint(1) DEFAULT 0,
  `declined` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `approver_id` (`approver_id`),
  KEY `absence_id` (`absence_id`),
  CONSTRAINT `absence_approval_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_approval_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_approval_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_approval_ibfk_4` FOREIGN KEY (`approver_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_approval_ibfk_5` FOREIGN KEY (`absence_id`) REFERENCES `absence` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`approved` = 0 or `declined` = 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `absence_settings`
--

DROP TABLE IF EXISTS `absence_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.absence_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `approvals_required` enum('One approval by either HR or a manager','Two approvals, one from HR and one from a manager') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `absence_settings_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_settings_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_settings_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `absence_type`
--

DROP TABLE IF EXISTS `absence_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.absence_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `type_name` varchar(100) NOT NULL,
  `color` varchar(20) NOT NULL,
  `editable` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `absence_type_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_type_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `absence_type_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounting_period`
--

DROP TABLE IF EXISTS `accounting_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.accounting_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `number` char(3) NOT NULL,
  `end_date` date NOT NULL,
  `accounting_year_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `accounting_year_id` (`accounting_year_id`),
  CONSTRAINT `accounting_period_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `accounting_period_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `accounting_period_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `accounting_period_ibfk_4` FOREIGN KEY (`accounting_year_id`) REFERENCES `accounting_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounting_year`
--

DROP TABLE IF EXISTS `accounting_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.accounting_year` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `code` char(6) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `accounts_published` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`,`trading_company_id`),
  UNIQUE KEY `name` (`name`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `accounting_year_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `accounting_year_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `accounting_year_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `accounting_year_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `address_format`
--

DROP TABLE IF EXISTS `address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.address_format` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `address_format_name` varchar(255) NOT NULL,
  `thoroughfare_enabled` tinyint(4) DEFAULT 0,
  `premise_enabled` tinyint(4) DEFAULT 0,
  `locality_enabled` tinyint(4) DEFAULT 0,
  `administrative_area_enabled` tinyint(4) DEFAULT 0,
  `sub_administrative_area_enabled` tinyint(4) DEFAULT 0,
  `postal_code_enabled` tinyint(4) DEFAULT 0,
  `thoroughfare_mandatory` tinyint(4) DEFAULT 0,
  `locality_mandatory` tinyint(4) DEFAULT 0,
  `premise_mandatory` tinyint(4) DEFAULT 0,
  `administrative_area_mandatory` tinyint(4) DEFAULT 0,
  `sub_administrative_area_mandatory` tinyint(4) DEFAULT 0,
  `postal_code_mandatory` tinyint(4) DEFAULT 0,
  `thoroughfare_label` varchar(50) DEFAULT NULL,
  `premise_label` varchar(50) DEFAULT NULL,
  `locality_label` varchar(50) DEFAULT NULL,
  `administrative_area_label` varchar(50) DEFAULT NULL,
  `sub_administrative_area_label` varchar(50) DEFAULT NULL,
  `postal_code_label` varchar(50) DEFAULT NULL,
  `country_label` varchar(50) NOT NULL,
  `thoroughfare_default` varchar(85) DEFAULT NULL,
  `premise_default` varchar(85) DEFAULT NULL,
  `locality_default` varchar(85) DEFAULT NULL,
  `administrative_area_default` varchar(85) DEFAULT NULL,
  `sub_administrative_area_default` varchar(85) DEFAULT NULL,
  `postal_code_default` varchar(15) DEFAULT NULL,
  `country_default` varchar(2) DEFAULT NULL,
  `long_template` text NOT NULL,
  `short_template` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `address_format_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `address_format_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `address_format_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `all_job_cost`
--

DROP TABLE IF EXISTS `all_job_cost`;
/*!50001 DROP VIEW IF EXISTS `all_job_cost`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.all_job_cost` (
  `id` tinyint NOT NULL,
  `table_id` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `cost` tinyint NOT NULL,
  `invoice_cost` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `Include_in_invoice` tinyint NOT NULL,
  `description_cost` tinyint NOT NULL,
  `created_on` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `all_so_costs`
--

DROP TABLE IF EXISTS `all_so_costs`;
/*!50001 DROP VIEW IF EXISTS `all_so_costs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.all_so_costs` (
  `id` tinyint NOT NULL,
  `table_id` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `purchase_order_id` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `cost` tinyint NOT NULL,
  `sales_order_id` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `created_on` tinyint NOT NULL,
  `include_cost` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `alternative_sku`
--

DROP TABLE IF EXISTS `alternative_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.alternative_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `parent_product_id` bigint(20) NOT NULL,
  `alternative_product_id` bigint(20) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `parent_product_id` (`parent_product_id`),
  KEY `alternative_product_id` (`alternative_product_id`),
  CONSTRAINT `alternative_sku_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `alternative_sku_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `alternative_sku_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `alternative_sku_ibfk_4` FOREIGN KEY (`parent_product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `alternative_sku_ibfk_5` FOREIGN KEY (`alternative_product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_user`
--

DROP TABLE IF EXISTS `application_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.application_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) DEFAULT NULL,
  `password_iterations` smallint(6) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `login_email` varchar(50) NOT NULL,
  `password_salt` varchar(64) NOT NULL,
  `password_expiry_date` datetime DEFAULT NULL,
  `password_is_hard_expiry_date` tinyint(1) DEFAULT 0,
  `system_account` tinyint(1) DEFAULT 0,
  `accounts_allow_all_periods` tinyint(1) NOT NULL DEFAULT 0,
  `tax_integration_user_name` varchar(50) DEFAULT NULL,
  `tax_integration_user_password` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `application_user_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `application_user_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `application_user_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `application_user_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_version`
--

DROP TABLE IF EXISTS `application_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.application_version` (
  `version_number` varchar(20) NOT NULL DEFAULT '0',
  `environment` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`version_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `applied_discount`
--

DROP TABLE IF EXISTS `applied_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.applied_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) NOT NULL,
  `quote_item_id` bigint(20) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `discount_name` varchar(250) DEFAULT NULL,
  `discount_type` enum('Customer custom','Net total','Quantity','Product custom','Customer tier','Manual') NOT NULL,
  `price_before_discount` decimal(13,5) NOT NULL,
  `price_after_discount` decimal(13,5) NOT NULL,
  `discount_amount` decimal(13,5) NOT NULL,
  `price_before_discount_in_currency` decimal(13,5) NOT NULL,
  `price_after_discount_in_currency` decimal(13,5) NOT NULL,
  `discount_amount_in_currency` decimal(13,5) NOT NULL,
  `discount_percentage` decimal(7,4) NOT NULL,
  `quantity_breakpoint` decimal(13,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `quote_item_id` (`quote_item_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  CONSTRAINT `applied_discount_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `applied_discount_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `applied_discount_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `applied_discount_ibfk_4` FOREIGN KEY (`quote_item_id`) REFERENCES `quote_item` (`id`),
  CONSTRAINT `applied_discount_ibfk_5` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assembled_product`
--

DROP TABLE IF EXISTS `assembled_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.assembled_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `assembled_product_id` bigint(20) DEFAULT NULL,
  `assembled_unit_id` bigint(20) DEFAULT NULL,
  `assembled_batch_id` bigint(20) DEFAULT NULL,
  `consumed_product_id` bigint(20) DEFAULT NULL,
  `consumed_unit_id` bigint(20) DEFAULT NULL,
  `consumed_batch_id` bigint(20) DEFAULT NULL,
  `consumed_quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `assembled_product_id` (`assembled_product_id`),
  KEY `consumed_product_id` (`consumed_product_id`),
  KEY `assembled_batch_id` (`assembled_batch_id`),
  KEY `consumed_batch_id` (`consumed_batch_id`),
  KEY `assembled_unit_id` (`assembled_unit_id`),
  KEY `consumed_unit_id` (`consumed_unit_id`),
  CONSTRAINT `assembled_product_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `assembled_product_ibfk_10` FOREIGN KEY (`consumed_unit_id`) REFERENCES `product_unit` (`id`),
  CONSTRAINT `assembled_product_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `assembled_product_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `assembled_product_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `assembled_product_ibfk_5` FOREIGN KEY (`assembled_product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `assembled_product_ibfk_6` FOREIGN KEY (`consumed_product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `assembled_product_ibfk_7` FOREIGN KEY (`assembled_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `assembled_product_ibfk_8` FOREIGN KEY (`consumed_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `assembled_product_ibfk_9` FOREIGN KEY (`assembled_unit_id`) REFERENCES `product_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.asset` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `contract_id` bigint(20) NOT NULL,
  `site_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `primary_engineer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_location_id` bigint(20) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `response_time` bigint(20) DEFAULT NULL,
  `resolution_time` bigint(20) DEFAULT NULL,
  `repair_or_replace` varchar(50) DEFAULT NULL,
  `stock_code` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `manufacturer_part_number` varchar(50) DEFAULT NULL,
  `rate` decimal(8,2) DEFAULT 0.00,
  `rate_sunday` decimal(8,2) DEFAULT 0.00,
  `rate_out_hours` decimal(8,2) DEFAULT 0.00,
  `travel_admin_charge` decimal(8,2) DEFAULT 0.00,
  `service_level` varchar(30) DEFAULT NULL,
  `equipment_location` varchar(200) DEFAULT NULL,
  `log_book_location` varchar(200) DEFAULT NULL,
  `include_charge_in_contract` tinyint(4) DEFAULT 0,
  `invoice_item_description` varchar(200) DEFAULT NULL,
  `contract_value` decimal(8,2) DEFAULT 0.00,
  `each_invoice_value` decimal(8,2) DEFAULT 0.00,
  `annual_contract_increase` decimal(8,2) DEFAULT 0.00,
  `contract_renewal_value` decimal(8,2) DEFAULT 0.00,
  `preauth_spend_level` decimal(8,2) DEFAULT 0.00,
  `invoice_due_date` datetime DEFAULT NULL,
  `quarantine` tinyint(4) DEFAULT 0,
  `primary_engineer_name` varchar(255) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `primary_engineer_id` (`primary_engineer_id`),
  KEY `site_id` (`site_id`),
  KEY `contract_id` (`contract_id`),
  KEY `product_id` (`product_id`),
  KEY `parent_id` (`parent_id`),
  KEY `resource_id` (`resource_id`),
  KEY `product_location_id` (`product_location_id`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `asset_ibfk_10` FOREIGN KEY (`product_location_id`) REFERENCES `product_location` (`id`),
  CONSTRAINT `asset_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `asset_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `asset_ibfk_4` FOREIGN KEY (`primary_engineer_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `asset_ibfk_5` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`),
  CONSTRAINT `asset_ibfk_6` FOREIGN KEY (`contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `asset_ibfk_7` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `asset_ibfk_8` FOREIGN KEY (`parent_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `asset_ibfk_9` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_event`
--

DROP TABLE IF EXISTS `audit_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.audit_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `user_id` bigint(20) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `type` char(12) NOT NULL,
  `entity` varchar(64) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `audit_event_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_event_relation`
--

DROP TABLE IF EXISTS `audit_event_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.audit_event_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `audit_event_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `nominal_journal_id` bigint(20) DEFAULT NULL,
  `cash_journal_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `customer_remittance_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `email_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  `bank_statement_id` bigint(20) DEFAULT NULL,
  `bank_statement_transaction_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `non_compliance_report_id` bigint(20) DEFAULT NULL,
  `note_id` bigint(20) DEFAULT NULL,
  `operation_id` bigint(20) DEFAULT NULL,
  `opportunity_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `resource_group_id` bigint(20) DEFAULT NULL,
  `resource_tag_name_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_id` bigint(20) DEFAULT NULL,
  `service_contract_id` bigint(20) DEFAULT NULL,
  `site_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `product_batch_id` bigint(20) DEFAULT NULL,
  `product_unit_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `warehouse_location_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `application_user_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_category_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) DEFAULT NULL,
  `type` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_event_id` (`audit_event_id`),
  KEY `asset_id` (`asset_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `nominal_journal_id` (`nominal_journal_id`),
  KEY `cash_journal_id` (`cash_journal_id`),
  KEY `company_id` (`company_id`),
  KEY `contact_id` (`contact_id`),
  KEY `customer_id` (`customer_id`),
  KEY `customer_remittance_id` (`customer_remittance_id`),
  KEY `department_id` (`department_id`),
  KEY `document_id` (`document_id`),
  KEY `division_id` (`division_id`),
  KEY `email_id` (`email_id`),
  KEY `employee_id` (`employee_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `bank_id` (`bank_id`),
  KEY `bank_statement_id` (`bank_statement_id`),
  KEY `bank_statement_transaction_id` (`bank_statement_transaction_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `job_id` (`job_id`),
  KEY `note_id` (`note_id`),
  KEY `non_compliance_report_id` (`non_compliance_report_id`),
  KEY `operation_id` (`operation_id`),
  KEY `opportunity_id` (`opportunity_id`),
  KEY `product_id` (`product_id`),
  KEY `project_id` (`project_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `quote_id` (`quote_id`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_group_id` (`resource_group_id`),
  KEY `resource_tag_name_id` (`resource_tag_name_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `returns_authorisation_id` (`returns_authorisation_id`),
  KEY `service_contract_id` (`service_contract_id`),
  KEY `site_id` (`site_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `product_unit_id` (`product_unit_id`),
  KEY `product_batch_id` (`product_batch_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  KEY `warehouse_location_id` (`warehouse_location_id`),
  KEY `application_user_id` (`application_user_id`),
  KEY `task_id` (`task_id`),
  KEY `branch_id` (`branch_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `general_ledger_code_category_id` (`general_ledger_code_category_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `audit_event_relation_ibfk_1` FOREIGN KEY (`audit_event_id`) REFERENCES `audit_event` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_10` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_11` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_12` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_13` FOREIGN KEY (`email_id`) REFERENCES `email` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_14` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_15` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_16` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_17` FOREIGN KEY (`bank_statement_id`) REFERENCES `bank_statement` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_18` FOREIGN KEY (`bank_statement_transaction_id`) REFERENCES `bank_statement_transaction` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_19` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_20` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_21` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_22` FOREIGN KEY (`non_compliance_report_id`) REFERENCES `non_compliance_report` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_23` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `audit_event_relation_ibfk_24` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_25` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `audit_event_relation_ibfk_26` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_27` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_28` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_29` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_3` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_30` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_31` FOREIGN KEY (`resource_tag_name_id`) REFERENCES `resource_tag_name` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_32` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_33` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_34` FOREIGN KEY (`returns_authorisation_id`) REFERENCES `returns_authorisation` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_35` FOREIGN KEY (`service_contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_36` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_37` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_38` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_39` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_4` FOREIGN KEY (`nominal_journal_id`) REFERENCES `nominal_journal` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_40` FOREIGN KEY (`product_unit_id`) REFERENCES `product_unit` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_41` FOREIGN KEY (`product_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_42` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_43` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_44` FOREIGN KEY (`warehouse_location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_45` FOREIGN KEY (`application_user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_46` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_47` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_48` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_49` FOREIGN KEY (`general_ledger_code_category_id`) REFERENCES `general_ledger_code_category` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_5` FOREIGN KEY (`cash_journal_id`) REFERENCES `cash_journal` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_50` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_51` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_6` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_7` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_8` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `audit_event_relation_ibfk_9` FOREIGN KEY (`customer_remittance_id`) REFERENCES `customer_remittance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `back_order`
--

DROP TABLE IF EXISTS `back_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.back_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_unit_of_measure_id` bigint(20) NOT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `job_item_id` bigint(20) DEFAULT NULL,
  `purchase_order_item_id` bigint(20) DEFAULT NULL,
  `assembly_job_item_id` bigint(20) DEFAULT NULL,
  `quantity` decimal(20,10) DEFAULT NULL,
  `quantity_base` bigint(20) unsigned DEFAULT NULL,
  `priority` enum('Low','Medium','High') NOT NULL,
  `priority_sequence` bigint(20) unsigned NOT NULL,
  `scheduled_back_order` tinyint(1) DEFAULT 0,
  `pending` tinyint(1) DEFAULT 1,
  `active` tinyint(1) DEFAULT 0,
  `complete` tinyint(1) DEFAULT 0,
  `required_by_date` date DEFAULT NULL,
  `preferred_resolution_method` enum('Alternative SKU','Break out pack','Dropship','Manufacturing','Raise purchase order','Scheduled delivery','Transfer request from another company','Transfer request from another warehouse','Other') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `product_id` (`product_id`),
  KEY `product_unit_of_measure_id` (`product_unit_of_measure_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `job_id` (`job_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `job_item_id` (`job_item_id`),
  KEY `purchase_order_item_id` (`purchase_order_item_id`),
  KEY `assembly_job_item_id` (`assembly_job_item_id`),
  KEY `preferred_resolution_method` (`preferred_resolution_method`),
  CONSTRAINT `back_order_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `back_order_ibfk_10` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `purchase_order_item` (`id`),
  CONSTRAINT `back_order_ibfk_11` FOREIGN KEY (`assembly_job_item_id`) REFERENCES `job_item` (`id`),
  CONSTRAINT `back_order_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `back_order_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `back_order_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `back_order_ibfk_5` FOREIGN KEY (`product_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `back_order_ibfk_6` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `back_order_ibfk_7` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `back_order_ibfk_8` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `back_order_ibfk_9` FOREIGN KEY (`job_item_id`) REFERENCES `job_item` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`sales_order_id` is not null or `job_id` is not null)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.bank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) NOT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `internal_account_ref` varchar(32) NOT NULL,
  `account_name` varchar(32) DEFAULT NULL,
  `account_number` varchar(32) DEFAULT NULL,
  `sort_code` varchar(10) DEFAULT NULL,
  `iban` varchar(34) DEFAULT NULL,
  `swift_bic` varchar(11) DEFAULT NULL,
  `use_bic_and_iban` tinyint(4) DEFAULT 1,
  `statement_balance` decimal(10,2) DEFAULT 0.00,
  `statement_balance_date` date DEFAULT NULL,
  `key_contact_id` bigint(20) DEFAULT NULL,
  `opening_balance` decimal(10,2) DEFAULT 0.00,
  `opening_balance_date` date DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `currency_id` (`currency_id`),
  KEY `key_contact_id` (`key_contact_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `bank_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_ibfk_4` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `bank_ibfk_5` FOREIGN KEY (`key_contact_id`) REFERENCES `person` (`id`),
  CONSTRAINT `bank_ibfk_6` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_account_reconciliation`
--

DROP TABLE IF EXISTS `bank_account_reconciliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.bank_account_reconciliation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `match_id` bigint(20) NOT NULL,
  `gl_transaction_id` bigint(20) DEFAULT NULL,
  `bank_statement_transaction_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `gl_transaction_id` (`gl_transaction_id`),
  KEY `bank_statement_transaction_id` (`bank_statement_transaction_id`),
  CONSTRAINT `bank_account_reconciliation_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_account_reconciliation_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_account_reconciliation_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_account_reconciliation_ibfk_4` FOREIGN KEY (`gl_transaction_id`) REFERENCES `general_ledger` (`id`),
  CONSTRAINT `bank_account_reconciliation_ibfk_5` FOREIGN KEY (`bank_statement_transaction_id`) REFERENCES `bank_statement_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_reconciliation_rule`
--

DROP TABLE IF EXISTS `bank_reconciliation_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.bank_reconciliation_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `bank_account_id` bigint(20) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `rule_type` enum('Spend','Income','All') NOT NULL,
  `match_type` enum('Full','Partial') NOT NULL,
  `match_text` varchar(32) NOT NULL,
  `applicable_field` varchar(32) NOT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `global` tinyint(4) NOT NULL DEFAULT 0,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `bank_account_id` (`bank_account_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_4` FOREIGN KEY (`bank_account_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_5` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_6` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `bank_reconciliation_rule_ibfk_7` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_statement`
--

DROP TABLE IF EXISTS `bank_statement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.bank_statement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `bank_account_id` bigint(20) NOT NULL,
  `imported_date` date NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `bank_statement_source` enum('Import','Manual') NOT NULL,
  `reconciled` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `bank_account_id` (`bank_account_id`),
  CONSTRAINT `bank_statement_ibfk_1` FOREIGN KEY (`bank_account_id`) REFERENCES `bank` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_statement_transaction`
--

DROP TABLE IF EXISTS `bank_statement_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.bank_statement_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `bank_account_id` bigint(20) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(50) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `payment_reference` varchar(50) DEFAULT '',
  `bank_transaction_source` enum('IMPORT','MANUAL') NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `reconciled` tinyint(4) NOT NULL DEFAULT 0,
  `bank_statement_id` bigint(20) NOT NULL,
  `reconciled_accounting_period_id` bigint(20) DEFAULT NULL,
  `reconciled_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bank_account_id` (`bank_account_id`),
  KEY `bank_statement_id` (`bank_statement_id`),
  KEY `reconciled_accounting_period_id` (`reconciled_accounting_period_id`),
  CONSTRAINT `bank_statement_transaction_ibfk_1` FOREIGN KEY (`bank_account_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `bank_statement_transaction_ibfk_2` FOREIGN KEY (`bank_statement_id`) REFERENCES `bank_statement` (`id`),
  CONSTRAINT `bank_statement_transaction_ibfk_3` FOREIGN KEY (`reconciled_accounting_period_id`) REFERENCES `accounting_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barcode_setting`
--

DROP TABLE IF EXISTS `barcode_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.barcode_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) NOT NULL,
  `barcode_type` enum('Code 39','Code 128','QR','Data matrix') NOT NULL,
  `barcode_use` enum('Warehouse label','Product code','User ID','Job code') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  CONSTRAINT `barcode_setting_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `barcode_setting_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `barcode_setting_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_of_materials`
--

DROP TABLE IF EXISTS `bill_of_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.bill_of_materials` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `product_unit_of_measure_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `item_sku` varchar(50) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `quantity` decimal(20,10) DEFAULT 0.0000000000,
  `multiple_use` tinyint(4) DEFAULT 0,
  `is_assembly` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_unit_of_measure_id` (`product_unit_of_measure_id`),
  KEY `product_id` (`product_id`),
  KEY `item_id` (`item_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `bill_of_materials_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bill_of_materials_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bill_of_materials_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `bill_of_materials_ibfk_4` FOREIGN KEY (`product_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `bill_of_materials_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bill_of_materials_ibfk_6` FOREIGN KEY (`item_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bill_of_materials_ibfk_7` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blacklisted_zone`
--

DROP TABLE IF EXISTS `blacklisted_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.blacklisted_zone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `zone_id` bigint(20) NOT NULL,
  `rule_description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `zone_id` (`zone_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `blacklisted_zone_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `blacklisted_zone_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `blacklisted_zone_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `blacklisted_zone_ibfk_4` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`),
  CONSTRAINT `blacklisted_zone_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.branch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) NOT NULL,
  `postal_address_id` bigint(20) DEFAULT NULL,
  `invoice_branch_id` bigint(20) DEFAULT NULL,
  `delivery_branch_id` bigint(20) DEFAULT NULL,
  `default_contact_id` bigint(20) DEFAULT NULL,
  `branch_name` varchar(255) DEFAULT NULL,
  `telephone_number` varchar(25) DEFAULT NULL,
  `url` varchar(515) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `fax_number` varchar(255) DEFAULT NULL,
  `location_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `company_id` (`company_id`),
  KEY `postal_address_id` (`postal_address_id`),
  KEY `invoice_branch_id` (`invoice_branch_id`),
  KEY `delivery_branch_id` (`delivery_branch_id`),
  KEY `email_address` (`email_address`),
  KEY `branch_name` (`branch_name`),
  KEY `telephone_number` (`telephone_number`),
  KEY `default_contact_id` (`default_contact_id`),
  CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `branch_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `branch_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `branch_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `branch_ibfk_5` FOREIGN KEY (`postal_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `branch_ibfk_6` FOREIGN KEY (`invoice_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `branch_ibfk_7` FOREIGN KEY (`delivery_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `branch_ibfk_8` FOREIGN KEY (`default_contact_id`) REFERENCES `contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_log_outcome`
--

DROP TABLE IF EXISTS `call_log_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.call_log_outcome` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `call_log_outcome_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `call_log_outcome_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `call_log_outcome_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `canada_tax_code`
--

DROP TABLE IF EXISTS `canada_tax_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.canada_tax_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `province` varchar(255) NOT NULL,
  `tax_code` varchar(255) NOT NULL,
  `province_rate` decimal(10,2) NOT NULL,
  `canada_rate` decimal(10,2) NOT NULL,
  `total_rate` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `canada_tax_code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `canada_tax_code_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `canada_tax_code_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cash_journal`
--

DROP TABLE IF EXISTS `cash_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.cash_journal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `internal_reference` varchar(20) DEFAULT NULL,
  `payment_reference` varchar(32) DEFAULT NULL,
  `bank_account_id` bigint(20) NOT NULL,
  `exchange_rate` decimal(12,4) DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `description` varchar(50) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `total_cash` decimal(10,2) DEFAULT 0.00,
  `accounting_period_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `bank_account_id` (`bank_account_id`),
  KEY `accounting_period_id` (`accounting_period_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `cash_journal_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cash_journal_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cash_journal_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cash_journal_ibfk_4` FOREIGN KEY (`bank_account_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `cash_journal_ibfk_5` FOREIGN KEY (`accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `cash_journal_ibfk_6` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cash_journal_item`
--

DROP TABLE IF EXISTS `cash_journal_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.cash_journal_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `cash_journal_id` bigint(20) NOT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `trading_company_gl_code_prefix` varchar(3) DEFAULT NULL,
  `division_gl_code_prefix` varchar(3) DEFAULT NULL,
  `department_gl_code_prefix` varchar(3) DEFAULT NULL,
  `description` varchar(40) NOT NULL,
  `debit` decimal(10,2) DEFAULT 0.00,
  `credit` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `input_output_VAT` enum('Input','Output') DEFAULT NULL,
  `tax_gl_code_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `cash_journal_id` (`cash_journal_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `tax_gl_code_id` (`tax_gl_code_id`),
  CONSTRAINT `cash_journal_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_4` FOREIGN KEY (`cash_journal_id`) REFERENCES `cash_journal` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_5` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_6` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_7` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `cash_journal_item_ibfk_8` FOREIGN KEY (`tax_gl_code_id`) REFERENCES `general_ledger_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cheque_position_settings`
--

DROP TABLE IF EXISTS `cheque_position_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.cheque_position_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `type` enum('Top with remittance below','Bottom with remittance above') DEFAULT 'Top with remittance below',
  `table_offset_right` smallint(6) DEFAULT 3,
  `table_offset_down` smallint(6) DEFAULT 335,
  `date_offset_right` smallint(6) DEFAULT 975,
  `date_offset_down` smallint(6) DEFAULT 75,
  `payee_offset_right` smallint(6) DEFAULT 110,
  `payee_offset_down` smallint(6) DEFAULT 185,
  `value_offset_right` smallint(6) DEFAULT 925,
  `value_offset_down` smallint(6) DEFAULT 200,
  `value_in_words_offset_right` smallint(6) DEFAULT 110,
  `value_in_words_offset_down` smallint(6) DEFAULT 185,
  `supplier_address_top_offset_right` smallint(6) DEFAULT 110,
  `supplier_address_top_offset_down` smallint(6) DEFAULT 225,
  `supplier_address_bottom_offset_right` smallint(6) DEFAULT 110,
  `supplier_address_bottom_offset_down` smallint(6) DEFAULT 400,
  `address_offset_position` varchar(6) DEFAULT 'TOP',
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `cheque_position_settings_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cheque_position_settings_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cheque_position_settings_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cheque_position_settings_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `default_currency_id` bigint(20) DEFAULT NULL,
  `default_branch_id` bigint(20) DEFAULT NULL,
  `default_invoice_branch_id` bigint(20) DEFAULT NULL,
  `default_delivery_branch_id` bigint(20) DEFAULT NULL,
  `company_name` varchar(100) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `type` enum('Company','Individual') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `default_currency_id` (`default_currency_id`),
  KEY `company_name` (`company_name`),
  KEY `default_delivery_branch_id` (`default_delivery_branch_id`),
  KEY `default_invoice_branch_id` (`default_invoice_branch_id`),
  KEY `default_branch_id` (`default_branch_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `company_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `company_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `company_ibfk_4` FOREIGN KEY (`default_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `company_ibfk_5` FOREIGN KEY (`default_delivery_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `company_ibfk_6` FOREIGN KEY (`default_invoice_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `company_ibfk_7` FOREIGN KEY (`default_branch_id`) REFERENCES `branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `company_customer_supplier_prospect`
--

DROP TABLE IF EXISTS `company_customer_supplier_prospect`;
/*!50001 DROP VIEW IF EXISTS `company_customer_supplier_prospect`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.company_customer_supplier_prospect` (
  `id` tinyint NOT NULL,
  `company_id` tinyint NOT NULL,
  `customer_id` tinyint NOT NULL,
  `supplier_id` tinyint NOT NULL,
  `prospect_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT 1,
  `preferred_image_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `branch_id` (`branch_id`),
  KEY `person_id` (`person_id`),
  KEY `role` (`role`),
  CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `contact_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `contact_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `contact_ibfk_4` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `contact_ibfk_5` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost_code`
--

DROP TABLE IF EXISTS `cost_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.cost_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `cost_code_name` varchar(50) NOT NULL,
  `element_one_name` varchar(50) NOT NULL,
  `element_one_code` char(4) NOT NULL,
  `element_two_name` varchar(50) DEFAULT NULL,
  `element_two_code` char(4) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `cost_code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cost_code_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `cost_code_ibfk_3` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_note`
--

DROP TABLE IF EXISTS `credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.credit_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `sale_currency_id` bigint(20) NOT NULL,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `sale_currency_name` varchar(41) NOT NULL,
  `sale_currency_symbol` varchar(3) NOT NULL,
  `sale_currency_code` varchar(3) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `credit_note_number_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `external_order_number` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) DEFAULT NULL,
  `credit_note_prefix` varchar(8) DEFAULT NULL,
  `payment_required_by` datetime DEFAULT NULL,
  `total_amount_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_outstanding` decimal(10,2) NOT NULL DEFAULT 0.00,
  `credit_note_total` decimal(10,2) GENERATED ALWAYS AS (`total_amount_paid` + `amount_outstanding`) VIRTUAL,
  `is_multiple_order_bulk_credit_note` tinyint(4) DEFAULT 0,
  `credit_note_date` date NOT NULL,
  `tax_point_date` date NOT NULL,
  `draft` tinyint(4) DEFAULT 1,
  `assigned` tinyint(4) DEFAULT 0,
  `paid` tinyint(4) DEFAULT 0,
  `posted` tinyint(4) DEFAULT 0,
  `include_logo` tinyint(4) DEFAULT 1,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_account_number` varchar(50) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `customer_address_id` bigint(20) NOT NULL,
  `customer_address_format_id` bigint(20) NOT NULL,
  `customer_address_name` varchar(100) DEFAULT NULL,
  `customer_thoroughfare` varchar(255) DEFAULT NULL,
  `customer_premise` varchar(255) DEFAULT NULL,
  `customer_locality` varchar(255) DEFAULT NULL,
  `customer_administrative_area` varchar(255) DEFAULT NULL,
  `customer_sub_administrative_area` varchar(255) DEFAULT NULL,
  `customer_postal_code` varchar(255) DEFAULT NULL,
  `customer_country` varchar(2) NOT NULL,
  `division_name` varchar(255) NOT NULL,
  `division_address_id` bigint(20) NOT NULL,
  `division_address_format_id` bigint(20) NOT NULL,
  `division_address_name` varchar(100) DEFAULT NULL,
  `division_thoroughfare` varchar(255) DEFAULT NULL,
  `division_premise` varchar(255) DEFAULT NULL,
  `division_locality` varchar(255) DEFAULT NULL,
  `division_administrative_area` varchar(255) DEFAULT NULL,
  `division_sub_administrative_area` varchar(255) DEFAULT NULL,
  `division_postal_code` varchar(255) DEFAULT NULL,
  `division_country` varchar(2) NOT NULL,
  `bank_internal_account_ref` varchar(32) NOT NULL,
  `bank_account_name` varchar(32) DEFAULT NULL,
  `bank_account_number` varchar(32) DEFAULT NULL,
  `bank_sort_code` varchar(10) DEFAULT NULL,
  `bank_iban` varchar(34) DEFAULT NULL,
  `bank_swift_bic` varchar(11) DEFAULT NULL,
  `bank_use_bic_and_iban` tinyint(4) DEFAULT 1,
  `trading_company_id` bigint(20) NOT NULL,
  `total_amount_paid_sale_currency` decimal(10,2) DEFAULT 0.00,
  `amount_outstanding_sale_currency` decimal(10,2) DEFAULT 0.00,
  `credit_note_total_sale_currency` decimal(10,2) GENERATED ALWAYS AS (`amount_outstanding_sale_currency` + `total_amount_paid_sale_currency`) VIRTUAL,
  `pdf_footer` longtext DEFAULT '',
  `period_posted_id` bigint(20) DEFAULT NULL,
  `period_fully_paid_id` bigint(20) DEFAULT NULL,
  `date_fully_paid` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `sale_currency_id` (`sale_currency_id`),
  KEY `credit_note_number_id` (`credit_note_number_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `period_posted_id` (`period_posted_id`),
  KEY `period_fully_paid_id` (`period_fully_paid_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `bank_id` (`bank_id`),
  CONSTRAINT `credit_note_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_ibfk_10` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `credit_note_ibfk_11` FOREIGN KEY (`period_posted_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `credit_note_ibfk_12` FOREIGN KEY (`period_fully_paid_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `credit_note_ibfk_13` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `credit_note_ibfk_14` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `credit_note_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `credit_note_ibfk_5` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `credit_note_ibfk_6` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `credit_note_ibfk_7` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `credit_note_ibfk_8` FOREIGN KEY (`sale_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `credit_note_ibfk_9` FOREIGN KEY (`credit_note_number_id`) REFERENCES `credit_note_number` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_outstanding_amount_before_update BEFORE UPDATE ON credit_note FOR EACH ROW BEGIN
        SET NEW.amount_outstanding = IFNULL((SELECT (SUM(li.gross_total)) - (NEW.total_amount_paid) FROM credit_note_item li WHERE li.credit_note_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_OS_amount_in_currency_before_update BEFORE UPDATE ON credit_note FOR EACH ROW BEGIN
        SET NEW.amount_outstanding_sale_currency = IFNULL((SELECT (SUM(li.gross_total_in_currency)) - (NEW.total_amount_paid_sale_currency) FROM credit_note_item li WHERE li.credit_note_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `credit_note_item`
--

DROP TABLE IF EXISTS `credit_note_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.credit_note_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) NOT NULL,
  `quote_item_id` bigint(20) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `same_as_original` tinyint(4) DEFAULT 1,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `price` decimal(10,2) DEFAULT 0.00,
  `price_in_currency` decimal(10,2) DEFAULT 0.00,
  `discount` decimal(10,2) DEFAULT 0.00,
  `discount_in_currency` decimal(11,2) DEFAULT 0.00,
  `net_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`price` - `discount`)) VIRTUAL,
  `net_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`price_in_currency` - `discount_in_currency`)) VIRTUAL,
  `description` text NOT NULL,
  `is_taxable` tinyint(4) DEFAULT 1,
  `allow_discounts` tinyint(4) DEFAULT 1,
  `tax_percent` varchar(255) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  `gross_total` decimal(10,2) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `gross_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_name` varchar(50) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `general_ledger_code_code` varchar(255) DEFAULT NULL,
  `general_ledger_code_description` varchar(255) DEFAULT NULL,
  `general_ledger_code_category` varchar(255) DEFAULT NULL,
  `tax_code_code` varchar(255) DEFAULT NULL,
  `tax_code_description` varchar(255) DEFAULT NULL,
  `tax_code_amount` decimal(5,2) DEFAULT NULL,
  `avalara_tax_code` varchar(25) DEFAULT NULL,
  `override_tax_in_tax_integration` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `quote_item_id` (`quote_item_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `job_id` (`job_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  CONSTRAINT `credit_note_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_item_ibfk_10` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `credit_note_item_ibfk_11` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `credit_note_item_ibfk_12` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `credit_note_item_ibfk_13` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `credit_note_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_item_ibfk_4` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `credit_note_item_ibfk_5` FOREIGN KEY (`quote_item_id`) REFERENCES `quote_item` (`id`),
  CONSTRAINT `credit_note_item_ibfk_6` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `credit_note_item_ibfk_7` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `credit_note_item_ibfk_8` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `credit_note_item_ibfk_9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_outstanding_amount_after_item_insert AFTER INSERT ON credit_note_item FOR EACH ROW BEGIN
        UPDATE credit_note i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM credit_note_item li WHERE li.credit_note_id = i.id) WHERE i.id = NEW.credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_OS_amount_in_currency_after_item_insert AFTER INSERT ON credit_note_item FOR EACH ROW BEGIN
        UPDATE credit_note i SET i.amount_outstanding_sale_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_sale_currency) FROM credit_note_item li WHERE li.credit_note_id = i.id) WHERE i.id = NEW.credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_outstanding_amount_after_item_update AFTER UPDATE ON credit_note_item FOR EACH ROW BEGIN
        UPDATE credit_note i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM credit_note_item li WHERE li.credit_note_id = i.id) WHERE i.id = NEW.credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_OS_amount_in_currency_after_item_update AFTER UPDATE ON credit_note_item FOR EACH ROW BEGIN
        UPDATE credit_note i SET i.amount_outstanding_sale_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_sale_currency) FROM credit_note_item li WHERE li.credit_note_id = i.id) WHERE i.id = NEW.credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `credit_note_number`
--

DROP TABLE IF EXISTS `credit_note_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.credit_note_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `credit_note_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `credit_note_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `currency_name` varchar(100) NOT NULL,
  `currency_code` varchar(10) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `exchange_rate` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `currency_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `currency_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `currency_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_field`
--

DROP TABLE IF EXISTS `custom_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.custom_field` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `table_name` varchar(50) NOT NULL,
  `data_type` varchar(20) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `custom_field_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_field_option`
--

DROP TABLE IF EXISTS `custom_field_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.custom_field_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `custom_field_id` bigint(20) NOT NULL,
  `label` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `custom_field_id` (`custom_field_id`),
  CONSTRAINT `custom_field_option_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_option_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_option_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_option_ibfk_4` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_field` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_field_value`
--

DROP TABLE IF EXISTS `custom_field_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.custom_field_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `custom_field_id` bigint(20) NOT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `opportunity_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `warehouse_location_id` bigint(20) DEFAULT NULL,
  `custom_field_option_id` bigint(20) DEFAULT NULL,
  `text_value` varchar(255) DEFAULT NULL,
  `number_value` int(11) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `custom_field_id` (`custom_field_id`),
  KEY `branch_id` (`branch_id`),
  KEY `company_id` (`company_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `job_id` (`job_id`),
  KEY `opportunity_id` (`opportunity_id`),
  KEY `quote_id` (`quote_id`),
  KEY `person_id` (`person_id`),
  KEY `product_id` (`product_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `warehouse_location_id` (`warehouse_location_id`),
  KEY `custom_field_option_id` (`custom_field_option_id`),
  KEY `credit_note_id` (`credit_note_id`),
  CONSTRAINT `custom_field_value_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_value_ibfk_10` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `custom_field_value_ibfk_11` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`),
  CONSTRAINT `custom_field_value_ibfk_12` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `custom_field_value_ibfk_13` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `custom_field_value_ibfk_14` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `custom_field_value_ibfk_15` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `custom_field_value_ibfk_16` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `custom_field_value_ibfk_17` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `custom_field_value_ibfk_18` FOREIGN KEY (`warehouse_location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `custom_field_value_ibfk_19` FOREIGN KEY (`custom_field_option_id`) REFERENCES `custom_field_option` (`id`),
  CONSTRAINT `custom_field_value_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_value_ibfk_20` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `custom_field_value_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_field_value_ibfk_4` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_field` (`id`),
  CONSTRAINT `custom_field_value_ibfk_5` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `custom_field_value_ibfk_6` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `custom_field_value_ibfk_7` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `custom_field_value_ibfk_8` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `custom_field_value_ibfk_9` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_product_price`
--

DROP TABLE IF EXISTS `custom_product_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.custom_product_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `custom_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `custom_product_price_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_product_price_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_product_price_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `custom_product_price_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `custom_product_price_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  `customer_tier_id` bigint(20) DEFAULT NULL,
  `sales_territory_id` bigint(20) DEFAULT NULL,
  `account_number` varchar(50) NOT NULL,
  `supplier_account_number` varchar(50) DEFAULT NULL,
  `credit_limit` decimal(10,2) DEFAULT 0.00,
  `credit_term_days` bigint(20) DEFAULT 0,
  `credit` tinyint(4) DEFAULT 0,
  `ignore_limit` tinyint(4) DEFAULT 0,
  `purchase_order_required` tinyint(4) DEFAULT 0,
  `sales_tax_required` tinyint(4) DEFAULT 1,
  `approved` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `hold` tinyint(4) DEFAULT 0,
  `is_drop_shippable` tinyint(4) DEFAULT 1,
  `stock_auto_allocate` tinyint(1) NOT NULL,
  `allow_backorder` tinyint(1) DEFAULT 1,
  `job_auto_allocate` tinyint(1) DEFAULT 1,
  `sub_ledger_id` bigint(20) DEFAULT NULL,
  `balance_owed` decimal(14,2) NOT NULL DEFAULT 0.00,
  `mailstop_no` varchar(50) DEFAULT NULL,
  `OVP_no` varchar(20) DEFAULT NULL,
  `exemption_number` varchar(25) DEFAULT NULL,
  `entity_use_code` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `company_id` (`company_id`),
  KEY `manager_id` (`manager_id`),
  KEY `bank_id` (`bank_id`),
  KEY `customer_tier_id` (`customer_tier_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `division_id` (`division_id`),
  KEY `sub_ledger_id` (`sub_ledger_id`),
  KEY `supplier_account_number` (`supplier_account_number`),
  KEY `sales_territory_id` (`sales_territory_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_ibfk_10` FOREIGN KEY (`sub_ledger_id`) REFERENCES `sub_ledger` (`id`),
  CONSTRAINT `customer_ibfk_11` FOREIGN KEY (`sales_territory_id`) REFERENCES `sale_territory` (`id`),
  CONSTRAINT `customer_ibfk_12` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `customer_ibfk_5` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `customer_ibfk_6` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `customer_ibfk_7` FOREIGN KEY (`customer_tier_id`) REFERENCES `customer_tier` (`id`),
  CONSTRAINT `customer_ibfk_8` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `customer_ibfk_9` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_discount`
--

DROP TABLE IF EXISTS `customer_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.customer_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `discount_name` varchar(30) NOT NULL,
  `discount_percentage` decimal(7,4) DEFAULT NULL,
  `enabled` tinyint(4) DEFAULT 1,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_discount_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_discount_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_discount_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_discount_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_remittance`
--

DROP TABLE IF EXISTS `customer_remittance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.customer_remittance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  `document_currency_id` bigint(20) NOT NULL,
  `payment_reference` varchar(255) DEFAULT NULL,
  `payment_made_on` date DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT 0.00,
  `amount_paid_in_currency` decimal(10,2) DEFAULT 0.00,
  `cheque_number` varchar(20) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `customer_id` (`customer_id`),
  KEY `bank_id` (`bank_id`),
  KEY `payment_method_id` (`payment_method_id`),
  KEY `currency_id` (`currency_id`),
  KEY `document_currency_id` (`document_currency_id`),
  CONSTRAINT `customer_remittance_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_remittance_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_remittance_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `customer_remittance_ibfk_4` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `customer_remittance_ibfk_5` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `customer_remittance_ibfk_6` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `customer_remittance_ibfk_7` FOREIGN KEY (`document_currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_tier`
--

DROP TABLE IF EXISTS `customer_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.customer_tier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `tier` varchar(10) NOT NULL,
  `tier_description` varchar(100) NOT NULL,
  `discount_percentage` decimal(7,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `customer_tier_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_tier_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `customer_tier_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_configuration`
--

DROP TABLE IF EXISTS `dashboard_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.dashboard_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `user_id` bigint(20) DEFAULT NULL,
  `dashboard_name` varchar(50) NOT NULL,
  `configuration` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`dashboard_name`),
  CONSTRAINT `dashboard_configuration_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_restore_configuration`
--

DROP TABLE IF EXISTS `dashboard_restore_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.dashboard_restore_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `user_id` bigint(20) DEFAULT NULL,
  `dashboard_name` varchar(50) NOT NULL,
  `configuration` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`dashboard_name`),
  CONSTRAINT `dashboard_restore_configuration_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_widget_template`
--

DROP TABLE IF EXISTS `dashboard_widget_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.dashboard_widget_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `subtype` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `configuration` text NOT NULL,
  `requires_id` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `type` (`type`),
  KEY `subtype` (`subtype`),
  KEY `name` (`name`),
  CONSTRAINT `dashboard_widget_template_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `default_warehouse_location_type`
--

DROP TABLE IF EXISTS `default_warehouse_location_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.default_warehouse_location_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL,
  `type` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `default_warehouse_location_type_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `default_warehouse_location_type_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `default_warehouse_location_type_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `default_warehouse_location_type_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `warehouse_location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) NOT NULL,
  `sales_order_item_id` bigint(20) NOT NULL,
  `delivery_note_number_id` bigint(20) NOT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `delivery_note_number_id` (`delivery_note_number_id`),
  CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `delivery_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `delivery_ibfk_4` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `delivery_ibfk_5` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `delivery_ibfk_6` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `delivery_ibfk_7` FOREIGN KEY (`delivery_note_number_id`) REFERENCES `delivery_note_number` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delivery_method`
--

DROP TABLE IF EXISTS `delivery_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.delivery_method` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `method_name` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `delivery_days` smallint(5) unsigned NOT NULL,
  `include_weekends` tinyint(4) NOT NULL DEFAULT 0,
  `include_national_holidays` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `method_name` (`method_name`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `delivery_method_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `delivery_method_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `delivery_method_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delivery_note_number`
--

DROP TABLE IF EXISTS `delivery_note_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.delivery_note_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `delivery_note_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `delivery_note_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `department_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `closed` tinyint(4) DEFAULT 0,
  `gl_code_prefix` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `division_id` (`division_id`),
  KEY `department_name` (`department_name`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `department_ibfk_5` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department_member`
--

DROP TABLE IF EXISTS `department_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.department_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `department_member_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_member_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_member_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department_resource`
--

DROP TABLE IF EXISTS `department_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.department_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) NOT NULL,
  `resource_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `department_id` (`department_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `department_resource_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_resource_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_resource_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `department_resource_ibfk_4` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `department_resource_ibfk_5` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dictionary_term`
--

DROP TABLE IF EXISTS `dictionary_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.dictionary_term` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) NOT NULL,
  `default_term` varchar(100) NOT NULL,
  `preferred_term` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  CONSTRAINT `dictionary_term_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `dictionary_term_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `dictionary_term_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_group`
--

DROP TABLE IF EXISTS `discount_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.discount_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(50) NOT NULL,
  `max_discount` decimal(5,2) DEFAULT 100.00,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `discount_group_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `discount_group_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `discount_group_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_group_item`
--

DROP TABLE IF EXISTS `discount_group_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.discount_group_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `discount_group_id` bigint(20) NOT NULL,
  `discount` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `discount_group_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `discount_group_item_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `discount_group_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.division` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `parent_company_id` bigint(20) DEFAULT NULL,
  `division_name` varchar(255) NOT NULL,
  `gl_code_prefix` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `parent_company_id` (`parent_company_id`),
  KEY `division_name` (`division_name`),
  CONSTRAINT `division_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `division_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `division_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `division_ibfk_4` FOREIGN KEY (`parent_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `division_resource`
--

DROP TABLE IF EXISTS `division_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.division_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) NOT NULL,
  `resource_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `division_id` (`division_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `division_resource_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `division_resource_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `division_resource_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `division_resource_ibfk_4` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `division_resource_ibfk_5` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `storage_engine` varchar(255) NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `uuid` varchar(36) NOT NULL,
  `version` varchar(20) DEFAULT '1',
  `mime_type` varchar(255) NOT NULL,
  `size` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `card_only` tinyint(4) NOT NULL DEFAULT 0,
  `privacy_setting_id` bigint(20) DEFAULT NULL,
  `linked_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `location_id` (`location_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `privacy_setting_id` (`privacy_setting_id`),
  CONSTRAINT `document_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `document` (`id`),
  CONSTRAINT `document_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `document_ibfk_6` FOREIGN KEY (`privacy_setting_id`) REFERENCES `document_privacy_setting` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_database`
--

DROP TABLE IF EXISTS `document_database`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_database` (
  `id` bigint(20) NOT NULL,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `file_data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `document_database_ibfk_1` FOREIGN KEY (`id`) REFERENCES `document` (`id`),
  CONSTRAINT `document_database_ibfk_2` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_database_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_database_ibfk_4` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_database_improved`
--

DROP TABLE IF EXISTS `document_database_improved`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_database_improved` (
  `id` bigint(20) NOT NULL,
  `seq` bigint(20) NOT NULL,
  `hash` char(32) NOT NULL,
  PRIMARY KEY (`id`,`seq`),
  CONSTRAINT `document_database_improved_ibfk_1` FOREIGN KEY (`id`) REFERENCES `document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_database_improved_data`
--

DROP TABLE IF EXISTS `document_database_improved_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_database_improved_data` (
  `hash` char(32) NOT NULL,
  `chunk` text NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_local`
--

DROP TABLE IF EXISTS `document_local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_local` (
  `id` bigint(20) NOT NULL,
  `seq` bigint(20) NOT NULL,
  `hash` char(32) NOT NULL,
  PRIMARY KEY (`id`,`seq`),
  CONSTRAINT `document_local_ibfk_1` FOREIGN KEY (`id`) REFERENCES `document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_permission`
--

DROP TABLE IF EXISTS `document_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `document_uuid` varchar(36) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `security_group_id` bigint(20) DEFAULT NULL,
  `can_read` tinyint(4) NOT NULL,
  `can_delete` tinyint(4) NOT NULL,
  `can_upload` tinyint(4) NOT NULL,
  `can_delete_folder` tinyint(4) NOT NULL,
  `can_create_folder` tinyint(4) NOT NULL,
  `is_admin` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `user_id` (`user_id`),
  KEY `security_group_id` (`security_group_id`),
  CONSTRAINT `document_permission_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_permission_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_permission_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_permission_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_permission_ibfk_5` FOREIGN KEY (`security_group_id`) REFERENCES `security_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_privacy_setting`
--

DROP TABLE IF EXISTS `document_privacy_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_privacy_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `document_uuid` varchar(36) NOT NULL,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  `can_read` tinyint(4) NOT NULL DEFAULT 1,
  `can_delete` tinyint(4) NOT NULL DEFAULT 1,
  `can_upload` tinyint(4) NOT NULL DEFAULT 1,
  `can_delete_folder` tinyint(4) NOT NULL DEFAULT 1,
  `can_create_folder` tinyint(4) NOT NULL DEFAULT 1,
  `inherit` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `document_privacy_setting_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_privacy_setting_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_privacy_setting_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_relation`
--

DROP TABLE IF EXISTS `document_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `helpdesk_ticket_id` bigint(20) DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  `bank_statement_id` bigint(20) DEFAULT NULL,
  `bank_statement_transaction_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `non_compliance_report_id` bigint(20) DEFAULT NULL,
  `note_id` bigint(20) DEFAULT NULL,
  `operation_id` bigint(20) DEFAULT NULL,
  `opportunity_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_unit_id` bigint(20) DEFAULT NULL,
  `product_batch_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `service_contract_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `warehouse_location_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_category_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) DEFAULT NULL,
  `application_user_id` bigint(20) DEFAULT NULL,
  `position` int(11) DEFAULT 1,
  `pdf_footer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `company_id` (`company_id`),
  KEY `contact_id` (`contact_id`),
  KEY `customer_id` (`customer_id`),
  KEY `document_id` (`document_id`),
  KEY `employee_id` (`employee_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `bank_id` (`bank_id`),
  KEY `bank_statement_id` (`bank_statement_id`),
  KEY `bank_statement_transaction_id` (`bank_statement_transaction_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `job_id` (`job_id`),
  KEY `non_compliance_report_id` (`non_compliance_report_id`),
  KEY `note_id` (`note_id`),
  KEY `operation_id` (`operation_id`),
  KEY `opportunity_id` (`opportunity_id`),
  KEY `division_id` (`division_id`),
  KEY `product_id` (`product_id`),
  KEY `project_id` (`project_id`),
  KEY `quote_id` (`quote_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `service_contract_id` (`service_contract_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `returns_authorisation_id` (`returns_authorisation_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  KEY `warehouse_location_id` (`warehouse_location_id`),
  KEY `application_user_id` (`application_user_id`),
  KEY `branch_id` (`branch_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `general_ledger_code_category_id` (`general_ledger_code_category_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `currency_id` (`currency_id`),
  KEY `pdf_footer_id` (`pdf_footer_id`),
  KEY `product_batch_id` (`product_batch_id`),
  KEY `product_unit_id` (`product_unit_id`),
  CONSTRAINT `document_relation_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `document_relation_ibfk_10` FOREIGN KEY (`bank_statement_id`) REFERENCES `bank_statement` (`id`),
  CONSTRAINT `document_relation_ibfk_11` FOREIGN KEY (`bank_statement_transaction_id`) REFERENCES `bank_statement_transaction` (`id`),
  CONSTRAINT `document_relation_ibfk_12` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `document_relation_ibfk_13` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `document_relation_ibfk_14` FOREIGN KEY (`non_compliance_report_id`) REFERENCES `non_compliance_report` (`id`),
  CONSTRAINT `document_relation_ibfk_15` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`),
  CONSTRAINT `document_relation_ibfk_16` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`),
  CONSTRAINT `document_relation_ibfk_17` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`),
  CONSTRAINT `document_relation_ibfk_18` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `document_relation_ibfk_19` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `document_relation_ibfk_2` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `document_relation_ibfk_20` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `document_relation_ibfk_21` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `document_relation_ibfk_22` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `document_relation_ibfk_23` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `document_relation_ibfk_24` FOREIGN KEY (`service_contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `document_relation_ibfk_25` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `document_relation_ibfk_26` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `document_relation_ibfk_27` FOREIGN KEY (`returns_authorisation_id`) REFERENCES `returns_authorisation` (`id`),
  CONSTRAINT `document_relation_ibfk_28` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `document_relation_ibfk_29` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `document_relation_ibfk_3` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `document_relation_ibfk_30` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `document_relation_ibfk_31` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`),
  CONSTRAINT `document_relation_ibfk_32` FOREIGN KEY (`warehouse_location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `document_relation_ibfk_33` FOREIGN KEY (`application_user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_relation_ibfk_34` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `document_relation_ibfk_35` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `document_relation_ibfk_36` FOREIGN KEY (`general_ledger_code_category_id`) REFERENCES `general_ledger_code_category` (`id`),
  CONSTRAINT `document_relation_ibfk_37` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `document_relation_ibfk_38` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `document_relation_ibfk_39` FOREIGN KEY (`pdf_footer_id`) REFERENCES `pdf_footer` (`id`),
  CONSTRAINT `document_relation_ibfk_4` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `document_relation_ibfk_40` FOREIGN KEY (`product_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `document_relation_ibfk_41` FOREIGN KEY (`product_unit_id`) REFERENCES `product_unit` (`id`),
  CONSTRAINT `document_relation_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `document_relation_ibfk_6` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  CONSTRAINT `document_relation_ibfk_7` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `document_relation_ibfk_8` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `document_relation_ibfk_9` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_tag`
--

DROP TABLE IF EXISTS `document_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_id` bigint(20) NOT NULL,
  `document_tag_name_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `document_id` (`document_id`),
  KEY `document_tag_name_id` (`document_tag_name_id`),
  CONSTRAINT `document_tag_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  CONSTRAINT `document_tag_ibfk_2` FOREIGN KEY (`document_tag_name_id`) REFERENCES `document_tag_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_tag_name`
--

DROP TABLE IF EXISTS `document_tag_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.document_tag_name` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `tag` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `document_tag_name_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_tag_name_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `document_tag_name_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dynamic_window_configuration`
--

DROP TABLE IF EXISTS `dynamic_window_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.dynamic_window_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `user_id` bigint(20) NOT NULL,
  `hash` char(10) NOT NULL,
  `configuration` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`hash`),
  CONSTRAINT `dynamic_window_configuration_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.email` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `subject` varchar(255) NOT NULL,
  `body_preview` text NOT NULL,
  `email_content_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_content_id` (`email_content_id`),
  CONSTRAINT `email_ibfk_1` FOREIGN KEY (`email_content_id`) REFERENCES `email_content` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_address`
--

DROP TABLE IF EXISTS `email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.email_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `email_address_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_address_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_address_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_content`
--

DROP TABLE IF EXISTS `email_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.email_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `raw` longtext DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_relation`
--

DROP TABLE IF EXISTS `email_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.email_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_id` bigint(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` varchar(10) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `user_id` (`user_id`),
  KEY `contact_id` (`contact_id`),
  KEY `role` (`role`),
  CONSTRAINT `email_relation_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `email` (`id`),
  CONSTRAINT `email_relation_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_relation_ibfk_3` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_server_configuration`
--

DROP TABLE IF EXISTS `email_server_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.email_server_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) NOT NULL,
  `server_address` varchar(100) NOT NULL,
  `server_port` smallint(5) unsigned NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `password` char(44) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  CONSTRAINT `email_server_configuration_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_server_configuration_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_server_configuration_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_type_settings`
--

DROP TABLE IF EXISTS `email_type_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.email_type_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_email_id` bigint(20) DEFAULT NULL,
  `email_type` enum('Customer','Invoice','Credit note','Operation','Purchase order','Quote','Sales order','Return note','Supplier') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_email_id` (`trading_company_email_id`),
  CONSTRAINT `email_type_settings_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_type_settings_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_type_settings_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `email_type_settings_ibfk_4` FOREIGN KEY (`trading_company_email_id`) REFERENCES `trading_company_email_address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) NOT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `job_title_id` bigint(20) DEFAULT NULL,
  `sales_territory_id` bigint(20) DEFAULT NULL,
  `hourly_rate` decimal(7,2) DEFAULT NULL,
  `charge_out_rate` decimal(7,2) DEFAULT NULL,
  `overtime_multiplier` decimal(6,3) DEFAULT NULL,
  `out_of_hours_multiplier` decimal(6,3) DEFAULT NULL,
  `salary` decimal(9,2) DEFAULT NULL,
  `salary_detail` text DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `date_left` date DEFAULT NULL,
  `national_insurance_number` char(13) DEFAULT NULL,
  `social_security_number` char(11) DEFAULT NULL,
  `is_manager` tinyint(4) DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  `resource_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `national_insurance_number` (`national_insurance_number`),
  UNIQUE KEY `social_security_number` (`social_security_number`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `person_id` (`person_id`),
  KEY `job_title_id` (`job_title_id`),
  KEY `sales_territory_id` (`sales_territory_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`job_title_id`) REFERENCES `job_titles` (`id`),
  CONSTRAINT `employee_ibfk_6` FOREIGN KEY (`sales_territory_id`) REFERENCES `sale_territory` (`id`),
  CONSTRAINT `employee_ibfk_7` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee_next_of_kin`
--

DROP TABLE IF EXISTS `employee_next_of_kin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.employee_next_of_kin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `next_of_kin_id` bigint(20) DEFAULT NULL,
  `is_primary_next_of_kin` tinyint(4) DEFAULT 0,
  `next_of_kin_relationship` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `next_of_kin_id` (`next_of_kin_id`),
  CONSTRAINT `employee_next_of_kin_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `employee_next_of_kin_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `employee_next_of_kin_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `employee_next_of_kin_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_next_of_kin_ibfk_5` FOREIGN KEY (`next_of_kin_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `finance_report_heading`
--

DROP TABLE IF EXISTS `finance_report_heading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.finance_report_heading` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `is_on_profit_and_loss_report` tinyint(4) NOT NULL DEFAULT 0,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `finance_report_heading_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `finance_report_heading_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `finance_report_heading_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `finance_report_heading_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `finance_report_sub_heading`
--

DROP TABLE IF EXISTS `finance_report_sub_heading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.finance_report_sub_heading` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `finance_report_heading_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `finance_report_heading_id` (`finance_report_heading_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `finance_report_sub_heading_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `finance_report_sub_heading_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `finance_report_sub_heading_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `finance_report_sub_heading_ibfk_4` FOREIGN KEY (`finance_report_heading_id`) REFERENCES `finance_report_heading` (`id`),
  CONSTRAINT `finance_report_sub_heading_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `general_ledger`
--

DROP TABLE IF EXISTS `general_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.general_ledger` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `ledger_code` varchar(255) NOT NULL,
  `ledger_description` varchar(255) DEFAULT NULL,
  `ledger_category` varchar(255) DEFAULT NULL,
  `ledger_heading` varchar(50) DEFAULT NULL,
  `ledger_sub_heading` varchar(50) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(10) NOT NULL,
  `debit` decimal(10,2) DEFAULT 0.00,
  `debit_in_currency` decimal(10,2) DEFAULT 0.00,
  `credit` decimal(10,2) DEFAULT 0.00,
  `credit_in_currency` decimal(10,2) DEFAULT 0.00,
  `currency_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `company` varchar(255) DEFAULT '',
  `product_name` varchar(255) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `invoice_number` bigint(20) DEFAULT NULL,
  `credit_note_number` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_number` varchar(50) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_number` varchar(50) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `nominal_journal_id` bigint(20) DEFAULT NULL,
  `cash_journal_id` bigint(20) DEFAULT NULL,
  `customer_remittance_id` bigint(20) DEFAULT NULL,
  `payment_reference` varchar(255) DEFAULT NULL,
  `tax_code` varchar(255) DEFAULT NULL,
  `tax_description` varchar(255) DEFAULT NULL,
  `tax_percent` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `tax_amount_in_currency` decimal(10,2) DEFAULT 0.00,
  `transaction_date` date NOT NULL,
  `trading_company_gl_code_prefix` varchar(3) DEFAULT NULL,
  `division_gl_code_prefix` varchar(3) DEFAULT NULL,
  `department_gl_code_prefix` varchar(3) DEFAULT NULL,
  `line_description` varchar(255) DEFAULT NULL,
  `reconciled` tinyint(4) NOT NULL DEFAULT 0,
  `bank_account_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `accounting_period_id` bigint(20) NOT NULL,
  `supplier_remittance_id` bigint(20) DEFAULT NULL,
  `reconciled_accounting_period_id` bigint(20) DEFAULT NULL,
  `reconciled_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `company_id` (`company_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `nominal_journal_id` (`nominal_journal_id`),
  KEY `cash_journal_id` (`cash_journal_id`),
  KEY `customer_remittance_id` (`customer_remittance_id`),
  KEY `currency_id` (`currency_id`),
  KEY `bank_account_id` (`bank_account_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `accounting_period_id` (`accounting_period_id`),
  KEY `supplier_remittance_id` (`supplier_remittance_id`),
  KEY `reconciled_accounting_period_id` (`reconciled_accounting_period_id`),
  CONSTRAINT `general_ledger_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_ibfk_10` FOREIGN KEY (`nominal_journal_id`) REFERENCES `nominal_journal` (`id`),
  CONSTRAINT `general_ledger_ibfk_11` FOREIGN KEY (`cash_journal_id`) REFERENCES `cash_journal` (`id`),
  CONSTRAINT `general_ledger_ibfk_12` FOREIGN KEY (`customer_remittance_id`) REFERENCES `customer_remittance` (`id`),
  CONSTRAINT `general_ledger_ibfk_13` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `general_ledger_ibfk_14` FOREIGN KEY (`bank_account_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `general_ledger_ibfk_15` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `general_ledger_ibfk_16` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `general_ledger_ibfk_17` FOREIGN KEY (`accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `general_ledger_ibfk_18` FOREIGN KEY (`supplier_remittance_id`) REFERENCES `supplier_remittance` (`id`),
  CONSTRAINT `general_ledger_ibfk_19` FOREIGN KEY (`reconciled_accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `general_ledger_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `general_ledger_ibfk_5` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `general_ledger_ibfk_6` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `general_ledger_ibfk_7` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `general_ledger_ibfk_8` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`),
  CONSTRAINT `general_ledger_ibfk_9` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `general_ledger_code`
--

DROP TABLE IF EXISTS `general_ledger_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.general_ledger_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `ledger_code` varchar(25) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `general_ledger_code_category_id` bigint(20) NOT NULL,
  `is_bank_account` tinyint(4) NOT NULL DEFAULT 0,
  `account_currency_id` bigint(20) DEFAULT NULL,
  `is_profit_and_loss_account` tinyint(4) NOT NULL DEFAULT 1,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ledger_code` (`ledger_code`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `account_currency_id` (`account_currency_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `general_ledger_code_category_id` (`general_ledger_code_category_id`),
  CONSTRAINT `general_ledger_code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_code_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_code_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_code_ibfk_4` FOREIGN KEY (`account_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `general_ledger_code_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `general_ledger_code_ibfk_6` FOREIGN KEY (`general_ledger_code_category_id`) REFERENCES `general_ledger_code_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `general_ledger_code_category`
--

DROP TABLE IF EXISTS `general_ledger_code_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.general_ledger_code_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `is_profit_and_loss` tinyint(4) NOT NULL DEFAULT 0,
  `finance_report_heading_id` bigint(20) DEFAULT NULL,
  `finance_report_sub_heading_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `allow_delete` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `finance_report_heading_id` (`finance_report_heading_id`),
  KEY `finance_report_sub_heading_id` (`finance_report_sub_heading_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `general_ledger_code_category_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_code_category_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_code_category_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `general_ledger_code_category_ibfk_4` FOREIGN KEY (`finance_report_heading_id`) REFERENCES `finance_report_heading` (`id`),
  CONSTRAINT `general_ledger_code_category_ibfk_5` FOREIGN KEY (`finance_report_sub_heading_id`) REFERENCES `finance_report_sub_heading` (`id`),
  CONSTRAINT `general_ledger_code_category_ibfk_6` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gl_code_period_movement`
--

DROP TABLE IF EXISTS `gl_code_period_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.gl_code_period_movement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company` bigint(20) DEFAULT NULL,
  `accounting_year_id` bigint(20) NOT NULL,
  `accounting_period_id` bigint(20) NOT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `cost_code_element_one_code` char(4) DEFAULT NULL,
  `cost_code_element_two_code` char(4) DEFAULT NULL,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_in_currency` decimal(12,2) NOT NULL DEFAULT 0.00,
  `is_initial_balance` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `accounting_period_id` (`accounting_period_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `accounting_year_id` (`accounting_year_id`),
  CONSTRAINT `gl_code_period_movement_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `gl_code_period_movement_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `gl_code_period_movement_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `gl_code_period_movement_ibfk_4` FOREIGN KEY (`accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `gl_code_period_movement_ibfk_5` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `gl_code_period_movement_ibfk_6` FOREIGN KEY (`accounting_year_id`) REFERENCES `accounting_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gl_opening_balance`
--

DROP TABLE IF EXISTS `gl_opening_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.gl_opening_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company` bigint(20) DEFAULT NULL,
  `accounting_year_id` bigint(20) NOT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `cost_code_element_one_code` char(4) DEFAULT NULL,
  `cost_code_element_two_code` char(4) DEFAULT NULL,
  `value` decimal(12,2) NOT NULL DEFAULT 0.00,
  `value_in_currency` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `accounting_year_id` (`accounting_year_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  CONSTRAINT `gl_opening_balance_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `gl_opening_balance_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `gl_opening_balance_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `gl_opening_balance_ibfk_4` FOREIGN KEY (`accounting_year_id`) REFERENCES `accounting_year` (`id`),
  CONSTRAINT `gl_opening_balance_ibfk_5` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `goods_received`
--

DROP TABLE IF EXISTS `goods_received`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.goods_received` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `purchase_order_item_id` bigint(20) NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `quantity` decimal(20,10) NOT NULL,
  `delivery_note_number` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_note_number` (`delivery_note_number`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `location_id` (`location_id`),
  KEY `purchase_order_item_id` (`purchase_order_item_id`),
  CONSTRAINT `goods_received_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `goods_received_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `goods_received_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `goods_received_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `goods_received_ibfk_5` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `purchase_order_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_item_outstanding_after_insert AFTER INSERT ON goods_received FOR EACH ROW BEGIN
        UPDATE purchase_order_item poi SET poi.outstanding = (
            (SELECT (poi.quantity - SUM(g.quantity)) FROM purchase_order_item poi INNER JOIN goods_received g ON poi.id = g.purchase_order_item_id WHERE poi.id = NEW.purchase_order_item_id) 
        ) WHERE poi.id = NEW.purchase_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_item_outstanding_after_update AFTER UPDATE ON goods_received FOR EACH ROW BEGIN
        UPDATE purchase_order_item poi SET poi.outstanding = (
            (SELECT (poi.quantity - SUM(g.quantity)) FROM purchase_order_item poi INNER JOIN goods_received g ON poi.id = g.purchase_order_item_id WHERE poi.id = NEW.purchase_order_item_id) 
        ) WHERE poi.id = NEW.purchase_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `greylisted_zone`
--

DROP TABLE IF EXISTS `greylisted_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.greylisted_zone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `zone_id` bigint(20) NOT NULL,
  `rule_description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `zone_id` (`zone_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `greylisted_zone_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `greylisted_zone_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `greylisted_zone_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `greylisted_zone_ibfk_4` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`),
  CONSTRAINT `greylisted_zone_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `helpdesk_ticket`
--

DROP TABLE IF EXISTS `helpdesk_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.helpdesk_ticket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) NOT NULL,
  `internal_id` bigint(20) unsigned NOT NULL,
  `platform_id` bigint(20) unsigned NOT NULL,
  `platform` varchar(30) NOT NULL,
  `feedback_type` enum('Customer Issue','Feature','Praise') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  CONSTRAINT `helpdesk_ticket_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `helpdesk_ticket_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `helpdesk_ticket_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inspection_report`
--

DROP TABLE IF EXISTS `inspection_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.inspection_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  `product_batch_id` bigint(20) DEFAULT NULL,
  `product_unit_id` bigint(20) DEFAULT NULL,
  `inspection_date` date NOT NULL,
  `manufacturing_date` date NOT NULL,
  `inspected_quantity` int(11) DEFAULT 0,
  `rejected_quantity` int(11) DEFAULT 0,
  `reworked_quantity` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `employee_id` (`employee_id`),
  KEY `product_batch_id` (`product_batch_id`),
  KEY `product_unit_id` (`product_unit_id`),
  CONSTRAINT `inspection_report_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `inspection_report_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `inspection_report_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `inspection_report_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `inspection_report_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `inspection_report_ibfk_6` FOREIGN KEY (`product_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `inspection_report_ibfk_7` FOREIGN KEY (`product_unit_id`) REFERENCES `product_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_cost`
--

DROP TABLE IF EXISTS `inventory_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.inventory_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `invoice_cost` decimal(10,2) NOT NULL,
  `for_invoice` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventory_cost_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `inventory_cost_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `inventory_cost_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `inventory_cost_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `inventory_cost_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.invoice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `sale_currency_id` bigint(20) NOT NULL,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `sale_currency_name` varchar(41) NOT NULL,
  `sale_currency_symbol` varchar(3) NOT NULL,
  `sale_currency_code` varchar(3) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `invoice_number_id` bigint(20) DEFAULT NULL,
  `invoicing_type` enum('Deposit','FinalDeposit','Progress','FinalProgress') DEFAULT NULL,
  `deposit_percentage` decimal(6,4) DEFAULT NULL,
  `is_refundable_deposit` tinyint(4) DEFAULT 1,
  `progress_percentage` decimal(6,4) DEFAULT NULL,
  `stage_type` enum('Percentage','Value','Lines') DEFAULT NULL,
  `bank_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `external_order_number` varchar(255) DEFAULT NULL,
  `invoice_prefix` varchar(8) DEFAULT NULL,
  `invoice_date` date NOT NULL,
  `tax_point_date` date NOT NULL,
  `payment_required_by` datetime NOT NULL,
  `total_amount_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_outstanding` decimal(10,2) NOT NULL DEFAULT 0.00,
  `invoice_total` decimal(10,2) GENERATED ALWAYS AS (`total_amount_paid` + `amount_outstanding`) VIRTUAL,
  `is_multiple_order_bulk_invoice` tinyint(4) DEFAULT 0,
  `draft` tinyint(4) DEFAULT 1,
  `assigned` tinyint(4) DEFAULT 0,
  `paid` tinyint(4) DEFAULT 0,
  `posted` tinyint(4) DEFAULT 0,
  `include_logo` tinyint(4) DEFAULT 1,
  `hide_discounts` tinyint(4) DEFAULT 0,
  `direct_from_quote` tinyint(4) DEFAULT 0,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_account_number` varchar(50) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `customer_address_id` bigint(20) NOT NULL,
  `customer_address_format_id` bigint(20) NOT NULL,
  `customer_address_name` varchar(100) DEFAULT NULL,
  `customer_thoroughfare` varchar(255) DEFAULT NULL,
  `customer_premise` varchar(255) DEFAULT NULL,
  `customer_locality` varchar(255) DEFAULT NULL,
  `customer_administrative_area` varchar(255) DEFAULT NULL,
  `customer_sub_administrative_area` varchar(255) DEFAULT NULL,
  `customer_postal_code` varchar(255) DEFAULT NULL,
  `customer_country` varchar(2) NOT NULL,
  `division_name` varchar(255) NOT NULL,
  `division_address_id` bigint(20) NOT NULL,
  `division_address_format_id` bigint(20) NOT NULL,
  `division_address_name` varchar(100) DEFAULT NULL,
  `division_thoroughfare` varchar(255) DEFAULT NULL,
  `division_premise` varchar(255) DEFAULT NULL,
  `division_locality` varchar(255) DEFAULT NULL,
  `division_administrative_area` varchar(255) DEFAULT NULL,
  `division_sub_administrative_area` varchar(255) DEFAULT NULL,
  `division_postal_code` varchar(255) DEFAULT NULL,
  `division_country` varchar(2) NOT NULL,
  `bank_internal_account_ref` varchar(32) NOT NULL,
  `bank_account_name` varchar(32) DEFAULT NULL,
  `bank_account_number` varchar(32) DEFAULT NULL,
  `bank_sort_code` varchar(10) DEFAULT NULL,
  `bank_iban` varchar(34) DEFAULT NULL,
  `bank_swift_bic` varchar(11) DEFAULT NULL,
  `bank_use_bic_and_iban` tinyint(4) DEFAULT 1,
  `sales_tax_number` varchar(30) DEFAULT NULL,
  `total_amount_paid_sale_currency` decimal(10,2) DEFAULT 0.00,
  `amount_outstanding_sale_currency` decimal(10,2) DEFAULT 0.00,
  `invoice_total_sale_currency` decimal(10,2) GENERATED ALWAYS AS (`amount_outstanding_sale_currency` + `total_amount_paid_sale_currency`) VIRTUAL,
  `pdf_footer` longtext DEFAULT '',
  `primary_invoice_address_id` bigint(20) DEFAULT NULL,
  `period_posted_id` bigint(20) DEFAULT NULL,
  `period_fully_paid_id` bigint(20) DEFAULT NULL,
  `date_fully_paid` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `sale_currency_id` (`sale_currency_id`),
  KEY `invoice_number_id` (`invoice_number_id`),
  KEY `bank_id` (`bank_id`),
  KEY `period_posted_id` (`period_posted_id`),
  KEY `period_fully_paid_id` (`period_fully_paid_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_ibfk_10` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `invoice_ibfk_11` FOREIGN KEY (`period_posted_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `invoice_ibfk_12` FOREIGN KEY (`period_fully_paid_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `invoice_ibfk_13` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `invoice_ibfk_5` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `invoice_ibfk_6` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `invoice_ibfk_7` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `invoice_ibfk_8` FOREIGN KEY (`sale_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `invoice_ibfk_9` FOREIGN KEY (`invoice_number_id`) REFERENCES `invoice_number` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_outstanding_amount_before_update BEFORE UPDATE ON invoice FOR EACH ROW BEGIN
        SET NEW.amount_outstanding = IFNULL((SELECT (SUM(li.gross_total)) - (NEW.total_amount_paid) FROM invoice_item li WHERE li.invoice_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_outstanding_amount_in_currency_before_update BEFORE UPDATE ON invoice FOR EACH ROW BEGIN
        SET NEW.amount_outstanding_sale_currency = IFNULL((SELECT (SUM(li.gross_total_in_currency)) - (NEW.total_amount_paid_sale_currency) FROM invoice_item li WHERE li.invoice_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoice_item`
--

DROP TABLE IF EXISTS `invoice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.invoice_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) NOT NULL,
  `quote_item_id` bigint(20) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `price` decimal(10,2) DEFAULT 0.00,
  `price_in_currency` decimal(10,2) DEFAULT 0.00,
  `discount` decimal(11,2) DEFAULT 0.00,
  `discount_in_currency` decimal(11,2) DEFAULT 0.00,
  `same_as_original` tinyint(4) DEFAULT 1,
  `net_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`price` - `discount`)) VIRTUAL,
  `net_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`price_in_currency` - `discount_in_currency`)) VIRTUAL,
  `description` text NOT NULL,
  `allow_discounts` tinyint(4) DEFAULT 1,
  `is_taxable` tinyint(4) DEFAULT 1,
  `tax_percent` varchar(255) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  `gross_total` decimal(10,2) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `gross_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_name` varchar(50) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `general_ledger_code_code` varchar(255) DEFAULT NULL,
  `general_ledger_code_description` varchar(255) DEFAULT NULL,
  `general_ledger_code_category` varchar(255) DEFAULT NULL,
  `tax_code_code` varchar(255) DEFAULT NULL,
  `tax_code_description` varchar(255) DEFAULT NULL,
  `tax_code_amount` decimal(5,2) DEFAULT NULL,
  `is_progress_and_reducible` tinyint(4) DEFAULT 0,
  `avalara_tax_code` varchar(25) DEFAULT NULL,
  `override_tax_in_tax_integration` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `quote_item_id` (`quote_item_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `job_id` (`job_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  CONSTRAINT `invoice_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_item_ibfk_10` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `invoice_item_ibfk_11` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `invoice_item_ibfk_12` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `invoice_item_ibfk_13` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `invoice_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_item_ibfk_4` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_item_ibfk_5` FOREIGN KEY (`quote_item_id`) REFERENCES `quote_item` (`id`),
  CONSTRAINT `invoice_item_ibfk_6` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `invoice_item_ibfk_7` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `invoice_item_ibfk_8` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `invoice_item_ibfk_9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_outstanding_amount_after_item_insert AFTER INSERT ON invoice_item FOR EACH ROW BEGIN
        UPDATE invoice i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM invoice_item li WHERE li.invoice_id = i.id) WHERE i.id = NEW.invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_outstanding_amount_in_currency_after_item_insert AFTER INSERT ON invoice_item FOR EACH ROW BEGIN
        UPDATE invoice i SET i.amount_outstanding_sale_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_sale_currency) FROM invoice_item li WHERE li.invoice_id = i.id) WHERE i.id = NEW.invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amount_outstanding_after_insert_invoice_item AFTER INSERT ON invoice_item FOR EACH ROW BEGIN
        UPDATE sales_order so INNER JOIN sales_order_item soi ON soi.sales_order_id = so.id SET so.invoice_amount_outstanding = (
            (SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE soi.id = NEW.sales_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amnt_OS_in_currency_after_insert_invoice_item AFTER INSERT ON invoice_item FOR EACH ROW BEGIN
        UPDATE sales_order so INNER JOIN sales_order_item soi ON soi.sales_order_id = so.id SET so.invoice_amount_outstanding_in_currency = (
            (SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total_in_currency), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE soi.id = NEW.sales_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_outstanding_amount_after_item_update AFTER UPDATE ON invoice_item FOR EACH ROW BEGIN
        UPDATE invoice i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM invoice_item li WHERE li.invoice_id = i.id) WHERE i.id = NEW.invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_outstanding_amount_in_currency_after_item_update AFTER UPDATE ON invoice_item FOR EACH ROW BEGIN
        UPDATE invoice i SET i.amount_outstanding_sale_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_sale_currency) FROM invoice_item li WHERE li.invoice_id = i.id) WHERE i.id = NEW.invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amount_outstanding_after_update_invoice_item AFTER UPDATE ON invoice_item FOR EACH ROW BEGIN
        UPDATE sales_order so INNER JOIN sales_order_item soi ON soi.sales_order_id = so.id SET so.invoice_amount_outstanding = (
            (SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE soi.id = NEW.sales_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amnt_OS_in_currency_after_update_invoice_item AFTER UPDATE ON invoice_item FOR EACH ROW BEGIN
        UPDATE sales_order so INNER JOIN sales_order_item soi ON soi.sales_order_id = so.id SET so.invoice_amount_outstanding_in_currency = (
            (SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total_in_currency), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE soi.id = NEW.sales_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amount_outstanding_after_delete_invoice_item AFTER DELETE ON invoice_item FOR EACH ROW BEGIN
        UPDATE sales_order so INNER JOIN sales_order_item soi ON soi.sales_order_id = so.id SET so.invoice_amount_outstanding = (
            (SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE soi.id = OLD.sales_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amnt_OS_in_currency_after_delete_invoice_item AFTER DELETE ON invoice_item FOR EACH ROW BEGIN
        UPDATE sales_order so INNER JOIN sales_order_item soi ON soi.sales_order_id = so.id SET so.invoice_amount_outstanding_in_currency = (
            (SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total_in_currency), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE soi.id = OLD.sales_order_item_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoice_number`
--

DROP TABLE IF EXISTS `invoice_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.invoice_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `invoice_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `invoice_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_long_description`
--

DROP TABLE IF EXISTS `item_long_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.item_long_description` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `quote_item_id` bigint(20) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `purchase_order_item_id` bigint(20) DEFAULT NULL,
  `note_text` longtext DEFAULT '',
  `note_raw` longtext DEFAULT '',
  `html` longtext DEFAULT '',
  `images_width` smallint(5) unsigned DEFAULT 0,
  `add_to_pdf` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  KEY `quote_item_id` (`quote_item_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `purchase_order_item_id` (`purchase_order_item_id`),
  CONSTRAINT `item_long_description_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `item_long_description_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `item_long_description_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `item_long_description_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_long_description_ibfk_5` FOREIGN KEY (`quote_item_id`) REFERENCES `quote_item` (`id`),
  CONSTRAINT `item_long_description_ibfk_6` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `item_long_description_ibfk_7` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `purchase_order_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `contract_manager_id` bigint(20) DEFAULT NULL,
  `job_manager_id` bigint(20) DEFAULT NULL,
  `type_id` bigint(20) NOT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `assembly_location_id` bigint(20) DEFAULT NULL,
  `stage_id` bigint(20) NOT NULL,
  `parent_job_id` bigint(20) DEFAULT NULL,
  `master_job_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `non_compliance_report_id` bigint(20) DEFAULT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `operation_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `schedule_period` bigint(20) DEFAULT 0,
  `preferred_scheduled_date` datetime DEFAULT NULL,
  `target_completion_date` date DEFAULT NULL,
  `details` text DEFAULT NULL,
  `progress` smallint(6) DEFAULT 0,
  `priority` varchar(50) NOT NULL,
  `duration` bigint(20) DEFAULT 0,
  `service_level_agreement` tinyint(4) DEFAULT 0,
  `draft` tinyint(4) DEFAULT 1,
  `complete` tinyint(4) DEFAULT 0,
  `hold` tinyint(4) DEFAULT 0,
  `cancelled` tinyint(4) DEFAULT 0,
  `escalated` tinyint(4) DEFAULT 0,
  `time_managed` tinyint(4) DEFAULT 0,
  `allow_time_to_be_booked` tinyint(4) DEFAULT 1,
  `requires_scheduling` tinyint(4) DEFAULT 0,
  `is_template` tinyint(1) DEFAULT 0,
  `template_name` varchar(50) DEFAULT NULL,
  `template_description` varchar(255) DEFAULT NULL,
  `allocated_time` int(11) DEFAULT NULL,
  `low_hour_threshold` int(11) DEFAULT NULL,
  `remaining_time` int(11) DEFAULT NULL,
  `product_quantity` int(11) DEFAULT 0,
  `product_quantity_assembled` int(11) DEFAULT 0,
  `product_quantity_failed` int(11) DEFAULT 0,
  `job_number_id` bigint(20) DEFAULT NULL,
  `job_template_number_id` bigint(20) DEFAULT NULL,
  `customer_alias` varchar(255) DEFAULT NULL,
  `customer_account_number` varchar(50) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `currency_name` varchar(41) NOT NULL,
  `currency_symbol` varchar(3) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `job_manager_name` varchar(255) DEFAULT NULL,
  `contract_manager_name` varchar(255) DEFAULT NULL,
  `product_sku` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `job_stage_name` varchar(50) NOT NULL,
  `job_type_name` varchar(100) NOT NULL,
  `bom_output_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `bom_output_quantity` decimal(20,10) DEFAULT 1.0000000000,
  `auto_allocate` tinyint(1) NOT NULL DEFAULT 1,
  `is_top_level` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_name` (`template_name`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `person_id` (`person_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `location_id` (`location_id`),
  KEY `currency_id` (`currency_id`),
  KEY `contract_manager_id` (`contract_manager_id`),
  KEY `job_manager_id` (`job_manager_id`),
  KEY `project_id` (`project_id`),
  KEY `type_id` (`type_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `stage_id` (`stage_id`),
  KEY `parent_job_id` (`parent_job_id`),
  KEY `master_job_id` (`master_job_id`),
  KEY `product_id` (`product_id`),
  KEY `operation_id` (`operation_id`),
  KEY `bom_output_unit_of_measure_id` (`bom_output_unit_of_measure_id`),
  KEY `branch_id` (`branch_id`),
  KEY `priority` (`priority`),
  KEY `preferred_scheduled_date` (`preferred_scheduled_date`),
  KEY `job_number_id` (`job_number_id`),
  KEY `job_template_number_id` (`job_template_number_id`),
  KEY `asset_id` (`asset_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `non_compliance_report_id` (`non_compliance_report_id`),
  CONSTRAINT `job_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_ibfk_10` FOREIGN KEY (`contract_manager_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `job_ibfk_11` FOREIGN KEY (`job_manager_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `job_ibfk_12` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `job_ibfk_13` FOREIGN KEY (`type_id`) REFERENCES `job_type` (`id`),
  CONSTRAINT `job_ibfk_14` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `job_ibfk_15` FOREIGN KEY (`stage_id`) REFERENCES `job_stage` (`id`),
  CONSTRAINT `job_ibfk_16` FOREIGN KEY (`parent_job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `job_ibfk_17` FOREIGN KEY (`master_job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `job_ibfk_18` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `job_ibfk_19` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE SET NULL,
  CONSTRAINT `job_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_ibfk_20` FOREIGN KEY (`bom_output_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `job_ibfk_21` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `job_ibfk_22` FOREIGN KEY (`job_number_id`) REFERENCES `job_number` (`id`),
  CONSTRAINT `job_ibfk_23` FOREIGN KEY (`job_template_number_id`) REFERENCES `job_template_number` (`id`),
  CONSTRAINT `job_ibfk_24` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `job_ibfk_25` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `job_ibfk_26` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `job_ibfk_27` FOREIGN KEY (`non_compliance_report_id`) REFERENCES `non_compliance_report` (`id`),
  CONSTRAINT `job_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `job_ibfk_5` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `job_ibfk_6` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `job_ibfk_7` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `job_ibfk_8` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `job_ibfk_9` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_cost`
--

DROP TABLE IF EXISTS `job_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `invoice_cost` decimal(10,2) NOT NULL,
  `for_invoice` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `job_cost_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_cost_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_cost_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_cost_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_item`
--

DROP TABLE IF EXISTS `job_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `unit_of_measure_id` bigint(20) NOT NULL,
  `quantity` decimal(20,10) DEFAULT 0.0000000000,
  `backorder_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `allocated_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `inspected_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `moved_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `disposed_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `consumed_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `include_cost` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  CONSTRAINT `job_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_item_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `job_item_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `job_item_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_number`
--

DROP TABLE IF EXISTS `job_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `job_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_resource_tag`
--

DROP TABLE IF EXISTS `job_resource_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_resource_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `resource_tag_name_id` bigint(20) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `resource_tag_name_id` (`resource_tag_name_id`),
  CONSTRAINT `job_resource_tag_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_resource_tag_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_resource_tag_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_resource_tag_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `job_resource_tag_ibfk_5` FOREIGN KEY (`resource_tag_name_id`) REFERENCES `resource_tag_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_stage`
--

DROP TABLE IF EXISTS `job_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_stage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_type_id` bigint(20) NOT NULL,
  `stage_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_type_id` (`job_type_id`),
  CONSTRAINT `job_stage_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_stage_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_stage_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_stage_ibfk_4` FOREIGN KEY (`job_type_id`) REFERENCES `job_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_template_number`
--

DROP TABLE IF EXISTS `job_template_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_template_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `job_template_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_template_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_time_sheet`
--

DROP TABLE IF EXISTS `job_time_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_time_sheet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `master_job_id` bigint(20) DEFAULT NULL,
  `parent_job_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) NOT NULL,
  `start_date` date NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `is_chargeable` tinyint(4) DEFAULT NULL,
  `time_used` int(11) NOT NULL,
  `time_chargeable` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  `details` text DEFAULT NULL,
  `engineer_notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `master_job_id` (`master_job_id`),
  KEY `job_id` (`job_id`),
  KEY `employee_id` (`employee_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  CONSTRAINT `job_time_sheet_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_time_sheet_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_time_sheet_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_time_sheet_ibfk_4` FOREIGN KEY (`master_job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `job_time_sheet_ibfk_5` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `job_time_sheet_ibfk_6` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `job_time_sheet_ibfk_7` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_titles`
--

DROP TABLE IF EXISTS `job_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_titles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `job_titles_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_titles_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_titles_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_type`
--

DROP TABLE IF EXISTS `job_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.job_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `type_category` enum('Manufacturing/Assembly/Build','Inspection/QA','Other') NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `color` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `job_type_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_type_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `job_type_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labour_cost`
--

DROP TABLE IF EXISTS `labour_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.labour_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  `duration` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `finish_time` datetime NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `invoice_cost` decimal(10,2) NOT NULL,
  `description` varchar(255) NOT NULL,
  `for_invoice` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `labour_cost_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `labour_cost_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `labour_cost_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `labour_cost_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `labour_cost_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lat_long`
--

DROP TABLE IF EXISTS `lat_long`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.lat_long` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  CONSTRAINT `lat_long_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `lat_long_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `list_configuration`
--

DROP TABLE IF EXISTS `list_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.list_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `user_id` bigint(20) DEFAULT NULL,
  `list_name` varchar(50) NOT NULL,
  `configuration` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`list_name`),
  CONSTRAINT `list_configuration_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `address_id` bigint(20) DEFAULT NULL,
  `lat_long_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `address_id` (`address_id`),
  KEY `lat_long_id` (`lat_long_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `location_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `location_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `location_ibfk_4` FOREIGN KEY (`address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `location_ibfk_5` FOREIGN KEY (`lat_long_id`) REFERENCES `lat_long` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maintenance_schedule`
--

DROP TABLE IF EXISTS `maintenance_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.maintenance_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `contract_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `display_label` varchar(255) DEFAULT NULL,
  `priority` enum('Low','Medium','High') NOT NULL,
  `frequency` enum('Daily','Weekly','Every two weeks','Monthly','Quarterly','6 monthly') NOT NULL,
  `preferred_start_date` datetime DEFAULT NULL,
  `duration` bigint(20) DEFAULT 0,
  `job_required` tinyint(4) DEFAULT 0,
  `schedule_job` tinyint(4) DEFAULT 0,
  `included_in_planning` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `contract_id` (`contract_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `maintenance_schedule_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `maintenance_schedule_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `maintenance_schedule_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `maintenance_schedule_ibfk_4` FOREIGN KEY (`contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `maintenance_schedule_ibfk_5` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maintenance_schedule_resource_tag`
--

DROP TABLE IF EXISTS `maintenance_schedule_resource_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.maintenance_schedule_resource_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `schedule_id` bigint(20) NOT NULL,
  `resource_tag_name_id` bigint(20) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `resource_tag_name_id` (`resource_tag_name_id`),
  CONSTRAINT `maintenance_schedule_resource_tag_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `maintenance_schedule_resource_tag_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `maintenance_schedule_resource_tag_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `maintenance_schedule_resource_tag_ibfk_4` FOREIGN KEY (`schedule_id`) REFERENCES `maintenance_schedule` (`id`),
  CONSTRAINT `maintenance_schedule_resource_tag_ibfk_5` FOREIGN KEY (`resource_tag_name_id`) REFERENCES `resource_tag_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager_managee`
--

DROP TABLE IF EXISTS `manager_managee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.manager_managee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) NOT NULL,
  `managee_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `manager_id` (`manager_id`),
  KEY `managee_id` (`managee_id`),
  CONSTRAINT `manager_managee_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `manager_managee_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `manager_managee_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `manager_managee_ibfk_4` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `manager_managee_ibfk_5` FOREIGN KEY (`managee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `miscellaneous_setting`
--

DROP TABLE IF EXISTS `miscellaneous_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.miscellaneous_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `unique_key` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `validation_regex` text NOT NULL,
  `validation_message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `national_holiday`
--

DROP TABLE IF EXISTS `national_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.national_holiday` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `holiday_date` date NOT NULL,
  `holiday_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net_total_discount`
--

DROP TABLE IF EXISTS `net_total_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.net_total_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `net_total_discount_breakpoint` int(11) NOT NULL,
  `discount_percentage` decimal(7,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `net_total_discount_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `net_total_discount_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `net_total_discount_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `net_total_discount_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nominal_journal`
--

DROP TABLE IF EXISTS `nominal_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.nominal_journal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `internal_reference` varchar(20) DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `description` varchar(50) NOT NULL,
  `accounting_period_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `type` enum('Reversing','Non-Reversing') DEFAULT NULL,
  `special_ye_adjustment` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `accounting_period_id` (`accounting_period_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `nominal_journal_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `nominal_journal_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `nominal_journal_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `nominal_journal_ibfk_4` FOREIGN KEY (`accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `nominal_journal_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nominal_journal_item`
--

DROP TABLE IF EXISTS `nominal_journal_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.nominal_journal_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `nominal_journal_id` bigint(20) NOT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `trading_company_gl_code_prefix` varchar(3) DEFAULT NULL,
  `division_gl_code_prefix` varchar(3) DEFAULT NULL,
  `department_gl_code_prefix` varchar(3) DEFAULT NULL,
  `description` varchar(40) NOT NULL,
  `debit` decimal(10,2) DEFAULT 0.00,
  `credit` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `input_output_VAT` enum('Input','Output') DEFAULT NULL,
  `tax_gl_code_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `nominal_journal_id` (`nominal_journal_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `tax_gl_code_id` (`tax_gl_code_id`),
  CONSTRAINT `nominal_journal_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_4` FOREIGN KEY (`nominal_journal_id`) REFERENCES `nominal_journal` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_5` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_6` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_7` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `nominal_journal_item_ibfk_8` FOREIGN KEY (`tax_gl_code_id`) REFERENCES `general_ledger_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `non_compliance_report`
--

DROP TABLE IF EXISTS `non_compliance_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.non_compliance_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `priority` varchar(6) NOT NULL,
  `description` varchar(255) NOT NULL,
  `action_taken` varchar(255) DEFAULT NULL,
  `prevention` varchar(255) DEFAULT NULL,
  `additional_information` text DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `completed` tinyint(4) DEFAULT 0,
  `cancelled` tinyint(4) DEFAULT 0,
  `draft` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `non_compliance_report_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `non_compliance_report_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `non_compliance_report_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `non_compliance_report_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `non_compliance_report_ibfk_5` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `non_compliance_report_ibfk_6` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `note_text` longtext DEFAULT '',
  `note_raw` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `note_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `note_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `note_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note_relation`
--

DROP TABLE IF EXISTS `note_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.note_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `note_id` bigint(20) NOT NULL,
  `absence_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `customer_remittance_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `disciplinary_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `email_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `non_compliance_report_id` bigint(20) DEFAULT NULL,
  `opportunity_id` bigint(20) DEFAULT NULL,
  `operation_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `resource_group_id` bigint(20) DEFAULT NULL,
  `resource_tag_name_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `service_contract_id` bigint(20) DEFAULT NULL,
  `site_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `product_batch_id` bigint(20) DEFAULT NULL,
  `product_unit_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `sales_pipeline_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `warehouse_location_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `application_user_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_category_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) DEFAULT NULL,
  `type` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `note_id` (`note_id`),
  KEY `absence_id` (`absence_id`),
  KEY `asset_id` (`asset_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `company_id` (`company_id`),
  KEY `contact_id` (`contact_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `customer_id` (`customer_id`),
  KEY `customer_remittance_id` (`customer_remittance_id`),
  KEY `department_id` (`department_id`),
  KEY `document_id` (`document_id`),
  KEY `division_id` (`division_id`),
  KEY `disciplinary_id` (`disciplinary_id`),
  KEY `email_id` (`email_id`),
  KEY `employee_id` (`employee_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `job_id` (`job_id`),
  KEY `non_compliance_report_id` (`non_compliance_report_id`),
  KEY `opportunity_id` (`opportunity_id`),
  KEY `operation_id` (`operation_id`),
  KEY `product_id` (`product_id`),
  KEY `project_id` (`project_id`),
  KEY `quote_id` (`quote_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_group_id` (`resource_group_id`),
  KEY `resource_tag_name_id` (`resource_tag_name_id`),
  KEY `returns_authorisation_id` (`returns_authorisation_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `service_contract_id` (`service_contract_id`),
  KEY `site_id` (`site_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  KEY `sales_pipeline_id` (`sales_pipeline_id`),
  KEY `product_unit_id` (`product_unit_id`),
  KEY `product_batch_id` (`product_batch_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  KEY `warehouse_location_id` (`warehouse_location_id`),
  KEY `application_user_id` (`application_user_id`),
  KEY `task_id` (`task_id`),
  KEY `branch_id` (`branch_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `general_ledger_code_category_id` (`general_ledger_code_category_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `note_relation_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`),
  CONSTRAINT `note_relation_ibfk_10` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `note_relation_ibfk_11` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  CONSTRAINT `note_relation_ibfk_12` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `note_relation_ibfk_13` FOREIGN KEY (`disciplinary_id`) REFERENCES `staff_disciplinary` (`id`),
  CONSTRAINT `note_relation_ibfk_14` FOREIGN KEY (`email_id`) REFERENCES `email` (`id`),
  CONSTRAINT `note_relation_ibfk_15` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `note_relation_ibfk_16` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `note_relation_ibfk_17` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `note_relation_ibfk_18` FOREIGN KEY (`non_compliance_report_id`) REFERENCES `non_compliance_report` (`id`),
  CONSTRAINT `note_relation_ibfk_19` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`),
  CONSTRAINT `note_relation_ibfk_2` FOREIGN KEY (`absence_id`) REFERENCES `absence` (`id`),
  CONSTRAINT `note_relation_ibfk_20` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`),
  CONSTRAINT `note_relation_ibfk_21` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `note_relation_ibfk_22` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `note_relation_ibfk_23` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `note_relation_ibfk_24` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `note_relation_ibfk_25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `note_relation_ibfk_26` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`id`),
  CONSTRAINT `note_relation_ibfk_27` FOREIGN KEY (`resource_tag_name_id`) REFERENCES `resource_tag_name` (`id`),
  CONSTRAINT `note_relation_ibfk_28` FOREIGN KEY (`returns_authorisation_id`) REFERENCES `returns_authorisation` (`id`),
  CONSTRAINT `note_relation_ibfk_29` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `note_relation_ibfk_3` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `note_relation_ibfk_30` FOREIGN KEY (`service_contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `note_relation_ibfk_31` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`),
  CONSTRAINT `note_relation_ibfk_32` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `note_relation_ibfk_33` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `note_relation_ibfk_34` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `note_relation_ibfk_35` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `note_relation_ibfk_36` FOREIGN KEY (`sales_pipeline_id`) REFERENCES `sales_pipeline` (`id`),
  CONSTRAINT `note_relation_ibfk_37` FOREIGN KEY (`product_unit_id`) REFERENCES `product_unit` (`id`),
  CONSTRAINT `note_relation_ibfk_38` FOREIGN KEY (`product_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `note_relation_ibfk_39` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `note_relation_ibfk_4` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `note_relation_ibfk_40` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`),
  CONSTRAINT `note_relation_ibfk_41` FOREIGN KEY (`warehouse_location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `note_relation_ibfk_42` FOREIGN KEY (`application_user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `note_relation_ibfk_43` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `note_relation_ibfk_44` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `note_relation_ibfk_45` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `note_relation_ibfk_46` FOREIGN KEY (`general_ledger_code_category_id`) REFERENCES `general_ledger_code_category` (`id`),
  CONSTRAINT `note_relation_ibfk_47` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `note_relation_ibfk_48` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `note_relation_ibfk_5` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `note_relation_ibfk_6` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `note_relation_ibfk_7` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `note_relation_ibfk_8` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `note_relation_ibfk_9` FOREIGN KEY (`customer_remittance_id`) REFERENCES `customer_remittance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `sender_id` bigint(20) DEFAULT NULL,
  `recipient_id` bigint(20) NOT NULL,
  `type` varchar(25) NOT NULL,
  `body` varchar(255) NOT NULL,
  `notified` tinyint(4) DEFAULT 0,
  `read` tinyint(4) DEFAULT 0,
  `cleared` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `recipient_id` (`recipient_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_relation`
--

DROP TABLE IF EXISTS `notification_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.notification_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) NOT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `job_id` (`job_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `notification_relation_ibfk_1` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`),
  CONSTRAINT `notification_relation_ibfk_2` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `notification_relation_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `notification_relation_ibfk_4` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation`
--

DROP TABLE IF EXISTS `operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.operation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `resource_tag_name_id` bigint(20) NOT NULL,
  `resource_tag_quantity` bigint(20) DEFAULT NULL,
  `completed_by_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `name` text NOT NULL,
  `description` text DEFAULT NULL,
  `duration` bigint(20) DEFAULT 0,
  `completed_date` datetime DEFAULT NULL,
  `requires_subcontract_work` tinyint(1) DEFAULT 0,
  `supplier_part_number` varchar(50) DEFAULT NULL,
  `cost_price` decimal(13,5) DEFAULT NULL,
  `requires_duration` tinyint(1) DEFAULT 0,
  `auto_complete_by_childjob` tinyint(1) DEFAULT 0,
  `child_job_number` text DEFAULT NULL,
  `set_up_duration` bigint(20) DEFAULT 0,
  `run_duration` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `completed_by_id` (`completed_by_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `product_id` (`product_id`),
  KEY `resource_tag_name_id` (`resource_tag_name_id`),
  CONSTRAINT `operation_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_ibfk_4` FOREIGN KEY (`completed_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_ibfk_5` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `operation_ibfk_6` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_ibfk_7` FOREIGN KEY (`resource_tag_name_id`) REFERENCES `resource_tag_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation_bill_of_materials`
--

DROP TABLE IF EXISTS `operation_bill_of_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.operation_bill_of_materials` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_id` bigint(20) NOT NULL,
  `bill_of_materials_id` bigint(20) NOT NULL,
  `quantity` decimal(20,10) DEFAULT 0.0000000000,
  PRIMARY KEY (`id`),
  KEY `operation_id` (`operation_id`),
  KEY `bill_of_materials_id` (`bill_of_materials_id`),
  CONSTRAINT `operation_bill_of_materials_ibfk_1` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`),
  CONSTRAINT `operation_bill_of_materials_ibfk_2` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `bill_of_materials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation_dependency`
--

DROP TABLE IF EXISTS `operation_dependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.operation_dependency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_id` bigint(20) NOT NULL,
  `depends_on_operation_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `operation_id` (`operation_id`),
  KEY `depends_on_operation_id` (`depends_on_operation_id`),
  CONSTRAINT `operation_dependency_ibfk_1` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`),
  CONSTRAINT `operation_dependency_ibfk_2` FOREIGN KEY (`depends_on_operation_id`) REFERENCES `operation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation_schedule`
--

DROP TABLE IF EXISTS `operation_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.operation_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `operation_id` bigint(20) NOT NULL,
  `start_offset` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `operation_id` (`operation_id`),
  CONSTRAINT `operation_schedule_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_schedule_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_schedule_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `operation_schedule_ibfk_4` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity`
--

DROP TABLE IF EXISTS `opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.opportunity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) NOT NULL,
  `sales_pipeline_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `percentage` smallint(6) DEFAULT 0,
  `value` decimal(10,2) DEFAULT 0.00,
  `won` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `trading_company_id` bigint(20) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_account_number` varchar(50) DEFAULT NULL,
  `manager_name` varchar(255) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `prospect_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `manager_id` (`manager_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `contact_id` (`contact_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `sales_pipeline_id` (`sales_pipeline_id`),
  CONSTRAINT `opportunity_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `opportunity_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `opportunity_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `opportunity_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `opportunity_ibfk_5` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `opportunity_ibfk_6` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `opportunity_ibfk_7` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `opportunity_ibfk_8` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `opportunity_ibfk_9` FOREIGN KEY (`sales_pipeline_id`) REFERENCES `sales_pipeline` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity_additional_cost`
--

DROP TABLE IF EXISTS `opportunity_additional_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.opportunity_additional_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `opportunity_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `cost` decimal(13,5) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `include_cost` tinyint(1) DEFAULT 1,
  `total_cost` decimal(13,5) GENERATED ALWAYS AS (`cost` * `quantity`) VIRTUAL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `opportunity_id` (`opportunity_id`),
  CONSTRAINT `opportunity_additional_cost_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `opportunity_additional_cost_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `opportunity_additional_cost_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `opportunity_additional_cost_ibfk_4` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `packaging_type`
--

DROP TABLE IF EXISTS `packaging_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.packaging_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `packaging_type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `packaging_type_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `packaging_type_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `packaging_type_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_reset_token`
--

DROP TABLE IF EXISTS `password_reset_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.password_reset_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `application_user_id` bigint(20) NOT NULL,
  `token` varchar(36) NOT NULL,
  `token_expiry_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `application_user_id` (`application_user_id`),
  CONSTRAINT `password_reset_token_ibfk_1` FOREIGN KEY (`application_user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  `payment_reference` varchar(255) DEFAULT NULL,
  `cheque_number` varchar(20) DEFAULT NULL,
  `payment_made_on` date DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT 0.00,
  `amount_paid_in_currency` decimal(10,2) DEFAULT 0.00,
  `currency_id` bigint(20) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `supplier_remittance_id` bigint(20) DEFAULT NULL,
  `period_posted_id` bigint(20) DEFAULT NULL,
  `period_fully_matched_id` bigint(20) DEFAULT NULL,
  `date_fully_matched` date DEFAULT NULL,
  `matched` tinyint(4) DEFAULT 0,
  `amount_unmatched` decimal(10,2) DEFAULT 0.00,
  `amount_unmatched_in_currency` decimal(10,2) DEFAULT 0.00,
  `matched_payment_id` bigint(20) DEFAULT NULL,
  `exchange_difference` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  KEY `period_posted_id` (`period_posted_id`),
  KEY `period_fully_matched_id` (`period_fully_matched_id`),
  KEY `matched_payment_id` (`matched_payment_id`),
  KEY `bank_id` (`bank_id`),
  KEY `payment_method_id` (`payment_method_id`),
  KEY `currency_id` (`currency_id`),
  KEY `supplier_remittance_id` (`supplier_remittance_id`),
  KEY `customer_name` (`customer_name`),
  KEY `payment_made_on` (`payment_made_on`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_ibfk_10` FOREIGN KEY (`period_posted_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `payment_ibfk_11` FOREIGN KEY (`period_fully_matched_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `payment_ibfk_12` FOREIGN KEY (`matched_payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_ibfk_13` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `payment_ibfk_14` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `payment_ibfk_15` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `payment_ibfk_16` FOREIGN KEY (`supplier_remittance_id`) REFERENCES `supplier_remittance` (`id`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `payment_ibfk_5` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `payment_ibfk_6` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `payment_ibfk_7` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `payment_ibfk_8` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `payment_ibfk_9` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_total_amount_paid_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
        UPDATE invoice i SET i.total_amount_paid = ((SELECT SUM(p.amount_paid) FROM payment p WHERE p.invoice_id = i.id) + 0) WHERE i.id = NEW.invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_invoice_total_amount_paid_in_currency_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
        UPDATE invoice i SET i.total_amount_paid_sale_currency = ((SELECT SUM(p.amount_paid_in_currency) FROM payment p WHERE p.invoice_id = i.id) + 0) WHERE i.id = NEW.invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_total_amount_paid_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
        UPDATE credit_note i SET i.total_amount_paid = ((SELECT SUM(-p.amount_paid) FROM payment p WHERE p.credit_note_id = i.id) + 0) WHERE i.id = NEW.credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_credit_note_total_amount_paid_in_currency_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
        UPDATE credit_note i SET i.total_amount_paid_sale_currency = ((SELECT SUM(-p.amount_paid_in_currency) FROM payment p WHERE p.credit_note_id = i.id) + 0) WHERE i.id = NEW.credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_total_amount_paid_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
    UPDATE supplier_invoice i SET i.total_amount_paid = ((SELECT IFNULL(SUM(p.amount_paid), 0) FROM payment p LEFT JOIN supplier_remittance sr ON p.supplier_remittance_id = sr.id WHERE p.supplier_invoice_id = i.id AND sr.is_void <> TRUE)) WHERE i.id = NEW.supplier_invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_total_amnt_paid_in_currency_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
    UPDATE supplier_invoice i SET i.total_amount_paid_purchase_currency = ((SELECT IFNULL(SUM(p.amount_paid_in_currency), 0) FROM payment p LEFT JOIN supplier_remittance sr ON p.supplier_remittance_id = sr.id WHERE p.supplier_invoice_id = i.id AND sr.is_void <> TRUE)) WHERE i.id = NEW.supplier_invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_total_amount_paid_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
        UPDATE supplier_credit_note i SET i.total_amount_paid = ((SELECT IFNULL(SUM(-p.amount_paid), 0) FROM payment p LEFT JOIN supplier_remittance sr ON p.supplier_remittance_id = sr.id WHERE p.supplier_credit_note_id = i.id AND sr.is_void <> TRUE)) WHERE i.id = NEW.supplier_credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_ttl_amt_paid_in_currency_aftr_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
        UPDATE supplier_credit_note i SET i.total_amount_paid_purchase_currency = ((SELECT IFNULL(SUM(-p.amount_paid_in_currency), 0) FROM payment p LEFT JOIN supplier_remittance sr ON p.supplier_remittance_id = sr.id WHERE p.supplier_credit_note_id = i.id AND sr.is_void <> TRUE)) WHERE i.id = NEW.supplier_credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_customer_remittance`
--

DROP TABLE IF EXISTS `payment_customer_remittance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.payment_customer_remittance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `payment_id` bigint(20) NOT NULL,
  `customer_remittance_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `payment_id` (`payment_id`),
  KEY `customer_remittance_id` (`customer_remittance_id`),
  CONSTRAINT `payment_customer_remittance_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_customer_remittance_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_customer_remittance_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_customer_remittance_ibfk_4` FOREIGN KEY (`customer_remittance_id`) REFERENCES `customer_remittance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.payment_method` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `payment_method_name` varchar(30) NOT NULL,
  `editable` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_method_name` (`payment_method_name`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `payment_method_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_method_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `payment_method_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdf_footer`
--

DROP TABLE IF EXISTS `pdf_footer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.pdf_footer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `footer_text` longtext DEFAULT '',
  `footer_image_align` enum('Right','Left') DEFAULT 'Left',
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `pdf_footer_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `pdf_footer_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `pdf_footer_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `pdf_footer_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permitted_warehouse_location`
--

DROP TABLE IF EXISTS `permitted_warehouse_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.permitted_warehouse_location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `location_id` (`location_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `permitted_warehouse_location_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `permitted_warehouse_location_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `permitted_warehouse_location_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `permitted_warehouse_location_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `permitted_warehouse_location_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `title_id` bigint(20) DEFAULT NULL,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `title_id` (`title_id`),
  KEY `surname` (`surname`,`forename`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_ibfk_4` FOREIGN KEY (`title_id`) REFERENCES `title` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.person_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) NOT NULL,
  `postal_address_id` bigint(20) NOT NULL,
  `is_primary` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `person_id` (`person_id`),
  KEY `postal_address_id` (`postal_address_id`),
  CONSTRAINT `person_address_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_address_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_address_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_address_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `person_address_ibfk_5` FOREIGN KEY (`postal_address_id`) REFERENCES `postal_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_email_address`
--

DROP TABLE IF EXISTS `person_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.person_email_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) NOT NULL,
  `email_address_id` bigint(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_primary` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `person_id` (`person_id`),
  KEY `email_address_id` (`email_address_id`),
  CONSTRAINT `person_email_address_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_email_address_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_email_address_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_email_address_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `person_email_address_ibfk_5` FOREIGN KEY (`email_address_id`) REFERENCES `email_address` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_telephone_number`
--

DROP TABLE IF EXISTS `person_telephone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.person_telephone_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) NOT NULL,
  `telephone_number` varchar(25) NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_primary` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_telephone_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_telephone_number_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_telephone_number_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `person_telephone_number_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postal_address`
--

DROP TABLE IF EXISTS `postal_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.postal_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `address_format_id` bigint(20) NOT NULL,
  `thoroughfare` varchar(85) DEFAULT NULL,
  `premise` varchar(85) DEFAULT NULL,
  `locality` varchar(85) DEFAULT NULL,
  `administrative_area` varchar(85) DEFAULT NULL,
  `sub_administrative_area` varchar(85) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `country` varchar(2) NOT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `delivery` tinyint(4) DEFAULT 0,
  `invoice` tinyint(4) DEFAULT 0,
  `correspondence` tinyint(4) DEFAULT 0,
  `primary_invoice` tinyint(4) DEFAULT 0,
  `primary_delivery` tinyint(4) DEFAULT 0,
  `primary_correspondence` tinyint(4) DEFAULT 0,
  `address_name` varchar(100) DEFAULT NULL,
  `is_address_validated` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `address_format_id` (`address_format_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `division_id` (`division_id`),
  KEY `branch_id` (`branch_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `postal_address_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `postal_address_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `postal_address_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `postal_address_ibfk_4` FOREIGN KEY (`address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `postal_address_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `postal_address_ibfk_6` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `postal_address_ibfk_7` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `postal_address_ibfk_8` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_group_purchase_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_purchase_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_group_consume_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_consume_id` bigint(20) DEFAULT NULL,
  `discount_group_id` bigint(20) DEFAULT NULL,
  `preferred_image_id` bigint(20) DEFAULT NULL,
  `packaging_type_id` bigint(20) DEFAULT NULL,
  `gl_code_purchases_id` bigint(20) DEFAULT NULL,
  `gl_code_raw_materials_id` bigint(20) DEFAULT NULL,
  `gl_code_work_in_progress_id` bigint(20) DEFAULT NULL,
  `gl_code_finished_goods_id` bigint(20) DEFAULT NULL,
  `gl_code_sales_id` bigint(20) DEFAULT NULL,
  `preferred_supplier_id` bigint(20) DEFAULT NULL,
  `top_level_sku_id` bigint(20) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `bom_output_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `stock_category_id` bigint(20) DEFAULT NULL,
  `bom_output_quantity` decimal(20,10) DEFAULT 1.0000000000,
  `consumption_multiplier` int(11) DEFAULT NULL,
  `stock_values_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `ean` varchar(13) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `sku` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `manufacturer_part_number` varchar(50) DEFAULT NULL,
  `preferred_minimum_order_quanity` int(11) DEFAULT 0,
  `pricing_method` enum('Manual','Margin %','Markup %') NOT NULL DEFAULT 'Manual',
  `costing_method` varchar(20) NOT NULL DEFAULT 'manual',
  `price_modifier` decimal(12,4) DEFAULT NULL,
  `cost_price` decimal(17,9) NOT NULL DEFAULT 0.000000000,
  `cost_price_display` decimal(10,2) DEFAULT 0.00,
  `normal_sell_price` decimal(17,9) NOT NULL DEFAULT 0.000000000,
  `normal_sell_price_display` decimal(10,2) DEFAULT 0.00,
  `minimum_sell_price` decimal(17,9) NOT NULL DEFAULT 0.000000000,
  `minimum_sell_price_display` decimal(10,2) DEFAULT 0.00,
  `maximum_sell_price` decimal(17,9) NOT NULL DEFAULT 0.000000000,
  `maximum_sell_price_display` decimal(10,2) DEFAULT 0.00,
  `cost_price_display_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `sell_price_display_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `height_including_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `width_including_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `depth_including_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `weight_including_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `volume_including_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `height_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `width_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `depth_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `weight_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `volume_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `width_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `height_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `depth_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `weight_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `volume_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `width_including_packaging` decimal(10,2) DEFAULT NULL,
  `height_including_packaging` decimal(10,2) DEFAULT NULL,
  `depth_including_packaging` decimal(10,2) DEFAULT NULL,
  `weight_including_packaging` decimal(10,2) DEFAULT NULL,
  `volume_including_packaging` decimal(10,2) DEFAULT NULL,
  `base_unit_of_measure` varchar(20) NOT NULL,
  `allocation_method` enum('FIFO','LIFO','LCF','HCF','SELECT') DEFAULT NULL,
  `strict_allocation_unit` tinyint(4) NOT NULL DEFAULT 0,
  `strict_allocation_batch` tinyint(4) NOT NULL DEFAULT 0,
  `batch_tracked` tinyint(4) NOT NULL DEFAULT 0,
  `unit_tracked` tinyint(4) NOT NULL DEFAULT 0,
  `managed` tinyint(4) NOT NULL DEFAULT 1,
  `vendor_restricted` tinyint(4) NOT NULL DEFAULT 0,
  `available_quote` tinyint(4) NOT NULL DEFAULT 1,
  `available_point_of_sale` tinyint(4) NOT NULL DEFAULT 1,
  `available_sales_order` tinyint(4) NOT NULL DEFAULT 1,
  `available_invoice` tinyint(4) NOT NULL DEFAULT 1,
  `available_purchase_order` tinyint(4) NOT NULL DEFAULT 1,
  `available_shipping` tinyint(4) NOT NULL DEFAULT 1,
  `available_job` tinyint(4) NOT NULL DEFAULT 1,
  `is_taxable` tinyint(4) NOT NULL DEFAULT 0,
  `is_deliverable` tinyint(4) NOT NULL DEFAULT 1,
  `auto_order` tinyint(4) NOT NULL DEFAULT 1,
  `is_assembly` tinyint(4) NOT NULL DEFAULT 0,
  `build_to_order` tinyint(4) NOT NULL DEFAULT 0,
  `is_bulk` tinyint(4) NOT NULL DEFAULT 0,
  `is_consumable` tinyint(4) NOT NULL DEFAULT 0,
  `is_top_level` tinyint(4) NOT NULL DEFAULT 0,
  `is_contract` tinyint(4) NOT NULL DEFAULT 0,
  `allow_discounts` tinyint(4) NOT NULL DEFAULT 1,
  `is_drop_shippable` tinyint(4) NOT NULL DEFAULT 0,
  `is_internally_replenished` tinyint(4) NOT NULL DEFAULT 0,
  `is_measured_by_area` tinyint(4) NOT NULL DEFAULT 0,
  `is_customer_owned` tinyint(4) NOT NULL DEFAULT 0,
  `draft` tinyint(4) NOT NULL DEFAULT 1,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `minimum_shipping_quantity` decimal(20,10) DEFAULT NULL,
  `minimum_shipping_quantity_base` int(11) DEFAULT NULL,
  `minimum_shipping_quantity_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `reorder_level` int(11) DEFAULT NULL,
  `minimum_stock` int(11) DEFAULT NULL,
  `maximum_stock` int(11) DEFAULT NULL,
  `consumable_multiplier` int(11) DEFAULT NULL,
  `times_duplicated` int(11) NOT NULL DEFAULT 1,
  `reorder_level_warning_percentage` decimal(6,2) DEFAULT 0.00,
  `location_when_no_warehouse_module` varchar(35) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `avalara_tax_code` varchar(25) DEFAULT NULL,
  `hs_commodity_code` varchar(25) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `unit_of_measure_group_purchase_id` (`unit_of_measure_group_purchase_id`),
  KEY `unit_of_measure_purchase_id` (`unit_of_measure_purchase_id`),
  KEY `unit_of_measure_group_consume_id` (`unit_of_measure_group_consume_id`),
  KEY `unit_of_measure_consume_id` (`unit_of_measure_consume_id`),
  KEY `height_including_packaging_unit_of_measure_id` (`height_including_packaging_unit_of_measure_id`),
  KEY `width_including_packaging_unit_of_measure_id` (`width_including_packaging_unit_of_measure_id`),
  KEY `depth_including_packaging_unit_of_measure_id` (`depth_including_packaging_unit_of_measure_id`),
  KEY `weight_including_packaging_unit_of_measure_id` (`weight_including_packaging_unit_of_measure_id`),
  KEY `volume_including_packaging_unit_of_measure_id` (`volume_including_packaging_unit_of_measure_id`),
  KEY `height_excluding_packaging_unit_of_measure_id` (`height_excluding_packaging_unit_of_measure_id`),
  KEY `width_excluding_packaging_unit_of_measure_id` (`width_excluding_packaging_unit_of_measure_id`),
  KEY `depth_excluding_packaging_unit_of_measure_id` (`depth_excluding_packaging_unit_of_measure_id`),
  KEY `weight_excluding_packaging_unit_of_measure_id` (`weight_excluding_packaging_unit_of_measure_id`),
  KEY `volume_excluding_packaging_unit_of_measure_id` (`volume_excluding_packaging_unit_of_measure_id`),
  KEY `discount_group_id` (`discount_group_id`),
  KEY `top_level_sku_id` (`top_level_sku_id`),
  KEY `packaging_type_id` (`packaging_type_id`),
  KEY `gl_code_purchases_id` (`gl_code_purchases_id`),
  KEY `gl_code_raw_materials_id` (`gl_code_raw_materials_id`),
  KEY `gl_code_work_in_progress_id` (`gl_code_work_in_progress_id`),
  KEY `gl_code_finished_goods_id` (`gl_code_finished_goods_id`),
  KEY `gl_code_sales_id` (`gl_code_sales_id`),
  KEY `minimum_shipping_quantity_unit_of_measure_id` (`minimum_shipping_quantity_unit_of_measure_id`),
  KEY `bom_output_unit_of_measure_id` (`bom_output_unit_of_measure_id`),
  KEY `cost_price_display_unit_of_measure_id` (`cost_price_display_unit_of_measure_id`),
  KEY `sell_price_display_unit_of_measure_id` (`sell_price_display_unit_of_measure_id`),
  KEY `stock_category_id` (`stock_category_id`),
  KEY `customer_id` (`customer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `cost_price` (`cost_price`),
  KEY `normal_sell_price` (`normal_sell_price`),
  KEY `preferred_supplier_id` (`preferred_supplier_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_ibfk_10` FOREIGN KEY (`depth_including_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_11` FOREIGN KEY (`weight_including_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_12` FOREIGN KEY (`volume_including_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_13` FOREIGN KEY (`height_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_14` FOREIGN KEY (`width_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_15` FOREIGN KEY (`depth_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_16` FOREIGN KEY (`weight_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_17` FOREIGN KEY (`volume_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_18` FOREIGN KEY (`discount_group_id`) REFERENCES `discount_group` (`id`),
  CONSTRAINT `product_ibfk_19` FOREIGN KEY (`top_level_sku_id`) REFERENCES `product` (`id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_ibfk_20` FOREIGN KEY (`packaging_type_id`) REFERENCES `packaging_type` (`id`),
  CONSTRAINT `product_ibfk_21` FOREIGN KEY (`gl_code_purchases_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `product_ibfk_22` FOREIGN KEY (`gl_code_raw_materials_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `product_ibfk_23` FOREIGN KEY (`gl_code_work_in_progress_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `product_ibfk_24` FOREIGN KEY (`gl_code_finished_goods_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `product_ibfk_25` FOREIGN KEY (`gl_code_sales_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `product_ibfk_26` FOREIGN KEY (`minimum_shipping_quantity_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_27` FOREIGN KEY (`bom_output_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_28` FOREIGN KEY (`cost_price_display_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_29` FOREIGN KEY (`sell_price_display_unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_ibfk_30` FOREIGN KEY (`stock_category_id`) REFERENCES `stock_category` (`id`),
  CONSTRAINT `product_ibfk_31` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `product_ibfk_32` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `product_ibfk_33` FOREIGN KEY (`preferred_supplier_id`) REFERENCES `product_suppliers` (`id`),
  CONSTRAINT `product_ibfk_34` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `product_ibfk_35` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `product_ibfk_4` FOREIGN KEY (`unit_of_measure_group_purchase_id`) REFERENCES `unit_of_measure_group` (`id`),
  CONSTRAINT `product_ibfk_5` FOREIGN KEY (`unit_of_measure_purchase_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_6` FOREIGN KEY (`unit_of_measure_group_consume_id`) REFERENCES `unit_of_measure_group` (`id`),
  CONSTRAINT `product_ibfk_7` FOREIGN KEY (`unit_of_measure_consume_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_8` FOREIGN KEY (`height_including_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `product_ibfk_9` FOREIGN KEY (`width_including_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK ((`strict_allocation_unit` = 0 or `unit_tracked` <> 0) and (`strict_allocation_batch` = 0 or `batch_tracked` <> 0)),
  CONSTRAINT `Assembly_must_have_BOMouputUOM` CHECK (`is_assembly` = 0 or `bom_output_unit_of_measure_id` is not null)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_batch`
--

DROP TABLE IF EXISTS `product_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_batch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `batch_identifier` varchar(255) NOT NULL,
  `date_of_assembly` datetime DEFAULT NULL,
  `date_of_purchase` datetime DEFAULT NULL,
  `cost_price` decimal(13,5) DEFAULT 0.00000,
  `use_before` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_batch_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_batch_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_batch_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_batch_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_custom_discount`
--

DROP TABLE IF EXISTS `product_custom_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_custom_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `discount_name` varchar(30) NOT NULL,
  `discount_percentage` decimal(7,4) DEFAULT NULL,
  `enabled` tinyint(4) DEFAULT 1,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_custom_discount_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_custom_discount_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_custom_discount_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_custom_discount_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_location`
--

DROP TABLE IF EXISTS `product_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `delivery_id` bigint(20) DEFAULT NULL,
  `delivery_third_party_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) DEFAULT NULL,
  `contract_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `product_batch_id` bigint(20) DEFAULT NULL,
  `product_unit_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  KEY `product_batch_id` (`product_batch_id`),
  KEY `product_unit_id` (`product_unit_id`),
  KEY `location_id` (`location_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `delivery_id` (`delivery_id`),
  KEY `delivery_third_party_id` (`delivery_third_party_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `product_location_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_location_ibfk_10` FOREIGN KEY (`delivery_third_party_id`) REFERENCES `third_party_goods_received` (`id`),
  CONSTRAINT `product_location_ibfk_11` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `product_location_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_location_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_location_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_location_ibfk_5` FOREIGN KEY (`product_batch_id`) REFERENCES `product_batch` (`id`),
  CONSTRAINT `product_location_ibfk_6` FOREIGN KEY (`product_unit_id`) REFERENCES `product_unit` (`id`),
  CONSTRAINT `product_location_ibfk_7` FOREIGN KEY (`location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `product_location_ibfk_8` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `product_location_ibfk_9` FOREIGN KEY (`delivery_id`) REFERENCES `goods_received` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_quantity_discount`
--

DROP TABLE IF EXISTS `product_quantity_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_quantity_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `discount_percentage` decimal(7,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_quantity_discount_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_quantity_discount_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_quantity_discount_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_quantity_discount_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_suppliers`
--

DROP TABLE IF EXISTS `product_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_suppliers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `unit_of_measure_id` bigint(20) NOT NULL,
  `min_order` decimal(20,10) DEFAULT 1.0000000000,
  `min_order_base` int(11) DEFAULT 1,
  `purchase_price` decimal(10,2) NOT NULL,
  `supplier_description` varchar(255) NOT NULL,
  `supplier_part_number` varchar(50) NOT NULL,
  `lead_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  CONSTRAINT `product_suppliers_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_suppliers_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_suppliers_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_suppliers_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_suppliers_ibfk_5` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `product_suppliers_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_tag`
--

DROP TABLE IF EXISTS `product_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `product_tag_name_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_tag_name_id` (`product_tag_name_id`),
  CONSTRAINT `product_tag_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_tag_ibfk_2` FOREIGN KEY (`product_tag_name_id`) REFERENCES `product_tag_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_tag_name`
--

DROP TABLE IF EXISTS `product_tag_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_tag_name` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `tag` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `product_tag_name_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_tag_name_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_tag_name_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_unit`
--

DROP TABLE IF EXISTS `product_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `unit_description` varchar(50) DEFAULT NULL,
  `unit_identifier` varchar(255) NOT NULL,
  `date_of_assembly` datetime DEFAULT NULL,
  `date_of_purchase` datetime DEFAULT NULL,
  `cost_price` decimal(13,5) DEFAULT 0.00000,
  `use_before` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_unit_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_unit_of_measure`
--

DROP TABLE IF EXISTS `product_unit_of_measure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_unit_of_measure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) NOT NULL,
  `measure_name` varchar(50) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `multiplier` int(10) unsigned NOT NULL,
  `is_default_purchase_unit` tinyint(1) DEFAULT 0,
  `is_default_sale_unit` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `group_id` (`group_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_unit_of_measure_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_of_measure_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_of_measure_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_of_measure_ibfk_4` FOREIGN KEY (`group_id`) REFERENCES `product_unit_of_measure_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_unit_of_measure_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_unit_of_measure_group`
--

DROP TABLE IF EXISTS `product_unit_of_measure_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.product_unit_of_measure_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_unit_of_measure_group_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_of_measure_group_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_of_measure_group_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `product_unit_of_measure_group_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `project_number_id` bigint(20) NOT NULL,
  `project_id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL,
  `actual_start_date` datetime DEFAULT NULL,
  `estimated_start_date` datetime DEFAULT NULL,
  `actual_finish_date` datetime DEFAULT NULL,
  `estimated_finish_date` datetime DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT 0.00,
  `location_id` bigint(20) DEFAULT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `location_id` (`location_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `project_number_id` (`project_number_id`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `project_ibfk_5` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `project_ibfk_6` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `project_ibfk_7` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `project_ibfk_8` FOREIGN KEY (`project_number_id`) REFERENCES `project_number` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_branch`
--

DROP TABLE IF EXISTS `project_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.project_branch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `branch_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `project_id` (`project_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `project_branch_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_branch_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_branch_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_branch_ibfk_4` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `project_branch_ibfk_5` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_number`
--

DROP TABLE IF EXISTS `project_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.project_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `project_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_person_role`
--

DROP TABLE IF EXISTS `project_person_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.project_person_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `project_id` (`project_id`),
  KEY `role_id` (`role_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `project_person_role_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_person_role_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_person_role_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_person_role_ibfk_4` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `project_person_role_ibfk_5` FOREIGN KEY (`role_id`) REFERENCES `project_role` (`id`),
  CONSTRAINT `project_person_role_ibfk_6` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_role`
--

DROP TABLE IF EXISTS `project_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.project_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `role_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `project_role_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_role_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_role_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_settings`
--

DROP TABLE IF EXISTS `project_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.project_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `request_project_on_quotes` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `project_settings_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_settings_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `project_settings_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promotional_item`
--

DROP TABLE IF EXISTS `promotional_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.promotional_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `unit_of_measure_id` bigint(20) NOT NULL,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `compulsory` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `product_id` (`product_id`),
  KEY `item_id` (`item_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  CONSTRAINT `promotional_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `promotional_item_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `promotional_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `promotional_item_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `promotional_item_ibfk_5` FOREIGN KEY (`item_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `promotional_item_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prospect`
--

DROP TABLE IF EXISTS `prospect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.prospect` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) NOT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `sales_territory_id` bigint(20) DEFAULT NULL,
  `sales_pipeline_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) NOT NULL,
  `managed_by` varchar(255) DEFAULT NULL,
  `closed` tinyint(4) DEFAULT 0,
  `rating` tinyint(4) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `person_id` (`person_id`),
  KEY `customer_id` (`customer_id`),
  KEY `company_id` (`company_id`),
  KEY `source_id` (`source_id`),
  KEY `sales_territory_id` (`sales_territory_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `division_id` (`division_id`),
  KEY `department_id` (`department_id`),
  KEY `sales_pipeline_id` (`sales_pipeline_id`),
  CONSTRAINT `prospect_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `prospect_ibfk_10` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `prospect_ibfk_11` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `prospect_ibfk_12` FOREIGN KEY (`sales_pipeline_id`) REFERENCES `sales_pipeline` (`id`),
  CONSTRAINT `prospect_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `prospect_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `prospect_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `prospect_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `prospect_ibfk_6` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `prospect_ibfk_7` FOREIGN KEY (`source_id`) REFERENCES `prospect_source` (`id`),
  CONSTRAINT `prospect_ibfk_8` FOREIGN KEY (`sales_territory_id`) REFERENCES `sale_territory` (`id`),
  CONSTRAINT `prospect_ibfk_9` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prospect_source`
--

DROP TABLE IF EXISTS `prospect_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.prospect_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `label` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `prospect_source_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `prospect_source_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `prospect_source_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.purchase_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `purchase_currency_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `purchase_order_number_id` bigint(20) DEFAULT NULL,
  `supplier_branch_id` bigint(20) NOT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `purchase_order_total` decimal(12,2) DEFAULT 0.00,
  `purchase_order_total_in_currency` decimal(12,2) DEFAULT 0.00,
  `description` varchar(255) NOT NULL,
  `approval_required` tinyint(4) DEFAULT 0,
  `awaiting_approval` tinyint(4) DEFAULT 0,
  `approved` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `complete` tinyint(4) DEFAULT 0,
  `hold` tinyint(4) DEFAULT 0,
  `draft` tinyint(4) DEFAULT 1,
  `order_date` date NOT NULL,
  `required_delivery_date` date DEFAULT NULL,
  `target_completion_date` date DEFAULT NULL,
  `approval_date` datetime DEFAULT NULL,
  `for_invoice` tinyint(4) DEFAULT 1,
  `include_logo` tinyint(4) DEFAULT 1,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_reference` varchar(30) DEFAULT NULL,
  `supplier_account_number` varchar(50) NOT NULL,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `purchase_currency_name` varchar(41) NOT NULL,
  `purchase_currency_symbol` varchar(3) NOT NULL,
  `purchase_currency_code` varchar(3) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `branch_name` varchar(255) NOT NULL,
  `branch_address_id` bigint(20) NOT NULL,
  `branch_address_format_id` bigint(20) NOT NULL,
  `branch_address_name` varchar(100) DEFAULT NULL,
  `branch_thoroughfare` varchar(255) DEFAULT NULL,
  `branch_premise` varchar(255) DEFAULT NULL,
  `branch_locality` varchar(255) DEFAULT NULL,
  `branch_administrative_area` varchar(255) DEFAULT NULL,
  `branch_sub_administrative_area` varchar(255) DEFAULT NULL,
  `branch_postal_code` varchar(255) DEFAULT NULL,
  `branch_country` varchar(2) NOT NULL,
  `invoice_address_id` bigint(20) NOT NULL,
  `invoice_address_format_id` bigint(20) NOT NULL,
  `invoice_thoroughfare` varchar(255) DEFAULT NULL,
  `invoice_premise` varchar(255) DEFAULT NULL,
  `invoice_locality` varchar(255) DEFAULT NULL,
  `invoice_administrative_area` varchar(255) DEFAULT NULL,
  `invoice_sub_administrative_area` varchar(255) DEFAULT NULL,
  `invoice_postal_code` varchar(255) DEFAULT NULL,
  `invoice_country` varchar(2) NOT NULL,
  `approved_by_name` varchar(71) DEFAULT NULL,
  `is_drop_shipment` tinyint(4) NOT NULL DEFAULT 0,
  `purchase_order_reason_id` bigint(20) DEFAULT NULL,
  `purchase_order_reason_label` varchar(100) NOT NULL,
  `include_cost_for_sales_order` tinyint(4) NOT NULL DEFAULT 1,
  `pdf_footer` longtext DEFAULT '',
  `is_non_stock_po` tinyint(4) DEFAULT NULL,
  `payment_approval_required_by_buyer` tinyint(4) DEFAULT 0,
  `ordered_by_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `is_invoice_address_validated` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `purchase_currency_id` (`purchase_currency_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `approved_by_id` (`approved_by_id`),
  KEY `job_id` (`job_id`),
  KEY `contact_id` (`contact_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `project_id` (`project_id`),
  KEY `supplier_branch_id` (`supplier_branch_id`),
  KEY `branch_address_id` (`branch_address_id`),
  KEY `branch_address_format_id` (`branch_address_format_id`),
  KEY `purchase_order_reason_id` (`purchase_order_reason_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `branch_id` (`branch_id`),
  KEY `ordered_by_id` (`ordered_by_id`),
  KEY `order_date` (`order_date`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_ibfk_10` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `purchase_order_ibfk_11` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `purchase_order_ibfk_12` FOREIGN KEY (`supplier_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `purchase_order_ibfk_13` FOREIGN KEY (`branch_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `purchase_order_ibfk_14` FOREIGN KEY (`branch_address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `purchase_order_ibfk_15` FOREIGN KEY (`purchase_order_reason_id`) REFERENCES `purchase_order_reason` (`id`),
  CONSTRAINT `purchase_order_ibfk_16` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `purchase_order_ibfk_17` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `purchase_order_ibfk_18` FOREIGN KEY (`ordered_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_ibfk_19` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `purchase_order_ibfk_2` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `purchase_order_ibfk_3` FOREIGN KEY (`purchase_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `purchase_order_ibfk_4` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_ibfk_5` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_ibfk_6` FOREIGN KEY (`approved_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_ibfk_7` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `purchase_order_ibfk_8` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `purchase_order_ibfk_9` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_item`
--

DROP TABLE IF EXISTS `purchase_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.purchase_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `purchase_order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `same_as_original` tinyint(4) DEFAULT 1,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `outstanding` int(11) DEFAULT 1,
  `description` text NOT NULL,
  `list_price` decimal(10,2) DEFAULT 0.00,
  `list_price_in_currency` decimal(10,2) DEFAULT 0.00,
  `tax_percent` decimal(5,2) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  `cost_price` decimal(13,5) DEFAULT 0.00000,
  `cost_price_in_currency` decimal(13,5) DEFAULT 0.00000,
  `net_total` decimal(13,5) GENERATED ALWAYS AS (`quantity` * `cost_price`) VIRTUAL,
  `gross_total` decimal(10,2) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `net_total_in_currency` decimal(13,5) GENERATED ALWAYS AS (`quantity` * `cost_price_in_currency`) VIRTUAL,
  `gross_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `tax_code_code` varchar(255) DEFAULT NULL,
  `tax_code_description` varchar(255) DEFAULT NULL,
  `is_assembly` tinyint(4) DEFAULT 0,
  `is_taxable` tinyint(4) DEFAULT 0,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  CONSTRAINT `purchase_order_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_10` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_11` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_4` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_7` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_8` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `purchase_order_item_ibfk_9` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_total_after_insert AFTER INSERT ON purchase_order_item FOR EACH ROW BEGIN
        UPDATE purchase_order po SET po.purchase_order_total = ((SELECT SUM(poi.gross_total) FROM purchase_order_item poi WHERE poi.purchase_order_id = po.id) + 0) WHERE po.id = NEW.purchase_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_total_in_currency_after_insert AFTER INSERT ON purchase_order_item FOR EACH ROW BEGIN
        UPDATE purchase_order po SET po.purchase_order_total_in_currency = ((SELECT SUM(poi.gross_total_in_currency) FROM purchase_order_item poi WHERE poi.purchase_order_id = po.id) + 0) WHERE po.id = NEW.purchase_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_total_after_update AFTER UPDATE ON purchase_order_item FOR EACH ROW BEGIN
        UPDATE purchase_order po SET po.purchase_order_total = ((SELECT SUM(poi.gross_total) FROM purchase_order_item poi WHERE poi.purchase_order_id = po.id) + 0) WHERE po.id = NEW.purchase_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_total_in_currency_after_update AFTER UPDATE ON purchase_order_item FOR EACH ROW BEGIN
        UPDATE purchase_order po SET po.purchase_order_total_in_currency = ((SELECT SUM(poi.gross_total_in_currency) FROM purchase_order_item poi WHERE poi.purchase_order_id = po.id) + 0) WHERE po.id = NEW.purchase_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_total_after_delete AFTER DELETE ON purchase_order_item FOR EACH ROW BEGIN
        UPDATE purchase_order po SET po.purchase_order_total = ((SELECT SUM(poi.gross_total) FROM purchase_order_item poi WHERE poi.purchase_order_id = po.id) + 0) WHERE po.id = OLD.purchase_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_purchase_order_total_in_currency_after_delete AFTER DELETE ON purchase_order_item FOR EACH ROW BEGIN
        UPDATE purchase_order po SET po.purchase_order_total_in_currency = ((SELECT SUM(poi.gross_total_in_currency) FROM purchase_order_item poi WHERE poi.purchase_order_id = po.id) + 0) WHERE po.id = OLD.purchase_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `purchase_order_job_cost`
--

DROP TABLE IF EXISTS `purchase_order_job_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.purchase_order_job_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) NOT NULL,
  `purchase_order_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `invoice_cost` decimal(10,2) DEFAULT NULL,
  `for_invoice` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `job_id` (`job_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  CONSTRAINT `purchase_order_job_cost_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_job_cost_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_job_cost_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_job_cost_ibfk_4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `purchase_order_job_cost_ibfk_5` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_number`
--

DROP TABLE IF EXISTS `purchase_order_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.purchase_order_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `purchase_order_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_reason`
--

DROP TABLE IF EXISTS `purchase_order_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.purchase_order_reason` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `label` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `purchase_order_reason_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_reason_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `purchase_order_reason_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quote`
--

DROP TABLE IF EXISTS `quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.quote` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) NOT NULL,
  `opportunity_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `rejection_reason_id` bigint(20) DEFAULT NULL,
  `follow_up_by_id` bigint(20) DEFAULT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `original_quote_id` bigint(20) DEFAULT NULL,
  `quote_number_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `sale_currency_id` bigint(20) NOT NULL,
  `customer_address_id` bigint(20) DEFAULT NULL,
  `postal_address_format_id` bigint(20) DEFAULT NULL,
  `prospect_address_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `template_name` varchar(20) DEFAULT NULL,
  `template_description` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `accepted` tinyint(4) DEFAULT 0,
  `approved` tinyint(4) DEFAULT 0,
  `approval_required` tinyint(4) DEFAULT 0,
  `awaiting_approval` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `rejected` tinyint(4) DEFAULT 0,
  `draft` tinyint(4) DEFAULT 1,
  `is_template` tinyint(4) DEFAULT 0,
  `approval_date` datetime DEFAULT NULL,
  `valid_until` datetime DEFAULT NULL,
  `follow_up_date` datetime DEFAULT NULL,
  `include_line_items_total` tinyint(4) DEFAULT 0,
  `include_shipping_address` tinyint(1) DEFAULT 0,
  `include_terms_and_conditions` tinyint(4) DEFAULT 0,
  `include_logo` tinyint(4) DEFAULT 1,
  `hide_discounts` tinyint(4) DEFAULT 0,
  `pdf_in_base_currency` tinyint(4) DEFAULT 0,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `include_in_opportunity_calcs` tinyint(4) DEFAULT 1,
  `quote_date` datetime DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `sale_currency_name` varchar(41) NOT NULL,
  `sale_currency_symbol` varchar(3) NOT NULL,
  `sale_currency_code` varchar(3) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_account_number` varchar(50) DEFAULT NULL,
  `postal_address_name` varchar(100) DEFAULT NULL,
  `postal_address_thoroughfare` varchar(255) DEFAULT NULL,
  `postal_address_premise` varchar(255) DEFAULT NULL,
  `postal_address_locality` varchar(255) DEFAULT NULL,
  `postal_address_administrative_area` varchar(255) DEFAULT NULL,
  `postal_address_sub_administrative_area` varchar(255) DEFAULT NULL,
  `postal_address_postal_code` varchar(255) DEFAULT NULL,
  `postal_address_country` varchar(2) DEFAULT NULL,
  `prospect_name` varchar(255) DEFAULT NULL,
  `correspondence_address_tier_name` varchar(255) NOT NULL,
  `correspondence_address_id` bigint(20) NOT NULL,
  `correspondence_address_format_id` bigint(20) NOT NULL,
  `correspondence_address_name` varchar(100) DEFAULT NULL,
  `correspondence_address_thoroughfare` varchar(255) DEFAULT NULL,
  `correspondence_address_premise` varchar(255) DEFAULT NULL,
  `correspondence_address_locality` varchar(255) DEFAULT NULL,
  `correspondence_address_administrative_area` varchar(255) DEFAULT NULL,
  `correspondence_address_sub_administrative_area` varchar(255) DEFAULT NULL,
  `correspondence_address_postal_code` varchar(255) DEFAULT NULL,
  `correspondence_address_country` varchar(2) NOT NULL,
  `rejection_reason` varchar(255) DEFAULT NULL,
  `follow_up_by_name` varchar(71) DEFAULT NULL,
  `approved_by_name` varchar(71) DEFAULT NULL,
  `pdf_footer` longtext DEFAULT '',
  `quote_total` decimal(12,2) DEFAULT 0.00,
  `quote_total_in_currency` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `opportunity_id` (`opportunity_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `rejection_reason_id` (`rejection_reason_id`),
  KEY `approved_by_id` (`approved_by_id`),
  KEY `follow_up_by_id` (`follow_up_by_id`),
  KEY `original_quote_id` (`original_quote_id`),
  KEY `customer_address_id` (`customer_address_id`),
  KEY `postal_address_format_id` (`postal_address_format_id`),
  KEY `prospect_address_id` (`prospect_address_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `sale_currency_id` (`sale_currency_id`),
  KEY `correspondence_address_id` (`correspondence_address_id`),
  KEY `correspondence_address_format_id` (`correspondence_address_format_id`),
  KEY `branch_id` (`branch_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `valid_until` (`valid_until`),
  KEY `follow_up_date` (`follow_up_date`),
  KEY `project_id` (`project_id`),
  KEY `quote_number_id` (`quote_number_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `quote_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_ibfk_10` FOREIGN KEY (`approved_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_ibfk_11` FOREIGN KEY (`follow_up_by_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `quote_ibfk_12` FOREIGN KEY (`original_quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `quote_ibfk_13` FOREIGN KEY (`customer_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `quote_ibfk_14` FOREIGN KEY (`postal_address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `quote_ibfk_15` FOREIGN KEY (`prospect_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `quote_ibfk_16` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `quote_ibfk_17` FOREIGN KEY (`sale_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `quote_ibfk_18` FOREIGN KEY (`correspondence_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `quote_ibfk_19` FOREIGN KEY (`correspondence_address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `quote_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_ibfk_20` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `quote_ibfk_21` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `quote_ibfk_22` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `quote_ibfk_23` FOREIGN KEY (`quote_number_id`) REFERENCES `quote_number` (`id`),
  CONSTRAINT `quote_ibfk_24` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `quote_ibfk_25` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `quote_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_ibfk_4` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `quote_ibfk_5` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `quote_ibfk_6` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `quote_ibfk_7` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`),
  CONSTRAINT `quote_ibfk_8` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `quote_ibfk_9` FOREIGN KEY (`rejection_reason_id`) REFERENCES `rejection_reason` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`customer_id` is not null or `prospect_id` is not null)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quote_additional_cost`
--

DROP TABLE IF EXISTS `quote_additional_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.quote_additional_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `cost` decimal(13,5) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `include_cost` tinyint(4) DEFAULT 1,
  `total_cost` decimal(13,5) GENERATED ALWAYS AS (`cost` * `quantity`) VIRTUAL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `quote_id` (`quote_id`),
  CONSTRAINT `quote_additional_cost_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_additional_cost_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_additional_cost_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_additional_cost_ibfk_4` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quote_item`
--

DROP TABLE IF EXISTS `quote_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.quote_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) NOT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `include_costs_in_quote` tinyint(4) DEFAULT 1,
  `include_in_sales_order` tinyint(4) DEFAULT 1,
  `is_assembly` tinyint(4) DEFAULT 0,
  `is_taxable` tinyint(4) DEFAULT 0,
  `is_deliverable` tinyint(4) DEFAULT 1,
  `allow_discounts` tinyint(4) DEFAULT 1,
  `same_as_original` tinyint(4) DEFAULT 1,
  `include_cost` tinyint(4) DEFAULT 1,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `cost_price` decimal(10,2) DEFAULT 0.00,
  `list_price` decimal(13,5) DEFAULT 0.00000,
  `list_price_in_currency` decimal(13,5) DEFAULT 0.00000,
  `minimum_sell_price` decimal(10,2) DEFAULT 0.00,
  `maximum_sell_price` decimal(10,2) DEFAULT 0.00,
  `calculated_discount` decimal(11,2) DEFAULT 0.00,
  `calculated_discount_in_currency` decimal(11,2) DEFAULT 0.00,
  `manual_discount` decimal(11,2) DEFAULT 0.00,
  `net_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`list_price` - `calculated_discount`)) VIRTUAL,
  `net_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`list_price_in_currency` - `calculated_discount_in_currency`)) VIRTUAL,
  `net_total_discount` decimal(10,2) DEFAULT 0.00,
  `gross_total` decimal(10,2) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `gross_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `description` text NOT NULL,
  `unit_of_measure_name` varchar(50) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `tax_percent` decimal(5,2) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `quote_id` (`quote_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `tax_code_id` (`tax_code_id`),
  CONSTRAINT `quote_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_item_ibfk_4` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `quote_item_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `quote_item_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `quote_item_ibfk_7` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `quote_item_ibfk_8` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `quote_item_ibfk_9` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_quote_total_after_insert AFTER INSERT ON quote_item FOR EACH ROW BEGIN
        UPDATE quote q SET q.quote_total = ((SELECT SUM(qi.gross_total) FROM quote_item qi WHERE qi.quote_id = q.id) + 0) WHERE q.id = NEW.quote_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_quote_total_in_currency_after_insert AFTER INSERT ON quote_item FOR EACH ROW BEGIN
        UPDATE quote q SET q.quote_total_in_currency = ((SELECT SUM(qi.gross_total_in_currency) FROM quote_item qi WHERE qi.quote_id = q.id) + 0) WHERE q.id = NEW.quote_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_quote_total_after_update AFTER UPDATE ON quote_item FOR EACH ROW BEGIN
        UPDATE quote q SET q.quote_total = ((SELECT SUM(qi.gross_total) FROM quote_item qi WHERE qi.quote_id = q.id) + 0) WHERE q.id = NEW.quote_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_quote_total_in_currency_after_update AFTER UPDATE ON quote_item FOR EACH ROW BEGIN
        UPDATE quote q SET q.quote_total_in_currency = ((SELECT SUM(qi.gross_total_in_currency) FROM quote_item qi WHERE qi.quote_id = q.id) + 0) WHERE q.id = NEW.quote_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_quote_total_in_currency_after_delete AFTER DELETE ON quote_item FOR EACH ROW BEGIN
        UPDATE quote q SET q.quote_total_in_currency = ((SELECT SUM(qi.gross_total_in_currency) FROM quote_item qi WHERE qi.quote_id = q.id) + 0) WHERE q.id = OLD.quote_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_quote_total_after_delete AFTER DELETE ON quote_item FOR EACH ROW BEGIN
        UPDATE quote q SET q.quote_total = ((SELECT SUM(qi.gross_total) FROM quote_item qi WHERE qi.quote_id = q.id) + 0) WHERE q.id = OLD.quote_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `quote_number`
--

DROP TABLE IF EXISTS `quote_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.quote_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `quote_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `quote_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipient_product`
--

DROP TABLE IF EXISTS `recipient_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.recipient_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `bulk_product_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `product_id` (`product_id`),
  KEY `bulk_product_id` (`bulk_product_id`),
  CONSTRAINT `recipient_product_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `recipient_product_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `recipient_product_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `recipient_product_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recipient_product_ibfk_5` FOREIGN KEY (`bulk_product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rejection_reason`
--

DROP TABLE IF EXISTS `rejection_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.rejection_reason` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `rejection_reason_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `rejection_reason_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `rejection_reason_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `resource_name` varchar(255) NOT NULL,
  `resource_description` varchar(255) DEFAULT NULL,
  `hourly_rate` decimal(7,2) DEFAULT NULL,
  `charge_out_rate` decimal(7,2) DEFAULT NULL,
  `overtime_multiplier` decimal(6,3) DEFAULT NULL,
  `out_of_hours_multiplier` decimal(6,3) DEFAULT NULL,
  `resource_group_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `resource_group_id` (`resource_group_id`),
  KEY `asset_id` (`asset_id`),
  KEY `product_id` (`product_id`),
  KEY `employee_id` (`employee_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_ibfk_4` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`id`),
  CONSTRAINT `resource_ibfk_5` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `resource_ibfk_6` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `resource_ibfk_7` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `resource_ibfk_8` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `resource_accessibility`
--

DROP TABLE IF EXISTS `resource_accessibility`;
/*!50001 DROP VIEW IF EXISTS `resource_accessibility`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.resource_accessibility` (
  `id` tinyint NOT NULL,
  `resource_id` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `division_id` tinyint NOT NULL,
  `department_id` tinyint NOT NULL,
  `ref_id` tinyint NOT NULL,
  `parent_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `resource_group`
--

DROP TABLE IF EXISTS `resource_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.resource_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(100) NOT NULL,
  `group_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `resource_group_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_group_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_group_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_tag`
--

DROP TABLE IF EXISTS `resource_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.resource_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `resource_id` bigint(20) NOT NULL,
  `resource_tag_name_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_tag_name_id` (`resource_tag_name_id`),
  CONSTRAINT `resource_tag_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_tag_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_tag_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_tag_ibfk_4` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `resource_tag_ibfk_5` FOREIGN KEY (`resource_tag_name_id`) REFERENCES `resource_tag_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_tag_name`
--

DROP TABLE IF EXISTS `resource_tag_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.resource_tag_name` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `tag_name` varchar(100) NOT NULL,
  `name_tag` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_name` (`tag_name`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `resource_tag_name_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_tag_name_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `resource_tag_name_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `return_note`
--

DROP TABLE IF EXISTS `return_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.return_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `returns_authorisation_id` (`returns_authorisation_id`),
  CONSTRAINT `return_note_ibfk_1` FOREIGN KEY (`returns_authorisation_id`) REFERENCES `returns_authorisation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `return_options_condition`
--

DROP TABLE IF EXISTS `return_options_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.return_options_condition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `condition_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `return_options_condition_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `return_options_condition_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `return_options_condition_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `return_reason`
--

DROP TABLE IF EXISTS `return_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.return_reason` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `return_reason` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `return_reason_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `return_reason_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `return_reason_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `returns_authorisation`
--

DROP TABLE IF EXISTS `returns_authorisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.returns_authorisation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL,
  `authorized_by_id` bigint(20) NOT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_number_id` bigint(20) NOT NULL,
  `return_reason_id` bigint(20) NOT NULL,
  `draft` tinyint(4) DEFAULT 1,
  `complete` tinyint(4) DEFAULT 0,
  `returns_authorisation_date` date NOT NULL,
  `include_line_items_total` tinyint(4) DEFAULT 0,
  `include_terms_and_conditions` tinyint(4) DEFAULT 0,
  `include_logo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `authorized_by_id` (`authorized_by_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `return_reason_id` (`return_reason_id`),
  KEY `returns_authorisation_number_id` (`returns_authorisation_number_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  CONSTRAINT `returns_authorisation_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_10` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_4` FOREIGN KEY (`authorized_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_6` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_7` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_8` FOREIGN KEY (`return_reason_id`) REFERENCES `return_reason` (`id`),
  CONSTRAINT `returns_authorisation_ibfk_9` FOREIGN KEY (`returns_authorisation_number_id`) REFERENCES `returns_authorisation_number` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `returns_authorisation_item`
--

DROP TABLE IF EXISTS `returns_authorisation_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.returns_authorisation_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_id` bigint(20) NOT NULL,
  `sales_order_item_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_unit_id` bigint(20) DEFAULT NULL,
  `return_note_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `returns_authorisation_id` (`returns_authorisation_id`),
  KEY `sales_order_item_id` (`sales_order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `return_note_id` (`return_note_id`),
  KEY `asset_id` (`asset_id`),
  KEY `product_unit_id` (`product_unit_id`),
  CONSTRAINT `returns_authorisation_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_4` FOREIGN KEY (`returns_authorisation_id`) REFERENCES `returns_authorisation` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_5` FOREIGN KEY (`sales_order_item_id`) REFERENCES `sales_order_item` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_6` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_7` FOREIGN KEY (`return_note_id`) REFERENCES `return_note` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_8` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `returns_authorisation_item_ibfk_9` FOREIGN KEY (`product_unit_id`) REFERENCES `product_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `returns_authorisation_number`
--

DROP TABLE IF EXISTS `returns_authorisation_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.returns_authorisation_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `returns_authorisation_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_authorisation_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `returns_received`
--

DROP TABLE IF EXISTS `returns_received`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.returns_received` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `returns_authorisation_item_id` bigint(20) NOT NULL,
  `location_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `location_id` (`location_id`),
  KEY `returns_authorisation_item_id` (`returns_authorisation_item_id`),
  CONSTRAINT `returns_received_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_received_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_received_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `returns_received_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `returns_received_ibfk_5` FOREIGN KEY (`returns_authorisation_item_id`) REFERENCES `returns_authorisation_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sale_territory`
--

DROP TABLE IF EXISTS `sale_territory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sale_territory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `label` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `label` (`label`),
  CONSTRAINT `sale_territory_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sale_territory_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sale_territory_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order`
--

DROP TABLE IF EXISTS `sales_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `sale_currency_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `sales_order_number_id` bigint(20) NOT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `quote_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `external_order_number` varchar(255) DEFAULT NULL,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `invoice_type` varchar(30) DEFAULT NULL,
  `template_name` varchar(20) DEFAULT NULL,
  `template_description` varchar(255) DEFAULT NULL,
  `order_date` date NOT NULL,
  `invoice_estimated_date` date DEFAULT NULL,
  `approval_date` datetime DEFAULT NULL,
  `invoice_offset_value` decimal(10,2) DEFAULT 0.00,
  `invoice_amount_outstanding` decimal(10,2) DEFAULT 0.00,
  `invoice_amount_outstanding_in_currency` decimal(10,2) DEFAULT 0.00,
  `sales_order_total` decimal(12,2) DEFAULT 0.00,
  `sales_order_total_in_currency` decimal(12,2) DEFAULT 0.00,
  `allow_autocomplete` tinyint(4) DEFAULT 1,
  `approval_required` tinyint(4) DEFAULT 0,
  `awaiting_approval` tinyint(4) DEFAULT 0,
  `approved` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `completed` tinyint(4) DEFAULT 0,
  `hold` tinyint(4) DEFAULT 0,
  `requires_invoice` tinyint(4) DEFAULT 1,
  `all_items_delivered` tinyint(4) DEFAULT 0,
  `all_items_invoiced` tinyint(4) DEFAULT 0,
  `invoice_status` enum('Not invoiced','Part invoiced','Fully invoiced') DEFAULT 'Not invoiced',
  `draft` tinyint(4) DEFAULT 1,
  `include_logo` tinyint(4) DEFAULT 1,
  `hide_discounts` tinyint(4) DEFAULT 0,
  `pdf_in_base_currency` tinyint(4) DEFAULT 0,
  `pdf_without_pricing` tinyint(4) DEFAULT 0,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `is_template` tinyint(4) DEFAULT 0,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `sale_currency_name` varchar(41) NOT NULL,
  `sale_currency_symbol` varchar(3) NOT NULL,
  `sale_currency_code` varchar(3) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_account_number` varchar(50) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email_address` varchar(510) DEFAULT NULL,
  `contact_telephone_number` varchar(25) DEFAULT NULL,
  `customer_address_id` bigint(20) NOT NULL,
  `customer_address_format_id` bigint(20) NOT NULL,
  `customer_address_name` varchar(100) DEFAULT NULL,
  `customer_thoroughfare` varchar(255) DEFAULT NULL,
  `customer_premise` varchar(255) DEFAULT NULL,
  `customer_locality` varchar(255) DEFAULT NULL,
  `customer_administrative_area` varchar(255) DEFAULT NULL,
  `customer_sub_administrative_area` varchar(255) DEFAULT NULL,
  `customer_postal_code` varchar(255) DEFAULT NULL,
  `customer_country` varchar(2) NOT NULL,
  `division_name` varchar(255) NOT NULL,
  `division_address_id` bigint(20) NOT NULL,
  `division_address_format_id` bigint(20) NOT NULL,
  `division_address_name` varchar(100) DEFAULT NULL,
  `division_thoroughfare` varchar(255) DEFAULT NULL,
  `division_premise` varchar(255) DEFAULT NULL,
  `division_locality` varchar(255) DEFAULT NULL,
  `division_administrative_area` varchar(255) DEFAULT NULL,
  `division_sub_administrative_area` varchar(255) DEFAULT NULL,
  `division_postal_code` varchar(255) DEFAULT NULL,
  `division_country` varchar(2) NOT NULL,
  `approved_by_name` varchar(71) DEFAULT NULL,
  `pdf_footer` longtext DEFAULT '',
  `pdf_footer_proforma` longtext DEFAULT '',
  `auto_allocate` tinyint(1) NOT NULL,
  `primary_invoice_address_id` bigint(20) DEFAULT NULL,
  `ready_to_invoice` tinyint(1) DEFAULT 0,
  `ready_to_invoice_authorised_by` bigint(20) DEFAULT NULL,
  `sales_contract_name` varchar(50) DEFAULT NULL,
  `sales_contract_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `approved_by_id` (`approved_by_id`),
  KEY `ready_to_invoice_authorised_by` (`ready_to_invoice_authorised_by`),
  KEY `contact_id` (`contact_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `sale_currency_id` (`sale_currency_id`),
  KEY `customer_address_id` (`customer_address_id`),
  KEY `customer_address_format_id` (`customer_address_format_id`),
  KEY `division_address_id` (`division_address_id`),
  KEY `division_address_format_id` (`division_address_format_id`),
  KEY `branch_id` (`branch_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `quote_id` (`quote_id`),
  KEY `project_id` (`project_id`),
  KEY `sales_order_number_id` (`sales_order_number_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `sales_order_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_ibfk_10` FOREIGN KEY (`customer_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `sales_order_ibfk_11` FOREIGN KEY (`customer_address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `sales_order_ibfk_12` FOREIGN KEY (`division_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `sales_order_ibfk_13` FOREIGN KEY (`division_address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `sales_order_ibfk_14` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `sales_order_ibfk_15` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `sales_order_ibfk_16` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `sales_order_ibfk_17` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `sales_order_ibfk_18` FOREIGN KEY (`sales_order_number_id`) REFERENCES `sales_order_number` (`id`),
  CONSTRAINT `sales_order_ibfk_19` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `sales_order_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `sales_order_ibfk_5` FOREIGN KEY (`approved_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_ibfk_6` FOREIGN KEY (`ready_to_invoice_authorised_by`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_ibfk_7` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `sales_order_ibfk_8` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `sales_order_ibfk_9` FOREIGN KEY (`sale_currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_adhoc`
--

DROP TABLE IF EXISTS `sales_order_adhoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_order_adhoc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `include_cost` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `sales_order_id` (`sales_order_id`),
  CONSTRAINT `sales_order_adhoc_ibfk_1` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_item`
--

DROP TABLE IF EXISTS `sales_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) NOT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `allow_discounts` tinyint(4) DEFAULT 1,
  `same_as_original` tinyint(4) DEFAULT 1,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `backorder_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `allocated_quantity` decimal(20,10) DEFAULT 0.0000000000,
  `picked_quantity` int(11) DEFAULT 0,
  `price` decimal(10,2) DEFAULT 0.00,
  `price_in_currency` decimal(10,2) DEFAULT 0.00,
  `cost_price` decimal(10,2) DEFAULT 0.00,
  `calculated_discount` decimal(11,2) DEFAULT 0.00,
  `calculated_discount_in_currency` decimal(11,2) DEFAULT 0.00,
  `description` text NOT NULL,
  `unit_of_measure_name` varchar(50) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `tax_percent` decimal(5,2) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  `is_assembly` tinyint(4) DEFAULT 0,
  `is_taxable` tinyint(4) DEFAULT 0,
  `is_deliverable` tinyint(4) DEFAULT 0,
  `height_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `width_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `depth_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `volume_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `weight_excluding_packaging` decimal(10,2) DEFAULT NULL,
  `height_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `width_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `depth_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `weight_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `volume_excluding_packaging_unit_of_measure_id` bigint(20) DEFAULT NULL,
  `net_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`price` - `calculated_discount`)) VIRTUAL,
  `gross_total` decimal(10,2) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `net_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`quantity` * (`price_in_currency` - `calculated_discount_in_currency`)) VIRTUAL,
  `gross_total_in_currency` decimal(10,2) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `cost_price_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `cost_price`) VIRTUAL,
  `avalara_tax_code` varchar(25) DEFAULT NULL,
  `override_tax_in_tax_integration` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `height_excluding_packaging_unit_of_measure_id` (`height_excluding_packaging_unit_of_measure_id`),
  KEY `width_excluding_packaging_unit_of_measure_id` (`width_excluding_packaging_unit_of_measure_id`),
  KEY `depth_excluding_packaging_unit_of_measure_id` (`depth_excluding_packaging_unit_of_measure_id`),
  KEY `weight_excluding_packaging_unit_of_measure_id` (`weight_excluding_packaging_unit_of_measure_id`),
  KEY `volume_excluding_packaging_unit_of_measure_id` (`volume_excluding_packaging_unit_of_measure_id`),
  KEY `created` (`created`),
  KEY `quantity` (`quantity`),
  KEY `picked_quantity` (`picked_quantity`),
  KEY `price` (`price`),
  KEY `cost_price` (`cost_price`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `sales_order_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_item_ibfk_10` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `sales_order_item_ibfk_11` FOREIGN KEY (`height_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `sales_order_item_ibfk_12` FOREIGN KEY (`width_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `sales_order_item_ibfk_13` FOREIGN KEY (`depth_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `sales_order_item_ibfk_14` FOREIGN KEY (`weight_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `sales_order_item_ibfk_15` FOREIGN KEY (`volume_excluding_packaging_unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`),
  CONSTRAINT `sales_order_item_ibfk_16` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `sales_order_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_item_ibfk_4` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `sales_order_item_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `sales_order_item_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `sales_order_item_ibfk_7` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `sales_order_item_ibfk_8` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `sales_order_item_ibfk_9` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_sales_order_total_after_insert AFTER INSERT ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.sales_order_total = ((SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) + 0) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_sales_order_total_in_currency_after_insert AFTER INSERT ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.sales_order_total_in_currency = ((SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) + 0) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amount_outstanding_after_insert_item AFTER INSERT ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.invoice_amount_outstanding = (
            (SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amnt_OS_in_currency_after_insert_item AFTER INSERT ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.invoice_amount_outstanding_in_currency = (
            (SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total_in_currency), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_sales_order_total_in_currency_after_update AFTER UPDATE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.sales_order_total_in_currency = ((SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) + 0) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_sales_order_total_after_update AFTER UPDATE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.sales_order_total = ((SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) + 0) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amount_outstanding_after_update_item AFTER UPDATE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.invoice_amount_outstanding = (
            (SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amnt_OS_in_currency_after_update_item AFTER UPDATE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.invoice_amount_outstanding_in_currency = (
            (SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total_in_currency), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE so.id = NEW.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_sales_order_total_after_delete AFTER DELETE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.sales_order_total = ((SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) + 0) WHERE so.id = OLD.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_sales_order_total_in_currency_after_delete AFTER DELETE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.sales_order_total_in_currency = ((SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) + 0) WHERE so.id = OLD.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amount_outstanding_after_delete_item AFTER DELETE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.invoice_amount_outstanding = (
            (SELECT SUM(soi.gross_total) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE so.id = OLD.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_so_invoice_amnt_OS_in_currency_after_delete_item AFTER DELETE ON sales_order_item FOR EACH ROW BEGIN
        UPDATE sales_order so SET so.invoice_amount_outstanding_in_currency = (
            (SELECT SUM(soi.gross_total_in_currency) FROM sales_order_item soi WHERE soi.sales_order_id = so.id) -
            (SELECT IFNULL(SUM(li.gross_total_in_currency), 0) FROM invoice i INNER JOIN invoice_item li ON li.invoice_id = i.id INNER JOIN sales_order_item soi2 ON soi2.id = li.sales_order_item_id WHERE soi2.sales_order_id = so.id)
        ) WHERE so.id = OLD.sales_order_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sales_order_number`
--

DROP TABLE IF EXISTS `sales_order_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_order_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `unique_number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_number` (`unique_number`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `sales_order_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_number_ibfk_2` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_order_settings`
--

DROP TABLE IF EXISTS `sales_order_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_order_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `require_authorisation_to_invoice` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `sales_order_settings_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_settings_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_order_settings_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_pipeline`
--

DROP TABLE IF EXISTS `sales_pipeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_pipeline` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `opportunity_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `sales_pipeline_stage_id` bigint(20) NOT NULL,
  `step_number` bigint(20) DEFAULT 1,
  `due_date` datetime DEFAULT NULL,
  `due_by_user_id` bigint(20) DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `completed_by_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `opportunity_id` (`opportunity_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `sales_pipeline_stage_id` (`sales_pipeline_stage_id`),
  KEY `due_by_user_id` (`due_by_user_id`),
  KEY `completed_by_user_id` (`completed_by_user_id`),
  CONSTRAINT `sales_pipeline_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_4` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunity` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_5` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_6` FOREIGN KEY (`sales_pipeline_stage_id`) REFERENCES `sales_pipeline_stage` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_7` FOREIGN KEY (`due_by_user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_ibfk_8` FOREIGN KEY (`completed_by_user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_pipeline_stage`
--

DROP TABLE IF EXISTS `sales_pipeline_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_pipeline_stage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `expected_duration` bigint(20) DEFAULT NULL,
  `target_days` smallint(5) unsigned NOT NULL,
  `type` enum('Opportunity','Prospect','Job') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `sales_pipeline_stage_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_stage_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_stage_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_pipeline_template`
--

DROP TABLE IF EXISTS `sales_pipeline_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_pipeline_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `type` enum('Opportunity','Prospect','Job') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `sales_pipeline_template_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_template_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sales_pipeline_template_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales_pipeline_template_stage`
--

DROP TABLE IF EXISTS `sales_pipeline_template_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sales_pipeline_template_stage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sales_pipeline_template_id` bigint(20) NOT NULL,
  `sales_pipeline_stage_id` bigint(20) NOT NULL,
  `step_number` bigint(20) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `sales_pipeline_template_id` (`sales_pipeline_template_id`),
  KEY `sales_pipeline_stage_id` (`sales_pipeline_stage_id`),
  CONSTRAINT `sales_pipeline_template_stage_ibfk_1` FOREIGN KEY (`sales_pipeline_template_id`) REFERENCES `sales_pipeline_template` (`id`),
  CONSTRAINT `sales_pipeline_template_stage_ibfk_2` FOREIGN KEY (`sales_pipeline_stage_id`) REFERENCES `sales_pipeline_stage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salutation`
--

DROP TABLE IF EXISTS `salutation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.salutation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `salutation` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salutation` (`salutation`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `salutation_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `salutation_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `salutation_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schedule_event`
--

DROP TABLE IF EXISTS `schedule_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.schedule_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `application_user_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `resource_tag_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `event_type` varchar(25) NOT NULL,
  `event_start` datetime NOT NULL,
  `event_end` datetime NOT NULL,
  `accepted` tinyint(4) DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `application_user_id` (`application_user_id`),
  KEY `contact_id` (`contact_id`),
  KEY `employee_id` (`employee_id`),
  KEY `job_id` (`job_id`),
  KEY `person_id` (`person_id`),
  KEY `project_id` (`project_id`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_tag_id` (`resource_tag_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `schedule_event_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `schedule_event_ibfk_10` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `schedule_event_ibfk_11` FOREIGN KEY (`resource_tag_id`) REFERENCES `resource_tag` (`id`),
  CONSTRAINT `schedule_event_ibfk_12` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `schedule_event_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `schedule_event_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `schedule_event_ibfk_4` FOREIGN KEY (`application_user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `schedule_event_ibfk_5` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `schedule_event_ibfk_6` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `schedule_event_ibfk_7` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `schedule_event_ibfk_8` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `schedule_event_ibfk_9` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security_group`
--

DROP TABLE IF EXISTS `security_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.security_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `super_user` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `security_group_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security_group_member`
--

DROP TABLE IF EXISTS `security_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.security_group_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `security_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `security_group_id` (`security_group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `security_group_member_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_member_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_member_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_member_ibfk_4` FOREIGN KEY (`security_group_id`) REFERENCES `security_group` (`id`),
  CONSTRAINT `security_group_member_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security_group_permission`
--

DROP TABLE IF EXISTS `security_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.security_group_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `security_group_id` bigint(20) NOT NULL,
  `security_permission_key` varchar(255) NOT NULL,
  `can_write` tinyint(4) DEFAULT 0,
  `can_read` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `security_group_id` (`security_group_id`),
  KEY `security_permission_key` (`security_permission_key`),
  CONSTRAINT `security_group_permission_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_permission_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_permission_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `security_group_permission_ibfk_4` FOREIGN KEY (`security_group_id`) REFERENCES `security_group` (`id`),
  CONSTRAINT `security_group_permission_ibfk_5` FOREIGN KEY (`security_permission_key`) REFERENCES `security_permission` (`unique_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2187 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security_permission`
--

DROP TABLE IF EXISTS `security_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.security_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unique_key` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `permission_type` varchar(10) NOT NULL,
  `parent_permission_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`unique_key`),
  KEY `parent_permission_id` (`parent_permission_id`),
  CONSTRAINT `security_permission_ibfk_1` FOREIGN KEY (`parent_permission_id`) REFERENCES `security_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2187 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_contract`
--

DROP TABLE IF EXISTS `service_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.service_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL,
  `contract_manager_id` bigint(20) DEFAULT NULL,
  `primary_engineer_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `fixed_external_order_number` varchar(30) DEFAULT NULL,
  `start_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `renewal_reminder_last_sent` datetime DEFAULT NULL,
  `hold` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `automatic_renewal` tinyint(4) DEFAULT 0,
  `renewal_reminder_required` tinyint(4) DEFAULT 0,
  `renewal_quote_required` tinyint(4) DEFAULT 0,
  `invoice_required` tinyint(4) DEFAULT 0,
  `external_order_number_required` tinyint(4) DEFAULT 0,
  `trading_company_id` bigint(20) NOT NULL,
  `annual_contract_increase` decimal(8,2) DEFAULT 0.00,
  `is_fixed_contract_value` tinyint(4) DEFAULT 0,
  `fixed_contract_value` decimal(10,2) DEFAULT NULL,
  `invoicing_period` enum('Monthly','Quarterly','6 Monthly','Annually') NOT NULL,
  `invoicing_method` enum('In arrears','In advance') NOT NULL,
  `description` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_account_number` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `contact_id` (`contact_id`),
  KEY `currency_id` (`currency_id`),
  KEY `contract_manager_id` (`contract_manager_id`),
  KEY `primary_engineer_id` (`primary_engineer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `start_date` (`start_date`),
  KEY `expiry_date` (`expiry_date`),
  CONSTRAINT `service_contract_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `service_contract_ibfk_10` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `service_contract_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `service_contract_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `service_contract_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `service_contract_ibfk_5` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `service_contract_ibfk_6` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `service_contract_ibfk_7` FOREIGN KEY (`contract_manager_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `service_contract_ibfk_8` FOREIGN KEY (`primary_engineer_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `service_contract_ibfk_9` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setup_setting`
--

DROP TABLE IF EXISTS `setup_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.setup_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `not_applicable` tinyint(1) DEFAULT 0,
  `setup_setting_detail_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `setup_setting_detail_id` (`setup_setting_detail_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `setup_setting_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `setup_setting_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `setup_setting_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `setup_setting_ibfk_4` FOREIGN KEY (`setup_setting_detail_id`) REFERENCES `setup_setting_detail` (`id`),
  CONSTRAINT `setup_setting_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setup_setting_detail`
--

DROP TABLE IF EXISTS `setup_setting_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.setup_setting_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `has_na` tinyint(1) DEFAULT 0,
  `type` enum('Accounting','Other') NOT NULL,
  `button_text` varchar(15) NOT NULL,
  `function_name` varchar(75) DEFAULT NULL,
  `tooltip_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `setup_setting_detail_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `setup_setting_detail_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `setup_setting_detail_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.shipment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `sales_order_id` bigint(20) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `quote_id` bigint(20) DEFAULT NULL,
  `invoice_id` bigint(20) DEFAULT NULL,
  `credit_note_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `address_format_id` bigint(20) NOT NULL,
  `delivery_method_id` bigint(20) DEFAULT NULL,
  `display_label` varchar(50) NOT NULL,
  `shipment_description` varchar(255) NOT NULL,
  `preferred_shipping_date` datetime DEFAULT NULL,
  `required_delivery_date` datetime DEFAULT NULL,
  `tax_reference` varchar(255) DEFAULT NULL,
  `thoroughfare` varchar(255) DEFAULT NULL,
  `premise` varchar(255) DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `administrative_area` varchar(255) DEFAULT NULL,
  `sub_administrative_area` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(2) NOT NULL,
  `all_items_delivered` tinyint(4) DEFAULT 0,
  `is_drop_shipment` tinyint(4) DEFAULT 0,
  `trading_company_id` bigint(20) DEFAULT NULL,
  `ship_from_address_id` bigint(20) DEFAULT NULL,
  `is_ship_to_address_validated` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `quote_id` (`quote_id`),
  KEY `address_format_id` (`address_format_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `ship_from_address_id` (`ship_from_address_id`),
  KEY `delivery_method_id` (`delivery_method_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `credit_note_id` (`credit_note_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `shipment_ibfk_10` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `shipment_ibfk_11` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `shipment_ibfk_12` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `shipment_ibfk_13` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `shipment_ibfk_14` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`),
  CONSTRAINT `shipment_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `shipment_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `shipment_ibfk_4` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_order` (`id`),
  CONSTRAINT `shipment_ibfk_5` FOREIGN KEY (`quote_id`) REFERENCES `quote` (`id`),
  CONSTRAINT `shipment_ibfk_6` FOREIGN KEY (`address_format_id`) REFERENCES `address_format` (`id`),
  CONSTRAINT `shipment_ibfk_7` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `shipment_ibfk_8` FOREIGN KEY (`ship_from_address_id`) REFERENCES `postal_address` (`id`),
  CONSTRAINT `shipment_ibfk_9` FOREIGN KEY (`delivery_method_id`) REFERENCES `delivery_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `contract_id` bigint(20) NOT NULL,
  `location_id` bigint(20) NOT NULL,
  `primary_contact_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  `site_name` varchar(255) NOT NULL,
  `fixed_contract_value` decimal(10,2) DEFAULT NULL,
  `site_hazard` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `contract_id` (`contract_id`),
  KEY `primary_contact_id` (`primary_contact_id`),
  KEY `location_id` (`location_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `site_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `site_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `site_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `site_ibfk_4` FOREIGN KEY (`contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `site_ibfk_5` FOREIGN KEY (`primary_contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `site_ibfk_6` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `site_ibfk_7` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_disciplinary`
--

DROP TABLE IF EXISTS `staff_disciplinary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.staff_disciplinary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) NOT NULL,
  `authorized_by_id` bigint(20) DEFAULT NULL,
  `reason_note_id` bigint(20) DEFAULT NULL,
  `other_note_id` bigint(20) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT 0,
  `disciplinary_date` datetime NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `reason_note_id` (`reason_note_id`),
  KEY `other_note_id` (`other_note_id`),
  CONSTRAINT `staff_disciplinary_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `staff_disciplinary_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `staff_disciplinary_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `staff_disciplinary_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `staff_disciplinary_ibfk_5` FOREIGN KEY (`reason_note_id`) REFERENCES `note` (`id`),
  CONSTRAINT `staff_disciplinary_ibfk_6` FOREIGN KEY (`other_note_id`) REFERENCES `note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sticky_note`
--

DROP TABLE IF EXISTS `sticky_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sticky_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `config` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  CONSTRAINT `sticky_note_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_category`
--

DROP TABLE IF EXISTS `stock_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.stock_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `parent_stock_category_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `parent_stock_category_id` (`parent_stock_category_id`),
  CONSTRAINT `stock_category_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `stock_category_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `stock_category_ibfk_3` FOREIGN KEY (`parent_stock_category_id`) REFERENCES `stock_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `stock_category_path`
--

DROP TABLE IF EXISTS `stock_category_path`;
/*!50001 DROP VIEW IF EXISTS `stock_category_path`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.stock_category_path` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `parent_path` tinyint NOT NULL,
  `parent_path_ids` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `path_ids` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `max_depth` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stock_management_creation_option`
--

DROP TABLE IF EXISTS `stock_management_creation_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.stock_management_creation_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `default_managed_setting` tinyint(4) NOT NULL DEFAULT 1,
  `sales_order_auto_allocate` tinyint(1) NOT NULL DEFAULT 1,
  `job_auto_allocate` tinyint(1) NOT NULL DEFAULT 1,
  `seperate_prefix_by_hyphen` tinyint(1) NOT NULL DEFAULT 1,
  `seperate_suffix_by_hyphen` tinyint(1) NOT NULL DEFAULT 1,
  `sku_number_auto_allocate` tinyint(1) NOT NULL DEFAULT 0,
  `prefix_sku_number` varchar(10) DEFAULT 'SKU',
  `suffix_sku_number` varchar(10) DEFAULT NULL,
  `numeric_sku_number` int(11) NOT NULL DEFAULT 1000,
  `minimum_sku_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `stock_management_creation_option_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `stock_management_creation_option_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `stock_management_creation_option_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `stock_values`
--

DROP TABLE IF EXISTS `stock_values`;
/*!50001 DROP VIEW IF EXISTS `stock_values`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.stock_values` (
  `product_id` tinyint NOT NULL,
  `total_stock` tinyint NOT NULL,
  `available` tinyint NOT NULL,
  `unavailable` tinyint NOT NULL,
  `available_to_consume_now` tinyint NOT NULL,
  `on_po_awaiting_goods` tinyint NOT NULL,
  `pending_stock` tinyint NOT NULL,
  `allocated_stock_job` tinyint NOT NULL,
  `allocated_stock_sales_order` tinyint NOT NULL,
  `back_order_for_sales_order` tinyint NOT NULL,
  `back_order_for_job` tinyint NOT NULL,
  `scheduled_for_sales_order` tinyint NOT NULL,
  `scheduled_for_job` tinyint NOT NULL,
  `total_stock_value` tinyint NOT NULL,
  `awaiting_assembly` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sub_ledger`
--

DROP TABLE IF EXISTS `sub_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.sub_ledger` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `type` enum('Sales','Purchase') NOT NULL,
  `code` varchar(4) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `current_accounting_year_id` bigint(20) DEFAULT NULL,
  `current_accounting_period_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `general_ledger_code_id` (`general_ledger_code_id`),
  UNIQUE KEY `code` (`code`,`trading_company_id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `current_accounting_year_id` (`current_accounting_year_id`),
  KEY `current_accounting_period_id` (`current_accounting_period_id`),
  CONSTRAINT `sub_ledger_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sub_ledger_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sub_ledger_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `sub_ledger_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `sub_ledger_ibfk_5` FOREIGN KEY (`current_accounting_year_id`) REFERENCES `accounting_year` (`id`),
  CONSTRAINT `sub_ledger_ibfk_6` FOREIGN KEY (`current_accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `sub_ledger_ibfk_7` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subledger_customer_supplier`
--

DROP TABLE IF EXISTS `subledger_customer_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.subledger_customer_supplier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `sub_ledger_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `sub_ledger_id` (`sub_ledger_id`),
  KEY `customer_id` (`customer_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `subledger_customer_supplier_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `subledger_customer_supplier_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `subledger_customer_supplier_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `subledger_customer_supplier_ibfk_4` FOREIGN KEY (`sub_ledger_id`) REFERENCES `sub_ledger` (`id`),
  CONSTRAINT `subledger_customer_supplier_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `subledger_customer_supplier_ibfk_6` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suggested_payment_run`
--

DROP TABLE IF EXISTS `suggested_payment_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.suggested_payment_run` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `sub_ledger_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_reference` varchar(50) NOT NULL,
  `bank_account_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  `extra_days` smallint(6) DEFAULT 0,
  `additional_notes` varchar(250) DEFAULT NULL,
  `due_date_used_initially` tinyint(4) NOT NULL DEFAULT 1,
  `report_created` tinyint(4) NOT NULL DEFAULT 0,
  `remittances_created` tinyint(4) NOT NULL DEFAULT 0,
  `authorised` tinyint(4) NOT NULL DEFAULT 0,
  `output_type` enum('Cheque/check remittance','Remittance with no cheque/check','Other') DEFAULT 'Other',
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `sub_ledger_id` (`sub_ledger_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `payment_method_id` (`payment_method_id`),
  KEY `bank_account_id` (`bank_account_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `suggested_payment_run_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_4` FOREIGN KEY (`sub_ledger_id`) REFERENCES `sub_ledger` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_6` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_7` FOREIGN KEY (`bank_account_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `suggested_payment_run_ibfk_8` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suggested_payment_run_cheque_number`
--

DROP TABLE IF EXISTS `suggested_payment_run_cheque_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.suggested_payment_run_cheque_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `suggested_payment_run_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `cheque_number` varchar(20) NOT NULL,
  `value` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `suggested_payment_run_id` (`suggested_payment_run_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `suggested_payment_run_cheque_number_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_cheque_number_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_cheque_number_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_cheque_number_ibfk_4` FOREIGN KEY (`suggested_payment_run_id`) REFERENCES `suggested_payment_run` (`id`),
  CONSTRAINT `suggested_payment_run_cheque_number_ibfk_5` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suggested_payment_run_document`
--

DROP TABLE IF EXISTS `suggested_payment_run_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.suggested_payment_run_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `suggested_payment_run_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) DEFAULT NULL,
  `payment_value` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `suggested_payment_run_id` (`suggested_payment_run_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_4` FOREIGN KEY (`suggested_payment_run_id`) REFERENCES `suggested_payment_run` (`id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_5` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_6` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `suggested_payment_run_document_ibfk_7` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) NOT NULL,
  `supplier_type_id` bigint(20) NOT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `account_number` varchar(50) NOT NULL,
  `supplier_expiry_date` datetime DEFAULT NULL,
  `approved` tinyint(4) DEFAULT 0,
  `closed` tinyint(4) DEFAULT 0,
  `hold` tinyint(4) DEFAULT 0,
  `minority_or_women_owned_business` tinyint(4) DEFAULT 0,
  `field_1099` tinyint(4) DEFAULT 0,
  `bank_internal_account_ref` varchar(32) DEFAULT NULL,
  `bank_account_name` varchar(32) DEFAULT NULL,
  `bank_account_number` varchar(32) DEFAULT NULL,
  `bank_sort_code` varchar(10) DEFAULT NULL,
  `bank_iban` varchar(34) DEFAULT NULL,
  `bank_swift_bic` varchar(11) DEFAULT NULL,
  `certification_number` varchar(34) DEFAULT NULL,
  `bank_account_currency_id` bigint(20) DEFAULT NULL,
  `default_payment_method_id` bigint(20) DEFAULT NULL,
  `sub_ledger_id` bigint(20) DEFAULT NULL,
  `sales_tax_number` varchar(30) DEFAULT NULL,
  `balance_owed` decimal(14,2) NOT NULL DEFAULT 0.00,
  `credit_term_days` bigint(20) DEFAULT 0,
  `federal_tax_id` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `company_id` (`company_id`),
  KEY `supplier_type_id` (`supplier_type_id`),
  KEY `bank_account_currency_id` (`bank_account_currency_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `division_id` (`division_id`),
  KEY `default_payment_method_id` (`default_payment_method_id`),
  KEY `sub_ledger_id` (`sub_ledger_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_ibfk_10` FOREIGN KEY (`sub_ledger_id`) REFERENCES `sub_ledger` (`id`),
  CONSTRAINT `supplier_ibfk_11` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `supplier_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `supplier_ibfk_5` FOREIGN KEY (`supplier_type_id`) REFERENCES `supplier_type` (`id`),
  CONSTRAINT `supplier_ibfk_6` FOREIGN KEY (`bank_account_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_ibfk_7` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `supplier_ibfk_8` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `supplier_ibfk_9` FOREIGN KEY (`default_payment_method_id`) REFERENCES `payment_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier_credit_note`
--

DROP TABLE IF EXISTS `supplier_credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier_credit_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `purchase_currency_id` bigint(20) NOT NULL,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `supplier_branch_id` bigint(20) NOT NULL,
  `supplier_credit_note_date` date NOT NULL,
  `due_date` date NOT NULL,
  `description` varchar(255) NOT NULL,
  `credit_note_number` varchar(50) NOT NULL,
  `approval_date` date DEFAULT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `approved` tinyint(4) DEFAULT 0,
  `posted` tinyint(4) DEFAULT 0,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `purchase_currency_name` varchar(41) NOT NULL,
  `purchase_currency_symbol` varchar(3) NOT NULL,
  `purchase_currency_code` varchar(3) NOT NULL,
  `total_amount_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_outstanding` decimal(10,2) NOT NULL DEFAULT 0.00,
  `credit_note_total` decimal(10,2) GENERATED ALWAYS AS (`amount_outstanding` + `total_amount_paid`) VIRTUAL,
  `paid` tinyint(4) DEFAULT 0,
  `trading_company_id` bigint(20) NOT NULL,
  `total_amount_paid_purchase_currency` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_outstanding_purchase_currency` decimal(10,2) NOT NULL DEFAULT 0.00,
  `credit_note_total_purchase_currency` decimal(10,2) GENERATED ALWAYS AS (`amount_outstanding_purchase_currency` + `total_amount_paid_purchase_currency`) VIRTUAL,
  `period_posted_id` bigint(20) DEFAULT NULL,
  `period_fully_paid_id` bigint(20) DEFAULT NULL,
  `date_fully_paid` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `purchase_currency_id` (`purchase_currency_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `approved_by_id` (`approved_by_id`),
  KEY `supplier_branch_id` (`supplier_branch_id`),
  KEY `period_posted_id` (`period_posted_id`),
  KEY `period_fully_paid_id` (`period_fully_paid_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `supplier_credit_note_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_10` FOREIGN KEY (`period_fully_paid_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_11` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_4` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_5` FOREIGN KEY (`purchase_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_6` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_7` FOREIGN KEY (`approved_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_8` FOREIGN KEY (`supplier_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `supplier_credit_note_ibfk_9` FOREIGN KEY (`period_posted_id`) REFERENCES `accounting_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_outstanding_amount_before_update BEFORE UPDATE ON supplier_credit_note FOR EACH ROW BEGIN
        SET NEW.amount_outstanding = IFNULL((SELECT (SUM(li.gross_total)) - (NEW.total_amount_paid) FROM supplier_credit_note_item li WHERE li.supplier_credit_note_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_OS_amount_in_currency_before_update BEFORE UPDATE ON supplier_credit_note FOR EACH ROW BEGIN
        SET NEW.amount_outstanding_purchase_currency = IFNULL((SELECT (SUM(li.gross_total_in_currency)) - (NEW.total_amount_paid_purchase_currency) FROM supplier_credit_note_item li WHERE li.supplier_credit_note_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `supplier_credit_note_item`
--

DROP TABLE IF EXISTS `supplier_credit_note_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier_credit_note_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `supplier_credit_note_id` bigint(20) NOT NULL,
  `supplier_invoice_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `purchase_order_item_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `price` decimal(10,2) DEFAULT 0.00,
  `price_in_currency` decimal(10,2) DEFAULT 0.00,
  `cost_price` decimal(10,2) DEFAULT 0.00,
  `cost_price_in_currency` decimal(10,2) DEFAULT 0.00,
  `net_total` decimal(13,5) GENERATED ALWAYS AS (`quantity` * `cost_price`) VIRTUAL,
  `gross_total` decimal(13,5) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `net_total_in_currency` decimal(13,5) GENERATED ALWAYS AS (`quantity` * `cost_price_in_currency`) VIRTUAL,
  `gross_total_in_currency` decimal(13,5) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `tax_percent` decimal(5,2) DEFAULT NULL,
  `description` text NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `supplier_credit_note_id` (`supplier_credit_note_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `purchase_order_item_id` (`purchase_order_item_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_10` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `purchase_order_item` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_11` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_12` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_4` FOREIGN KEY (`supplier_credit_note_id`) REFERENCES `supplier_credit_note` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_5` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_6` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_7` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_8` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `supplier_credit_note_item_ibfk_9` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_outstanding_amount_after_item_insert AFTER INSERT ON supplier_credit_note_item FOR EACH ROW BEGIN
        UPDATE supplier_credit_note i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM supplier_credit_note_item li WHERE li.supplier_credit_note_id = i.id) WHERE i.id = NEW.supplier_credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_OS_amnt_in_currency_aftr_item_insert AFTER INSERT ON supplier_credit_note_item FOR EACH ROW BEGIN
        UPDATE supplier_credit_note i SET i.amount_outstanding_purchase_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_purchase_currency) FROM supplier_credit_note_item li WHERE li.supplier_credit_note_id = i.id) WHERE i.id = NEW.supplier_credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_outstanding_amount_after_item_update AFTER UPDATE ON supplier_credit_note_item FOR EACH ROW BEGIN
        UPDATE supplier_credit_note i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM supplier_credit_note_item li WHERE li.supplier_credit_note_id = i.id) WHERE i.id = NEW.supplier_credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_credit_note_OS_amnt_in_currency_aftr_item_update AFTER UPDATE ON supplier_credit_note_item FOR EACH ROW BEGIN
        UPDATE supplier_credit_note i SET i.amount_outstanding_purchase_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_purchase_currency) FROM supplier_credit_note_item li WHERE li.supplier_credit_note_id = i.id) WHERE i.id = NEW.supplier_credit_note_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `supplier_invoice`
--

DROP TABLE IF EXISTS `supplier_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier_invoice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `base_currency_id` bigint(20) NOT NULL,
  `purchase_currency_id` bigint(20) NOT NULL,
  `exchange_rate` decimal(10,2) DEFAULT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `supplier_branch_id` bigint(20) NOT NULL,
  `supplier_invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `description` varchar(255) NOT NULL,
  `invoice_number` varchar(50) DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `awaiting_approval` tinyint(4) DEFAULT 1,
  `payment_approval_required_by_buyer` tinyint(4) DEFAULT 0,
  `approved` tinyint(4) DEFAULT 0,
  `approved_by_buyer` tinyint(4) DEFAULT 0,
  `posted` tinyint(4) DEFAULT 0,
  `view_in_base_currency` tinyint(4) DEFAULT 0,
  `base_currency_name` varchar(41) NOT NULL,
  `base_currency_symbol` varchar(3) NOT NULL,
  `base_currency_code` varchar(3) NOT NULL,
  `purchase_currency_name` varchar(41) NOT NULL,
  `purchase_currency_symbol` varchar(3) NOT NULL,
  `purchase_currency_code` varchar(3) NOT NULL,
  `total_amount_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_outstanding` decimal(10,2) NOT NULL DEFAULT 0.00,
  `invoice_total` decimal(10,2) GENERATED ALWAYS AS (`amount_outstanding` + `total_amount_paid`) VIRTUAL,
  `paid` tinyint(4) DEFAULT 0,
  `trading_company_id` bigint(20) NOT NULL,
  `total_amount_paid_purchase_currency` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_outstanding_purchase_currency` decimal(10,2) NOT NULL DEFAULT 0.00,
  `invoice_total_purchase_currency` decimal(10,2) GENERATED ALWAYS AS (`amount_outstanding_purchase_currency` + `total_amount_paid_purchase_currency`) VIRTUAL,
  `period_posted_id` bigint(20) DEFAULT NULL,
  `period_fully_paid_id` bigint(20) DEFAULT NULL,
  `date_fully_paid` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `purchase_currency_id` (`purchase_currency_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `approved_by_id` (`approved_by_id`),
  KEY `supplier_branch_id` (`supplier_branch_id`),
  KEY `period_posted_id` (`period_posted_id`),
  KEY `period_fully_paid_id` (`period_fully_paid_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `supplier_invoice_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_10` FOREIGN KEY (`period_fully_paid_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_11` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_4` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_5` FOREIGN KEY (`purchase_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_6` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_7` FOREIGN KEY (`approved_by_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_8` FOREIGN KEY (`supplier_branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `supplier_invoice_ibfk_9` FOREIGN KEY (`period_posted_id`) REFERENCES `accounting_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_outstanding_amount_before_update BEFORE UPDATE ON supplier_invoice FOR EACH ROW BEGIN
        SET NEW.amount_outstanding = IFNULL((SELECT (SUM(li.gross_total)) - (NEW.total_amount_paid) FROM supplier_invoice_item li WHERE li.supplier_invoice_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_OS_amount_in_currency_before_update BEFORE UPDATE ON supplier_invoice FOR EACH ROW BEGIN
        SET NEW.amount_outstanding_purchase_currency = IFNULL((SELECT (SUM(li.gross_total_in_currency)) - (NEW.total_amount_paid_purchase_currency) FROM supplier_invoice_item li WHERE li.supplier_invoice_id = NEW.id),0);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `supplier_invoice_item`
--

DROP TABLE IF EXISTS `supplier_invoice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier_invoice_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `supplier_invoice_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) NOT NULL,
  `purchase_order_item_id` bigint(20) DEFAULT NULL,
  `unit_of_measure_id` bigint(20) DEFAULT NULL,
  `general_ledger_code_id` bigint(20) DEFAULT NULL,
  `cost_code_id` bigint(20) DEFAULT NULL,
  `tax_code_id` bigint(20) DEFAULT NULL,
  `tax_value` decimal(10,2) DEFAULT 0.00,
  `tax_value_in_currency` decimal(10,2) DEFAULT 0.00,
  `quantity` decimal(20,10) DEFAULT 1.0000000000,
  `price` decimal(10,2) DEFAULT 0.00,
  `price_in_currency` decimal(10,2) DEFAULT 0.00,
  `cost_price` decimal(10,2) DEFAULT 0.00,
  `cost_price_in_currency` decimal(10,2) DEFAULT 0.00,
  `net_total` decimal(13,5) GENERATED ALWAYS AS (`quantity` * `cost_price`) VIRTUAL,
  `gross_total` decimal(13,5) GENERATED ALWAYS AS (`net_total` + `tax_value`) VIRTUAL,
  `net_total_in_currency` decimal(13,5) GENERATED ALWAYS AS (`quantity` * `cost_price_in_currency`) VIRTUAL,
  `gross_total_in_currency` decimal(13,5) GENERATED ALWAYS AS (`net_total_in_currency` + `tax_value_in_currency`) VIRTUAL,
  `tax_percent` decimal(5,2) DEFAULT NULL,
  `description` text NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `supplier_invoice_id` (`supplier_invoice_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  KEY `tax_code_id` (`tax_code_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `purchase_order_item_id` (`purchase_order_item_id`),
  KEY `general_ledger_code_id` (`general_ledger_code_id`),
  KEY `cost_code_id` (`cost_code_id`),
  CONSTRAINT `supplier_invoice_item_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_10` FOREIGN KEY (`general_ledger_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_11` FOREIGN KEY (`cost_code_id`) REFERENCES `cost_code` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_4` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `supplier_invoice` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_7` FOREIGN KEY (`tax_code_id`) REFERENCES `tax_code` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_8` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  CONSTRAINT `supplier_invoice_item_ibfk_9` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `purchase_order_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_outstanding_amount_after_item_insert AFTER INSERT ON supplier_invoice_item FOR EACH ROW BEGIN
        UPDATE supplier_invoice i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM supplier_invoice_item li WHERE li.supplier_invoice_id = i.id) WHERE i.id = NEW.supplier_invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_OS_amount_in_currency_after_item_insert AFTER INSERT ON supplier_invoice_item FOR EACH ROW BEGIN
        UPDATE supplier_invoice i SET i.amount_outstanding_purchase_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_purchase_currency) FROM supplier_invoice_item li WHERE li.supplier_invoice_id = i.id) WHERE i.id = NEW.supplier_invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_outstanding_amount_after_item_update AFTER UPDATE ON supplier_invoice_item FOR EACH ROW BEGIN
        UPDATE supplier_invoice i SET i.amount_outstanding = (SELECT (SUM(li.gross_total)) - (i.total_amount_paid) FROM supplier_invoice_item li WHERE li.supplier_invoice_id = i.id) WHERE i.id = NEW.supplier_invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`appadmin`@`localhost`*/ /*!50003 TRIGGER update_supplier_invoice_OS_amount_in_currency_after_item_update AFTER UPDATE ON supplier_invoice_item FOR EACH ROW BEGIN
        UPDATE supplier_invoice i SET i.amount_outstanding_purchase_currency = (SELECT (SUM(li.gross_total_in_currency)) - (i.total_amount_paid_purchase_currency) FROM supplier_invoice_item li WHERE li.supplier_invoice_id = i.id) WHERE i.id = NEW.supplier_invoice_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `supplier_remittance`
--

DROP TABLE IF EXISTS `supplier_remittance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier_remittance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `bank_id` bigint(20) NOT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `cheque_number` varchar(20) DEFAULT NULL,
  `is_void` tinyint(1) DEFAULT 0,
  `void_period_id` bigint(20) DEFAULT NULL,
  `void_date` date DEFAULT NULL,
  `payment_made_on` date NOT NULL,
  `amount_paid` decimal(10,2) DEFAULT 0.00,
  `amount_paid_in_currency` decimal(10,2) DEFAULT 0.00,
  `currency_id` bigint(20) NOT NULL,
  `document_currency_id` bigint(20) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `cleared_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `bank_id` (`bank_id`),
  KEY `payment_method_id` (`payment_method_id`),
  KEY `currency_id` (`currency_id`),
  KEY `document_currency_id` (`document_currency_id`),
  KEY `void_period_id` (`void_period_id`),
  CONSTRAINT `supplier_remittance_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_4` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_5` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_6` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_7` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_8` FOREIGN KEY (`document_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `supplier_remittance_ibfk_9` FOREIGN KEY (`void_period_id`) REFERENCES `accounting_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier_type`
--

DROP TABLE IF EXISTS `supplier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.supplier_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `supplier_type_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_type_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `supplier_type_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_ticket`
--

DROP TABLE IF EXISTS `support_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.support_ticket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `service_contract_id` bigint(20) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `requires_asset` tinyint(4) DEFAULT 1,
  `closed` tinyint(4) DEFAULT 0,
  `awaiting_response` tinyint(4) DEFAULT 0,
  `closed_on` datetime DEFAULT NULL,
  `time_open` bigint(20) DEFAULT NULL,
  `time_booked` bigint(20) DEFAULT 0,
  `customer_name` varchar(255) NOT NULL,
  `customer_account_number` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `customer_id` (`customer_id`),
  KEY `service_contract_id` (`service_contract_id`),
  KEY `asset_id` (`asset_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `support_ticket_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `support_ticket_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `support_ticket_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `support_ticket_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `support_ticket_ibfk_5` FOREIGN KEY (`service_contract_id`) REFERENCES `service_contract` (`id`),
  CONSTRAINT `support_ticket_ibfk_6` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `support_ticket_ibfk_7` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `support_ticket_ibfk_8` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_ticket_creation_option`
--

DROP TABLE IF EXISTS `support_ticket_creation_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.support_ticket_creation_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `create_with_asset` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `support_ticket_creation_option_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `support_ticket_creation_option_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `support_ticket_creation_option_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system_admin_setting`
--

DROP TABLE IF EXISTS `system_admin_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.system_admin_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `unique_key` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `helper` varchar(255) DEFAULT NULL,
  `group_name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `value_boolean` tinyint(4) DEFAULT 1,
  `validation_regex` text NOT NULL,
  `validation_message` text NOT NULL,
  `data_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_call_log`
--

DROP TABLE IF EXISTS `task_call_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.task_call_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `assigned_employee_id` bigint(20) DEFAULT NULL,
  `assigned_department_id` bigint(20) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT '',
  `complete` tinyint(4) DEFAULT 0,
  `open` tinyint(4) DEFAULT 1,
  `hold` tinyint(4) DEFAULT 0,
  `logged_on` datetime NOT NULL DEFAULT current_timestamp(),
  `type` varchar(50) DEFAULT NULL,
  `model_type` varchar(25) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `outcome_id` bigint(20) DEFAULT NULL,
  `pending_support_ticket_id` bigint(20) DEFAULT NULL,
  `contact_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `prospect_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `call_log_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `owner_id` (`owner_id`),
  KEY `assigned_employee_id` (`assigned_employee_id`),
  KEY `assigned_department_id` (`assigned_department_id`),
  KEY `outcome_id` (`outcome_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  KEY `pending_support_ticket_id` (`pending_support_ticket_id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `contact_id` (`contact_id`),
  KEY `customer_id` (`customer_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `prospect_id` (`prospect_id`),
  KEY `task_id` (`task_id`),
  KEY `call_log_id` (`call_log_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `task_call_log_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `task_call_log_ibfk_10` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `task_call_log_ibfk_11` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `task_call_log_ibfk_12` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `task_call_log_ibfk_13` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `task_call_log_ibfk_14` FOREIGN KEY (`prospect_id`) REFERENCES `prospect` (`id`),
  CONSTRAINT `task_call_log_ibfk_15` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `task_call_log_ibfk_16` FOREIGN KEY (`call_log_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `task_call_log_ibfk_17` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `task_call_log_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `task_call_log_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `task_call_log_ibfk_4` FOREIGN KEY (`assigned_employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `task_call_log_ibfk_5` FOREIGN KEY (`assigned_department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `task_call_log_ibfk_6` FOREIGN KEY (`outcome_id`) REFERENCES `call_log_outcome` (`id`),
  CONSTRAINT `task_call_log_ibfk_7` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `task_call_log_ibfk_8` FOREIGN KEY (`pending_support_ticket_id`) REFERENCES `support_ticket` (`id`),
  CONSTRAINT `task_call_log_ibfk_9` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_relation`
--

DROP TABLE IF EXISTS `task_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.task_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `sales_pipeline_id` bigint(20) DEFAULT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `job_id` (`job_id`),
  KEY `sales_pipeline_id` (`sales_pipeline_id`),
  KEY `support_ticket_id` (`support_ticket_id`),
  CONSTRAINT `task_relation_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task_call_log` (`id`),
  CONSTRAINT `task_relation_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `task_relation_ibfk_3` FOREIGN KEY (`sales_pipeline_id`) REFERENCES `sales_pipeline` (`id`),
  CONSTRAINT `task_relation_ibfk_4` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_code`
--

DROP TABLE IF EXISTS `tax_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.tax_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `tax_code` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `tax_code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `tax_code_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `tax_code_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_integration_details`
--

DROP TABLE IF EXISTS `tax_integration_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.tax_integration_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `type` enum('Avalara AvaTax','None') NOT NULL,
  `authentication_type` enum('Username/Password','AccountID/LicenceKey') NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `account_id` varchar(25) DEFAULT NULL,
  `licence_key` varchar(128) DEFAULT NULL,
  `is_sandbox` tinyint(1) DEFAULT 0,
  `validate_address_on_change` tinyint(1) DEFAULT 0,
  `validate_supplier_addresses` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `tax_integration_details_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `tax_integration_details_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `tax_integration_details_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_member`
--

DROP TABLE IF EXISTS `team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.team_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `branch_id` bigint(20) NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `branch_id` (`branch_id`),
  KEY `employee_id` (`employee_id`),
  KEY `role` (`role`),
  CONSTRAINT `team_member_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `team_member_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `team_member_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `team_member_ibfk_4` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  CONSTRAINT `team_member_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `third_party_goods_received`
--

DROP TABLE IF EXISTS `third_party_goods_received`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.third_party_goods_received` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `quantity` decimal(20,10) NOT NULL,
  `unit_of_measure_id` bigint(20) NOT NULL,
  `delivery_note_number` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_note_number` (`delivery_note_number`),
  KEY `creator_id` (`creator_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `editor_id` (`editor_id`),
  KEY `location_id` (`location_id`),
  KEY `product_id` (`product_id`),
  KEY `unit_of_measure_id` (`unit_of_measure_id`),
  CONSTRAINT `third_party_goods_received_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `third_party_goods_received_ibfk_2` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `third_party_goods_received_ibfk_3` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `third_party_goods_received_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `third_party_goods_received_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `third_party_goods_received_ibfk_6` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `product_unit_of_measure` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_sheet_creation_option`
--

DROP TABLE IF EXISTS `time_sheet_creation_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.time_sheet_creation_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `job_max_duration` decimal(2,1) NOT NULL,
  `support_ticket_max_duration` decimal(2,1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `time_sheet_creation_option_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `time_sheet_creation_option_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `time_sheet_creation_option_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeline_configuration`
--

DROP TABLE IF EXISTS `timeline_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.timeline_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `user_id` bigint(20) DEFAULT NULL,
  `source_entity` varchar(50) NOT NULL,
  `configuration` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`source_entity`),
  CONSTRAINT `timeline_configuration_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `timeline_entry`
--

DROP TABLE IF EXISTS `timeline_entry`;
/*!50001 DROP VIEW IF EXISTS `timeline_entry`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.timeline_entry` (
  `id` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `creator_id` tinyint NOT NULL,
  `note_text` tinyint NOT NULL,
  `note_raw` tinyint NOT NULL,
  `event_type` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `source_entity` tinyint NOT NULL,
  `source_entity_id` tinyint NOT NULL,
  `asset_id` tinyint NOT NULL,
  `call_log_id` tinyint NOT NULL,
  `company_id` tinyint NOT NULL,
  `contact_id` tinyint NOT NULL,
  `credit_note_id` tinyint NOT NULL,
  `customer_id` tinyint NOT NULL,
  `department_id` tinyint NOT NULL,
  `division_id` tinyint NOT NULL,
  `document_id` tinyint NOT NULL,
  `email_id` tinyint NOT NULL,
  `employee_id` tinyint NOT NULL,
  `invoice_id` tinyint NOT NULL,
  `job_id` tinyint NOT NULL,
  `non_compliance_report_id` tinyint NOT NULL,
  `note_id` tinyint NOT NULL,
  `opportunity_id` tinyint NOT NULL,
  `product_batch_id` tinyint NOT NULL,
  `product_id` tinyint NOT NULL,
  `project_id` tinyint NOT NULL,
  `quote_id` tinyint NOT NULL,
  `prospect_id` tinyint NOT NULL,
  `purchase_order_id` tinyint NOT NULL,
  `product_unit_id` tinyint NOT NULL,
  `resource_id` tinyint NOT NULL,
  `site_id` tinyint NOT NULL,
  `resource_group_id` tinyint NOT NULL,
  `resource_tag_name_id` tinyint NOT NULL,
  `sales_order_id` tinyint NOT NULL,
  `service_contract_id` tinyint NOT NULL,
  `supplier_id` tinyint NOT NULL,
  `support_ticket_id` tinyint NOT NULL,
  `trading_company_id` tinyint NOT NULL,
  `supplier_invoice_id` tinyint NOT NULL,
  `supplier_credit_note_id` tinyint NOT NULL,
  `warehouse_location_id` tinyint NOT NULL,
  `returns_authorisation_id` tinyint NOT NULL,
  `branch_id` tinyint NOT NULL,
  `operation_id` tinyint NOT NULL,
  `customer_remittance_id` tinyint NOT NULL,
  `user_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `title`
--

DROP TABLE IF EXISTS `title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.title` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `title_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `title_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `title_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_company`
--

DROP TABLE IF EXISTS `trading_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.trading_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `multi_currency` tinyint(4) DEFAULT 1,
  `default_currency_id` bigint(20) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `gl_code_prefix` varchar(3) NOT NULL,
  `invoice_prefix` varchar(8) DEFAULT NULL,
  `credit_note_prefix` varchar(8) DEFAULT NULL,
  `invoice_starting_number` bigint(20) NOT NULL,
  `credit_note_starting_number` bigint(20) NOT NULL,
  `quote_starting_number` bigint(20) NOT NULL,
  `purchase_order_starting_number` bigint(20) NOT NULL,
  `sales_order_starting_number` bigint(20) NOT NULL,
  `delivery_note_starting_number` bigint(20) NOT NULL,
  `returns_auth_starting_number` bigint(20) NOT NULL,
  `job_starting_number` bigint(20) NOT NULL,
  `job_template_starting_number` bigint(20) NOT NULL,
  `project_starting_number` bigint(20) NOT NULL,
  `is_dormant` tinyint(4) DEFAULT 0,
  `sales_tax_number` varchar(30) DEFAULT NULL,
  `business_registration_number` varchar(30) DEFAULT NULL,
  `terms_document_uuid` varchar(36) DEFAULT NULL,
  `cost_codes_used` tinyint(4) DEFAULT 0,
  `cost_code_elements_used` enum('One','Two') DEFAULT 'Two',
  `retained_earnings_gl_code_id` bigint(20) DEFAULT NULL,
  `input_tax_gl_code_id` bigint(20) DEFAULT NULL,
  `output_tax_gl_code_id` bigint(20) DEFAULT NULL,
  `exchange_rate_difference_gl_code_id` bigint(20) DEFAULT NULL,
  `deposit_gl_code_id` bigint(20) DEFAULT NULL,
  `current_accounting_year_id` bigint(20) DEFAULT NULL,
  `current_accounting_period_id` bigint(20) DEFAULT NULL,
  `is_period_being_closed` tinyint(4) DEFAULT 0,
  `start_date_number` smallint(6) NOT NULL,
  `start_month_number` smallint(6) NOT NULL,
  `end_date_number` smallint(6) NOT NULL,
  `end_month_number` smallint(6) NOT NULL,
  `is_set_up_completed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `default_currency_id` (`default_currency_id`),
  KEY `company_name` (`company_name`),
  KEY `current_accounting_year_id` (`current_accounting_year_id`),
  KEY `current_accounting_period_id` (`current_accounting_period_id`),
  KEY `retained_earnings_gl_code_id` (`retained_earnings_gl_code_id`),
  KEY `input_tax_gl_code_id` (`input_tax_gl_code_id`),
  KEY `output_tax_gl_code_id` (`output_tax_gl_code_id`),
  KEY `exchange_rate_difference_gl_code_id` (`exchange_rate_difference_gl_code_id`),
  CONSTRAINT `trading_company_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `trading_company_ibfk_10` FOREIGN KEY (`exchange_rate_difference_gl_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `trading_company_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `trading_company_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `trading_company_ibfk_4` FOREIGN KEY (`default_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `trading_company_ibfk_5` FOREIGN KEY (`current_accounting_year_id`) REFERENCES `accounting_year` (`id`),
  CONSTRAINT `trading_company_ibfk_6` FOREIGN KEY (`current_accounting_period_id`) REFERENCES `accounting_period` (`id`),
  CONSTRAINT `trading_company_ibfk_7` FOREIGN KEY (`retained_earnings_gl_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `trading_company_ibfk_8` FOREIGN KEY (`input_tax_gl_code_id`) REFERENCES `general_ledger_code` (`id`),
  CONSTRAINT `trading_company_ibfk_9` FOREIGN KEY (`output_tax_gl_code_id`) REFERENCES `general_ledger_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_company_email_address`
--

DROP TABLE IF EXISTS `trading_company_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.trading_company_email_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) NOT NULL,
  `email_address_id` bigint(20) NOT NULL,
  `note` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `trading_company_id` (`trading_company_id`),
  KEY `email_address_id` (`email_address_id`),
  CONSTRAINT `trading_company_email_address_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `trading_company_email_address_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `trading_company_email_address_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `trading_company_email_address_ibfk_4` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `trading_company_email_address_ibfk_5` FOREIGN KEY (`email_address_id`) REFERENCES `email_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unit_of_measure`
--

DROP TABLE IF EXISTS `unit_of_measure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.unit_of_measure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) NOT NULL,
  `measure_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `unit_of_measure_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `unit_of_measure_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `unit_of_measure_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `unit_of_measure_ibfk_4` FOREIGN KEY (`group_id`) REFERENCES `unit_of_measure_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unit_of_measure_group`
--

DROP TABLE IF EXISTS `unit_of_measure_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.unit_of_measure_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `unit_of_measure_group_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `unit_of_measure_group_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `unit_of_measure_group_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `us_tax_code`
--

DROP TABLE IF EXISTS `us_tax_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.us_tax_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `state_code` varchar(255) NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `combined_rate` decimal(10,4) NOT NULL,
  `state_rate` decimal(10,4) NOT NULL,
  `country_rate` decimal(10,4) NOT NULL,
  `city_rate` decimal(10,4) NOT NULL,
  `special_rate` decimal(10,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `us_tax_code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `us_tax_code_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `us_tax_code_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_trading_company`
--

DROP TABLE IF EXISTS `user_trading_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.user_trading_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `trading_company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `user_id` (`user_id`),
  KEY `trading_company_id` (`trading_company_id`),
  CONSTRAINT `user_trading_company_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `user_trading_company_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `user_trading_company_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `user_trading_company_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `user_trading_company_ibfk_5` FOREIGN KEY (`trading_company_id`) REFERENCES `trading_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `warehouse_accessibility`
--

DROP TABLE IF EXISTS `warehouse_accessibility`;
/*!50001 DROP VIEW IF EXISTS `warehouse_accessibility`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.warehouse_accessibility` (
  `id` tinyint NOT NULL,
  `location_id` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `division_id` tinyint NOT NULL,
  `department_id` tinyint NOT NULL,
  `ref_id` tinyint NOT NULL,
  `parent_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `warehouse_department`
--

DROP TABLE IF EXISTS `warehouse_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.warehouse_department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `warehouse_location_id` bigint(20) NOT NULL,
  `department_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `warehouse_location_id` (`warehouse_location_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `warehouse_department_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_department_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_department_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_department_ibfk_4` FOREIGN KEY (`warehouse_location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `warehouse_department_ibfk_5` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_division`
--

DROP TABLE IF EXISTS `warehouse_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.warehouse_division` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `warehouse_location_id` bigint(20) DEFAULT NULL,
  `division_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `warehouse_location_id` (`warehouse_location_id`),
  KEY `division_id` (`division_id`),
  CONSTRAINT `warehouse_division_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_division_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_division_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_division_ibfk_4` FOREIGN KEY (`warehouse_location_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `warehouse_division_ibfk_5` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_location`
--

DROP TABLE IF EXISTS `warehouse_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.warehouse_location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_company_id` bigint(20) NOT NULL,
  `address_id` bigint(20) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `locked` tinyint(4) DEFAULT 0,
  `available_for_allocation` tinyint(4) DEFAULT 1,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dimensions` varchar(255) DEFAULT NULL,
  `max_weight` varchar(255) DEFAULT NULL,
  `min_temperature` varchar(255) DEFAULT NULL,
  `max_temperature` varchar(255) DEFAULT NULL,
  `access_notes` varchar(255) DEFAULT NULL,
  `further_notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `parent_id` (`parent_id`),
  KEY `parent_company_id` (`parent_company_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `warehouse_location_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_location_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_location_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `warehouse_location_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `warehouse_location` (`id`),
  CONSTRAINT `warehouse_location_ibfk_5` FOREIGN KEY (`parent_company_id`) REFERENCES `trading_company` (`id`),
  CONSTRAINT `warehouse_location_ibfk_6` FOREIGN KEY (`address_id`) REFERENCES `postal_address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `warehouse_location_path`
--

DROP TABLE IF EXISTS `warehouse_location_path`;
/*!50001 DROP VIEW IF EXISTS `warehouse_location_path`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.warehouse_location_path` (
  `id` tinyint NOT NULL,
  `location_name` tinyint NOT NULL,
  `parent_path` tinyint NOT NULL,
  `parent_path_ids` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `path_ids` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `max_depth` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `warehouse_location_stock_quantity`
--

DROP TABLE IF EXISTS `warehouse_location_stock_quantity`;
/*!50001 DROP VIEW IF EXISTS `warehouse_location_stock_quantity`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `businessman.warehouse_location_stock_quantity` (
  `location` tinyint NOT NULL,
  `product` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `quantity` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zone`
--

DROP TABLE IF EXISTS `zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.zone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  CONSTRAINT `zone_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `zone_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `zone_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zone_country`
--

DROP TABLE IF EXISTS `zone_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessman.zone_country` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp(6) NOT NULL DEFAULT current_timestamp(6),
  `last_edited` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `creator_id` bigint(20) NOT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `destroyer_id` bigint(20) DEFAULT NULL,
  `zone_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `editor_id` (`editor_id`),
  KEY `destroyer_id` (`destroyer_id`),
  KEY `zone_id` (`zone_id`),
  CONSTRAINT `zone_country_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `zone_country_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `zone_country_ibfk_3` FOREIGN KEY (`destroyer_id`) REFERENCES `application_user` (`id`),
  CONSTRAINT `zone_country_ibfk_4` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'businessman1711base'
--

--
-- Final view structure for view `all_job_cost`
--

/*!50001 DROP TABLE IF EXISTS `all_job_cost`*/;
/*!50001 DROP VIEW IF EXISTS `all_job_cost`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_job_cost` AS select concat('jc',`jc`.`id`) AS `id`,`jc`.`id` AS `table_id`,'Adhoc cost' AS `type`,`jc`.`cost` AS `cost`,`jc`.`invoice_cost` AS `invoice_cost`,`jc`.`job_id` AS `job_id`,`jc`.`for_invoice` AS `Include_in_invoice`,`jc`.`description` AS `description_cost`,`jc`.`created` AS `created_on` from `job_cost` `jc` union select concat('ic',`ic`.`id`) AS `id`,`ic`.`id` AS `table_id`,'Inventory cost' AS `type`,`p`.`normal_sell_price` * `ic`.`quantity` AS `cost`,`ic`.`invoice_cost` AS `invoice_cost`,`ic`.`job_id` AS `job_id`,`ic`.`for_invoice` AS `Include_in_invoice`,`ic`.`description` AS `description_cost`,`ic`.`created` AS `created_on` from (`inventory_cost` `ic` join `product` `p` on(`ic`.`product_id` = `p`.`id`)) union select concat('ji',`ji`.`id`) AS `id`,`ji`.`id` AS `table_id`,'Item cost' AS `type`,`p`.`cost_price` * `ji`.`quantity` AS `cost`,`p`.`cost_price` * `ji`.`quantity` AS `invoice_cost`,`ji`.`job_id` AS `job_id`,1 AS `Include_in_invoice`,`p`.`description` AS `description_cost`,`ji`.`created` AS `created_on` from (`job_item` `ji` join `product` `p` on(`ji`.`product_id` = `p`.`id`)) union select concat('po',`po`.`id`) AS `id`,`po`.`id` AS `table_id`,'Purchase order cost' AS `type`,(select sum(`purchase_order`.`purchase_order_total`) from `purchase_order` where `purchase_order`.`id` = `po`.`id`) AS `cost`,(select sum(`purchase_order`.`purchase_order_total`) from `purchase_order` where `purchase_order`.`id` = `po`.`id`) AS `invoice_cost`,`po`.`job_id` AS `job_id`,`pojc`.`for_invoice` AS `Include_in_invoice`,concat('PO for ',`co`.`company_name`) AS `description_cost`,`po`.`created` AS `created_on` from ((((`purchase_order` `po` left join `purchase_order_item` `poi` on(`po`.`id` = `poi`.`purchase_order_id`)) left join `purchase_order_job_cost` `pojc` on(`po`.`id` = `pojc`.`purchase_order_id`)) join `supplier` `s` on(`po`.`supplier_id` = `s`.`id`)) join `company` `co` on(`s`.`company_id` = `co`.`id`)) union select concat('lc',`lc`.`id`) AS `id`,`lc`.`id` AS `table_id`,'Labour cost' AS `type`,`lc`.`cost` AS `cost`,`lc`.`invoice_cost` AS `invoice_cost`,`lc`.`job_id` AS `job_id`,`lc`.`for_invoice` AS `Include_in_invoice`,`lc`.`description` AS `description_cost`,`lc`.`created` AS `created_on` from `labour_cost` `lc` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `all_so_costs`
--

/*!50001 DROP TABLE IF EXISTS `all_so_costs`*/;
/*!50001 DROP VIEW IF EXISTS `all_so_costs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_so_costs` AS select concat('adhoc',`soad`.`id`) AS `id`,`soad`.`id` AS `table_id`,NULL AS `job_id`,NULL AS `purchase_order_id`,'Adhoc cost' AS `type`,`soad`.`cost` AS `cost`,`soad`.`sales_order_id` AS `sales_order_id`,`soad`.`description` AS `description`,`soad`.`created` AS `created_on`,`soad`.`include_cost` AS `include_cost` from `sales_order_adhoc` `soad` union select `jc`.`id` AS `id`,`jc`.`table_id` AS `table_id`,`j`.`id` AS `job_id`,NULL AS `purchase_order_id`,'Job cost' AS `type`,`jc`.`cost` AS `cost`,`so`.`id` AS `sales_order_id`,`jc`.`description_cost` AS `description`,`jc`.`created_on` AS `created_on`,`jc`.`Include_in_invoice` AS `include_cost` from ((`all_job_cost` `jc` join `job` `j` on(`jc`.`job_id` = `j`.`id`)) join `sales_order` `so` on(`j`.`sales_order_id` = `so`.`id`)) union select concat('po',`po`.`id`) AS `id`,`po`.`id` AS `table_id`,NULL AS `job_id`,`po`.`id` AS `purchase_order_id`,'Purchase order cost' AS `type`,(select sum(`purchase_order`.`purchase_order_total`) from `purchase_order` where `purchase_order`.`id` = `po`.`id`) AS `cost`,`po`.`sales_order_id` AS `sales_order_id`,concat('PO for ',`co`.`company_name`) AS `description`,`po`.`created` AS `created_on`,`po`.`include_cost_for_sales_order` AS `include_cost` from ((((`purchase_order` `po` left join `purchase_order_item` `poi` on(`po`.`id` = `poi`.`purchase_order_id`)) join `supplier` `s` on(`po`.`supplier_id` = `s`.`id`)) join `company` `co` on(`s`.`company_id` = `co`.`id`)) join `sales_order` `so` on(`po`.`sales_order_id` = `so`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `company_customer_supplier_prospect`
--

/*!50001 DROP TABLE IF EXISTS `company_customer_supplier_prospect`*/;
/*!50001 DROP VIEW IF EXISTS `company_customer_supplier_prospect`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `company_customer_supplier_prospect` AS select row_number() over ( order by `co`.`id`) AS `id`,`co`.`id` AS `company_id`,`cu`.`id` AS `customer_id`,`su`.`id` AS `supplier_id`,`pr`.`id` AS `prospect_id` from (((`company` `co` left join `customer` `cu` on(`cu`.`company_id` = `co`.`id`)) left join `supplier` `su` on(`su`.`company_id` = `co`.`id`)) left join `prospect` `pr` on(`pr`.`company_id` = `co`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `resource_accessibility`
--

/*!50001 DROP TABLE IF EXISTS `resource_accessibility`*/;
/*!50001 DROP VIEW IF EXISTS `resource_accessibility`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `resource_accessibility` AS select concat('div',`dvr`.`id`) AS `id`,`dvr`.`resource_id` AS `resource_id`,'Division' AS `type`,`d`.`id` AS `division_id`,NULL AS `department_id`,`d`.`id` AS `ref_id`,`t`.`company_name` AS `parent_name` from (((`division_resource` `dvr` join `resource` `r` on(`dvr`.`resource_id` = `r`.`id`)) join `division` `d` on(`dvr`.`division_id` = `d`.`id`)) join `trading_company` `t` on(`d`.`parent_company_id` = `t`.`id`)) union select concat('dep',`dpr`.`id`) AS `id`,`dpr`.`resource_id` AS `resource_id`,'Department' AS `type`,NULL AS `division_id`,`dp`.`id` AS `department_id`,`dp`.`id` AS `ref_id`,`dv`.`division_name` AS `parent_name` from (((`department_resource` `dpr` join `resource` `r` on(`dpr`.`resource_id` = `r`.`id`)) join `department` `dp` on(`dpr`.`department_id` = `dp`.`id`)) join `division` `dv` on(`dp`.`division_id` = `dv`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_category_path`
--

/*!50001 DROP TABLE IF EXISTS `stock_category_path`*/;
/*!50001 DROP VIEW IF EXISTS `stock_category_path`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_category_path` AS with recursive parents as (select `businessman`.`stock_category`.`id` AS `id`,`businessman`.`stock_category`.`parent_stock_category_id` AS `parent_stock_category_id`,`businessman`.`stock_category`.`name` AS `name`,cast('' as char(255) charset utf8) AS `parent_path`,cast(`businessman`.`stock_category`.`name` as char(255) charset utf8) AS `path`,cast('' as char(255) charset utf8) AS `parent_path_ids`,cast(`businessman`.`stock_category`.`id` as char(255) charset utf8) AS `path_ids`,0 AS `depth` from `businessman`.`stock_category` union all select `sc`.`id` AS `id`,`sc`.`parent_stock_category_id` AS `parent_stock_category_id`,`sc`.`name` AS `name`,`parents`.`path` AS `parent_path`,if(`parents`.`path` = '',`sc`.`name`,concat(`parents`.`path`,' ➔ ',`sc`.`name`)) AS `path`,`parents`.`path_ids` AS `parent_path_ids`,if(`parents`.`path_ids` = '',`sc`.`id`,concat(`parents`.`path_ids`,',',`sc`.`id`)) AS `path_ids`,`parents`.`depth` + 1 AS `depth` from (`businessman`.`stock_category` `sc` join `parents` on(`sc`.`parent_stock_category_id` = `parents`.`id`)) where `parents`.`id` <> `sc`.`id`)select `p1`.`id` AS `id`,`p1`.`name` AS `name`,`p1`.`parent_path` AS `parent_path`,`p1`.`parent_path_ids` AS `parent_path_ids`,`p1`.`path` AS `path`,`p1`.`path_ids` AS `path_ids`,`p1`.`depth` AS `depth`,(select max(`p2`.`depth`) from `parents` `p2` where `p1`.`id` = `p2`.`id`) AS `max_depth` from `parents` `p1` having `p1`.`depth` = `max_depth` order by `p1`.`path` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_values`
--

/*!50001 DROP TABLE IF EXISTS `stock_values`*/;
/*!50001 DROP VIEW IF EXISTS `stock_values`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_values` AS select `q1`.`stock_id` AS `product_id`,if(`q1`.`is_unit_tracked`,`q1`.`unit_tracked_stock`,if(`q1`.`is_batch_tracked`,`q1`.`batch_tracked_stock`,`q1`.`total_stock`)) AS `total_stock`,if(`q1`.`is_unit_tracked`,`q1`.`available_unit_tracked`,if(`q1`.`is_batch_tracked`,`q1`.`available_batch_tracked`,`q1`.`available`)) AS `available`,if(`q1`.`is_unit_tracked`,`q1`.`unavailable_unit_tracked`,if(`q1`.`is_batch_tracked`,`q1`.`unavailable_batch_tracked`,`q1`.`unavailable`)) AS `unavailable`,if(`q1`.`is_unit_tracked`,`q1`.`available_unit_tracked` - `q1`.`allocated_stock_job_unit_tracked` - `q1`.`allocated_stock_sales_order_unit_tracked`,if(`q1`.`is_batch_tracked`,`q1`.`available_batch_tracked` - `q1`.`allocated_stock_job_batch_tracked` - `q1`.`allocated_stock_sales_order_batch_tracked`,`q1`.`available` - `q1`.`allocated_stock_job` - `q1`.`allocated_stock_sales_order`)) AS `available_to_consume_now`,`q1`.`on_po_awaiting_goods` AS `on_po_awaiting_goods`,`q1`.`on_po_awaiting_goods` + ifnull(`q1`.`awaiting_assembly`,0) + if(`q1`.`is_unit_tracked`,`q1`.`unit_tracked_stock`,if(`q1`.`is_batch_tracked`,`q1`.`batch_tracked_stock`,`q1`.`total_stock`)) AS `pending_stock`,if(`q1`.`is_unit_tracked`,`q1`.`allocated_stock_job_unit_tracked`,if(`q1`.`is_batch_tracked`,`q1`.`allocated_stock_job_batch_tracked`,`q1`.`allocated_stock_job`)) AS `allocated_stock_job`,if(`q1`.`is_unit_tracked`,`q1`.`allocated_stock_sales_order_unit_tracked`,if(`q1`.`is_batch_tracked`,`q1`.`allocated_stock_sales_order_batch_tracked`,`q1`.`allocated_stock_sales_order`)) AS `allocated_stock_sales_order`,`q1`.`back_order_for_sales_order` AS `back_order_for_sales_order`,`q1`.`back_order_for_job` AS `back_order_for_job`,`q1`.`scheduled_for_sales_order` AS `scheduled_for_sales_order`,`q1`.`scheduled_for_job` AS `scheduled_for_job`,ifnull(`q1`.`total_stock`,0) * ifnull(`q1`.`cost_price`,0) AS `total_stock_value`,ifnull(`q1`.`awaiting_assembly`,0) AS `awaiting_assembly` from (select `businessman`.`product`.`id` AS `stock_id`,`businessman`.`product`.`unit_tracked` AS `is_unit_tracked`,`businessman`.`product`.`batch_tracked` AS `is_batch_tracked`,`businessman`.`product`.`is_assembly` AS `is_assembly`,`businessman`.`product`.`cost_price` AS `cost_price`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from `businessman`.`product_location` where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_unit_id` is null and `businessman`.`product_location`.`product_batch_id` is null and `businessman`.`product_location`.`location_id` is not null) AS `total_stock`,(select ifnull(count(`businessman`.`product_location`.`id`),0) from `businessman`.`product_location` where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_unit_id` is not null and `businessman`.`product_location`.`location_id` is not null) AS `unit_tracked_stock`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from `businessman`.`product_location` where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_batch_id` is not null and `businessman`.`product_location`.`location_id` is not null) AS `batch_tracked_stock`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`warehouse_location` on(`businessman`.`product_location`.`location_id` = `businessman`.`warehouse_location`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_unit_id` is null and `businessman`.`product_location`.`product_batch_id` is null and `businessman`.`warehouse_location`.`available_for_allocation` = 1) AS `available`,(select ifnull(count(`businessman`.`product_location`.`location_id`),0) from (`businessman`.`product_location` join `businessman`.`warehouse_location` on(`businessman`.`product_location`.`location_id` = `businessman`.`warehouse_location`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_unit_id` is not null and `businessman`.`warehouse_location`.`available_for_allocation` = 1) AS `available_unit_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`warehouse_location` on(`businessman`.`product_location`.`location_id` = `businessman`.`warehouse_location`.`id`)) where `businessman`.`product_location`.`product_batch_id` is not null and `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`warehouse_location`.`available_for_allocation` = 1) AS `available_batch_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`warehouse_location` on(`businessman`.`product_location`.`location_id` = `businessman`.`warehouse_location`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_unit_id` is null and `businessman`.`product_location`.`product_batch_id` is null and `businessman`.`warehouse_location`.`available_for_allocation` = 0) AS `unavailable`,(select ifnull(count(`businessman`.`product_location`.`location_id`),0) from (`businessman`.`product_location` join `businessman`.`warehouse_location` on(`businessman`.`product_location`.`location_id` = `businessman`.`warehouse_location`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_unit_id` is not null and `businessman`.`warehouse_location`.`available_for_allocation` = 0) AS `unavailable_unit_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`warehouse_location` on(`businessman`.`product_location`.`location_id` = `businessman`.`warehouse_location`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`product_batch_id` is not null and `businessman`.`warehouse_location`.`available_for_allocation` = 0) AS `unavailable_batch_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from ((`businessman`.`product_location` join `businessman`.`shipment` on(`businessman`.`product_location`.`shipment_id` = `businessman`.`shipment`.`id`)) join `businessman`.`purchase_order` on(`businessman`.`shipment`.`purchase_order_id` = `businessman`.`purchase_order`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`delivery_id` is null and `businessman`.`purchase_order`.`draft` = 0 and `businessman`.`purchase_order`.`awaiting_approval` = 0 and `businessman`.`purchase_order`.`hold` = 0 and `businessman`.`purchase_order`.`closed` = 0 and `businessman`.`purchase_order`.`complete` = 0) AS `on_po_awaiting_goods`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from `businessman`.`product_location` where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`location_id` is not null and `businessman`.`product_location`.`job_id` is not null and `businessman`.`product_location`.`product_unit_id` is null and `businessman`.`product_location`.`product_batch_id` is null) AS `allocated_stock_job`,(select ifnull(count(`businessman`.`product_location`.`location_id`),0) from `businessman`.`product_location` where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`location_id` is not null and `businessman`.`product_location`.`job_id` is not null and `businessman`.`product_location`.`product_unit_id` is not null) AS `allocated_stock_job_unit_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from `businessman`.`product_location` where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`location_id` is not null and `businessman`.`product_location`.`job_id` is not null and `businessman`.`product_location`.`product_batch_id` is not null) AS `allocated_stock_job_batch_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`shipment` on(`businessman`.`product_location`.`shipment_id` = `businessman`.`shipment`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`location_id` is not null and `businessman`.`shipment`.`sales_order_id` is not null and `businessman`.`product_location`.`product_unit_id` is null and `businessman`.`product_location`.`product_batch_id` is null) AS `allocated_stock_sales_order`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`shipment` on(`businessman`.`product_location`.`shipment_id` = `businessman`.`shipment`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`location_id` is not null and `businessman`.`shipment`.`sales_order_id` is not null and `businessman`.`product_location`.`product_unit_id` is not null) AS `allocated_stock_sales_order_unit_tracked`,(select ifnull(sum(`businessman`.`product_location`.`quantity`),0) from (`businessman`.`product_location` join `businessman`.`shipment` on(`businessman`.`product_location`.`shipment_id` = `businessman`.`shipment`.`id`)) where `businessman`.`product_location`.`product_id` = `stock_id` and `businessman`.`product_location`.`location_id` is not null and `businessman`.`shipment`.`sales_order_id` is not null and `businessman`.`product_location`.`product_batch_id` is not null) AS `allocated_stock_sales_order_batch_tracked`,(select ifnull(sum(`bo`.`quantity_base`),0) from `businessman`.`back_order` `bo` where `bo`.`product_id` = `stock_id` and `bo`.`scheduled_back_order` = 0 and `bo`.`sales_order_id` is not null) AS `back_order_for_sales_order`,(select ifnull(sum(`bo`.`quantity`),0) from `businessman`.`back_order` `bo` where `bo`.`product_id` = `stock_id` and `bo`.`scheduled_back_order` = 0 and `bo`.`job_id` is not null) AS `back_order_for_job`,(select ifnull(sum(`bo`.`quantity_base`),0) from `businessman`.`back_order` `bo` where `bo`.`product_id` = `stock_id` and `bo`.`scheduled_back_order` <> 0 and `bo`.`sales_order_id` is not null) AS `scheduled_for_sales_order`,(select ifnull(sum(`bo`.`quantity`),0) from `businessman`.`back_order` `bo` where `bo`.`product_id` = `stock_id` and `bo`.`scheduled_back_order` <> 0 and `bo`.`job_id` is not null) AS `scheduled_for_job`,(select sum(ifnull(`businessman`.`job`.`product_quantity`,0) - ifnull(`businessman`.`job`.`product_quantity_assembled`,0)) from `businessman`.`job` where `businessman`.`job`.`product_id` = `stock_id` and `businessman`.`product`.`is_assembly` <> 0) AS `awaiting_assembly` from `businessman`.`product`) `q1` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `timeline_entry`
--

/*!50001 DROP TABLE IF EXISTS `timeline_entry`*/;
/*!50001 DROP VIEW IF EXISTS `timeline_entry`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `timeline_entry` AS select concat('n',`n`.`id`) AS `id`,`n`.`created` AS `created`,`n`.`creator_id` AS `creator_id`,`n`.`note_text` AS `note_text`,`n`.`note_raw` AS `note_raw`,'create' AS `event_type`,`r`.`type` AS `type`,'Note' AS `source_entity`,`r`.`note_id` AS `source_entity_id`,`r`.`asset_id` AS `asset_id`,`r`.`call_log_id` AS `call_log_id`,`r`.`company_id` AS `company_id`,`r`.`contact_id` AS `contact_id`,`r`.`credit_note_id` AS `credit_note_id`,`r`.`customer_id` AS `customer_id`,`r`.`department_id` AS `department_id`,`r`.`division_id` AS `division_id`,`r`.`document_id` AS `document_id`,`r`.`email_id` AS `email_id`,`r`.`employee_id` AS `employee_id`,`r`.`invoice_id` AS `invoice_id`,`r`.`job_id` AS `job_id`,`r`.`non_compliance_report_id` AS `non_compliance_report_id`,`r`.`note_id` AS `note_id`,`r`.`opportunity_id` AS `opportunity_id`,`r`.`product_batch_id` AS `product_batch_id`,`r`.`product_id` AS `product_id`,`r`.`project_id` AS `project_id`,`r`.`quote_id` AS `quote_id`,`r`.`prospect_id` AS `prospect_id`,`r`.`purchase_order_id` AS `purchase_order_id`,`r`.`product_unit_id` AS `product_unit_id`,`r`.`resource_id` AS `resource_id`,`r`.`site_id` AS `site_id`,`r`.`resource_group_id` AS `resource_group_id`,`r`.`resource_tag_name_id` AS `resource_tag_name_id`,`r`.`sales_order_id` AS `sales_order_id`,`r`.`service_contract_id` AS `service_contract_id`,`r`.`supplier_id` AS `supplier_id`,`r`.`support_ticket_id` AS `support_ticket_id`,`r`.`trading_company_id` AS `trading_company_id`,`r`.`supplier_invoice_id` AS `supplier_invoice_id`,`r`.`supplier_credit_note_id` AS `supplier_credit_note_id`,`r`.`warehouse_location_id` AS `warehouse_location_id`,`r`.`returns_authorisation_id` AS `returns_authorisation_id`,`r`.`branch_id` AS `branch_id`,`r`.`operation_id` AS `operation_id`,`r`.`customer_remittance_id` AS `customer_remittance_id`,`n`.`creator_id` AS `user_id` from (`note_relation` `r` left join `note` `n` on(`r`.`note_id` = `n`.`id`)) union select concat('a',`a`.`id`) AS `id`,`a`.`created` AS `created`,`a`.`user_id` AS `creator_id`,`a`.`description` AS `note_text`,NULL AS `note_raw`,`a`.`type` AS `event_type`,`r`.`type` AS `type`,`a`.`entity` AS `source_entity`,`a`.`entity_id` AS `source_entity_id`,`r`.`asset_id` AS `asset_id`,`r`.`call_log_id` AS `call_log_id`,`r`.`company_id` AS `company_id`,`r`.`contact_id` AS `contact_id`,`r`.`credit_note_id` AS `credit_note_id`,`r`.`customer_id` AS `customer_id`,`r`.`department_id` AS `department_id`,`r`.`division_id` AS `division_id`,`r`.`document_id` AS `document_id`,`r`.`email_id` AS `email_id`,`r`.`employee_id` AS `employee_id`,`r`.`invoice_id` AS `invoice_id`,`r`.`job_id` AS `job_id`,`r`.`non_compliance_report_id` AS `non_compliance_report_id`,`r`.`note_id` AS `note_id`,`r`.`opportunity_id` AS `opportunity_id`,`r`.`product_batch_id` AS `product_batch_id`,`r`.`product_id` AS `product_id`,`r`.`project_id` AS `project_id`,`r`.`quote_id` AS `quote_id`,`r`.`prospect_id` AS `prospect_id`,`r`.`purchase_order_id` AS `purchase_order_id`,`r`.`product_unit_id` AS `product_unit_id`,`r`.`resource_id` AS `resource_id`,`r`.`site_id` AS `site_id`,`r`.`resource_group_id` AS `resource_group_id`,`r`.`resource_tag_name_id` AS `resource_tag_name_id`,`r`.`sales_order_id` AS `sales_order_id`,`r`.`service_contract_id` AS `service_contract_id`,`r`.`supplier_id` AS `supplier_id`,`r`.`support_ticket_id` AS `support_ticket_id`,`r`.`trading_company_id` AS `trading_company_id`,`r`.`supplier_invoice_id` AS `supplier_invoice_id`,`r`.`supplier_credit_note_id` AS `supplier_credit_note_id`,`r`.`warehouse_location_id` AS `warehouse_location_id`,`r`.`returns_authorisation_id` AS `returns_authorisation_id`,`r`.`branch_id` AS `branch_id`,`r`.`operation_id` AS `operation_id`,`r`.`customer_remittance_id` AS `customer_remittance_id`,`a`.`user_id` AS `user_id` from (`audit_event_relation` `r` left join `audit_event` `a` on(`r`.`audit_event_id` = `a`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `warehouse_accessibility`
--

/*!50001 DROP TABLE IF EXISTS `warehouse_accessibility`*/;
/*!50001 DROP VIEW IF EXISTS `warehouse_accessibility`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `warehouse_accessibility` AS select concat('div',`wd`.`id`) AS `id`,`wd`.`warehouse_location_id` AS `location_id`,`wlp`.`path` AS `path`,'division' AS `type`,`d`.`id` AS `division_id`,NULL AS `department_id`,`d`.`id` AS `ref_id`,`t`.`company_name` AS `parent_name` from ((((`businessman`.`warehouse_division` `wd` join `businessman`.`warehouse_location` `wl` on(`wd`.`warehouse_location_id` = `wl`.`id`)) join `businessman`.`warehouse_location_path` `wlp` on(`wd`.`warehouse_location_id` = `wlp`.`id`)) join `businessman`.`division` `d` on(`wd`.`division_id` = `d`.`id`)) join `businessman`.`trading_company` `t` on(`d`.`parent_company_id` = `t`.`id`)) union select concat('dep',`wdp`.`id`) AS `id`,`wdp`.`warehouse_location_id` AS `location_id`,`wlp`.`path` AS `path`,'department' AS `type`,NULL AS `division_id`,`d`.`id` AS `department_id`,`d`.`id` AS `ref_id`,`v`.`division_name` AS `parent_name` from ((((`businessman`.`warehouse_department` `wdp` join `businessman`.`warehouse_location` `wl` on(`wdp`.`warehouse_location_id` = `wl`.`id`)) join `businessman`.`warehouse_location_path` `wlp` on(`wdp`.`warehouse_location_id` = `wlp`.`id`)) join `businessman`.`department` `d` on(`wdp`.`department_id` = `d`.`id`)) join `businessman`.`division` `v` on(`d`.`division_id` = `v`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `warehouse_location_path`
--

/*!50001 DROP TABLE IF EXISTS `warehouse_location_path`*/;
/*!50001 DROP VIEW IF EXISTS `warehouse_location_path`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `warehouse_location_path` AS with recursive parents as (select `businessman`.`warehouse_location`.`id` AS `id`,`businessman`.`warehouse_location`.`parent_id` AS `parent_id`,`businessman`.`warehouse_location`.`location_name` AS `location_name`,cast('' as char(255) charset utf8) AS `parent_path`,cast(`businessman`.`warehouse_location`.`location_name` as char(255) charset utf8) AS `path`,cast('' as char(255) charset utf8) AS `parent_path_ids`,cast(`businessman`.`warehouse_location`.`id` as char(255) charset utf8) AS `path_ids`,0 AS `depth` from `businessman`.`warehouse_location` union all select `wl`.`id` AS `id`,`wl`.`parent_id` AS `parent_id`,`wl`.`location_name` AS `location_name`,`parents`.`path` AS `parent_path`,if(`parents`.`path` = '',`wl`.`location_name`,concat(`parents`.`path`,' ➔ ',`wl`.`location_name`)) AS `path`,`parents`.`path_ids` AS `parent_path_ids`,if(`parents`.`path_ids` = '',`wl`.`id`,concat(`parents`.`path_ids`,',',`wl`.`id`)) AS `path_ids`,`parents`.`depth` + 1 AS `depth` from (`businessman`.`warehouse_location` `wl` join `parents` on(`wl`.`parent_id` = `parents`.`id`)) where `parents`.`id` <> `wl`.`id`)select `p1`.`id` AS `id`,`p1`.`location_name` AS `location_name`,`p1`.`parent_path` AS `parent_path`,`p1`.`parent_path_ids` AS `parent_path_ids`,`p1`.`path` AS `path`,`p1`.`path_ids` AS `path_ids`,`p1`.`depth` AS `depth`,(select max(`p2`.`depth`) from `parents` `p2` where `p1`.`id` = `p2`.`id`) AS `max_depth` from `parents` `p1` having `p1`.`depth` = `max_depth` order by `p1`.`path` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `warehouse_location_stock_quantity`
--

/*!50001 DROP TABLE IF EXISTS `warehouse_location_stock_quantity`*/;
/*!50001 DROP VIEW IF EXISTS `warehouse_location_stock_quantity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`appadmin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `warehouse_location_stock_quantity` AS select `product_location`.`location_id` AS `location`,`product`.`sku` AS `product`,`product`.`product_name` AS `name`,`product`.`description` AS `description`,sum(`product_location`.`quantity`) AS `quantity`,`product`.`id` AS `id` from ((`product_location` join `warehouse_location` on(`product_location`.`location_id` = `warehouse_location`.`id`)) join `product` on(`product_location`.`product_id` = `product`.`id`)) where `product`.`sku` is not null group by `product_location`.`location_id`,`product_location`.`product_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-04 15:14:21
