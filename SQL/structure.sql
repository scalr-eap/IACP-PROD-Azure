-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: localhost    Database: scalr
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_ccs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_ccs` (
  `account_id` int(11) NOT NULL COMMENT 'clients.id reference',
  `cc_id` binary(16) NOT NULL COMMENT 'ccs.cc_id reference',
  PRIMARY KEY (`account_id`,`cc_id`),
  KEY `idx_cc_id` (`cc_id`),
  CONSTRAINT `fk_b6e70905def505d6` FOREIGN KEY (`cc_id`) REFERENCES `ccs` (`cc_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_bd44f317af5fc8ab` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_cloud_resources` (
  `account_id` int(11) NOT NULL COMMENT 'clients.id ref',
  `cloud_resource_link_id` binary(16) NOT NULL COMMENT 'cloud_resource_links.id ref',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `unique_cloud_resource_link_id` (`cloud_resource_link_id`),
  CONSTRAINT `fk_e9bfe66a57201e0e` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_team_envs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_team_envs` (
  `env_id` int(11) NOT NULL DEFAULT '0',
  `team_id` int(11) NOT NULL,
  `account_role_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`team_id`,`env_id`),
  KEY `fk_account_team_envs_account_teams1` (`team_id`),
  KEY `fk_account_team_envs_client_environments1` (`env_id`),
  KEY `idx_account_role_id` (`account_role_id`),
  CONSTRAINT `fk_67fe3f7169b2` FOREIGN KEY (`account_role_id`) REFERENCES `acl_account_roles` (`account_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_team_user_acls`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_team_user_acls` (
  `account_team_user_id` int(11) NOT NULL,
  `account_role_id` varchar(20) NOT NULL,
  PRIMARY KEY (`account_team_user_id`,`account_role_id`),
  KEY `fk_9888fac48291b3452f82_idx` (`account_team_user_id`),
  KEY `fk_d7ced79d114b481574f8_idx` (`account_role_id`),
  CONSTRAINT `fk_241cb20f77a84d2a9a95` FOREIGN KEY (`account_team_user_id`) REFERENCES `account_team_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_4c65ed7fea80e0f3792d` FOREIGN KEY (`account_role_id`) REFERENCES `acl_account_roles` (`account_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_team_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_team_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permissions` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique` (`team_id`,`user_id`),
  KEY `fk_account_team_users_account_teams1` (`team_id`),
  KEY `fk_account_team_users_account_users1` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_teams`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `account_role_id` varchar(20) DEFAULT NULL COMMENT 'Default ACL role for team users',
  PRIMARY KEY (`id`),
  KEY `fk_account_teams_clients1` (`account_id`),
  KEY `idx_account_role_id` (`account_role_id`),
  CONSTRAINT `FK_315e023acf4b65b9203` FOREIGN KEY (`account_role_id`) REFERENCES `acl_account_roles` (`account_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_user_dashboards`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user_dashboards` (
  `user_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `value` text NOT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_696ae4c7a0ba` (`user_id`,`account_id`,`env_id`),
  KEY `env_id` (`env_id`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `account_user_dashboards_ibfk_2` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_e65bbecaa3f4` FOREIGN KEY (`user_id`, `account_id`) REFERENCES `account_users` (`user_id`, `account_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_user_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user_settings` (
  `account_user_id` binary(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_user_id`,`name`),
  KEY `idx_name` (`name`),
  CONSTRAINT `fk_3d15e57ca7f3` FOREIGN KEY (`account_user_id`) REFERENCES `account_users` (`account_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_users` (
  `account_user_id` binary(16) NOT NULL COMMENT 'The unique identifier of the account-user link',
  `user_id` int(11) NOT NULL COMMENT 'users.id reference',
  `account_id` int(11) DEFAULT NULL COMMENT 'clients.id reference, must be NULL for the global-admin and fin-admin',
  `type` varchar(45) DEFAULT NULL COMMENT 'User access type in specified account',
  `status` varchar(45) NOT NULL DEFAULT 'Inactive' COMMENT 'Account user link status.',
  `comments` text,
  PRIMARY KEY (`account_user_id`),
  UNIQUE KEY `uk_d4c3d1d55b23` (`user_id`,`account_id`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `fk_4be24d2d5cffef12` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_8c26a07ca59d6361` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_account_role_resource_modes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_account_role_resource_modes` (
  `account_role_id` varchar(20) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `mode` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`account_role_id`,`resource_id`),
  KEY `idx_resource_id` (`resource_id`),
  CONSTRAINT `fk_5b640da31e7b` FOREIGN KEY (`account_role_id`, `resource_id`) REFERENCES `acl_account_role_resources` (`account_role_id`, `resource_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_account_role_resource_permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_account_role_resource_permissions` (
  `account_role_id` varchar(20) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `perm_id` varchar(64) NOT NULL,
  `granted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`account_role_id`,`resource_id`,`perm_id`),
  KEY `fk_f123f4826415e04bfa12_idx` (`account_role_id`,`resource_id`),
  CONSTRAINT `fk_a98e2a51b27453360594` FOREIGN KEY (`account_role_id`, `resource_id`) REFERENCES `acl_account_role_resources` (`account_role_id`, `resource_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_account_role_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_account_role_resources` (
  `account_role_id` varchar(20) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `granted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`account_role_id`,`resource_id`),
  KEY `fk_e81073f7212f04f8db61_idx` (`account_role_id`),
  CONSTRAINT `fk_2a0b54035678ca90222b` FOREIGN KEY (`account_role_id`) REFERENCES `acl_account_roles` (`account_role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_account_roles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_account_roles` (
  `account_role_id` varchar(20) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `is_automatic` int(1) NOT NULL DEFAULT '0' COMMENT 'Whether the role is created automatically.',
  PRIMARY KEY (`account_role_id`),
  KEY `base_role_id` (`role_id`),
  KEY `account_id` (`account_id`),
  KEY `idx_accountid_roleid` (`account_id`,`role_id`,`is_automatic`),
  CONSTRAINT `fk_acl_account_roles_acl_roles1` FOREIGN KEY (`role_id`) REFERENCES `acl_roles` (`role_id`),
  CONSTRAINT `fk_acl_account_roles_clients1` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account level roles override global roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_role_resource_permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role_resource_permissions` (
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `perm_id` varchar(64) NOT NULL,
  `granted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`resource_id`,`perm_id`),
  KEY `fk_b0bc67f70c85735d0da2_idx` (`role_id`,`resource_id`),
  CONSTRAINT `fk_8a0eafb8ae6ea4f2d276` FOREIGN KEY (`role_id`, `resource_id`) REFERENCES `acl_role_resources` (`role_id`, `resource_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grants privileges to unique permissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_role_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role_resources` (
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `granted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`resource_id`,`role_id`),
  KEY `fk_aa1q8565e63a6f2d299_idx` (`role_id`),
  CONSTRAINT `fk_3a1qafb85e63a6f2d276` FOREIGN KEY (`role_id`) REFERENCES `acl_roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grants access permissions to resources.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_roles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_roles` (
  `role_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Global ACL roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL COMMENT 'Identifier of Account',
  `created_by_id` int(11) DEFAULT NULL COMMENT 'User who created an announcement',
  `created_by_email` varchar(100) NOT NULL COMMENT 'Email of the User who created an announcement',
  `added` datetime NOT NULL COMMENT 'Create timestamp',
  `title` varchar(100) NOT NULL,
  `msg` text NOT NULL COMMENT 'Raw content',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Pinned flag',
  PRIMARY KEY (`id`),
  KEY `idx_added` (`added`),
  KEY `fk_12741abab84d` (`created_by_id`),
  KEY `fk_312de420e119` (`account_id`),
  CONSTRAINT `fk_12741abab84d` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_312de420e119` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User Announcements';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `apache_vhosts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apache_vhosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `is_ssl_enabled` tinyint(1) DEFAULT '0',
  `farm_id` int(11) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `ssl_cert` text,
  `ssl_key` text,
  `ca_cert` text,
  `last_modified` datetime DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  `httpd_conf` text,
  `httpd_conf_vars` text,
  `advanced_mode` tinyint(1) DEFAULT '0',
  `httpd_conf_ssl` text,
  `ssl_cert_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_name` (`name`,`env_id`,`farm_id`,`farm_roleid`),
  KEY `clientid` (`client_id`),
  KEY `env_id` (`env_id`),
  KEY `fk_5a34fbba6754` (`farm_roleid`),
  KEY `fk_822c4b786717` (`farm_id`),
  CONSTRAINT `fk_5a34fbba6754` FOREIGN KEY (`farm_roleid`) REFERENCES `farm_roles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_822c4b786717` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_auth_app_urls`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_auth_app_urls` (
  `type` tinyint(1) NOT NULL COMMENT 'Url type 0 - origin, 1 - redirect',
  `url` varchar(255) NOT NULL COMMENT 'Application url',
  `app_id` char(12) NOT NULL COMMENT 'api_auth_apps.app_id ref',
  PRIMARY KEY (`type`,`url`),
  KEY `idx_app_id` (`app_id`),
  CONSTRAINT `fk_84a9eb20f109` FOREIGN KEY (`app_id`) REFERENCES `api_auth_apps` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API Application urls';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_auth_apps`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_auth_apps` (
  `id` char(12) NOT NULL COMMENT 'Application ID',
  `name` varchar(255) NOT NULL COMMENT 'Application Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_app_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Authorized API Applications';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_counters`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_counters` (
  `date` datetime NOT NULL,
  `api_credentials_id` varchar(32) NOT NULL,
  `requests` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`date`,`api_credentials_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_request_stats`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_request_stats` (
  `hash` binary(32) NOT NULL COMMENT 'Identifier of API endpoint',
  `endpoint` varchar(255) NOT NULL COMMENT 'API endpoint',
  `total_count` int(11) NOT NULL DEFAULT '1',
  `min_time` float NOT NULL DEFAULT '0',
  `max_time` float NOT NULL DEFAULT '0',
  `start_date` datetime NOT NULL COMMENT 'Date and Time the first call on this endpoint was made',
  `last_date` datetime NOT NULL COMMENT 'Date and Time the last call on this endpoint was made',
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API Requests statistics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autosnap_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autosnap_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `snapshot_id` varchar(50) NOT NULL,
  `created` datetime NOT NULL,
  `auto_snapshot_id` int(11) DEFAULT NULL,
  `volume_id` varchar(36) NOT NULL,
  `volume_type` varchar(20) NOT NULL,
  `platform` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `autosnapid` (`auto_snapshot_id`),
  KEY `idx_platform_volume` (`platform`,`volume_id`,`volume_type`),
  CONSTRAINT `fk_b4cb129a3eb5` FOREIGN KEY (`auto_snapshot_id`) REFERENCES `autosnap_settings` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autosnap_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autosnap_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `env_id` int(11) NOT NULL,
  `period` int(5) DEFAULT NULL,
  `last_snapshot_date` datetime DEFAULT NULL,
  `rotate` int(11) NOT NULL DEFAULT '0',
  `last_snapshot_id` varchar(50) DEFAULT NULL,
  `cloud_location` varchar(50) NOT NULL,
  `volume_id` varchar(36) NOT NULL,
  `volume_type` varchar(20) NOT NULL,
  `platform` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `env_id` (`env_id`),
  KEY `idx_dtlastsnapshot` (`last_snapshot_date`),
  KEY `idx_object` (`volume_id`,`volume_type`),
  KEY `idx_platform` (`platform`),
  CONSTRAINT `autosnap_settings_ibfk_1` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `azure_ad_groups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `azure_ad_groups` (
  `id` binary(16) NOT NULL COMMENT 'Azure AD group ID',
  `name` varchar(255) NOT NULL COMMENT 'Azure AD group name',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_task_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bundle_task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bundle_task_id` int(11) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`),
  KEY `NewIndex1` (`bundle_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_tasks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bundle_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prototype_role_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  `server_id` varchar(36) DEFAULT NULL,
  `replace_type` varchar(20) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `platform` varchar(20) DEFAULT NULL,
  `rolename` varchar(100) DEFAULT NULL,
  `failure_reason` text,
  `bundle_type` varchar(20) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `dtstarted` datetime DEFAULT NULL,
  `dtfinished` datetime DEFAULT NULL,
  `remove_proto_role` tinyint(1) DEFAULT '0',
  `snapshot_id` varchar(255) DEFAULT NULL,
  `platform_status` varchar(50) DEFAULT NULL,
  `description` text,
  `role_id` int(11) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `cloud_location` varchar(50) DEFAULT NULL,
  `meta_data` text,
  `os_family` varchar(20) DEFAULT NULL,
  `os_name` varchar(255) DEFAULT NULL,
  `os_version` varchar(10) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_by_email` varchar(100) DEFAULT NULL,
  `generation` tinyint(1) DEFAULT '1',
  `object` varchar(20) DEFAULT 'role',
  `object_scope` varchar(16) DEFAULT 'environment',
  `os_id` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `clientid` (`client_id`),
  KEY `env_id` (`env_id`),
  KEY `server_id` (`server_id`),
  KEY `status` (`status`),
  KEY `bundle_tasks_farms_id` (`farm_id`),
  CONSTRAINT `bundle_tasks_farms_id` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bundle_tasks_ibfk_1` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_items`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_items` (
  `key` varchar(255) NOT NULL COMMENT 'Cache item unique key',
  `value` longtext COMMENT 'Serialized cache item value',
  `created` datetime NOT NULL COMMENT 'Cache item created date and time in UTC',
  `expires` datetime DEFAULT NULL COMMENT 'Сached item expiration UTC timestamp ',
  PRIMARY KEY (`key`),
  KEY `idx_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_tag_links`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_tag_links` (
  `cache_item_id` varchar(255) NOT NULL COMMENT 'Ref to cache_items.key',
  `tag_hash` binary(32) NOT NULL COMMENT 'Ref to cache_tags.hash',
  `cache_item_key` varchar(255) NOT NULL COMMENT 'Cache item key',
  PRIMARY KEY (`cache_item_key`,`tag_hash`),
  KEY `idx_cache_id` (`cache_item_id`),
  KEY `idx_cache_key` (`cache_item_key`),
  KEY `idx_tag_hash` (`tag_hash`),
  CONSTRAINT `fk_8d3cf012316b` FOREIGN KEY (`cache_item_id`) REFERENCES `cache_items` (`key`) ON DELETE CASCADE,
  CONSTRAINT `fk_b35c6fe54ca3` FOREIGN KEY (`tag_hash`) REFERENCES `cache_tags` (`hash`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_tags`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_tags` (
  `hash` binary(32) NOT NULL COMMENT 'Tag version hash',
  `tag` varchar(255) NOT NULL COMMENT 'Tag name',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'Tag version',
  PRIMARY KEY (`hash`),
  UNIQUE KEY `unique_tag_version` (`tag`,`version`),
  KEY `idx_tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_properties` (
  `cc_id` binary(16) NOT NULL COMMENT 'ccs.cc_id reference',
  `name` varchar(64) NOT NULL COMMENT 'Name of the property',
  `value` mediumtext COMMENT 'The value',
  PRIMARY KEY (`cc_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CC properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs` (
  `cc_id` binary(16) NOT NULL COMMENT 'ID of the cost centre',
  `name` varchar(255) NOT NULL COMMENT 'The name',
  `account_id` int(11) DEFAULT NULL COMMENT 'clients.id reference',
  `created_by_id` int(11) DEFAULT NULL COMMENT 'Id of the creator',
  `created_by_email` varchar(255) DEFAULT NULL COMMENT 'Email of the creator',
  `created` datetime NOT NULL COMMENT 'Creation timestamp (UTC)',
  `archived` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether it is archived',
  PRIMARY KEY (`cc_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_name` (`name`(3)),
  KEY `idx_created_by_id` (`created_by_id`),
  CONSTRAINT `fk_ccs_clients` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cost Centers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_environment_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_environment_properties` (
  `env_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group` varchar(20) NOT NULL,
  `cloud` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`env_id`,`name`,`group`),
  KEY `env_id` (`env_id`),
  KEY `name_value` (`name`(100),`value`(100)),
  KEY `name` (`name`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_environments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_environments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `env_id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL COMMENT 'Admin email address',
  `client_id` int(11) NOT NULL,
  `dt_added` datetime NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'Active',
  `default_priority` int(11) NOT NULL DEFAULT '0' COMMENT 'Default priority',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_env_id` (`env_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_settings` (
  `clientid` int(11) NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`clientid`,`key`),
  KEY `settingskey` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc_id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `isbilled` tinyint(1) DEFAULT '0',
  `dtdue` datetime DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT '0',
  `fullname` varchar(60) DEFAULT NULL,
  `org` varchar(60) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `state` varchar(60) DEFAULT NULL,
  `city` varchar(60) DEFAULT NULL,
  `zipcode` varchar(60) DEFAULT NULL,
  `address1` varchar(60) DEFAULT NULL,
  `address2` varchar(60) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `fax` varchar(60) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `iswelcomemailsent` tinyint(1) DEFAULT '0',
  `login_attempts` int(5) DEFAULT '0',
  `dtlastloginattempt` datetime DEFAULT NULL,
  `comments` text,
  `priority` int(4) NOT NULL DEFAULT '0',
  `identity_provider_id` varchar(24) NOT NULL COMMENT 'The identity provider identifier',
  `mode` varchar(10) NOT NULL COMMENT 'Product mode: iacp, cmp, full',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_acc_id` (`acc_id`),
  KEY `idx_dtadded` (`dtadded`),
  KEY `idx_isactive` (`isactive`),
  KEY `idx_dtdue` (`dtdue`),
  KEY `idx_status` (`status`),
  KEY `idx_identity_provider_id` (`identity_provider_id`),
  CONSTRAINT `fk_2ef77245449c` FOREIGN KEY (`identity_provider_id`) REFERENCES `identity_providers` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_credentials`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_credentials` (
  `id` char(12) NOT NULL,
  `cred_id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `cloud` varchar(20) NOT NULL,
  `status` tinyint(4) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_cred_id` (`cred_id`),
  UNIQUE KEY `idx_scope_name` (`name`,`account_id`,`env_id`),
  KEY `idx_account` (`account_id`),
  KEY `idx_env` (`env_id`),
  KEY `idx_cloud` (`cloud`),
  KEY `idx_ccid_cloud` (`id`,`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_credentials_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_credentials_properties` (
  `cloud_credentials_id` char(12) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text,
  PRIMARY KEY (`cloud_credentials_id`,`name`),
  CONSTRAINT `fk_70cfb1f619cd7b1f` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_instance_types`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_instance_types` (
  `cloud_location_id` binary(16) NOT NULL COMMENT 'cloud_locations.cloud_location_id ref',
  `instance_type_id` varchar(45) NOT NULL COMMENT 'ID of the instance type',
  `name` varchar(255) NOT NULL COMMENT 'Display name',
  `ram` varchar(255) NOT NULL COMMENT 'Memory info',
  `vcpus` varchar(255) NOT NULL DEFAULT '' COMMENT 'CPU info',
  `disk` varchar(255) NOT NULL DEFAULT '' COMMENT 'Disk info',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'Storage type info',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT 'Notes',
  `options` text NOT NULL COMMENT 'Json encoded options',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0-inactive, 1-active, 2-obsolete',
  `is_dynamic` tinyint(1) NOT NULL COMMENT 'Whether the type is dynamic?',
  `priority` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance type sorting field',
  PRIMARY KEY (`cloud_location_id`,`instance_type_id`),
  KEY `idx_instance_type_id` (`instance_type_id`),
  KEY `idx_status` (`status`),
  KEY `idx_order` (`cloud_location_id`,`priority`),
  CONSTRAINT `fk_b73f53a22640` FOREIGN KEY (`cloud_location_id`) REFERENCES `cloud_locations` (`cloud_location_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance types for each cloud location';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_locations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_locations` (
  `cloud_location_id` binary(16) NOT NULL COMMENT 'UUID',
  `platform` varchar(20) NOT NULL COMMENT 'Cloud platform',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'Normalized endpoint url',
  `cloud_location` varchar(255) NOT NULL COMMENT 'Cloud location',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cloud_location_id`),
  KEY `idx_find` (`platform`,`cloud_location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Known cloud locations for each platform';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_resource_links`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_resource_links` (
  `id` binary(16) NOT NULL COMMENT 'Scalr Object ref',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Scalr Object type',
  `cloud_resource_id` binary(16) DEFAULT NULL COMMENT 'cloud_resources.id ref',
  `uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT 'UUID',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `unique` (`id`,`type`,`cloud_resource_id`),
  KEY `fk_42d2e1d8d08e222a` (`cloud_resource_id`),
  KEY `id` (`id`,`type`,`cloud_resource_id`),
  CONSTRAINT `fk_d2e7506f50dfdc34` FOREIGN KEY (`cloud_resource_id`) REFERENCES `cloud_resources` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_resource_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_resource_properties` (
  `cloud_resource_id` binary(16) NOT NULL COMMENT 'ID of the cloud resource',
  `name` varchar(255) NOT NULL COMMENT 'Property name',
  `value` text COMMENT 'Property value',
  PRIMARY KEY (`cloud_resource_id`,`name`),
  CONSTRAINT `fk_a33be22a6319` FOREIGN KEY (`cloud_resource_id`) REFERENCES `cloud_resources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cloud resources properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_resource_registry_references`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_resource_registry_references` (
  `registry_id` binary(16) NOT NULL COMMENT 'registry.id ref',
  `cloud_resource_id` binary(16) NOT NULL COMMENT 'cloud_resources.id ref',
  `cleanup_reason` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The reason of resource removing',
  PRIMARY KEY (`registry_id`,`cloud_resource_id`),
  KEY `fk_ade14d0a2436cd98` (`cloud_resource_id`),
  CONSTRAINT `fk_ade14d0a2436cd98` FOREIGN KEY (`cloud_resource_id`) REFERENCES `cloud_resources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_eb2f15f907f96307` FOREIGN KEY (`registry_id`) REFERENCES `registry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_resources` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `type` tinyint(3) unsigned NOT NULL COMMENT 'Resource type',
  `cloud_credentials_id` char(12) NOT NULL COMMENT 'ID of the Cloud credentials',
  `cloud_location` varchar(255) NOT NULL COMMENT 'The cloud location',
  `cloud_object_id` text NOT NULL COMMENT 'ID of the resource on the Cloud',
  `cloud_object_hash` binary(32) NOT NULL COMMENT 'Cloud object identifier packed with SHA256',
  `name` varchar(64) DEFAULT '' COMMENT 'Scalr name',
  `added` datetime NOT NULL COMMENT 'Date when resource is added to Scalr',
  `changed` datetime NOT NULL COMMENT 'Last resource change date',
  `purpose` tinyint(3) unsigned DEFAULT NULL COMMENT 'Resource creation purpose',
  `account_id` int(11) DEFAULT NULL COMMENT 'scope',
  `env_id` int(11) DEFAULT NULL COMMENT 'scope',
  `owner_id` int(11) DEFAULT NULL COMMENT 'account_users.id ref',
  `cleanup_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Cleanup status',
  `ownership_id` binary(16) DEFAULT NULL COMMENT 'Ownership FK UUID',
  `ownership_management` tinyint(4) NOT NULL DEFAULT '2' COMMENT 'Ownership management type 1: scalr or 2: manual',
  `not_found_attempts` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Number of attempts to find resource',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_cloud_id` (`type`,`cloud_credentials_id`,`cloud_location`,`cloud_object_hash`),
  KEY `idx_added` (`added`),
  KEY `idx_changed` (`changed`),
  KEY `fk_c8b3f06e72bf4d7d` (`cloud_credentials_id`),
  KEY `fk_d34e5db02307b9a3` (`account_id`),
  KEY `fk_1473d0c93a360d5c` (`env_id`),
  KEY `fk_bd077fa732c490dc` (`owner_id`),
  KEY `idx_own_manage` (`ownership_management`),
  KEY `idx_not_found_attempts` (`not_found_attempts`),
  KEY `fk_2905add541ed` (`ownership_id`),
  KEY `idx_cloud_object_hash` (`cloud_object_hash`),
  CONSTRAINT `fk_1473d0c93a360d5c` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_2905add541ed` FOREIGN KEY (`ownership_id`) REFERENCES `team_ownership` (`id`),
  CONSTRAINT `fk_bd077fa732c490dc` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_c8b3f06e72bf4d7d` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_d34e5db02307b9a3` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cloud resources in use';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_resources_poller_queue`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_resources_poller_queue` (
  `id` binary(16) NOT NULL COMMENT 'UUID unique identifier',
  `cloud_credentials_hash` binary(32) NOT NULL COMMENT 'Hash of ordered cloud credentials IDs',
  `platform` varchar(20) NOT NULL COMMENT 'Cloud platform',
  `cloud_resource_type` tinyint(3) unsigned NOT NULL COMMENT 'CLoud resource type',
  `cloud_location` varchar(255) NOT NULL COMMENT 'The cloud location',
  `cloud_credentials_ids` text NOT NULL COMMENT 'list of cloud credentials IDs',
  `next_describe` datetime NOT NULL COMMENT 'Next describe time',
  `failure_message` varchar(255) NOT NULL DEFAULT '' COMMENT 'Failure message',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_platform_type_location_hash` (`platform`,`cloud_resource_type`,`cloud_location`,`cloud_credentials_hash`),
  KEY `idx_next_describe` (`next_describe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cloud resources poller queue data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_aws_reserved_instance_configurations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_aws_reserved_instance_configurations` (
  `hash` binary(32) NOT NULL COMMENT 'Unique hash for RI',
  `scope` tinyint(1) NOT NULL COMMENT 'Either region or availability zone',
  `cloud_location_zone` varchar(255) NOT NULL DEFAULT '' COMMENT 'Availability zone name',
  `cloud_location` varchar(255) DEFAULT NULL COMMENT 'Region name',
  `instance_platform` varchar(255) NOT NULL COMMENT 'Operation system, could be Linux/UNIX, Windows, VPC or without',
  `instance_tenancy` tinyint(1) NOT NULL COMMENT 'Instance tenancy, could be: default(0) and dedicated(1)',
  `instance_type` varchar(45) NOT NULL COMMENT 'Instance type',
  `offering_class` varchar(255) NOT NULL COMMENT 'Either convertible or standard',
  `offering_type` tinyint(1) NOT NULL COMMENT 'Heavy Utilization(1) | Medium Utilization(2) | Light Utilization(3) | No Upfront(4) | Partial Upfront(5) | All Upfront(6)',
  `term` int(11) unsigned NOT NULL COMMENT 'RI term in seconds, for AWS seller could be 1 or 3 years',
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RI configuration';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_aws_reserved_instance_offerings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_aws_reserved_instance_offerings` (
  `id` binary(16) NOT NULL COMMENT 'AWS ReservedInstanceOfferingId',
  `configuration_hash` binary(32) NOT NULL COMMENT 'References to cm_aws_reserved_instances_offerings',
  `seller` tinyint(1) NOT NULL COMMENT 'Either AWS or 3rd Party',
  `upfront_price` decimal(11,4) NOT NULL DEFAULT '0.0000' COMMENT 'Amount of money being paid upfront',
  `hourly_rate` decimal(11,4) NOT NULL DEFAULT '0.0000' COMMENT 'Amount of money that will be paid hourly',
  `currency_code` varchar(5) NOT NULL DEFAULT 'USD' COMMENT 'Currency code',
  PRIMARY KEY (`id`),
  KEY `idx_configuration_hash` (`configuration_hash`),
  CONSTRAINT `fk_9d2eda972974` FOREIGN KEY (`configuration_hash`) REFERENCES `cm_aws_reserved_instance_configurations` (`hash`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RI offering';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_aws_reserved_instance_purchased`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_aws_reserved_instance_purchased` (
  `id` binary(16) NOT NULL COMMENT 'AWS ReservedInstanceId',
  `cloud_credentials_id` char(12) NOT NULL COMMENT 'scalr.cloud_credentials reference',
  `configuration_hash` binary(32) NOT NULL COMMENT 'cm_aws_reserved_instances_configurations reference',
  `count_instances` tinyint(2) NOT NULL COMMENT 'Could be up to 20 for a region',
  `state` tinyint(1) NOT NULL DEFAULT '2' COMMENT 'RI stage: payment-pending(1) | active(2) | payment-failed(3) | retired(4)',
  `purchased` datetime NOT NULL COMMENT 'RI purchase date (UTC)',
  PRIMARY KEY (`id`,`cloud_credentials_id`),
  KEY `idx_cloud_credentials_id` (`cloud_credentials_id`),
  KEY `idx_configuration_hash` (`configuration_hash`),
  CONSTRAINT `fk_8854f1195467` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_fd9782cecf40` FOREIGN KEY (`configuration_hash`) REFERENCES `cm_aws_reserved_instance_configurations` (`hash`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Purchased reserved instances';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_aws_reserved_instance_recommendation_offerings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_aws_reserved_instance_recommendation_offerings` (
  `recommendation_id` binary(16) NOT NULL COMMENT 'References to cm_aws_reserved_instances_offerings',
  `offering_id` binary(16) NOT NULL COMMENT 'cm_aws_reserved_instances_offerings reference',
  PRIMARY KEY (`recommendation_id`,`offering_id`),
  KEY `idx_offering_id` (`offering_id`),
  CONSTRAINT `fk_6a077f843b34` FOREIGN KEY (`offering_id`) REFERENCES `cm_aws_reserved_instance_offerings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_a8bcc9fa1157` FOREIGN KEY (`recommendation_id`) REFERENCES `cm_aws_reserved_instance_recommendations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pivot table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_aws_reserved_instance_recommendations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_aws_reserved_instance_recommendations` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `cloud_credentials_id` char(12) NOT NULL COMMENT 'scalr.cloud_credentials reference',
  `count_instances` tinyint(2) NOT NULL COMMENT 'Could be up to 20 for a region',
  `observation_period` int(11) NOT NULL COMMENT 'The period (days) on which the recommendation was based on',
  `added` datetime NOT NULL COMMENT 'UTC Datetime when offering was added',
  PRIMARY KEY (`id`),
  KEY `idx_cloud_credentials_id` (`cloud_credentials_id`),
  CONSTRAINT `fk_f8cde2369516` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RI recommendation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_billing_data_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_billing_data_versions` (
  `cloud` varchar(20) NOT NULL,
  `cloud_account` varchar(36) NOT NULL COMMENT 'cloud credentials account id',
  `date` date NOT NULL COMMENT 'version date',
  `version` int(10) unsigned NOT NULL COMMENT 'timestamp of the last processing',
  PRIMARY KEY (`cloud`,`cloud_account`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Billing files processing versions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_custom_tags`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_custom_tags` (
  `cloud_credentials_id` char(12) NOT NULL COMMENT 'payer cloud_credentials.id reference',
  `name` varbinary(128) NOT NULL COMMENT 'custom tag name like organization:backend',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Specifies whether the custom tag is selected or not by user for cost calculation',
  PRIMARY KEY (`cloud_credentials_id`,`name`),
  CONSTRAINT `fk_e600b3270d71` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Custom tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_pricing_conditions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pricing_conditions` (
  `hash` binary(16) NOT NULL,
  `condition1` varchar(255) NOT NULL DEFAULT '',
  `condition2` varchar(255) NOT NULL DEFAULT '',
  `price` decimal(9,6) unsigned NOT NULL,
  PRIMARY KEY (`hash`,`condition1`,`condition2`),
  CONSTRAINT `fk_06036d53419e` FOREIGN KEY (`hash`) REFERENCES `cm_pricing_products` (`hash`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_pricing_product_types`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pricing_product_types` (
  `code` char(4) NOT NULL,
  `description` varchar(255) NOT NULL,
  `unit` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_pricing_products`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_pricing_products` (
  `hash` binary(16) NOT NULL,
  `provider` varchar(20) NOT NULL,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `code` char(4) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`),
  UNIQUE KEY `idx_id` (`provider`,`identifier`,`code`,`name`),
  KEY `idx_code` (`code`),
  CONSTRAINT `fk_8586a660b2bb` FOREIGN KEY (`code`) REFERENCES `cm_pricing_product_types` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_report_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_report_properties` (
  `report_id` binary(16) NOT NULL COMMENT 'cm_reports.id ref',
  `name` varchar(255) NOT NULL COMMENT 'Property name',
  `value` text COMMENT 'Property value',
  PRIMARY KEY (`report_id`,`name`),
  CONSTRAINT `fk_3D775EFDEE63` FOREIGN KEY (`report_id`) REFERENCES `cm_reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cost Manager report properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cm_reports`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_reports` (
  `id` binary(16) NOT NULL COMMENT 'Pk UUID',
  `name` varchar(255) NOT NULL COMMENT 'Name of report',
  `type` tinyint(4) NOT NULL COMMENT 'Report type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cost Manager Reports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `env_id` int(11) NOT NULL,
  `rule` varchar(255) NOT NULL,
  `sg_name` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`env_id`,`sg_name`,`rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `default_records`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` int(11) DEFAULT '0',
  `type` enum('NS','MX','CNAME','A','TXT') DEFAULT NULL,
  `ttl` int(11) DEFAULT '14400',
  `priority` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dns_zone_records`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_zone_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(6) DEFAULT NULL,
  `ttl` int(10) unsigned DEFAULT NULL,
  `priority` int(10) unsigned DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `issystem` tinyint(1) DEFAULT NULL,
  `weight` int(10) DEFAULT NULL,
  `port` int(10) DEFAULT NULL,
  `server_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `zoneid` (`zone_id`,`type`(1),`value`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dns_zones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `zone_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `soa_owner` varchar(100) DEFAULT NULL,
  `soa_ttl` int(10) unsigned DEFAULT NULL,
  `soa_parent` varchar(100) DEFAULT NULL,
  `soa_serial` int(10) unsigned DEFAULT NULL,
  `soa_refresh` int(10) unsigned DEFAULT NULL,
  `soa_retry` int(10) unsigned DEFAULT NULL,
  `soa_expire` int(10) unsigned DEFAULT NULL,
  `soa_min_ttl` int(10) unsigned DEFAULT NULL,
  `dtlastmodified` datetime DEFAULT NULL,
  `axfr_allowed_hosts` tinytext,
  `allow_manage_system_records` tinyint(1) DEFAULT '0',
  `isonnsserver` tinyint(1) DEFAULT '0',
  `iszoneconfigmodified` tinyint(1) DEFAULT '0',
  `allowed_accounts` text,
  `private_root_records` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zones_index3945` (`zone_name`),
  KEY `farmid` (`farm_id`),
  KEY `clientid` (`client_id`),
  KEY `env_id` (`env_id`),
  KEY `iszoneconfigmodified` (`iszoneconfigmodified`),
  KEY `idx_isonnsserver` (`isonnsserver`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec2_ebs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec2_ebs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_id` int(11) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `volume_id` varchar(36) DEFAULT NULL,
  `server_id` varchar(36) DEFAULT NULL,
  `attachment_status` varchar(30) DEFAULT NULL,
  `mount_status` varchar(20) DEFAULT NULL,
  `device` varchar(15) DEFAULT NULL,
  `server_index` int(3) DEFAULT NULL,
  `mount` tinyint(1) DEFAULT '0',
  `mountpoint` varchar(50) DEFAULT NULL,
  `ec2_avail_zone` varchar(30) DEFAULT NULL,
  `ec2_region` varchar(30) DEFAULT NULL,
  `isfsexist` tinyint(1) DEFAULT '0',
  `ismanual` tinyint(1) DEFAULT '0',
  `size` int(11) DEFAULT NULL,
  `snap_id` varchar(50) DEFAULT NULL,
  `type` enum('standard','io1') NOT NULL DEFAULT 'standard',
  `iops` int(4) DEFAULT NULL,
  `ismysqlvolume` tinyint(1) DEFAULT '0',
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `env_id` (`env_id`),
  KEY `server_id` (`server_id`),
  KEY `farm_roleid_index` (`farm_roleid`,`server_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elastic_ips`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elastic_ips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farmid` int(11) DEFAULT NULL,
  `role_name` varchar(100) DEFAULT NULL,
  `ipaddress` varchar(15) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0',
  `instance_id` varchar(36) DEFAULT NULL,
  `clientid` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  `instance_index` int(11) DEFAULT '0',
  `farm_roleid` int(11) DEFAULT NULL,
  `server_id` varchar(36) DEFAULT NULL,
  `allocation_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `farmid` (`farmid`),
  KEY `farm_roleid` (`farm_roleid`),
  KEY `env_id` (`env_id`),
  KEY `server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `environment_cloud_credentials`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environment_cloud_credentials` (
  `env_id` int(11) NOT NULL,
  `cloud` varchar(20) NOT NULL,
  `cloud_credentials_id` char(12) NOT NULL,
  PRIMARY KEY (`env_id`,`cloud`),
  KEY `fk_939ecd9217a9244d_idx` (`cloud_credentials_id`,`cloud`),
  CONSTRAINT `fk_939ecd9217a9244d` FOREIGN KEY (`cloud_credentials_id`, `cloud`) REFERENCES `cloud_credentials` (`id`, `cloud`),
  CONSTRAINT `fk_d25d9d49dedcc31a` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `environment_cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environment_cloud_resources` (
  `env_id` int(11) NOT NULL COMMENT 'client_environments.id ref',
  `cloud_resource_link_id` binary(16) NOT NULL COMMENT 'cloud_resource_links.id ref',
  PRIMARY KEY (`env_id`),
  UNIQUE KEY `unique_cloud_resource_link_id` (`cloud_resource_link_id`),
  CONSTRAINT `fk_a97490349fea8d68` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `environment_policy_groups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environment_policy_groups` (
  `env_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `group_id` varchar(24) NOT NULL,
  PRIMARY KEY (`env_id`,`group_id`),
  KEY `idx_group_id_type` (`group_id`,`type`),
  CONSTRAINT `fk_9988930441f47425` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_9a0bd063917435c6` FOREIGN KEY (`group_id`, `type`) REFERENCES `policy_groups` (`id`, `type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `environment_resource_quotas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environment_resource_quotas` (
  `env_id` int(11) NOT NULL COMMENT 'client_environments.id ref',
  `cloud` varchar(255) NOT NULL COMMENT 'Cloud platform name',
  `quota_id` binary(16) NOT NULL COMMENT 'resource_quotas.id ref',
  KEY `idx_quota_id_cloud` (`quota_id`,`cloud`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_f6tfxldgpbrl9xd2` FOREIGN KEY (`quota_id`, `cloud`) REFERENCES `resource_quotas` (`id`, `cloud`),
  CONSTRAINT `fk_y932fe7irf7ffxi9` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_definitions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_definitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(25) NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL COMMENT 'Created at timestamp',
  `is_system` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'The flag of the system events. System events used in webhooks, orchestrations, scheduler tasks etc.',
  `is_built_in` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'The flag of the Scalr built-in events',
  `is_shared` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Sharing for all lower scopes.',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`(16)),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_created` (`created`),
  CONSTRAINT `fk_event_defs_client_envs_id` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_defs_clients_id` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farmid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT 'Event type',
  `dtadded` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `ishandled` tinyint(1) DEFAULT '0',
  `short_message` varchar(255) DEFAULT NULL,
  `event_object` text,
  `event_id` varchar(36) DEFAULT NULL,
  `event_server_id` varchar(36) DEFAULT NULL,
  `msg_expected` int(11) DEFAULT NULL,
  `msg_created` int(11) DEFAULT NULL,
  `msg_sent` int(11) DEFAULT '0',
  `wh_total` int(3) DEFAULT '0',
  `wh_completed` int(3) DEFAULT '0',
  `wh_failed` int(3) DEFAULT '0',
  `scripts_total` int(3) DEFAULT '0',
  `scripts_completed` int(3) DEFAULT '0',
  `scripts_failed` int(3) DEFAULT '0',
  `scripts_timedout` int(3) DEFAULT '0',
  `is_suspend` tinyint(1) DEFAULT '0',
  `fired_by_id` int(11) DEFAULT NULL COMMENT 'The id, which fired event',
  `fired_by_type` varchar(25) NOT NULL DEFAULT 'system' COMMENT 'The type, which fired event',
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_id` (`event_id`),
  KEY `farmid` (`farmid`),
  KEY `event_server_id` (`event_server_id`),
  KEY `idx_ishandled` (`ishandled`),
  KEY `idx_dtadded` (`dtadded`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_cloud_resources` (
  `farm_id` int(11) NOT NULL COMMENT 'farms.id ref',
  `cloud_resource_link_id` binary(16) NOT NULL COMMENT 'cloud_resource_links.id ref',
  PRIMARY KEY (`farm_id`),
  UNIQUE KEY `unique_cloud_resource_link_id` (`cloud_resource_link_id`),
  CONSTRAINT `fk_4262d3b721864e87` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_lease_requests`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_lease_requests` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `farm_id` int(11) NOT NULL,
  `requested_hours` int(11) NOT NULL,
  `request_time` datetime DEFAULT NULL,
  `request_comment` text,
  `request_user_id` int(11) NOT NULL,
  `answer_comment` text,
  `answer_user_id` text,
  `status` char(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `farm_id` (`farm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_ansible_tower_bootstrap_configurations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_ansible_tower_bootstrap_configurations` (
  `farm_role_id` int(11) NOT NULL COMMENT 'Farm role identifier. farm_roles.id',
  `configuration_id` binary(16) NOT NULL COMMENT 'AT bootstrap configuration identifier. services_ansible_tower_bootstrap_configurations.id',
  `variables` mediumtext NOT NULL COMMENT 'AT host variables',
  PRIMARY KEY (`farm_role_id`,`configuration_id`),
  KEY `idx_config` (`configuration_id`),
  KEY `idx_farm_role` (`farm_role_id`),
  CONSTRAINT `fk_0bcd3d4050d2` FOREIGN KEY (`farm_role_id`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_679d48a69133` FOREIGN KEY (`configuration_id`) REFERENCES `services_ansible_tower_bootstrap_configurations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_cloud_resources` (
  `farm_role_id` int(11) NOT NULL COMMENT 'farm_roles.id ref',
  `cloud_resource_link_id` binary(16) NOT NULL COMMENT 'cloud_resource_links.id ref',
  PRIMARY KEY (`farm_role_id`),
  UNIQUE KEY `unique_cloud_resource_link_id` (`cloud_resource_link_id`),
  CONSTRAINT `fk_e1651af529593a6a` FOREIGN KEY (`farm_role_id`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_config_presets`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_config_presets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_roleid` int(11) DEFAULT NULL,
  `behavior` varchar(25) DEFAULT NULL,
  `cfg_filename` varchar(25) DEFAULT NULL,
  `cfg_key` varchar(100) DEFAULT NULL,
  `cfg_value` text,
  PRIMARY KEY (`id`),
  KEY `main` (`farm_roleid`,`behavior`),
  CONSTRAINT `farm_role_config_presets_ibfk_1` FOREIGN KEY (`farm_roleid`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_scaling_metrics`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_scaling_metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_roleid` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  `dtlastpolled` datetime DEFAULT NULL,
  `last_value` varchar(255) DEFAULT NULL,
  `settings` text,
  `last_data` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex4` (`farm_roleid`,`metric_id`),
  KEY `NewIndex1` (`farm_roleid`),
  KEY `NewIndex2` (`metric_id`),
  CONSTRAINT `farm_role_scaling_metrics_ibfk_1` FOREIGN KEY (`farm_roleid`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_scaling_times`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_scaling_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_roleid` int(11) DEFAULT NULL,
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `days_of_week` varchar(75) DEFAULT NULL,
  `instances_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `farmroleid` (`farm_roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_settings` (
  `farm_roleid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  `type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`farm_roleid`,`name`),
  KEY `name` (`name`(30)),
  CONSTRAINT `farm_role_settings_ibfk_1` FOREIGN KEY (`farm_roleid`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_storage_config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_storage_config` (
  `id` varchar(36) NOT NULL,
  `farm_role_id` int(11) DEFAULT NULL,
  `index` tinyint(3) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `fs` varchar(15) DEFAULT NULL,
  `re_use` tinyint(1) DEFAULT NULL,
  `rebuild` tinyint(1) DEFAULT '0',
  `mount` tinyint(1) DEFAULT NULL,
  `mountpoint` varchar(255) DEFAULT NULL,
  `label` varchar(32) DEFAULT NULL COMMENT 'Disk label (windows only)',
  `mount_options` text COMMENT 'Mount options (linux only)',
  `status` varchar(20) DEFAULT NULL,
  `is_root` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether storage configuration is root.',
  PRIMARY KEY (`id`),
  KEY `farm_role_id` (`farm_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_storage_devices`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_storage_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_role_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `cloud_location` varchar(50) DEFAULT NULL,
  `server_index` tinyint(4) DEFAULT NULL,
  `server_id` varchar(36) DEFAULT NULL,
  `placement` varchar(36) DEFAULT NULL,
  `storage_config_id` varchar(36) DEFAULT NULL,
  `config` text,
  `storage_id` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_id` (`storage_id`),
  KEY `storage_config_id` (`storage_config_id`),
  KEY `fk_c1acfd734360` (`server_id`),
  CONSTRAINT `farm_role_storage_devices_ibfk_1` FOREIGN KEY (`storage_config_id`) REFERENCES `farm_role_storage_config` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_c1acfd734360` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_role_storage_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_role_storage_settings` (
  `storage_config_id` varchar(36) NOT NULL DEFAULT '',
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`storage_config_id`,`name`),
  CONSTRAINT `farm_role_storage_settings_ibfk_1` FOREIGN KEY (`storage_config_id`) REFERENCES `farm_role_storage_config` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_roles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farmid` int(11) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `dtlastsync` datetime DEFAULT NULL,
  `reboot_timeout` int(10) DEFAULT '300',
  `launch_timeout` int(10) DEFAULT '300',
  `status_timeout` int(10) DEFAULT '20',
  `launch_index` int(5) DEFAULT '0',
  `role_id` int(11) DEFAULT NULL,
  `platform` varchar(20) DEFAULT NULL,
  `cloud_location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `farmid` (`farmid`),
  KEY `platform` (`platform`),
  CONSTRAINT `fk_8b9544c72e6c` FOREIGN KEY (`farmid`) REFERENCES `farms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_settings` (
  `farmid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`farmid`,`name`),
  CONSTRAINT `fk_farm_settings_farms` FOREIGN KEY (`farmid`) REFERENCES `farms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_template_categories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_template_categories` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `account_id` int(11) DEFAULT NULL COMMENT 'scope',
  `env_id` int(11) DEFAULT NULL COMMENT 'scope',
  `name` varchar(50) NOT NULL,
  `icon` varchar(32) NOT NULL DEFAULT 'base' COMMENT 'UI icon',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_name` (`name`),
  CONSTRAINT `fk_8f2c720d1033d001` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_a48bdcbb93da534a` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farm_templates`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_templates` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `account_id` int(11) DEFAULT NULL COMMENT 'scope',
  `env_id` int(11) DEFAULT NULL COMMENT 'scope',
  `category_id` binary(16) DEFAULT NULL COMMENT 'Farm template category',
  `name` varchar(100) NOT NULL,
  `description` text,
  `details` text COMMENT 'Farm template details',
  `app_description` text COMMENT 'Application description',
  `icon` varchar(50) DEFAULT NULL COMMENT 'Icon name',
  `custom_icon` mediumtext COMMENT 'Custom icon json data',
  `content` longtext,
  `published` tinyint(1) NOT NULL COMMENT 'Is template published in Service Catalog',
  `owner_id` int(11) DEFAULT NULL COMMENT 'account_users.id ref',
  `ownership_id` binary(16) DEFAULT NULL COMMENT 'Ownership FK UUID',
  `cost` decimal(8,2) unsigned DEFAULT NULL COMMENT 'The hourly cost of usage (USD)',
  `source` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Farm template source type',
  `repository_id` binary(16) DEFAULT NULL COMMENT 'repositories.id ref',
  `file_path` text COMMENT 'Path to file in repo',
  `repository_version` varchar(255) DEFAULT NULL COMMENT 'Branch name, tag or commit hash in repo',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_ownership_id` (`ownership_id`),
  KEY `fk_5345958f5164` (`repository_id`),
  KEY `fk_8d090ef1acef01e9` (`env_id`),
  KEY `fk_b1312cdc3e5e0e01` (`account_id`),
  CONSTRAINT `fk_5345958f5164` FOREIGN KEY (`repository_id`) REFERENCES `repositories` (`id`),
  CONSTRAINT `fk_8d090ef1acef01e9` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_8f58b0d5e08c2445` FOREIGN KEY (`ownership_id`) REFERENCES `team_ownership` (`id`),
  CONSTRAINT `fk_8fac388aacf4fea2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_b1312cdc3e5e0e01` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b65bf65c0e2480b0` FOREIGN KEY (`category_id`) REFERENCES `farm_template_categories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `iscompleted` tinyint(1) DEFAULT '0',
  `hash` varchar(25) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `dtlaunched` datetime DEFAULT NULL,
  `term_on_sync_fail` tinyint(1) DEFAULT '1',
  `region` varchar(255) DEFAULT 'us-east-1',
  `farm_roles_launch_order` tinyint(1) DEFAULT '0',
  `comments` text,
  `created_by_id` int(11) DEFAULT NULL,
  `created_by_email` varchar(250) DEFAULT NULL,
  `changed_by_id` int(11) NOT NULL,
  `changed_time` varchar(32) DEFAULT NULL,
  `farm_template_id` binary(16) DEFAULT NULL,
  `ownership_id` binary(16) DEFAULT NULL COMMENT 'Ownership FK UUID',
  PRIMARY KEY (`id`),
  KEY `clientid` (`clientid`),
  KEY `env_id` (`env_id`),
  KEY `idx_created_by_id` (`created_by_id`),
  KEY `idx_changed_by_id` (`changed_by_id`),
  KEY `idx_status` (`status`),
  KEY `idx_farm_template_id` (`farm_template_id`),
  KEY `fk_bf0ff69574da` (`ownership_id`),
  CONSTRAINT `farms_ibfk_1` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_86dcb1b18e849437` FOREIGN KEY (`farm_template_id`) REFERENCES `farm_templates` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bf0ff69574da` FOREIGN KEY (`ownership_id`) REFERENCES `team_ownership` (`id`),
  CONSTRAINT `fk_farms_account_users_id` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `git_template_tasks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `git_template_tasks` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `status` tinyint(1) NOT NULL DEFAULT '3' COMMENT 'Task status',
  `content` longtext COMMENT 'Template file content',
  `error_message` text COMMENT 'Error message',
  `farm_template_id` binary(16) DEFAULT NULL COMMENT 'farm_templates.id ref',
  `created` datetime NOT NULL COMMENT 'Task created UTC timestamp',
  PRIMARY KEY (`id`),
  KEY `fk_185115d2c9c1` (`farm_template_id`),
  CONSTRAINT `fk_185115d2c9c1` FOREIGN KEY (`farm_template_id`) REFERENCES `farm_templates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Git template tasks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_variables`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_variables` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `unique_id` binary(32) NOT NULL COMMENT 'Unique ID',
  `variable_id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `name` varchar(128) NOT NULL COMMENT 'Name of Variable',
  `account_id` int(11) DEFAULT NULL COMMENT 'clients.id ref',
  `env_id` int(11) DEFAULT NULL COMMENT 'client_environments.id ref',
  `role_id` int(11) DEFAULT NULL COMMENT 'roles.id ref',
  `farm_id` int(11) DEFAULT NULL COMMENT 'farms.id ref',
  `farm_role_id` int(11) DEFAULT NULL COMMENT 'farm_roles.id ref',
  `server_id` varchar(36) DEFAULT NULL COMMENT 'servers.server_id ref',
  `scope_priority` int(11) NOT NULL DEFAULT '0' COMMENT 'scope as priority according order',
  `value` text NOT NULL COMMENT 'Value of Variable',
  `description` text NOT NULL COMMENT 'Description of Variable',
  `category` varchar(32) NOT NULL DEFAULT '' COMMENT 'Category of Variable',
  `flag_final` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag if Variable is final',
  `flag_required` varchar(16) NOT NULL DEFAULT 'off' COMMENT 'Required scope for Variable',
  `flag_hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag if Variable is hidden',
  `format` varchar(15) NOT NULL DEFAULT '' COMMENT 'Format of Variable',
  `validator` text COMMENT 'Validator of Variable',
  `webhook_endpoint_id` binary(16) DEFAULT NULL COMMENT 'webhook_endpoints.endpoint_id ref',
  `workspace_id` varchar(24) DEFAULT NULL COMMENT 'tf_workspaces.id ref',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id` (`unique_id`),
  UNIQUE KEY `unique_global_variable_id` (`variable_id`),
  KEY `idx_identity` (`name`,`account_id`,`env_id`,`role_id`,`farm_id`,`farm_role_id`,`server_id`),
  KEY `idx_scope_priority` (`scope_priority`),
  KEY `fk_b2049e1af0e7` (`webhook_endpoint_id`),
  KEY `fk_02e490df4414` (`account_id`),
  KEY `fk_227a04d36ddd` (`env_id`),
  KEY `fk_b5fbb9cab4e8` (`role_id`),
  KEY `fk_b2f1d1235dfe` (`farm_id`),
  KEY `fk_767072b8d80b` (`farm_role_id`),
  KEY `fk_72eebeae7516` (`server_id`),
  KEY `idx_value` (`value`(255)),
  KEY `fk_01f0984a39bf` (`workspace_id`),
  CONSTRAINT `fk_01f0984a39bf` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_02e490df4414` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_227a04d36ddd` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_72eebeae7516` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_767072b8d80b` FOREIGN KEY (`farm_role_id`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b2049e1af0e7` FOREIGN KEY (`webhook_endpoint_id`) REFERENCES `webhook_endpoints` (`endpoint_id`),
  CONSTRAINT `fk_b2f1d1235dfe` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b5fbb9cab4e8` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `governance_policies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `governance_policies` (
  `id` varchar(24) NOT NULL COMMENT 'Scalr happy id',
  `group_id` varchar(24) NOT NULL COMMENT 'Policy group happy id',
  `cloud_credentials_id` char(12) DEFAULT NULL COMMENT 'cloud_credentials_id ref',
  `type` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_992cb307269b290d` (`cloud_credentials_id`),
  KEY `idx_group_id` (`group_id`),
  CONSTRAINT `fk_992cb307269b290d` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_9cd94c717600` FOREIGN KEY (`group_id`) REFERENCES `policy_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `governance_quotas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `governance_quotas` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `quota_id` binary(16) NOT NULL COMMENT 'resource_quotas.id ref',
  `type` varchar(255) NOT NULL COMMENT 'Quota type',
  `status` tinyint(1) NOT NULL COMMENT 'Status',
  `value` int(11) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`id`),
  KEY `idx_quota_id` (`quota_id`),
  CONSTRAINT `fk_630bjcaf87ivna9p` FOREIGN KEY (`quota_id`) REFERENCES `resource_quotas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_permissions` (
  `name` varchar(120) NOT NULL COMMENT 'Permission of an agreed upon format item:action',
  `description` text COMMENT 'Description of the permission',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table of permissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_roles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_roles` (
  `id` varchar(24) NOT NULL COMMENT 'Role identifier',
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(128) NOT NULL COMMENT 'Name of a role',
  `description` text COMMENT 'Role description',
  `is_shared` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_account_name` (`account_id`,`name`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `FK_6D2DCDA99B6B5FBA` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table containing access roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_roles_permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_roles_permissions` (
  `role_id` varchar(24) NOT NULL COMMENT 'Role identifier',
  `permission` varchar(120) NOT NULL COMMENT 'Permission of an agreed upon format item:action',
  PRIMARY KEY (`role_id`,`permission`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_permission` (`permission`),
  CONSTRAINT `FK_EBBD7FFC57698A6A` FOREIGN KEY (`role_id`) REFERENCES `iam_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_EBBD7FFCE04992AA` FOREIGN KEY (`permission`) REFERENCES `iam_permissions` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_team_access_policies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_team_access_policies` (
  `team_id` varchar(24) NOT NULL COMMENT 'Team identifier',
  `scope_identity_id` binary(32) NOT NULL COMMENT 'Scope identity binary from hash identifier',
  `role_id` varchar(24) NOT NULL COMMENT 'Role identifier',
  PRIMARY KEY (`team_id`,`scope_identity_id`,`role_id`),
  KEY `idx_role` (`role_id`),
  KEY `idx_scope` (`scope_identity_id`),
  CONSTRAINT `FK_56A127F1296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `iam_teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_56A127F1D60322AC` FOREIGN KEY (`role_id`) REFERENCES `iam_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_56a127f1db1ba170` FOREIGN KEY (`scope_identity_id`) REFERENCES `scope_identities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Assignment many to many of access roles to teams with scope restriction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_team_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_team_users` (
  `team_id` varchar(24) NOT NULL COMMENT 'Team identifier',
  `user_id` varchar(24) NOT NULL COMMENT 'User happy id',
  PRIMARY KEY (`team_id`,`user_id`),
  KEY `idx_user` (`user_id`),
  CONSTRAINT `fk_4de1caae296cd8ae` FOREIGN KEY (`team_id`) REFERENCES `iam_teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_4de1caae693bc8c6` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_teams`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_teams` (
  `id` varchar(24) NOT NULL COMMENT 'Team identifier',
  `identity_provider_id` varchar(24) NOT NULL COMMENT 'The identity provider identifier',
  `scope_identity_id` binary(32) NOT NULL COMMENT 'Scope identity binary from hash identifier',
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`identity_provider_id`,`scope_identity_id`,`name`),
  KEY `idx_scope` (`scope_identity_id`),
  CONSTRAINT `fk_4dd1c136b5fb2c8e` FOREIGN KEY (`identity_provider_id`) REFERENCES `identity_providers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_4dd1c136db1ba170` FOREIGN KEY (`scope_identity_id`) REFERENCES `scope_identities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_user_access_policies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iam_user_access_policies` (
  `user_id` varchar(24) NOT NULL COMMENT 'User happy id',
  `scope_identity_id` binary(32) NOT NULL COMMENT 'Scope identity binary from hash identifier',
  `role_id` varchar(24) NOT NULL COMMENT 'Role identifier',
  PRIMARY KEY (`user_id`,`scope_identity_id`,`role_id`),
  KEY `idx_role` (`role_id`),
  KEY `idx_scope` (`scope_identity_id`),
  CONSTRAINT `FK_C8E77F1AA1B0EC6C` FOREIGN KEY (`role_id`) REFERENCES `iam_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_2205e0036e4c0379` FOREIGN KEY (`scope_identity_id`) REFERENCES `scope_identities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_67235100693bc8c6` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Assignment many to many of access roles to users with scope restriction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `identity_provider_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identity_provider_settings` (
  `identity_provider_id` varchar(24) NOT NULL COMMENT 'The identity provider identifier',
  `name` varchar(255) NOT NULL COMMENT 'Setting name',
  `value` text NOT NULL COMMENT 'Setting value',
  PRIMARY KEY (`identity_provider_id`,`name`),
  CONSTRAINT `fk_fd91043e1d3c` FOREIGN KEY (`identity_provider_id`) REFERENCES `identity_providers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `identity_providers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identity_providers` (
  `id` varchar(24) NOT NULL COMMENT 'PK UUID',
  `type` varchar(10) NOT NULL COMMENT 'Provider type (scalr, ldap, saml)',
  `name` varchar(255) NOT NULL COMMENT 'Provider name',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_software`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_software` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `image_hash` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `name` varchar(45) NOT NULL DEFAULT '',
  `version` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_image_hash` (`image_hash`),
  CONSTRAINT `fk_images_hash_image_software` FOREIGN KEY (`image_hash`) REFERENCES `images` (`hash`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `images`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `hash` binary(16) NOT NULL,
  `id` varchar(255) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `bundle_task_id` int(11) DEFAULT NULL,
  `platform` varchar(25) NOT NULL DEFAULT '',
  `cloud_location` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  `os` varchar(60) DEFAULT NULL,
  `os_family` varchar(30) DEFAULT NULL,
  `os_generation` varchar(10) DEFAULT NULL,
  `os_version` varchar(10) DEFAULT NULL,
  `dt_added` datetime NOT NULL COMMENT 'Created at timestamp',
  `dt_last_used` datetime DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_by_email` varchar(100) DEFAULT NULL,
  `architecture` enum('i386','x86_64') NOT NULL DEFAULT 'x86_64',
  `size` int(11) DEFAULT NULL,
  `is_deprecated` tinyint(1) NOT NULL DEFAULT '0',
  `source` enum('BundleTask','Manual') NOT NULL DEFAULT 'Manual',
  `type` varchar(20) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `status_error` varchar(255) DEFAULT NULL,
  `agent_version` varchar(20) DEFAULT NULL,
  `os_id` varchar(25) NOT NULL DEFAULT '',
  `is_scalarized` tinyint(1) NOT NULL DEFAULT '1',
  `has_cloud_init` tinyint(1) NOT NULL DEFAULT '0',
  `root_device_name` varchar(16) DEFAULT NULL,
  `is_shared` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Sharing for all lower scopes.',
  `is_system` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'System image flag.',
  `volumes` mediumtext,
  `is_thin_provisioning_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'True if VMware Image has disks with Thin provisioning',
  PRIMARY KEY (`hash`),
  UNIQUE KEY `idx_id` (`id`,`platform`,`cloud_location`,`account_id`,`env_id`,`hostname`),
  KEY `env_id_idx` (`env_id`),
  KEY `idx_name` (`name`(16)),
  KEY `idx_status` (`status`),
  KEY `idx_os_id` (`os_id`),
  KEY `idx_image_id` (`id`),
  KEY `idx_cloud_location` (`platform`,`cloud_location`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_hostname` (`hostname`),
  CONSTRAINT `fk_images_client_environmnets_id` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_images_clients_id` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integration_hub_operations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integration_hub_operations` (
  `id` binary(16) NOT NULL COMMENT 'Pk',
  `webhook_history_id` binary(16) DEFAULT NULL COMMENT 'Webhook history id ref',
  `env_id` int(11) NOT NULL COMMENT 'Env id ref',
  `farm_id` int(11) DEFAULT NULL COMMENT 'Farm id ref',
  `server_id` varchar(36) DEFAULT NULL COMMENT 'Server id ref',
  `name` varchar(255) NOT NULL COMMENT 'Name of operation',
  `details` text COMMENT 'Operation details',
  `status` varchar(255) DEFAULT NULL COMMENT 'Current operation status',
  `message` text COMMENT 'Operation result',
  `created` datetime NOT NULL COMMENT 'UTC Datetime when operation created',
  `finished` datetime DEFAULT NULL COMMENT 'UTC Datetime when operation finished',
  `decision_maker_user_id` int(11) DEFAULT NULL COMMENT 'User who made decision on built-in approval',
  PRIMARY KEY (`id`),
  KEY `idx_farm_created` (`farm_id`,`created`),
  KEY `idx_webhook_history_id` (`webhook_history_id`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_farm_id` (`farm_id`),
  KEY `idx_decision_maker_user_id` (`decision_maker_user_id`),
  KEY `fk_fc703b435e69` (`env_id`),
  CONSTRAINT `fk_66bfdee2ad1a` FOREIGN KEY (`decision_maker_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_9ebdeadc6bd8` FOREIGN KEY (`webhook_history_id`) REFERENCES `webhook_history` (`history_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_fc703b435e69` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fdf93af1129e` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_pool_addresses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_pool_addresses` (
  `ip_address` varbinary(16) NOT NULL COMMENT 'Allocated IP address',
  `ip_pool_id` binary(16) NOT NULL COMMENT 'ip_pools.id ref',
  `server_id` varchar(36) NOT NULL COMMENT 'Server id',
  `gateway` varbinary(16) DEFAULT NULL COMMENT 'Default gateway for external ipam type',
  `subnet_mask` varbinary(16) DEFAULT NULL COMMENT 'Subnet mask',
  `dns_domain` varchar(255) DEFAULT NULL COMMENT 'DNS Domain',
  `dns_servers` text COMMENT 'DNS Servers List',
  `dns_suffixes` text COMMENT 'DNS Suffixes LIST',
  `network_id` varchar(255) DEFAULT NULL COMMENT 'Network id',
  `state` tinyint(1) DEFAULT '1' COMMENT 'Ip address state type 0 - unregistered, 1 - registered',
  PRIMARY KEY (`ip_address`),
  KEY `idx_ip_pool_id` (`ip_pool_id`),
  KEY `idx_server_id` (`server_id`),
  CONSTRAINT `fk_6492bce21913` FOREIGN KEY (`ip_pool_id`) REFERENCES `ip_pools` (`id`),
  CONSTRAINT `fk_d2fa9ca2d79a` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP Pools allocated addresses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_pool_ranges`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_pool_ranges` (
  `id` binary(16) NOT NULL COMMENT 'IP Range UUID',
  `ip_start` varbinary(16) NOT NULL COMMENT 'IP start',
  `ip_end` varbinary(16) NOT NULL COMMENT 'IP end',
  `available` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Ip range available status',
  `ip_pool_id` binary(16) NOT NULL COMMENT 'ip_pools.id ref',
  PRIMARY KEY (`id`),
  KEY `idx_ip_pool_id` (`ip_pool_id`),
  CONSTRAINT `fk_ee14d52b7aa5` FOREIGN KEY (`ip_pool_id`) REFERENCES `ip_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP Pools ranges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_pools`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_pools` (
  `id` binary(16) NOT NULL COMMENT 'IP Pool UUID',
  `name` varchar(255) NOT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `type` tinyint(4) NOT NULL COMMENT 'Type',
  `account_id` int(11) DEFAULT NULL COMMENT 'accounts.id ref',
  `gateway` varbinary(16) DEFAULT NULL COMMENT 'Default gateway for scalr_ipam type',
  `subnet_mask` varbinary(16) DEFAULT NULL COMMENT 'Subnet mask',
  `dns_domain` varchar(255) DEFAULT NULL COMMENT 'DNS Domain',
  `dns_servers` text COMMENT 'DNS Servers List',
  `dns_suffixes` text COMMENT 'DNS Suffixes LIST',
  `ip_allocation` tinyint(4) DEFAULT NULL COMMENT 'Ip allocation type',
  `webhook_endpoint` varchar(255) DEFAULT NULL COMMENT 'Webhook endpoint',
  `webhook_userdata` text COMMENT 'Webhook userdata',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `fk_633473g8112f` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Scalr managed IP Pools';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_cluster_environments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kubernetes_cluster_environments` (
  `cluster_id` binary(16) NOT NULL COMMENT 'Kubernetes cluster UUID',
  `env_id` int(11) NOT NULL COMMENT 'Environment ID',
  PRIMARY KEY (`cluster_id`,`env_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_0cbe1015f75b` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_8176662b88eb` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_cluster_nodes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kubernetes_cluster_nodes` (
  `cluster_id` binary(16) NOT NULL COMMENT 'scalr.kubernetes_clusters.id reference',
  `name` varchar(255) NOT NULL COMMENT 'Node name',
  `ready` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Determines if node is ready',
  `cpu_total` int(11) DEFAULT NULL COMMENT 'Total number of cpu cores',
  `cpu_used` decimal(5,2) DEFAULT NULL COMMENT 'Number of used cpu cores (percents)',
  `memory_total` decimal(9,2) DEFAULT NULL COMMENT 'Total memory capacity in gigabytes',
  `memory_used` decimal(5,2) DEFAULT NULL COMMENT 'Used memory capacity in percents',
  `kubelet_version` varchar(15) DEFAULT NULL COMMENT 'Kubelet version',
  PRIMARY KEY (`cluster_id`,`name`),
  CONSTRAINT `fk_0b9c7c4d6d47` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_cluster_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kubernetes_cluster_properties` (
  `cluster_id` binary(16) NOT NULL COMMENT 'scalr.kubernetes_clusters.id reference',
  `name` varchar(255) NOT NULL COMMENT 'Name of property: workload, configuration, services,..',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`cluster_id`,`name`),
  CONSTRAINT `fk_e34719233a51` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_clusters`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kubernetes_clusters` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `account_id` int(11) NOT NULL COMMENT 'The ID of the account',
  `cloud_credentials_id` char(12) DEFAULT NULL COMMENT 'cloud_credentials.id reference',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name of cluster',
  `type` varchar(20) NOT NULL COMMENT 'Cluster type, could be Kubernetes, Amazon EKS, Google GKE,...',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Cluster status',
  `status_message` varchar(255) DEFAULT NULL COMMENT 'Cluster status message',
  `endpoint` varchar(255) NOT NULL COMMENT 'IPV4 address or hostname of the cluster',
  `master_version` varchar(20) NOT NULL COMMENT 'Version of the kubernetes master(ex. 1.9.2-gke.1)',
  `cloud_location` varchar(255) DEFAULT NULL COMMENT 'The cloud location',
  `kube_config` text COMMENT 'Kube config in yaml format',
  `cluster_credentials` text COMMENT 'Encrypted JSON with cloud credentials. could contain user, password, user_key, user_cert, cluster_cert',
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether access from Environments is restricted.',
  PRIMARY KEY (`id`),
  KEY `idx_cloud_credentials_id` (`cloud_credentials_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_name` (`name`(16)),
  KEY `idx_type` (`type`),
  KEY `idx_master_version` (`master_version`),
  CONSTRAINT `fk_59de7a1de3b2` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b2d2a66d8fe8` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labs` (
  `id` varchar(36) NOT NULL COMMENT 'Labs feature machine name',
  `name` varchar(255) DEFAULT NULL COMMENT 'Human readable name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Feature description',
  `is_forced` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Feature force enable flag',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is feature enabled flag',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labs_toggles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labs_toggles` (
  `id` binary(16) NOT NULL COMMENT 'uuid',
  `feature_id` varchar(36) NOT NULL COMMENT 'Labs feature machine name',
  `account_id` int(11) DEFAULT NULL COMMENT 'Account Id',
  `env_id` int(11) DEFAULT NULL COMMENT 'Environment Id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_feature_account_env` (`feature_id`,`account_id`,`env_id`),
  KEY `idx_feature_id` (`feature_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_9704392bcc77` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ac08e2cc127a` FOREIGN KEY (`feature_id`) REFERENCES `labs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_e2df932bf4b9` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logentries`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logentries` (
  `id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `serverid` varchar(36) DEFAULT NULL,
  `message` text NOT NULL,
  `severity` tinyint(1) DEFAULT '0',
  `time` int(11) NOT NULL,
  `source` varchar(255) DEFAULT NULL,
  `farmid` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `farm_role_id` int(11) DEFAULT NULL,
  `cnt` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_time` (`time`),
  KEY `idx_farmid_severity` (`farmid`,`severity`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_farmid` (`farmid`),
  CONSTRAINT `fk_6add96d9e18d` FOREIGN KEY (`farmid`) REFERENCES `farms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `messageid` varchar(75) NOT NULL,
  `processing_time` float DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `handle_attempts` int(2) DEFAULT '1',
  `dtlasthandleattempt` datetime DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `message` longtext,
  `server_id` varchar(36) NOT NULL,
  `event_server_id` varchar(36) DEFAULT NULL,
  `type` enum('in','out') DEFAULT NULL,
  `message_name` varchar(255) DEFAULT NULL COMMENT 'Name of message',
  `message_version` int(2) DEFAULT NULL,
  `message_format` enum('xml','json') DEFAULT NULL,
  `ipaddress` varchar(15) DEFAULT NULL,
  `event_id` varchar(36) DEFAULT NULL,
  `scheduled` datetime DEFAULT NULL COMMENT 'Message send scheduled time. UTC Date Time',
  `priority` tinyint(4) DEFAULT '10' COMMENT 'The priority of message processing',
  PRIMARY KEY (`messageid`,`server_id`),
  KEY `server_id` (`server_id`),
  KEY `status` (`status`,`type`),
  KEY `dt` (`dtlasthandleattempt`),
  KEY `msg_format` (`message_format`),
  KEY `event_id` (`event_id`),
  KEY `idx_type_status_dt` (`type`,`status`,`dtlasthandleattempt`),
  KEY `dtadded_idx` (`dtadded`),
  KEY `idx_scheduled` (`scheduled`),
  KEY `idx_type_status_priority` (`type`,`status`,`priority`),
  KEY `message_name` (`message_name`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orchestration_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orchestration_log` (
  `farmid` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `server_id` varchar(36) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `message` text,
  `event_server_id` varchar(36) DEFAULT NULL,
  `script_name` varchar(255) DEFAULT NULL,
  `exec_time` int(11) DEFAULT NULL,
  `exec_exitcode` int(11) DEFAULT NULL,
  `run_as` varchar(255) DEFAULT NULL,
  `event_id` varchar(36) DEFAULT NULL,
  `execution_id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `task_id` int(11) DEFAULT NULL COMMENT 'Scheduler task id',
  `cleanup_after` datetime DEFAULT NULL COMMENT 'scheduled removal',
  PRIMARY KEY (`execution_id`),
  KEY `farmid` (`farmid`),
  KEY `server_id` (`server_id`),
  KEY `event_id` (`event_id`),
  KEY `event_server_id` (`event_server_id`),
  KEY `idx_dtadded` (`dtadded`),
  KEY `idx_script_name` (`script_name`),
  KEY `idx_server_id` (`server_id`),
  CONSTRAINT `fk_09aa7d917043` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_e879166fd385` FOREIGN KEY (`farmid`) REFERENCES `farms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orchestration_log_manual_scripts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orchestration_log_manual_scripts` (
  `id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `execution_id` binary(16) DEFAULT NULL,
  `server_id` varchar(36) NOT NULL COMMENT 'The server id',
  `user_id` int(11) DEFAULT NULL COMMENT 'The user id',
  `user_email` varchar(100) DEFAULT NULL COMMENT 'The user email',
  `added` datetime DEFAULT NULL COMMENT 'The created date',
  `cleanup_after` datetime DEFAULT NULL COMMENT 'scheduled removal',
  PRIMARY KEY (`id`),
  KEY `idx_execution_id` (`execution_id`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_added` (`added`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User data for orchestration log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orchestration_rule_conditions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orchestration_rule_conditions` (
  `orchestration_rule_id` binary(16) NOT NULL,
  `type` varchar(255) NOT NULL COMMENT 'condition type',
  `value` varchar(255) NOT NULL COMMENT 'condition value',
  PRIMARY KEY (`orchestration_rule_id`,`type`,`value`),
  KEY `idx_orchestration_rule_id` (`orchestration_rule_id`),
  CONSTRAINT `fk_189c3190817052a` FOREIGN KEY (`orchestration_rule_id`) REFERENCES `orchestration_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orchestration_rule_params`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orchestration_rule_params` (
  `orchestration_rule_id` binary(16) NOT NULL,
  `farm_role_id` int(11) NOT NULL,
  `params` text COMMENT 'serialized script params',
  PRIMARY KEY (`orchestration_rule_id`,`farm_role_id`),
  KEY `idx_orchestration_rule_id` (`orchestration_rule_id`),
  KEY `idx_farm_role_id` (`farm_role_id`),
  CONSTRAINT `fk_95962e12cf504dca` FOREIGN KEY (`farm_role_id`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bb9f6f27850b8607` FOREIGN KEY (`orchestration_rule_id`) REFERENCES `orchestration_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orchestration_rules`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orchestration_rules` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `account_id` int(11) DEFAULT NULL COMMENT 'scope',
  `env_id` int(11) DEFAULT NULL COMMENT 'scope',
  `role_id` int(11) DEFAULT NULL COMMENT 'scope',
  `farm_role_id` int(11) DEFAULT NULL COMMENT 'scope',
  `event_name` varchar(50) NOT NULL COMMENT 'trigger event',
  `order_index` int(11) NOT NULL DEFAULT '0' COMMENT 'execution ordering',
  `target` varchar(50) NOT NULL COMMENT 'execution target',
  `type` varchar(10) NOT NULL COMMENT 'orchestration rule type',
  `script_path` varchar(255) DEFAULT NULL COMMENT 'local script path',
  `script_id` int(11) DEFAULT NULL COMMENT 'scalr script id',
  `version` varchar(255) NOT NULL COMMENT 'Version identifier',
  `timeout` int(5) NOT NULL COMMENT 'script execution timeout',
  `is_sync` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'blocking/non-blocking execution',
  `run_as` varchar(255) DEFAULT NULL COMMENT 'run script as user',
  `is_active` tinyint(1) NOT NULL COMMENT 'enabled/disabled flag',
  `params` text COMMENT 'serialized script params',
  `variables` text COMMENT 'Json encoded script variables',
  PRIMARY KEY (`id`),
  KEY `idx_event_name` (`event_name`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_farm_role_id` (`farm_role_id`),
  KEY `idx_script_id` (`script_id`),
  KEY `idx_search` (`event_name`,`target`,`is_active`,`id`) USING BTREE,
  CONSTRAINT `fk_93385c3b38229a02` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_9efaf3a6251515ab` FOREIGN KEY (`farm_role_id`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_a4eb1ec56cab21a2` FOREIGN KEY (`script_id`) REFERENCES `scripts` (`id`),
  CONSTRAINT `fk_aa36109df86d3b4e` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bd84545faac5d431` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `os`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `os` (
  `id` varchar(25) NOT NULL,
  `name` varchar(50) NOT NULL,
  `family` varchar(20) NOT NULL,
  `generation` varchar(10) NOT NULL,
  `version` varchar(15) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'inactive',
  `is_system` tinyint(1) DEFAULT '0',
  `created` datetime NOT NULL COMMENT 'Created at timestamp',
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`version`,`name`,`family`,`generation`),
  KEY `idx_created` (`created`),
  KEY `idx_name` (`name`(16)),
  KEY `idx_family` (`family`),
  KEY `idx_generation` (`generation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_groups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_groups` (
  `id` varchar(24) NOT NULL COMMENT 'Scalr happy id',
  `account_id` int(11) NOT NULL COMMENT 'scope',
  `type` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(255) DEFAULT NULL COMMENT 'Current status',
  `error_message` text COMMENT 'Error message from revision binding',
  `parent_group_id` varchar(24) DEFAULT NULL COMMENT 'IF not null, this is a preview policy group',
  `merge_at` datetime DEFAULT NULL COMMENT 'DATETIME when policy group was merged in UTC',
  `revision_binding_id` varchar(24) DEFAULT NULL COMMENT 'The vcs revision binding identifier',
  `opa_version` varchar(255) DEFAULT NULL COMMENT 'OPA version to use for this policy group',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_account_name` (`account_id`,`name`),
  KEY `fk_a07f76aaae4bacf2_idx` (`id`,`type`),
  KEY `fk_88679799361fe035` (`account_id`),
  KEY `idx_parent_group_id` (`parent_group_id`),
  KEY `idx_revision_binding_id` (`revision_binding_id`),
  CONSTRAINT `fk_83ab0367f2637288` FOREIGN KEY (`revision_binding_id`) REFERENCES `vcs_revision_bindings` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_88679799361fe035` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bc53ed077253` FOREIGN KEY (`parent_group_id`) REFERENCES `policy_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_properties` (
  `project_id` binary(16) NOT NULL COMMENT 'projects.project_id reference',
  `name` varchar(64) NOT NULL COMMENT 'Name of the property',
  `value` mediumtext COMMENT 'The value',
  PRIMARY KEY (`project_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Project properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project_id` binary(16) NOT NULL COMMENT 'ID of the project',
  `cc_id` binary(16) NOT NULL COMMENT 'ccs.cc_id reference',
  `name` varchar(255) NOT NULL COMMENT 'The name',
  `account_id` int(11) DEFAULT NULL COMMENT 'clients.id reference',
  `shared` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Type of the share',
  `env_id` int(11) DEFAULT NULL COMMENT 'Associated environment',
  `created_by_id` int(11) DEFAULT NULL COMMENT 'Id of the creator',
  `created_by_email` varchar(255) DEFAULT NULL COMMENT 'Email of the creator',
  `created` datetime NOT NULL COMMENT 'Creation timestamp (UTC)',
  `archived` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether it is archived',
  PRIMARY KEY (`project_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_name` (`name`(3)),
  KEY `idx_cc_id` (`cc_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_created_by_id` (`created_by_id`,`shared`),
  KEY `idx_shared` (`shared`),
  CONSTRAINT `fk_projects_ccs` FOREIGN KEY (`cc_id`) REFERENCES `ccs` (`cc_id`),
  CONSTRAINT `fk_projects_clients` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Projects';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `type` tinyint(3) unsigned NOT NULL COMMENT 'The type of the Scalr object',
  `name` varchar(255) DEFAULT '' COMMENT 'Display name of the Scalr object',
  `object_id` varchar(36) NOT NULL COMMENT 'Unique identifier of the Scalr object',
  `parent_id` binary(16) DEFAULT NULL COMMENT 'registry.id ref',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_type_object_id` (`type`,`object_id`),
  KEY `fk_dae0074501243796` (`parent_id`),
  CONSTRAINT `fk_dae0074501243796` FOREIGN KEY (`parent_id`) REFERENCES `registry` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Scalr registry';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry_relations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_relations` (
  `id` binary(16) NOT NULL COMMENT 'registry.id ref',
  `ancestor_id` binary(16) NOT NULL COMMENT 'registry.id ref',
  PRIMARY KEY (`id`,`ancestor_id`),
  KEY `fk_9c131639a7d10a52` (`ancestor_id`),
  CONSTRAINT `fk_7af488db64a0533b` FOREIGN KEY (`id`) REFERENCES `registry` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_9c131639a7d10a52` FOREIGN KEY (`ancestor_id`) REFERENCES `registry` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relations between Scalr objects';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repositories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repositories` (
  `id` binary(16) NOT NULL COMMENT 'Unique identifier',
  `account_id` int(11) DEFAULT NULL COMMENT 'Account identifier',
  `env_id` int(11) DEFAULT NULL COMMENT 'Environment identifier',
  `name` varchar(255) NOT NULL COMMENT 'Repository name',
  `uri` text NOT NULL COMMENT 'Repository URI',
  `auth_type` tinyint(4) NOT NULL COMMENT 'Authentication type',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_1c4123b35363` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_70c0ee4df941` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repository_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository_settings` (
  `repository_id` binary(16) NOT NULL COMMENT 'Repository identifier',
  `name` varchar(255) NOT NULL COMMENT 'Property name',
  `value` text COMMENT 'Property value',
  PRIMARY KEY (`repository_id`,`name`),
  KEY `idx_name` (`name`),
  CONSTRAINT `fk_28863c4c1281` FOREIGN KEY (`repository_id`) REFERENCES `repositories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_quotas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_quotas` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `account_id` int(11) NOT NULL COMMENT 'clients.id ref',
  `cloud` varchar(255) NOT NULL COMMENT 'Cloud platform name',
  `name` varchar(255) NOT NULL COMMENT 'Quota name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_account_name` (`account_id`,`name`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_id_cloud` (`id`,`cloud`),
  CONSTRAINT `fk_ae386cg80w1sks26` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rightsizing_available_instance_types`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rightsizing_available_instance_types` (
  `server_id` varchar(36) NOT NULL COMMENT 'servers.server_id ref',
  `instance_type` varchar(45) NOT NULL COMMENT 'instance_type identifier',
  PRIMARY KEY (`server_id`,`instance_type`),
  CONSTRAINT `fk_bec04f22c4d9` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rightsizing_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rightsizing_history` (
  `server_id` varchar(36) NOT NULL COMMENT 'server.id reference',
  `created` datetime NOT NULL COMMENT 'UTC Datetime when resizing was initialized',
  `resolved` datetime DEFAULT NULL COMMENT 'UTC Datetime when resizing was applied',
  `original_instance_type_id` varchar(45) NOT NULL COMMENT 'original instance_type identifier',
  `original_instance_type_name` varchar(255) NOT NULL COMMENT 'original instance_type_name',
  `replacement_instance_type_id` varchar(45) NOT NULL COMMENT 'replacement instance_type identifier',
  `replacement_instance_type_name` varchar(255) NOT NULL COMMENT 'replacement instance_type_name',
  `estimate_saving` decimal(9,6) NOT NULL COMMENT 'Estimated saving (dollar/hour)  per instance',
  `original_cpu` int(11) unsigned NOT NULL COMMENT 'CPU(Cores) of original instance type',
  `original_ram` int(11) unsigned NOT NULL COMMENT 'RAM(GB) of original instance type',
  `error_message` text COMMENT 'History failure message if resizing can not be performed',
  `original_server_status` varchar(25) NOT NULL COMMENT 'History original server status',
  PRIMARY KEY (`server_id`,`created`),
  CONSTRAINT `fk_e68174f621aa` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rightsizing_recommendations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rightsizing_recommendations` (
  `server_id` varchar(36) NOT NULL COMMENT 'servers.id reference',
  `instance_type` varchar(45) NOT NULL COMMENT 'instance_type identifier',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is recommendation chosen? 1 or 0',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Priority of recommendation',
  `estimate_saving` decimal(9,6) NOT NULL COMMENT 'Estimated saving (dollar/hour)  per instance',
  `added` datetime NOT NULL COMMENT 'UTC Datetime when recommendation was proposed',
  `description` text COMMENT 'Description',
  PRIMARY KEY (`server_id`,`instance_type`),
  CONSTRAINT `fk_c5bd84d11f25` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_ansible_tower_bootstrap_configurations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_ansible_tower_bootstrap_configurations` (
  `role_id` int(11) NOT NULL COMMENT 'Role identifier. roles.id',
  `configuration_id` binary(16) NOT NULL COMMENT 'AT bootstrap configuration identifier. services_ansible_tower_bootstrap_configurations.id',
  `variables` mediumtext NOT NULL COMMENT 'AT host variables',
  PRIMARY KEY (`role_id`,`configuration_id`),
  KEY `idx_config` (`configuration_id`),
  KEY `idx_role` (`role_id`),
  CONSTRAINT `fk_49e21acc5550` FOREIGN KEY (`configuration_id`) REFERENCES `services_ansible_tower_bootstrap_configurations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_a82cc3024c74` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_behaviors`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_behaviors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `behavior` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id_behavior` (`role_id`,`behavior`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `role_behaviors_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_categories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `icon` varchar(32) NOT NULL DEFAULT 'base' COMMENT 'UI icon',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`(16)),
  KEY `idx_env_id` (`env_id`),
  KEY `fk_90eb45b25a4bddd0` (`account_id`),
  CONSTRAINT `fk_90eb45b25a4bddd0` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_d98efdec7207c239` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_environments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_environments` (
  `role_id` int(11) NOT NULL,
  `env_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`env_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_role_environments_client_environments_id` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_role_environments_roles_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_images`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_images` (
  `role_id` int(11) NOT NULL,
  `image_hash` binary(16) NOT NULL,
  PRIMARY KEY (`role_id`,`image_hash`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_image_hash` (`image_hash`),
  CONSTRAINT `fk_ba1400cc0311b87d` FOREIGN KEY (`image_hash`) REFERENCES `images` (`hash`),
  CONSTRAINT `role_images_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_properties` (
  `role_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`role_id`,`name`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `role_properties_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_software_deleted`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_software_deleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `software_name` varchar(45) DEFAULT NULL,
  `software_version` varchar(20) DEFAULT NULL,
  `software_key` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `role_software_deleted_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `origin` enum('SHARED','CUSTOM') DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `description` text,
  `behaviors` varchar(90) DEFAULT NULL,
  `quick_start_group` varchar(32) NOT NULL DEFAULT '',
  `is_devel` tinyint(1) NOT NULL DEFAULT '0',
  `is_deprecated` tinyint(1) DEFAULT '0',
  `is_quick_start` tinyint(1) NOT NULL DEFAULT '0',
  `generation` tinyint(4) DEFAULT '1',
  `os` varchar(60) DEFAULT NULL,
  `os_family` varchar(30) DEFAULT NULL,
  `os_generation` varchar(10) DEFAULT NULL,
  `os_version` varchar(10) DEFAULT NULL,
  `dtadded` datetime NOT NULL COMMENT 'Created at timestamp',
  `dt_last_used` datetime DEFAULT NULL,
  `added_by_userid` int(11) DEFAULT NULL,
  `added_by_email` varchar(50) DEFAULT NULL,
  `os_id` varchar(25) NOT NULL DEFAULT '',
  `is_scalarized` tinyint(1) NOT NULL DEFAULT '1',
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether access from Environments is restricted.',
  `replacement_role_id` int(11) DEFAULT NULL COMMENT 'Recommended replacement role for deprecated one',
  `deprecated_at` datetime DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'System role flag.',
  PRIMARY KEY (`id`),
  KEY `idx_os_family` (`os_family`),
  KEY `idx_origin` (`origin`),
  KEY `idx_client_id` (`client_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_name` (`name`(16)),
  KEY `idx_cat_id` (`cat_id`),
  KEY `idx_os_id` (`os_id`),
  KEY `idx_is_quick_start` (`is_quick_start`),
  KEY `idx_replacement_role_id` (`replacement_role_id`),
  CONSTRAINT `fk_1326471b4f680eef` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_6ab3b53cbdfa0be8` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ba1400cc0311b87b` FOREIGN KEY (`replacement_role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_bc65c689039a0d77` FOREIGN KEY (`cat_id`) REFERENCES `role_categories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sc_offering_categories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sc_offering_categories` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `account_id` int(11) DEFAULT NULL COMMENT 'scope',
  `env_id` int(11) DEFAULT NULL COMMENT 'scope',
  `name` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT NULL COMMENT 'UI icon',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_0f106febc233` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_e0fcbac55def` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sc_services`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sc_services` (
  `id` varchar(24) NOT NULL COMMENT 'Scalr ID',
  `account_id` int(11) NOT NULL COMMENT 'scope',
  `env_id` int(11) NOT NULL COMMENT 'scope',
  `name` varchar(255) NOT NULL COMMENT 'Name of the Application',
  `offering_id` varchar(24) NOT NULL COMMENT 'sc_offering.id ref',
  `status` varchar(64) NOT NULL COMMENT 'Application status',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the Application was created',
  `tags` text COMMENT 'Application Tags. key: value in JSON format',
  `error_message` text COMMENT 'Specifies the reason for the errored status',
  `created_by` int(11) DEFAULT NULL COMMENT 'users.id ref',
  `created_by_email` varchar(100) DEFAULT NULL COMMENT 'Email of the User who created an application',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_offering_id` (`env_id`),
  KEY `fk_0d8c6f217286` (`offering_id`),
  KEY `idx_created_by` (`created_by`),
  CONSTRAINT `fk_0d8c6f217286` FOREIGN KEY (`offering_id`) REFERENCES `tf_offerings` (`id`),
  CONSTRAINT `fk_1134e0f1a896` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_a8eceb2ab785` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_c85c92c04dd1` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sc_services_terraform`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sc_services_terraform` (
  `service_id` varchar(24) NOT NULL COMMENT 'Service.id ref',
  `status` varchar(64) NOT NULL COMMENT 'Terraform application status',
  `outputs` text COMMENT 'Terraform outputs in JSON format',
  `resources` text COMMENT 'List of created resources in JSON format',
  `workspace_id` varchar(24) DEFAULT NULL COMMENT 'tf_workspaces.id ref',
  `terraform_offering_version_id` varchar(24) NOT NULL COMMENT 'The terraform offering version identifier',
  PRIMARY KEY (`service_id`),
  KEY `idx_workspace_id` (`workspace_id`),
  KEY `idx_terraform_offering_version_id` (`terraform_offering_version_id`),
  CONSTRAINT `fk_15a83241ab1d` FOREIGN KEY (`service_id`) REFERENCES `sc_services` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_2c038f2a59ed` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ba9c6b4c97f2` FOREIGN KEY (`terraform_offering_version_id`) REFERENCES `tf_offering_versions` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scaling_metrics`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scaling_metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `retrieve_method` varchar(20) DEFAULT NULL,
  `calc_function` varchar(20) DEFAULT NULL,
  `algorithm` varchar(15) DEFAULT NULL,
  `alias` varchar(25) DEFAULT NULL,
  `is_invert` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether it should invert logic',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_unique_name` (`account_id`,`name`),
  CONSTRAINT `fk_612f4f62b80300e9` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_a50c892c22f74988` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scalr_hosts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalr_hosts` (
  `host` varchar(255) NOT NULL COMMENT 'The name of the Scalr host',
  `version` varchar(16) NOT NULL COMMENT 'Scalr version app/etc/version',
  `edition` varchar(128) NOT NULL COMMENT 'Scalr edition',
  `git_commit` varchar(64) DEFAULT NULL COMMENT 'Last git commit',
  `git_commit_added` datetime DEFAULT NULL COMMENT 'Date of last git commit',
  `services` text COMMENT 'List of enabled services (json)',
  PRIMARY KEY (`host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Scalr hosts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scalr_services`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalr_services` (
  `name` varchar(64) NOT NULL COMMENT 'The unique name of the service',
  `num_workers` int(11) NOT NULL DEFAULT '0' COMMENT 'The last number of running workers',
  `num_tasks` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of processed tasks on last run',
  `started` datetime DEFAULT NULL COMMENT 'Time of the last start',
  `prev_finish` datetime DEFAULT NULL COMMENT 'Time of the previous finish',
  `state` tinyint(3) unsigned DEFAULT NULL COMMENT 'State of the service',
  `memory_usage` float NOT NULL DEFAULT '0' COMMENT 'The current value of memory usage',
  `prev_num_workers` int(11) NOT NULL DEFAULT '0' COMMENT 'The previous number of running workers',
  `prev_num_tasks` int(11) NOT NULL DEFAULT '0' COMMENT 'The previous of processed tasks on last run',
  `prev_start` datetime DEFAULT NULL COMMENT 'Time of the previous start',
  `prev_memory_usage` float NOT NULL DEFAULT '0' COMMENT 'The value of memory usage on previous loop',
  PRIMARY KEY (`name`),
  KEY `idx_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Scalr services';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scalr_tasks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalr_tasks` (
  `id` binary(16) NOT NULL COMMENT 'PK UUID',
  `name` varchar(255) NOT NULL COMMENT 'Name of task, PK',
  `context` text COMMENT 'Task context',
  `execute_at` datetime NOT NULL COMMENT 'UTC When task should be executed',
  `created_at` datetime NOT NULL COMMENT 'UTC When task was created',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_execute_at` (`execute_at`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduler`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('script_exec','terminate_farm','launch_farm','fire_event','system') DEFAULT NULL,
  `comments` text NOT NULL,
  `target_id` int(11) DEFAULT NULL COMMENT 'id of farm, farm_role from other tables',
  `target_server_index` int(11) DEFAULT NULL,
  `target_type` enum('farm','role','instance') DEFAULT NULL,
  `script_id` int(11) DEFAULT NULL,
  `script_version` varchar(10) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL COMMENT 'start task''s time',
  `last_start_time` datetime DEFAULT NULL COMMENT 'the last time task was started',
  `restart_every` int(11) DEFAULT '0' COMMENT 'restart task every N minutes',
  `config` text COMMENT 'arguments for action',
  `timezone` varchar(100) DEFAULT NULL,
  `status` varchar(11) DEFAULT NULL COMMENT 'active, suspended, finished',
  `account_id` int(11) DEFAULT NULL COMMENT 'Task belongs to selected account',
  `env_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `account_id` (`account_id`,`env_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scope_identities`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scope_identities` (
  `id` binary(32) NOT NULL COMMENT 'Scope identity binary from hash identifier',
  `account_id` varchar(24) DEFAULT NULL,
  `environment_id` varchar(24) DEFAULT NULL,
  `workspace_id` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_workspace` (`workspace_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_environment_id` (`environment_id`),
  CONSTRAINT `FK_B52E075B82D40A1F` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_b52e075b903e3a95` FOREIGN KEY (`environment_id`) REFERENCES `client_environments` (`env_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_b52e075b9b6b5fb7` FOREIGN KEY (`account_id`) REFERENCES `clients` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table connecting scope hashes to scope entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scopes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scopes` (
  `id` binary(32) NOT NULL COMMENT 'Scope identity binary from hash identifier',
  `resource_type` varchar(24) NOT NULL COMMENT 'Type of scope resource that is in scope identity',
  `resource_id` varchar(24) NOT NULL COMMENT 'Id of scope resource that is in scope identity',
  PRIMARY KEY (`id`,`resource_type`,`resource_id`),
  CONSTRAINT `fk_8be4c789d1b862b8` FOREIGN KEY (`id`) REFERENCES `scope_identities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table of scopes, for each scope N records, where N amount of elements in scope identity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_execute_messages`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_execute_messages` (
  `messageid` varchar(75) NOT NULL COMMENT 'UUID',
  `processing_time` float DEFAULT NULL COMMENT 'Processing time',
  `status` tinyint(1) DEFAULT '0' COMMENT 'Status of message (pending,handled,unsupported,failed)',
  `handle_attempts` int(2) DEFAULT '1' COMMENT 'Number of attempts to handle',
  `dtlasthandleattempt` datetime DEFAULT NULL COMMENT 'Date of last attempt to handle',
  `dtadded` datetime DEFAULT NULL COMMENT 'Date when message added',
  `message` longtext COMMENT 'Message body',
  `server_id` varchar(36) NOT NULL COMMENT 'Server that message relate to',
  `event_server_id` varchar(36) DEFAULT NULL COMMENT 'Server where message was invoked',
  `type` varchar(30) DEFAULT NULL COMMENT 'Type of message',
  `message_name` varchar(30) DEFAULT NULL COMMENT 'Name of message',
  `message_version` int(2) DEFAULT NULL COMMENT 'Version of message',
  `message_format` varchar(30) DEFAULT NULL COMMENT 'Format for message body',
  `ipaddress` varchar(15) DEFAULT NULL COMMENT 'Ip address of server that sent message to us',
  `event_id` varchar(36) DEFAULT NULL COMMENT 'Event id',
  `scheduled` datetime DEFAULT NULL COMMENT 'Message send scheduled time. UTC Date Time',
  `priority` tinyint(4) DEFAULT '10' COMMENT 'The priority of message processing',
  PRIMARY KEY (`messageid`,`server_id`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_scheduled` (`scheduled`),
  KEY `idx_type_status_priority` (`type`,`status`,`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ExecScript messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_variables`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_variables` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `name` varchar(128) NOT NULL COMMENT 'Name of Variable',
  `script_id` int(11) NOT NULL COMMENT 'scripts.id ref',
  `value` text NOT NULL COMMENT 'Value of Variable',
  `description` text NOT NULL COMMENT 'Description of Variable',
  `category` varchar(32) NOT NULL DEFAULT '' COMMENT 'Category of Variable',
  `flag_final` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag if Variable is final',
  `flag_required` varchar(16) NOT NULL DEFAULT 'off' COMMENT 'Required scope for Variable',
  `flag_hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag if Variable is hidden',
  `format` varchar(15) NOT NULL DEFAULT '' COMMENT 'Format of Variable',
  `validator` text COMMENT 'Validator of Variable',
  `webhook_endpoint_id` binary(16) DEFAULT NULL COMMENT 'webhook_endpoints.endpoint_id ref',
  PRIMARY KEY (`id`),
  UNIQUE KEY `script_id` (`script_id`,`name`),
  CONSTRAINT `fk_5c3546525ca2` FOREIGN KEY (`script_id`) REFERENCES `scripts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_versions` (
  `script_id` int(11) NOT NULL,
  `version` varchar(255) NOT NULL COMMENT 'Version identifier',
  `content` longtext,
  `dt_created` datetime NOT NULL,
  `variables` text,
  `changed_by_id` int(11) DEFAULT NULL,
  `changed_by_email` varchar(250) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Default(latest) version of script. Used only for git scripts',
  PRIMARY KEY (`script_id`,`version`),
  KEY `idx_dt_created` (`dt_created`),
  CONSTRAINT `fk_script_versions_scripts_id` FOREIGN KEY (`script_id`) REFERENCES `scripts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scripts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_changed` datetime DEFAULT NULL,
  `os` varchar(16) NOT NULL,
  `is_sync` tinyint(1) DEFAULT '0',
  `timeout` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_by_email` varchar(250) DEFAULT NULL,
  `allow_script_parameters` tinyint(1) NOT NULL DEFAULT '0',
  `is_deprecated` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Script deprecation flag',
  `is_shared` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Sharing for all lower scopes.',
  `source` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Script source type (1: Scalr, 2: Git)',
  `repo_id` binary(16) DEFAULT NULL COMMENT 'repositories.id ref',
  `repo_path` text COMMENT 'Path to script file on repository',
  `require_admin_privileges` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_dt_created` (`dt_created`),
  KEY `idx_name` (`name`(8)),
  KEY `idx_os` (`os`),
  KEY `idx_blocking` (`is_sync`),
  KEY `idx_repo_id` (`repo_id`),
  CONSTRAINT `fk_c1ecfc65aff9` FOREIGN KEY (`repo_id`) REFERENCES `repositories` (`id`),
  CONSTRAINT `fk_scripts_client_environments_id` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_scripts_clients_id` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security_group_rules_comments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_rules_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `env_id` int(11) NOT NULL,
  `cloud_credentials_hash` binary(32) DEFAULT NULL COMMENT 'cloud_credentials unique key',
  `platform` varchar(20) NOT NULL,
  `cloud_location` varchar(50) NOT NULL,
  `vpc_id` varchar(36) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `rule` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_main` (`env_id`,`platform`,`cloud_location`,`vpc_id`,`group_name`,`rule`),
  CONSTRAINT `FK_security_group_rules_comments_env_id` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_alerts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_alerts` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `server_id` varchar(36) NOT NULL COMMENT 'Server ID',
  `metric` varchar(255) NOT NULL COMMENT 'Metric type',
  `occurred` datetime NOT NULL COMMENT 'Date when error occurred (UTC)',
  `last_check` datetime DEFAULT NULL COMMENT 'Last time when unresolved error was checked (UTC)',
  `resolved` datetime DEFAULT NULL COMMENT 'Date when error resolved (UTC)',
  `status` tinyint(1) DEFAULT '0' COMMENT 'Status of error',
  `message` varchar(255) DEFAULT NULL COMMENT 'Short error message',
  `details` text COMMENT 'Full error message',
  `farm_id` int(11) DEFAULT NULL COMMENT 'Farm ID',
  `farm_role_id` int(11) DEFAULT NULL COMMENT 'Farm Role ID',
  `env_id` int(11) NOT NULL COMMENT 'Environment ID',
  `account_id` int(11) NOT NULL COMMENT 'Account ID',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_farm_id` (`farm_id`),
  KEY `idx_farm_role_id` (`farm_role_id`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_occurred` (`occurred`),
  KEY `idx_server_metric` (`server_id`,`metric`(16)),
  KEY `idx_last_check` (`last_check`),
  KEY `idx_status_resolved` (`status`,`resolved`),
  CONSTRAINT `fk_362cfea8a19c` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_cloud_resources` (
  `server_id` varchar(36) NOT NULL COMMENT 'servers.id ref',
  `cloud_resource_link_id` binary(16) NOT NULL COMMENT 'cloud_resource_links.id ref',
  PRIMARY KEY (`server_id`),
  UNIQUE KEY `unique_cloud_resource_link_id` (`cloud_resource_link_id`),
  CONSTRAINT `fk_d9304745a7fb1e2c` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_container_labels`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_container_labels` (
  `container_id` binary(32) NOT NULL COMMENT 'server_containers.container_id ref',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`container_id`,`name`),
  CONSTRAINT `fk_9e9b660e4f44` FOREIGN KEY (`container_id`) REFERENCES `server_containers` (`container_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_container_ports`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_container_ports` (
  `uuid` binary(16) NOT NULL COMMENT 'UUID',
  `container_id` binary(32) NOT NULL COMMENT 'server_containers.container_id ref',
  `protocol` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - tcp / 2 - udp',
  `source` smallint(5) unsigned DEFAULT NULL COMMENT 'A host port',
  `destination` smallint(5) unsigned NOT NULL COMMENT 'A container port',
  `host_ip` varbinary(16) DEFAULT NULL COMMENT 'IPv4 / IPv6 address (see INET6_ATON())',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `idx_unique` (`container_id`,`protocol`,`source`,`destination`,`host_ip`),
  CONSTRAINT `fk_4fe94a49a8a1` FOREIGN KEY (`container_id`) REFERENCES `server_containers` (`container_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_container_volumes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_container_volumes` (
  `container_id` binary(32) NOT NULL COMMENT 'server_containers.container_id ref',
  `source` varchar(255) NOT NULL COMMENT 'Host mpoint / volume',
  `destination` varchar(255) NOT NULL COMMENT 'Container mpoint',
  PRIMARY KEY (`container_id`,`source`,`destination`),
  CONSTRAINT `fk_fb3b10b35a9d` FOREIGN KEY (`container_id`) REFERENCES `server_containers` (`container_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_containers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_containers` (
  `container_id` binary(32) NOT NULL COMMENT 'Container ID',
  `server_id` varchar(36) NOT NULL COMMENT 'servers.id ref',
  `image` varchar(255) NOT NULL COMMENT 'Docker image name',
  `network` varchar(255) NOT NULL COMMENT 'Network name',
  `name` varchar(255) NOT NULL COMMENT 'The name of container',
  `created` datetime NOT NULL COMMENT 'UTC timestamp when it is created',
  `privileged` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether container has full access to host',
  `command` text COMMENT 'The command that a container runs',
  PRIMARY KEY (`container_id`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_created` (`created`),
  KEY `idx_name` (`name`(16)),
  CONSTRAINT `fk_c2c22becd0e8` FOREIGN KEY (`server_id`) REFERENCES `servers` (`server_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_launch_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_launch_log` (
  `server_id` char(36) NOT NULL COMMENT 'servers.server_id ref',
  `phase_id` tinyint(4) NOT NULL COMMENT 'Identifier of the phase',
  `status` tinyint(4) NOT NULL COMMENT 'Phase status',
  `started` datetime DEFAULT NULL COMMENT 'UTC start timestamp',
  `finished` datetime DEFAULT NULL COMMENT 'UTC finish timestamp',
  `error_message` text COMMENT 'Error message',
  PRIMARY KEY (`server_id`,`phase_id`),
  KEY `idx_started` (`started`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Server launch operation phase';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_properties` (
  `server_id` varchar(36) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`server_id`,`name`),
  KEY `serverid` (`server_id`),
  KEY `name_value` (`name`(20),`value`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_properties_archive`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_properties_archive` (
  `server_id` varchar(36) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`server_id`,`name`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_name_value` (`name`(20),`value`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_termination_errors`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_termination_errors` (
  `server_id` varchar(36) NOT NULL COMMENT 'servers.server_id ref',
  `retry_after` datetime NOT NULL COMMENT 'After what time it should be revalidated',
  `attempts` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The number of unsuccessful attempts',
  `last_error` text COMMENT 'Error message',
  PRIMARY KEY (`server_id`),
  KEY `idx_retry_after` (`retry_after`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Server termination process errors';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` varchar(36) DEFAULT NULL,
  `cloud_server_id` varchar(80) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) NOT NULL,
  `platform` varchar(20) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `instance_type_name` varchar(32) DEFAULT NULL COMMENT 'Instance type name',
  `status` varchar(25) DEFAULT NULL,
  `remote_ip` varchar(15) DEFAULT NULL,
  `local_ip` varchar(15) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `dtinitialized` datetime DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  `farm_index` mediumint(8) unsigned DEFAULT NULL COMMENT 'Instance index in the farm',
  `termination_priority` tinyint(4) DEFAULT NULL,
  `cloud_location` varchar(255) DEFAULT NULL,
  `cloud_location_zone` varchar(255) DEFAULT NULL,
  `image_id` varchar(255) DEFAULT NULL,
  `image_hash` binary(16) DEFAULT NULL,
  `dtshutdownscheduled` datetime DEFAULT NULL,
  `dtrebootstart` datetime DEFAULT NULL,
  `dtlastsync` datetime DEFAULT NULL,
  `os_type` enum('windows','linux') DEFAULT 'linux',
  `is_scalarized` tinyint(4) NOT NULL DEFAULT '1',
  `termination_attempts` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `farm_roleid` (`farm_roleid`),
  KEY `farmid_status` (`farm_id`,`status`),
  KEY `local_ip` (`local_ip`),
  KEY `env_id` (`env_id`),
  KEY `client_id` (`client_id`),
  KEY `idx_dtshutdownscheduled` (`dtshutdownscheduled`),
  KEY `idx_image_id` (`image_id`),
  KEY `idx_farm_index` (`farm_index`),
  KEY `idx_dtadded` (`dtadded`),
  KEY `idx_platform` (`platform`),
  KEY `idx_env_farm_status` (`env_id`,`farm_id`,`status`),
  KEY `idx_scheduled_attempts_force` (`dtshutdownscheduled`,`termination_attempts`),
  KEY `idx_cloud_server_id` (`cloud_server_id`),
  KEY `idx_role_images` (`server_id`,`env_id`,`farm_id`,`farm_roleid`,`platform`),
  KEY `fk_5ad87217b602` (`image_hash`),
  CONSTRAINT `fk_5ad87217b602` FOREIGN KEY (`image_hash`) REFERENCES `images` (`hash`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers_history` (
  `client_id` int(11) DEFAULT NULL,
  `server_id` varchar(36) NOT NULL,
  `cloud_server_id` varchar(80) DEFAULT NULL,
  `cloud_location` varchar(255) DEFAULT NULL,
  `project_id` binary(16) DEFAULT NULL,
  `cc_id` binary(16) DEFAULT NULL,
  `instance_type_name` varchar(50) DEFAULT NULL,
  `dtlaunched` datetime DEFAULT NULL,
  `dtterminated` datetime DEFAULT NULL,
  `launch_reason_id` tinyint(1) DEFAULT NULL,
  `launch_reason` varchar(255) DEFAULT NULL,
  `terminate_reason_id` tinyint(1) DEFAULT NULL,
  `terminate_reason` varchar(255) DEFAULT NULL,
  `platform` varchar(20) DEFAULT NULL,
  `os_type` enum('linux','windows') DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `farm_created_by_id` int(11) DEFAULT NULL,
  `server_index` int(5) DEFAULT NULL,
  `scu_used` float(11,2) DEFAULT '0.00',
  `scu_reported` float(11,2) DEFAULT '0.00',
  `scu_updated` tinyint(1) DEFAULT '0',
  `scu_collecting` tinyint(1) DEFAULT '0',
  `vcpus` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Count of Instance CPU',
  `ram` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of Instance ram',
  PRIMARY KEY (`server_id`),
  KEY `client_id` (`client_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_cc_id` (`cc_id`),
  KEY `idx_platform` (`platform`),
  KEY `idx_cloud_location` (`cloud_location`),
  KEY `idx_cloud_server_id` (`cloud_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers_launch_timelog`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers_launch_timelog` (
  `server_id` varchar(36) NOT NULL DEFAULT '',
  `os_family` varchar(15) DEFAULT NULL,
  `os_version` varchar(10) DEFAULT NULL,
  `cloud` varchar(20) DEFAULT NULL COMMENT 'Platform name',
  `cloud_location` varchar(255) DEFAULT NULL COMMENT 'Cloud location',
  `server_type` varchar(45) DEFAULT NULL COMMENT 'Server type',
  `behaviors` varchar(255) DEFAULT NULL,
  `ts_created` int(11) DEFAULT NULL,
  `ts_launched` int(11) DEFAULT NULL,
  `ts_hi` int(11) DEFAULT NULL,
  `ts_bhu` int(11) DEFAULT NULL,
  `ts_hu` int(11) DEFAULT NULL,
  `time_to_boot` int(5) DEFAULT NULL,
  `time_to_hi` int(5) DEFAULT NULL,
  `last_init_status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers_termination_data`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers_termination_data` (
  `server_id` varchar(36) NOT NULL,
  `farm_role_id` int(11) DEFAULT NULL COMMENT 'FarmRole id',
  `type` tinyint(4) NOT NULL COMMENT 'Type',
  `request` longtext,
  `request_url` text,
  `request_query` text,
  `response_code` int(3) DEFAULT NULL,
  `response_status` varchar(64) DEFAULT NULL,
  `response` longtext,
  `created` datetime NOT NULL COMMENT 'Created (UTC)',
  PRIMARY KEY (`server_id`,`type`),
  KEY `idx_response_code` (`response_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_ansible_tower_bootstrap_configurations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_ansible_tower_bootstrap_configurations` (
  `id` binary(16) NOT NULL COMMENT 'Unique row identifier',
  `account_id` int(11) DEFAULT NULL COMMENT 'User account identifier. clients.id',
  `at_server_id` binary(16) NOT NULL COMMENT 'AT server link. services_ansible_tower_servers.id',
  `organization_id` int(11) NOT NULL COMMENT 'AT organization ID',
  `inventory_id` int(11) NOT NULL COMMENT 'AT inventory ID',
  `name` varchar(255) NOT NULL COMMENT 'Bootstrap configuration name',
  `groups` text COMMENT 'Configuration groups list',
  `is_shared` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it shared to outer scope?',
  `variables` mediumtext NOT NULL COMMENT 'AT host variables',
  `allow_override` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is allow override variables?',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`account_id`),
  KEY `idx_server` (`at_server_id`),
  CONSTRAINT `fk_178a6ec49987` FOREIGN KEY (`at_server_id`) REFERENCES `services_ansible_tower_servers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_6a2986195d1a` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_ansible_tower_group_templates`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_ansible_tower_group_templates` (
  `id` binary(16) NOT NULL COMMENT 'Unique row identifier',
  `account_id` int(11) DEFAULT NULL COMMENT 'User account identifier. clients.id',
  `at_server_id` binary(16) NOT NULL COMMENT 'AT server link. services_ansible_tower_servers.id',
  `name` varchar(512) NOT NULL COMMENT 'AT group template name',
  `description` text NOT NULL COMMENT 'AT group template description',
  `parent_id` binary(16) DEFAULT NULL COMMENT 'Self referenced hierarchy link. services_ansible_tower_group_templates.id',
  `variables` text COMMENT 'AT Group variables',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`account_id`),
  KEY `idx_server` (`at_server_id`),
  KEY `idx_parent` (`parent_id`),
  CONSTRAINT `fk_04e5be3b8410` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b22b22aad2fe` FOREIGN KEY (`parent_id`) REFERENCES `services_ansible_tower_group_templates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_be79aba3a7de` FOREIGN KEY (`at_server_id`) REFERENCES `services_ansible_tower_servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_ansible_tower_machine_credentials`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_ansible_tower_machine_credentials` (
  `id` binary(16) NOT NULL COMMENT 'Unique row identifier',
  `configuration_id` binary(16) NOT NULL COMMENT 'Bootstrap configuration identifier. services_ansible_tower_bootstrap_configurations.id',
  `credentials_id` int(11) NOT NULL COMMENT 'AT machine credentials ID',
  `os_type` tinyint(1) NOT NULL COMMENT 'OS type flag',
  `password` varchar(255) DEFAULT NULL COMMENT 'password for windows credentials',
  `public_key` text COMMENT 'ssh public key for linux credentials',
  `become_method` varchar(20) DEFAULT NULL COMMENT 'Become method (sudo||null) ',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT 'Username',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_conf_os_creds` (`configuration_id`,`os_type`),
  KEY `idx_config` (`configuration_id`),
  CONSTRAINT `fk_1fe86efd13b4` FOREIGN KEY (`configuration_id`) REFERENCES `services_ansible_tower_bootstrap_configurations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_ansible_tower_servers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_ansible_tower_servers` (
  `id` binary(16) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL COMMENT 'Server access URL',
  `username` varchar(255) NOT NULL COMMENT 'User name',
  `password` varchar(255) NOT NULL COMMENT 'Password',
  `validate_ssl` tinyint(4) NOT NULL DEFAULT '1',
  `token` varchar(40) DEFAULT NULL COMMENT 'Authorization token string',
  `token_expires_at` datetime DEFAULT NULL COMMENT 'Token expiration date in UTC timezone',
  `ca_certificate` text COMMENT 'CA certificate.',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`account_id`),
  CONSTRAINT `fk_d426cf787ad6` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_chef_servers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_chef_servers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `level` tinyint(4) NOT NULL COMMENT '1 - Scalr, 2 - Account, 4 - Env',
  `url` varchar(255) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `auth_key` text,
  `v_username` varchar(255) DEFAULT NULL,
  `v_auth_key` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_db_backup_parts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_db_backup_parts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `backup_id` int(11) DEFAULT NULL,
  `path` text,
  `size` int(11) DEFAULT NULL,
  `seq_number` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_id` (`backup_id`),
  CONSTRAINT `services_db_backup_parts_ibfk_1` FOREIGN KEY (`backup_id`) REFERENCES `services_db_backups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_db_backups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_db_backups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(25) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `platform` varchar(25) DEFAULT NULL,
  `provider` varchar(20) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `cloud_location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `env_id` (`env_id`),
  CONSTRAINT `services_db_backups_ibfk_1` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_db_backups_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_db_backups_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_role_id` int(11) NOT NULL,
  `operation` enum('backup','bundle') NOT NULL,
  `date` datetime NOT NULL,
  `status` enum('ok','error') NOT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `main` (`farm_role_id`),
  CONSTRAINT `services_db_backups_history_ibfk_1` FOREIGN KEY (`farm_role_id`) REFERENCES `farm_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services_ssl_certs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_ssl_certs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `env_id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `ssl_pkey` text NOT NULL,
  `ssl_cert` text NOT NULL,
  `ssl_cabundle` text,
  `ssl_pkey_password` text,
  `ssl_simple_pkey` text,
  PRIMARY KEY (`id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_94f84469e7e0ee97` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` varchar(64) NOT NULL COMMENT 'setting ID',
  `value` text COMMENT 'The value',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssh_keys`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssh_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `env_id` int(11) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `private_key` text,
  `public_key` text,
  `cloud_location` varchar(255) DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `cloud_key_name` varchar(255) DEFAULT NULL,
  `platform` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_platform` (`platform`,`type`,`env_id`,`farm_id`,`cloud_location`,`cloud_key_name`),
  KEY `fk_ssh_keys_client_environments_id` (`env_id`),
  KEY `idx_farm_id` (`farm_id`),
  KEY `idx_cloud_key_name` (`cloud_key_name`),
  CONSTRAINT `fk_ssh_keys_client_environments_id` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ssh_keys_farms_id` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_device_cloud_resources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_device_cloud_resources` (
  `storage_config_id` varchar(36) NOT NULL COMMENT 'farm_role_storage_devices.storage_config_id ref',
  `cloud_resource_link_id` binary(16) NOT NULL COMMENT 'cloud_resource_links.id ref',
  PRIMARY KEY (`storage_config_id`),
  UNIQUE KEY `unique_cloud_resource_link_id` (`cloud_resource_link_id`),
  CONSTRAINT `fk_86e626097dd67aab` FOREIGN KEY (`storage_config_id`) REFERENCES `farm_role_storage_config` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_restore_configs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_restore_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `farm_roleid` int(11) DEFAULT NULL,
  `dtadded` datetime DEFAULT NULL,
  `manifest` text,
  `type` enum('full','incremental') NOT NULL,
  `parent_manifest` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_snapshots`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_snapshots` (
  `id` varchar(36) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `config` text,
  `description` text,
  `ismysql` tinyint(1) DEFAULT '0',
  `dtcreated` datetime DEFAULT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `cloud_location` varchar(20) DEFAULT NULL,
  `cloud_resource_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `farm_roleid` (`farm_roleid`),
  KEY `idx_cloud_resource_id` (`cloud_resource_id`),
  CONSTRAINT `fk_ced0314b30e9` FOREIGN KEY (`cloud_resource_id`) REFERENCES `cloud_resources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_volumes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_volumes` (
  `id` varchar(50) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `attachment_status` varchar(255) DEFAULT NULL,
  `mount_status` varchar(255) DEFAULT NULL,
  `config` text,
  `type` varchar(20) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `platform` varchar(20) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `fstype` varchar(255) DEFAULT NULL,
  `farm_roleid` int(11) DEFAULT NULL,
  `server_index` int(11) DEFAULT NULL,
  `purpose` varchar(20) DEFAULT NULL,
  `cloud_resource_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cloud_resource_id` (`cloud_resource_id`),
  CONSTRAINT `fk_d0769a19750d` FOREIGN KEY (`cloud_resource_id`) REFERENCES `cloud_resources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag_links`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_links` (
  `tag_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `resource` varchar(36) NOT NULL COMMENT 'Tagged resource type',
  `resource_id` varchar(24) NOT NULL,
  UNIQUE KEY `unique_link` (`resource`,`resource_id`,`tag_id`),
  KEY `idx_tag_id` (`tag_id`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `fk_b0f81d02d9b01a35` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b93f94fca697a0ca` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_policy_tag` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Policy tag flag.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_ownership`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_ownership` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `hash` binary(32) NOT NULL COMMENT 'Hash of ordered teams set',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account teams sets used for vary resources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_ownership_items`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_ownership_items` (
  `ownership_id` binary(16) NOT NULL COMMENT 'UUID of account team preset',
  `team_id` int(11) NOT NULL COMMENT 'account_teams.id ref',
  PRIMARY KEY (`ownership_id`,`team_id`),
  KEY `idx_team_id` (`team_id`),
  CONSTRAINT `fk_6222c27c524b` FOREIGN KEY (`team_id`) REFERENCES `account_teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_998534a469a1` FOREIGN KEY (`ownership_id`) REFERENCES `team_ownership` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_access_tokens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_access_tokens` (
  `id` varchar(24) NOT NULL COMMENT 'The access token identifier',
  `token` varchar(512) NOT NULL COMMENT 'The JWT access token',
  `created_by` int(11) NOT NULL COMMENT 'The user identifier',
  `description` text COMMENT 'The access token description',
  `created_at` datetime NOT NULL COMMENT 'Created at UTC timestamp',
  `last_used_at` datetime DEFAULT NULL COMMENT 'Last used at UTC timestamp',
  PRIMARY KEY (`id`),
  KEY `idx_created_by` (`created_by`),
  CONSTRAINT `fk_5a9f5ea3d977` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_applies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_applies` (
  `id` varchar(24) NOT NULL,
  `status` varchar(64) NOT NULL COMMENT 'Status of the apply operation',
  `resource_additions` int(11) unsigned DEFAULT NULL COMMENT 'The number of created resources',
  `resource_changes` int(11) unsigned DEFAULT NULL COMMENT 'The number of modified resources',
  `resource_destructions` int(11) unsigned DEFAULT NULL COMMENT 'The number of deleted resources',
  `log_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading an apply log',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the Apply was created',
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_applies_statuses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_applies_statuses` (
  `id` binary(16) NOT NULL COMMENT 'The status transition times identifier',
  `resource_id` varchar(24) NOT NULL COMMENT 'The resource  identifier',
  `status` varchar(64) NOT NULL COMMENT 'The a status of a resource',
  `occurred_at` datetime NOT NULL COMMENT 'The utc datetime when this status is occurred',
  `reason` text COMMENT 'The a reason for set to this status',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_occurred_at` (`occurred_at`),
  CONSTRAINT `fk_88c2957c9c44` FOREIGN KEY (`resource_id`) REFERENCES `tf_applies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_blobs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_blobs` (
  `blob_id` varchar(64) NOT NULL COMMENT 'Blob id PK',
  `blob` longblob COMMENT 'Blob data',
  `modified_at` datetime NOT NULL COMMENT 'The UTC datetime at which the blob was modified last time',
  `accessed_at` datetime DEFAULT NULL COMMENT 'The UTC datetime at which the blob was accessed last time',
  `read_only` tinyint(1) DEFAULT '1' COMMENT 'Writes to this blob will be disabled if true.',
  PRIMARY KEY (`blob_id`),
  KEY `idx_modified_at` (`modified_at`),
  KEY `idx_accessed_at` (`accessed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_blobs_cache`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_blobs_cache` (
  `id` binary(16) NOT NULL COMMENT 'UUID',
  `blob_id` varchar(64) NOT NULL COMMENT 'Blob identifier',
  `blob` mediumblob COMMENT 'Blob data',
  `length` int(10) unsigned NOT NULL COMMENT 'Blob data length',
  `offset` int(10) unsigned NOT NULL COMMENT 'Offset position',
  PRIMARY KEY (`id`),
  KEY `idx_blob_id` (`blob_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_configuration_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_configuration_versions` (
  `id` varchar(24) NOT NULL,
  `source` varchar(255) NOT NULL COMMENT 'Represents a source of a configuration version',
  `status` varchar(64) NOT NULL COMMENT 'Represents a configuration version status',
  `auto_queue_runs` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'When true, runs are queued automatically when the configuration version is uploaded',
  `speculative` tinyint(1) unsigned NOT NULL COMMENT 'When true, this configuration version can only be used for planning',
  `configuration_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading an configuration version',
  `workspace_id` varchar(24) NOT NULL COMMENT 'The ID of the workspace the configuration version belongs to',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the ConfigurationVersion was created',
  `revision_binding_id` varchar(24) DEFAULT NULL COMMENT 'The vcs revision binding',
  `inputs` mediumtext COMMENT 'Input variables',
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_workspace_id` (`workspace_id`),
  KEY `idx_revision_binding_id` (`revision_binding_id`),
  CONSTRAINT `fk_402bb78b19b4` FOREIGN KEY (`revision_binding_id`) REFERENCES `vcs_revision_bindings` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_69062659f238` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_configuration_versions_statuses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_configuration_versions_statuses` (
  `id` binary(16) NOT NULL COMMENT 'The status transition times identifier',
  `resource_id` varchar(24) NOT NULL COMMENT 'The resource  identifier',
  `status` varchar(64) NOT NULL COMMENT 'The a status of a resource',
  `occurred_at` datetime NOT NULL COMMENT 'The utc datetime when this status is occurred',
  `reason` text COMMENT 'The a reason for set to this status',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_occurred_at` (`occurred_at`),
  CONSTRAINT `fk_09f1aee3e6ee` FOREIGN KEY (`resource_id`) REFERENCES `tf_configuration_versions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_cost_estimates`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_cost_estimates` (
  `id` varchar(24) NOT NULL,
  `status` varchar(64) NOT NULL COMMENT 'Status of the cost estimate operation',
  `resources_count` int(11) unsigned DEFAULT NULL COMMENT 'Total count of processed resources',
  `matched_resources_count` int(11) unsigned DEFAULT NULL COMMENT 'Count of matched resources',
  `unmatched_resources_count` int(11) unsigned DEFAULT NULL COMMENT 'Count of unmatched resources',
  `errored_resources_count` int(11) unsigned DEFAULT NULL COMMENT 'Count of errored resources',
  `prior_monthly_cost` decimal(12,6) unsigned DEFAULT NULL COMMENT 'Prior monthly cost',
  `proposed_monthly_cost` decimal(12,6) unsigned DEFAULT NULL COMMENT 'Current monthly cost',
  `delta_monthly_cost` decimal(12,6) DEFAULT NULL COMMENT 'Delta monthly cost',
  `resources` text COMMENT 'The UTC datetime at which the Apply was created',
  `log_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading cost estimate log',
  `error_message` text COMMENT 'Specifies the reason for the errored status',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_cost_estimates_statuses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_cost_estimates_statuses` (
  `id` binary(16) NOT NULL COMMENT 'The status transition times identifier',
  `resource_id` varchar(24) NOT NULL COMMENT 'The resource  identifier',
  `status` varchar(64) NOT NULL COMMENT 'The a status of a resource',
  `occurred_at` datetime NOT NULL COMMENT 'The utc datetime when this status is occurred',
  `reason` text COMMENT 'The a reason for set to this status',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_occurred_at` (`occurred_at`),
  CONSTRAINT `fk_ad5c0f4e1bd3` FOREIGN KEY (`resource_id`) REFERENCES `tf_cost_estimates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_endpoints`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_endpoints` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `account_id` varchar(24) DEFAULT NULL COMMENT 'clients.acc_id ref',
  `env_id` varchar(24) DEFAULT NULL COMMENT 'client_environments.env_id ref',
  `workspace_id` varchar(24) DEFAULT NULL COMMENT 'tf_workspaces.id ref',
  `name` varchar(255) NOT NULL COMMENT 'Endpoint name',
  `url` varchar(2048) NOT NULL COMMENT 'Endpoint URL',
  `secret_key` varchar(255) NOT NULL COMMENT 'Secret key to sign payload',
  `timeout` int(11) NOT NULL COMMENT 'Webhook timeout',
  `max_attempts` int(11) NOT NULL COMMENT 'Max delivery attempts',
  `http_method` varchar(12) NOT NULL DEFAULT 'POST' COMMENT 'Http method',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_name` (`name`(190)),
  KEY `idx_workspace_id` (`workspace_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_39358a0fa2b7` FOREIGN KEY (`account_id`) REFERENCES `clients` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_6edd9cf69bbf` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`env_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_8b6eaf39498f` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_event_definitions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_event_definitions` (
  `name` varchar(64) NOT NULL,
  `description` text,
  `created_at` datetime NOT NULL COMMENT 'UTC Created at timestamp',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_marketing_reports`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_marketing_reports` (
  `id` binary(16) NOT NULL COMMENT 'PK uuid',
  `report` mediumtext COMMENT 'Report data (json)',
  `modified_at` datetime NOT NULL COMMENT 'The UTC datetime at which the report was modified last time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_module_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_module_versions` (
  `id` varchar(24) NOT NULL,
  `module_id` varchar(24) NOT NULL COMMENT 'tf_modules.id ref',
  `source` varchar(24) NOT NULL COMMENT 'Source of the version',
  `status` varchar(24) NOT NULL COMMENT 'Status of the version',
  `error_message` text COMMENT 'Error message',
  `version` varchar(64) NOT NULL COMMENT 'SemVer for module version',
  `module_blob_id` varchar(255) DEFAULT NULL COMMENT 'Id of the blob where module version source code is stored',
  `created_at` datetime NOT NULL COMMENT 'UTC timestamp when module created',
  `updated_at` datetime NOT NULL COMMENT 'UTC timestamp when module last time updated',
  `details` mediumtext COMMENT 'README file',
  `inputs` mediumtext COMMENT 'Input variables',
  `outputs` mediumtext COMMENT 'Output variables',
  `dependencies` mediumtext COMMENT 'Dependencies',
  `resources` text COMMENT 'Resources',
  `revision_binding_id` varchar(24) DEFAULT NULL COMMENT 'The vcs revision binding',
  PRIMARY KEY (`id`),
  KEY `idx_module_id` (`module_id`),
  KEY `idx_revision_binding_id` (`revision_binding_id`),
  CONSTRAINT `fk_6cae07f9352e` FOREIGN KEY (`module_id`) REFERENCES `tf_modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_7693524986aa` FOREIGN KEY (`revision_binding_id`) REFERENCES `vcs_revision_bindings` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_modules`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_modules` (
  `id` varchar(24) NOT NULL,
  `acc_id` varchar(24) DEFAULT NULL COMMENT 'clients.acc_id ref',
  `name` varchar(64) NOT NULL COMMENT 'Name of the module',
  `provider` varchar(64) NOT NULL COMMENT 'Name of the provider',
  `env_id` varchar(24) DEFAULT NULL COMMENT 'client_environments.env_id ref',
  `status` varchar(24) NOT NULL COMMENT 'Status of the module',
  `error_message` text COMMENT 'Error message',
  `created_at` datetime NOT NULL COMMENT 'UTC timestamp when module created',
  `updated_at` datetime NOT NULL COMMENT 'UTC timestamp when module last time updated',
  PRIMARY KEY (`id`),
  KEY `idx_organization_name` (`env_id`),
  KEY `acc_idx` (`acc_id`),
  CONSTRAINT `fk_0c7836847331` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`env_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_7985b5c85a84` FOREIGN KEY (`acc_id`) REFERENCES `clients` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_offering_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_offering_versions` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `offering_id` varchar(24) NOT NULL COMMENT 'offerings.id ref',
  `status` varchar(64) NOT NULL COMMENT 'Offering Version status',
  `inputs` mediumtext COMMENT 'List of TF variables defined in module in JSON format',
  `manifest` mediumtext COMMENT 'Contents of scalr-module.hcl file in JSON format',
  `resources` text COMMENT 'List of resources defined in module.tf file in JSON format',
  `outputs` text COMMENT 'TF outputs template',
  `module_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading TF module contents',
  `readme` text COMMENT 'Contents of readme.md file',
  `error_message` text COMMENT 'Specifies the reason for the errored status',
  `synced_at` datetime NOT NULL COMMENT 'UTC Datetime when this version was last synchronized',
  `revision_binding_id` varchar(24) NOT NULL COMMENT 'The vcs revision binding identifier',
  PRIMARY KEY (`id`),
  KEY `idx_offering_id` (`offering_id`),
  KEY `idx_status` (`status`),
  KEY `idx_revision_binding_id` (`revision_binding_id`),
  CONSTRAINT `fk_64696ed74a7b` FOREIGN KEY (`revision_binding_id`) REFERENCES `vcs_revision_bindings` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_afc1675159de` FOREIGN KEY (`offering_id`) REFERENCES `tf_offerings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_offerings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_offerings` (
  `id` varchar(24) NOT NULL COMMENT 'UUID',
  `account_id` int(11) DEFAULT NULL COMMENT 'scope',
  `env_id` int(11) DEFAULT NULL COMMENT 'scope',
  `category_id` varchar(24) DEFAULT NULL COMMENT 'Offering category',
  `name` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL COMMENT 'Application created UTC timestamp',
  `icon` varchar(50) DEFAULT NULL COMMENT 'Icon name',
  `custom_icon` mediumtext COMMENT 'Custom icon json data',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_category_id` (`category_id`),
  CONSTRAINT `fk_696fe8e1bc0d` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_c8783dd1e6f7` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ffb054bad3ef` FOREIGN KEY (`category_id`) REFERENCES `sc_offering_categories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_plans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_plans` (
  `id` varchar(24) NOT NULL,
  `has_changes` tinyint(1) unsigned NOT NULL COMMENT 'A boolean value that indicates whether the terraform plan has any changes',
  `status` varchar(64) NOT NULL COMMENT 'Status of a plan operation',
  `resource_additions` int(11) unsigned DEFAULT NULL COMMENT 'The number of created resources',
  `resource_changes` int(11) unsigned DEFAULT NULL COMMENT 'The number of modified resources',
  `resource_destructions` int(11) unsigned DEFAULT NULL COMMENT 'The number of deleted resources',
  `plan_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading a plan body',
  `log_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading a plan log',
  `plan_json_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading a plan JSON',
  `created_at` datetime NOT NULL COMMENT 'The time at which the Plan was created',
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_plans_statuses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_plans_statuses` (
  `id` binary(16) NOT NULL COMMENT 'The status transition times identifier',
  `resource_id` varchar(24) NOT NULL COMMENT 'The resource  identifier',
  `status` varchar(64) NOT NULL COMMENT 'The a status of a resource',
  `occurred_at` datetime NOT NULL COMMENT 'The utc datetime when this status is occurred',
  `reason` text COMMENT 'The a reason for set to this status',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_occurred_at` (`occurred_at`),
  CONSTRAINT `fk_c13c534649d6` FOREIGN KEY (`resource_id`) REFERENCES `tf_plans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_policy_check_results`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_policy_check_results` (
  `id` varchar(24) NOT NULL COMMENT 'The policy check result id',
  `policy_check_id` varchar(24) NOT NULL COMMENT 'ID of the policy check this result belongs to',
  `name` varchar(100) NOT NULL COMMENT 'Policy name',
  `result` varchar(64) NOT NULL COMMENT 'Status of the policy check operation',
  `messages` text NOT NULL COMMENT 'Outcome (JSON array of strings) of policy checking',
  PRIMARY KEY (`id`),
  UNIQUE KEY `policy_check_id` (`policy_check_id`,`name`),
  CONSTRAINT `fk_844dc8ae361dd009` FOREIGN KEY (`policy_check_id`) REFERENCES `tf_policy_checks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_policy_checks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_policy_checks` (
  `id` varchar(24) NOT NULL COMMENT 'The policy check identifier',
  `run_id` varchar(24) NOT NULL COMMENT 'ID of the run this policy check belongs to',
  `policy_group_check_id` varchar(24) NOT NULL,
  `status` varchar(64) NOT NULL COMMENT 'Status of the policy check operation',
  `log_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for writing policy check log',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the Policy check was created',
  `total_passed` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of passed policies',
  `total_failed` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of failed policies including hard, soft and advisory failed',
  `hard_failed` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of hard failed policies',
  `soft_failed` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of soft failed policies',
  `advisory_failed` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of advisory failed policies',
  `duration` int(11) NOT NULL COMMENT 'Policy check duration in ms',
  PRIMARY KEY (`id`),
  KEY `idx_run_id` (`run_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_policy_group_check_id` (`policy_group_check_id`),
  CONSTRAINT `fk_9fcaa613cd44` FOREIGN KEY (`policy_group_check_id`) REFERENCES `tf_policy_group_checks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_f9ff5d703403` FOREIGN KEY (`run_id`) REFERENCES `tf_runs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_policy_checks_statuses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_policy_checks_statuses` (
  `id` binary(16) NOT NULL COMMENT 'The status transition times identifier',
  `resource_id` varchar(24) NOT NULL COMMENT 'The resource  identifier',
  `status` varchar(64) NOT NULL COMMENT 'The a status of a resource',
  `occurred_at` datetime NOT NULL COMMENT 'The utc datetime when this status is occurred',
  `reason` text COMMENT 'The a reason for set to this status',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_occurred_at` (`occurred_at`),
  CONSTRAINT `fk_6823a5644c74` FOREIGN KEY (`resource_id`) REFERENCES `tf_policy_checks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_policy_group_checks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_policy_group_checks` (
  `id` varchar(24) NOT NULL,
  `policy_group_id` varchar(24) DEFAULT NULL,
  `revision_binding_id` varchar(24) NOT NULL,
  `status` varchar(64) NOT NULL COMMENT 'Policy group check status',
  `error_message` text COMMENT 'Policy group check Error message',
  `source` varchar(64) NOT NULL COMMENT 'Policy froup check was triggered from',
  `created_at` datetime NOT NULL COMMENT 'Created at UTC timestamp',
  PRIMARY KEY (`id`),
  KEY `idx_policy_group_id` (`policy_group_id`),
  KEY `idx_revision_binding_id` (`revision_binding_id`),
  CONSTRAINT `fk_654330e2701e` FOREIGN KEY (`revision_binding_id`) REFERENCES `vcs_revision_bindings` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_9099647f7f4d` FOREIGN KEY (`policy_group_id`) REFERENCES `policy_groups` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Policy group checks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_runs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_runs` (
  `id` varchar(24) NOT NULL,
  `is_destroy` tinyint(1) unsigned NOT NULL COMMENT 'Specifies if this plan is a destroy plan, which will destroy all provisioned resources.',
  `message` varchar(512) DEFAULT NULL COMMENT 'Specifies the message to be associated with this run',
  `metadata` text NOT NULL COMMENT 'Custom metadata of the run',
  `source` varchar(255) NOT NULL COMMENT 'Represents a source type of a run',
  `status` varchar(64) NOT NULL COMMENT 'Represents a status of a run',
  `terraform_version` varchar(255) NOT NULL COMMENT 'Represents the version of Terraform that used to perform this run',
  `has_changes` tinyint(1) unsigned NOT NULL COMMENT 'A boolean value that indicates whether the terraform plan has any changes',
  `plan_only` tinyint(1) unsigned NOT NULL COMMENT 'This field can be set to only run terraform plan and not actually apply it',
  `force_cancel_available_at` datetime DEFAULT NULL COMMENT 'The UTC datetime at which the force-cancel action will become available',
  `workspace_id` varchar(255) NOT NULL COMMENT 'The ID of the workspace the run belongs to',
  `configuration_version_id` varchar(255) NOT NULL COMMENT 'The configuration record used in the run',
  `plan_id` varchar(24) NOT NULL COMMENT 'The ID of the Plan to associate with the Run',
  `cost_estimate_id` varchar(24) DEFAULT NULL COMMENT 'tf_cost_estimates.id ref',
  `apply_id` varchar(24) DEFAULT NULL COMMENT 'The ID of the Apply to associate with the Run',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the Run was created',
  `canceled_at` datetime DEFAULT NULL COMMENT 'The UTC datetime at which the Run was canceled',
  `created_by` varchar(24) DEFAULT NULL COMMENT 'User happy id',
  `created_by_email` varchar(100) DEFAULT NULL COMMENT 'Email of the User who created a run',
  `inputs` mediumtext COMMENT 'Input variables',
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_workspace_id` (`workspace_id`),
  KEY `idx_configuration_version_id` (`configuration_version_id`),
  KEY `idx_plan_id` (`plan_id`),
  KEY `idx_apply_id` (`apply_id`),
  KEY `idx_cost_estimate_id` (`cost_estimate_id`),
  KEY `fk_3bcd543226da` (`created_by`),
  CONSTRAINT `fk_18e0ebf37f6a` FOREIGN KEY (`apply_id`) REFERENCES `tf_applies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_350d28bb03ee` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_3bcd543226da` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_96955c529ee9` FOREIGN KEY (`configuration_version_id`) REFERENCES `tf_configuration_versions` (`id`),
  CONSTRAINT `fk_ac03be5960c3` FOREIGN KEY (`cost_estimate_id`) REFERENCES `tf_cost_estimates` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_f2ab2f618cb6` FOREIGN KEY (`plan_id`) REFERENCES `tf_plans` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_runs_statuses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_runs_statuses` (
  `id` binary(16) NOT NULL COMMENT 'The status transition times identifier',
  `resource_id` varchar(24) NOT NULL COMMENT 'The resource  identifier',
  `status` varchar(64) NOT NULL COMMENT 'The a status of a resource',
  `occurred_at` datetime NOT NULL COMMENT 'The utc datetime when this status is occurred',
  `reason` text COMMENT 'The a reason for set to this status',
  PRIMARY KEY (`id`),
  KEY `idx_resource_id` (`resource_id`),
  KEY `idx_occurred_at` (`occurred_at`),
  CONSTRAINT `fk_62cb19032687` FOREIGN KEY (`resource_id`) REFERENCES `tf_runs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_state_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_state_versions` (
  `id` varchar(24) NOT NULL,
  `serial` int(11) unsigned NOT NULL COMMENT 'The serial of the state version',
  `vcs_commit_sha` varchar(255) DEFAULT NULL COMMENT 'SHA of the VCS commit',
  `vcs_commit_url` varchar(255) DEFAULT NULL COMMENT 'URL of the commit related to this state version',
  `state_blob_id` varchar(255) DEFAULT NULL COMMENT 'ID of the blob in the Blob Storage. Used for reading a raw state',
  `run_id` varchar(24) DEFAULT NULL COMMENT 'The ID of the run to associate with the state version',
  `workspace_id` varchar(24) NOT NULL COMMENT 'The ID of the workspace the state version belongs to',
  `lineage` varchar(255) DEFAULT NULL COMMENT 'Unique ID assigned to a state when it is created',
  `md5_hash` varchar(32) NOT NULL COMMENT 'An MD5 hash of the raw state version',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the StateVersion was created',
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_run_id` (`run_id`),
  KEY `idx_workspace_id` (`workspace_id`),
  CONSTRAINT `fk_0c9be79f49e5` FOREIGN KEY (`run_id`) REFERENCES `tf_runs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_c2732ae1cd8a` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_template_versions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_template_versions` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId; prefix - tplver',
  `template_id` varchar(24) NOT NULL COMMENT 'tf_templates.id ref',
  `status` varchar(24) NOT NULL COMMENT 'Status of the version',
  `error_message` text COMMENT 'Error message',
  `version` varchar(64) NOT NULL COMMENT 'SemVer for template version',
  `template_blob_id` varchar(255) DEFAULT NULL COMMENT 'Id of the blob where template version source code is stored',
  `created_at` datetime NOT NULL COMMENT 'UTC timestamp when template created',
  `updated_at` datetime NOT NULL COMMENT 'UTC timestamp when template last time updated',
  `details` mediumtext COMMENT 'README file',
  `inputs` mediumtext COMMENT 'Input variables',
  `outputs` mediumtext COMMENT 'Output variables',
  `resources` text COMMENT 'Resources',
  `revision_binding_id` varchar(24) DEFAULT NULL COMMENT 'The vcs revision binding',
  PRIMARY KEY (`id`),
  KEY `idx_template_id` (`template_id`),
  KEY `idx_revision_binding_id` (`revision_binding_id`),
  CONSTRAINT `fk_a7a36918fa7169b3` FOREIGN KEY (`template_id`) REFERENCES `tf_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_e040a85574861aea` FOREIGN KEY (`revision_binding_id`) REFERENCES `vcs_revision_bindings` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_templates`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_templates` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId; prefix - tpl',
  `name` varchar(64) NOT NULL COMMENT 'Name of the template',
  `description` text COMMENT 'Template description',
  `env_id` varchar(24) DEFAULT NULL COMMENT 'client_environments.env_id ref',
  `acc_id` varchar(24) DEFAULT NULL COMMENT 'clients.acc_id ref',
  `status` varchar(24) NOT NULL COMMENT 'Status of the template',
  `created_at` datetime NOT NULL COMMENT 'UTC timestamp when template created',
  `updated_at` datetime NOT NULL COMMENT 'UTC timestamp when template last time updated',
  PRIMARY KEY (`id`),
  KEY `idx_organization_name` (`env_id`),
  KEY `idx_account_id` (`acc_id`),
  CONSTRAINT `fk_04d5a269d3ef` FOREIGN KEY (`acc_id`) REFERENCES `clients` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_9ecaaeb05a45` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`env_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_variables`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_variables` (
  `id` varchar(24) NOT NULL,
  `key` varchar(128) NOT NULL COMMENT 'The name of the variable',
  `value` text NOT NULL COMMENT 'tf var value',
  `description` varchar(512) DEFAULT NULL COMMENT 'The description of the variable',
  `category` varchar(9) NOT NULL COMMENT 'Either env or terraform',
  `hcl` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether to evaluate the value of the variable as a string of HCL code',
  `sensitive` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether the value is sensitive.',
  `workspace_id` varchar(24) NOT NULL COMMENT 'tf_workspaces.id ref',
  PRIMARY KEY (`id`),
  KEY `idx_key` (`key`),
  KEY `idx_category` (`category`),
  KEY `idx_workspace_id` (`workspace_id`),
  CONSTRAINT `fk_90da2968fde8` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_webhook_deliveries`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_webhook_deliveries` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `webhook_id` varchar(24) NOT NULL COMMENT 'The ID of the webhook',
  `event_name` varchar(64) NOT NULL COMMENT 'tf_event_definitions.name',
  `run_id` varchar(24) DEFAULT NULL COMMENT 'tf_runs.ref',
  `triggered_by_id` int(11) DEFAULT NULL COMMENT 'The ID of the user who triggered event',
  `status` varchar(64) NOT NULL COMMENT 'Status of delivery',
  `request_headers` text COMMENT 'Json encoded',
  `request_body` mediumtext COMMENT 'Json encoded',
  `response_headers` text COMMENT 'Json encoded',
  `response_body` mediumtext COMMENT 'Json encoded',
  `response_code` int(11) DEFAULT NULL COMMENT 'Response status code',
  `attempts` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of delivery attempts',
  `triggered_at` datetime NOT NULL COMMENT 'The UTC datetime when event was triggered',
  `last_handle_attempt_at` datetime NOT NULL COMMENT 'The UTC datetime of last handle attempt',
  `error_message` text COMMENT 'Webhook delivery error message',
  PRIMARY KEY (`id`),
  KEY `idx_webhook_id` (`webhook_id`),
  KEY `idx_event_id` (`event_name`),
  KEY `idx_triggered_by_id` (`triggered_by_id`),
  KEY `fk_51f283cde52b` (`run_id`),
  CONSTRAINT `fk_001baa258189` FOREIGN KEY (`event_name`) REFERENCES `tf_event_definitions` (`name`) ON DELETE CASCADE,
  CONSTRAINT `fk_050c48ffe588` FOREIGN KEY (`webhook_id`) REFERENCES `tf_webhooks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_51f283cde52b` FOREIGN KEY (`run_id`) REFERENCES `tf_runs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_b3cd2616ee46` FOREIGN KEY (`triggered_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_webhook_events`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_webhook_events` (
  `webhook_id` varchar(24) NOT NULL COMMENT 'The ID of the webhook',
  `event_name` varchar(64) NOT NULL COMMENT 'tf_event_definitions.name',
  PRIMARY KEY (`webhook_id`,`event_name`),
  KEY `idx_event_id` (`event_name`),
  CONSTRAINT `fk_3e0fa57b1996` FOREIGN KEY (`event_name`) REFERENCES `tf_event_definitions` (`name`) ON DELETE CASCADE,
  CONSTRAINT `fk_53aee09edffa` FOREIGN KEY (`webhook_id`) REFERENCES `tf_webhooks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_webhooks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_webhooks` (
  `id` varchar(24) NOT NULL COMMENT 'ScalrId',
  `account_id` varchar(24) DEFAULT NULL COMMENT 'clients.acc_id ref',
  `env_id` varchar(24) DEFAULT NULL COMMENT 'client_environments.env_id ref',
  `workspace_id` varchar(24) DEFAULT NULL COMMENT 'tf_workspaces.id ref',
  `endpoint_id` varchar(24) NOT NULL COMMENT 'tf_endpoints.ref',
  `name` varchar(255) NOT NULL COMMENT 'Webhook name',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Enabled/Disabled',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_workspace_id` (`workspace_id`),
  KEY `idx_endpoint_id` (`endpoint_id`),
  KEY `idx_name` (`name`(190)),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_19a74a5e5cae` FOREIGN KEY (`account_id`) REFERENCES `clients` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_27aa5ded3d09` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_a6017c9424ec` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`env_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aee9b46cbd4e` FOREIGN KEY (`endpoint_id`) REFERENCES `tf_endpoints` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_workspaces`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_workspaces` (
  `id` varchar(24) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Name of the workspace',
  `auto_apply` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether to automatically apply changes when a Terraform plan is successful',
  `operations` tinyint(1) unsigned NOT NULL COMMENT 'A boolean value that allow to execute all terraform operation in a remote backend',
  `resources` text COMMENT 'List of created resources in JSON format',
  `outputs` text COMMENT 'TF outputs template',
  `queue_all_runs` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Whether all runs should be queued',
  `working_directory` varchar(255) DEFAULT NULL COMMENT 'A relative path that Terraform will execute within',
  `terraform_version` varchar(255) NOT NULL COMMENT 'The version of Terraform to use for this workspace',
  `locked` tinyint(1) unsigned NOT NULL COMMENT 'Once locked, the state of a workspace cannot be modified',
  `env_id` varchar(24) NOT NULL COMMENT 'client_environments.env_id ref',
  `current_run_id` varchar(24) DEFAULT NULL COMMENT 'The active run of the workspace',
  `last_run_id` varchar(24) DEFAULT NULL COMMENT 'Last non-speculative run in the Workspace',
  `created_at` datetime NOT NULL COMMENT 'The UTC datetime at which the Workspace was created',
  `created_by` varchar(24) DEFAULT NULL COMMENT 'User happy id',
  `created_by_email` varchar(100) DEFAULT NULL COMMENT 'Email of the User who created a workspace',
  `tags` text,
  PRIMARY KEY (`id`),
  KEY `idx_current_run_id` (`current_run_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_created_by` (`created_by`),
  KEY `idx_workspaces_last_run` (`last_run_id`),
  KEY `idx_organization_name` (`env_id`),
  CONSTRAINT `fk_145b63584841` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`env_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_c2f4281b41d8` FOREIGN KEY (`current_run_id`) REFERENCES `tf_runs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_c5722b27de12ab56` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_f59431483969` FOREIGN KEY (`last_run_id`) REFERENCES `tf_runs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_ws_latency_histogram`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_ws_latency_histogram` (
  `upper_bound` float NOT NULL COMMENT 'Upper bound for this bucket (-1 means infinity)',
  `bucket_time_slot` datetime NOT NULL COMMENT 'UTC timestamp for the hour of this bucket (minutes and seconds need to be dropped)',
  `account_id` int(11) NOT NULL COMMENT 'clients.id ref',
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`upper_bound`,`bucket_time_slot`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `fk_0a1f089bd4c9e180` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_ws_latency_state`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf_ws_latency_state` (
  `workspace_id` varchar(24) NOT NULL COMMENT 'tf_workspaces.id ref',
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'UTC timestamp when this workspace entered pending state',
  PRIMARY KEY (`workspace_id`),
  KEY `idx_workspace_id` (`workspace_id`),
  CONSTRAINT `fk_960670eef91139f2` FOREIGN KEY (`workspace_id`) REFERENCES `tf_workspaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upgrade_backups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upgrade_backups` (
  `id` binary(16) NOT NULL COMMENT 'uuid PK',
  `name` varchar(255) NOT NULL COMMENT 'Table name',
  `schema` varchar(64) DEFAULT NULL COMMENT 'Table schema',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upgrade_messages`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upgrade_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varbinary(16) NOT NULL COMMENT 'upgrades.uuid reference',
  `created` datetime NOT NULL COMMENT 'Creation timestamp',
  `message` text COMMENT 'Error messages',
  PRIMARY KEY (`id`),
  KEY `idx_uuid` (`uuid`),
  CONSTRAINT `upgrade_messages_ibfk_1` FOREIGN KEY (`uuid`) REFERENCES `upgrades` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upgrades`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upgrades` (
  `uuid` varbinary(16) NOT NULL COMMENT 'Unique identifier of update',
  `released` datetime NOT NULL COMMENT 'The time when upgrade script is issued',
  `appears` datetime NOT NULL COMMENT 'The time when upgrade does appear',
  `applied` datetime DEFAULT NULL COMMENT 'The time when update is successfully applied',
  `status` tinyint(4) NOT NULL COMMENT 'Upgrade status',
  `hash` varbinary(20) DEFAULT NULL COMMENT 'SHA1 hash of the upgrade file',
  `blocker` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is blocker',
  PRIMARY KEY (`uuid`),
  KEY `idx_status` (`status`),
  KEY `idx_appears` (`appears`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_api_keys`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_keys` (
  `key_id` char(20) NOT NULL COMMENT 'The unique identifier of the key',
  `name` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL COMMENT 'scalr.account_users.id ref',
  `secret_key` varchar(255) NOT NULL COMMENT 'Encrypted secret key',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - active, 0 - inactive',
  `created` datetime NOT NULL COMMENT 'Created at timestamp',
  `last_used` datetime DEFAULT NULL COMMENT 'Created at timestamp',
  PRIMARY KEY (`key_id`),
  KEY `idx_user_keys` (`user_id`,`active`),
  KEY `idx_active` (`active`),
  CONSTRAINT `fk_0a036c6a9223` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API keys';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_api_tokens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_tokens` (
  `token` binary(16) NOT NULL COMMENT 'API oAuth token',
  `user_id` int(11) NOT NULL COMMENT 'account_users.id ref',
  `app_id` char(12) NOT NULL COMMENT 'Application ID',
  `issued` datetime NOT NULL COMMENT 'UTC Timestamp',
  `expires` datetime NOT NULL COMMENT 'UTC Timestamp of expiration',
  `scopes` varchar(255) NOT NULL COMMENT 'Access token scopes',
  PRIMARY KEY (`token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_app_id` (`app_id`),
  KEY `idx_issued` (`issued`),
  KEY `idx_expires` (`expires`),
  CONSTRAINT `fk_586493dcec7c` FOREIGN KEY (`app_id`) REFERENCES `api_auth_apps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_d7d6ebc3d4b4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API User oAuth tokens';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sessions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sessions` (
  `id` binary(32) NOT NULL COMMENT 'PK',
  `token` binary(32) NOT NULL COMMENT 'CSRF Token',
  `user_id` int(11) DEFAULT NULL COMMENT 'User users.id ref',
  `created` datetime NOT NULL COMMENT 'Created (UTC)',
  `last_used` datetime DEFAULT NULL COMMENT 'Last Used (UTC)',
  `timeout` int(11) NOT NULL DEFAULT '0' COMMENT 'Record will become inactive after N seconds on inactivity (based on last_used)',
  `expired` datetime NOT NULL COMMENT 'Expired (UTC). Record will become inactive after this date.',
  `properties` text COMMENT 'Key-value json-encoded storage',
  `api_access_token` varchar(512) DEFAULT NULL COMMENT 'The JWT access token for API v3',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token` (`token`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_b204855d4fde` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_settings` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`name`),
  KEY `name` (`name`),
  CONSTRAINT `fk_account_users_id_user_settings` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_used_passwords`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_used_passwords` (
  `user_id` int(11) NOT NULL COMMENT 'Account user id',
  `created` datetime NOT NULL COMMENT 'Date of creating password',
  `hash` varchar(255) NOT NULL COMMENT 'Password hash',
  PRIMARY KEY (`user_id`,`created`),
  CONSTRAINT `fk_user_used_passwords_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User used passwords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_vars`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_vars` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`user_id`,`name`),
  KEY `name` (`name`),
  CONSTRAINT `user_vars_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) NOT NULL COMMENT 'User happy id',
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `dtlastlogin` datetime DEFAULT NULL,
  `loginattempts` int(4) NOT NULL DEFAULT '0',
  `auth_mode` varchar(10) NOT NULL DEFAULT 'scalr' COMMENT 'User auth mode: scalr, ldap, saml',
  `status` varchar(45) NOT NULL DEFAULT 'Active' COMMENT 'User status: Active, Inactive',
  `comments` text COMMENT 'Comments',
  `identity_provider_id` varchar(24) NOT NULL COMMENT 'The identity provider identifier',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_idp_username` (`identity_provider_id`,`username`),
  UNIQUE KEY `unique_idp_email` (`identity_provider_id`,`email`),
  KEY `email` (`email`),
  KEY `idx_identity_provider_id` (`identity_provider_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_cef89448c845` FOREIGN KEY (`identity_provider_id`) REFERENCES `identity_providers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vcs_bindings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcs_bindings` (
  `resource_id` varchar(24) NOT NULL COMMENT 'PK resource id',
  `resource_type` varchar(64) NOT NULL COMMENT 'PK resource type',
  `provider_id` varchar(24) NOT NULL COMMENT 'VCS Provider vcs_providers.id ref',
  `repository_id` varchar(255) NOT NULL COMMENT 'Repository ID',
  `branch` varchar(255) DEFAULT NULL COMMENT 'Repository branch',
  `revision` varchar(255) DEFAULT NULL COMMENT 'Repository revision',
  `path` text COMMENT 'Path to subdirectory/file',
  PRIMARY KEY (`resource_id`,`resource_type`),
  KEY `idx_repository_id` (`repository_id`),
  KEY `idx_provider_id` (`provider_id`),
  CONSTRAINT `fk_40b0abd734b5` FOREIGN KEY (`provider_id`) REFERENCES `vcs_providers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vcs_oauth_applications`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcs_oauth_applications` (
  `id` binary(16) NOT NULL COMMENT 'PK UUID',
  `callback_url` varchar(255) NOT NULL COMMENT 'Callback URL',
  `client_id` varchar(255) NOT NULL COMMENT 'Client ID',
  `client_secret` text NOT NULL COMMENT 'Client secret',
  `token` text COMMENT 'Access token (JSON)',
  `error` text COMMENT 'Error message',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vcs_providers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcs_providers` (
  `id` varchar(24) NOT NULL COMMENT 'PK UUID',
  `account_id` int(11) DEFAULT NULL COMMENT 'Account ID clients.id ref',
  `env_id` int(11) DEFAULT NULL COMMENT 'Env ID client_environments.id',
  `oauth_application_id` binary(16) DEFAULT NULL COMMENT 'vcs_oauth_applications.id ref',
  `type` varchar(32) NOT NULL COMMENT 'Provider type (standalone, github, bitbucket etc)',
  `name` varchar(255) NOT NULL COMMENT 'Name of provider',
  `auth_type` varchar(32) NOT NULL COMMENT 'Authorization type (basic,ssh,public,oauth2)',
  `username` varchar(255) DEFAULT NULL COMMENT 'Username for basic auth',
  `password` varchar(512) DEFAULT NULL COMMENT 'Password for basic auth',
  `ssh` text COMMENT 'SSH private Key',
  `url` varchar(255) DEFAULT NULL COMMENT 'API server URL',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_auth_type` (`auth_type`),
  KEY `idx_oauth_application_id` (`oauth_application_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  CONSTRAINT `fk_61c9c77ef07d` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_9fbd2bee6e79` FOREIGN KEY (`oauth_application_id`) REFERENCES `vcs_oauth_applications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_c662ab35f8d6` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vcs_revision_bindings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcs_revision_bindings` (
  `id` varchar(24) NOT NULL COMMENT 'The vcs revision binding identifier',
  `provider_id` varchar(24) DEFAULT NULL COMMENT 'VCS Provider vcs_providers.id ref',
  `repository_id` varchar(255) NOT NULL COMMENT 'Repository ID',
  `branch` varchar(255) DEFAULT NULL COMMENT 'Repository branch',
  `path` text COMMENT 'Path to subdirectory/file',
  `commit_sha` varchar(255) DEFAULT NULL COMMENT 'The commit sha',
  `commit_message` text COMMENT 'The commit message',
  `sender_name` varchar(255) DEFAULT NULL COMMENT 'The commit sender name',
  `sender_username` varchar(255) DEFAULT NULL COMMENT 'The commit sender username',
  `sender_email` varchar(255) DEFAULT NULL COMMENT 'The commit sender email',
  `is_pull_request` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If revision binding is pull request',
  `pull_request_number` int(11) DEFAULT NULL COMMENT 'Pull request number',
  `pull_request_title` varchar(512) DEFAULT NULL COMMENT 'Pull request title',
  `pull_request_url` varchar(512) DEFAULT NULL COMMENT 'Pull request url',
  PRIMARY KEY (`id`),
  KEY `idx_repository_id` (`repository_id`),
  KEY `idx_provider_id` (`provider_id`),
  CONSTRAINT `fk_fd2a0239d839` FOREIGN KEY (`provider_id`) REFERENCES `vcs_providers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vcs_webhooks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcs_webhooks` (
  `id` binary(16) NOT NULL COMMENT 'PK Id webhook given by provider',
  `webhook_id` varchar(255) NOT NULL COMMENT 'Webhook ID from provider',
  `provider_id` varchar(24) NOT NULL COMMENT 'VCS Provider vcs_providers.id ref',
  `status` varchar(24) NOT NULL DEFAULT 'active' COMMENT 'Webhook status',
  `repository_id` varchar(255) NOT NULL COMMENT 'Repository id',
  `events` text COMMENT 'Subscribed events',
  `url` varchar(512) NOT NULL COMMENT 'Webhook callback url',
  `secret_key` text COMMENT 'Secret key for securing webhooks',
  PRIMARY KEY (`id`),
  KEY `idx_provider_id` (`provider_id`),
  CONSTRAINT `fk_7d6bd3245c90` FOREIGN KEY (`provider_id`) REFERENCES `vcs_providers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vmware_task_properties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmware_task_properties` (
  `task_id` binary(16) NOT NULL COMMENT 'Identifier of the task',
  `name` varchar(255) NOT NULL COMMENT 'Identifier of the task property',
  `value` text COMMENT 'Value of the task property',
  PRIMARY KEY (`task_id`,`name`),
  CONSTRAINT `fk_3d642ce2c008` FOREIGN KEY (`task_id`) REFERENCES `vmware_tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VMware cloud task properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vmware_tasks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vmware_tasks` (
  `id` binary(16) NOT NULL COMMENT 'ID of the task',
  `cloud_credentials_id` char(12) NOT NULL COMMENT 'ID of the Cloud credentials',
  `operation` tinyint(3) unsigned NOT NULL COMMENT 'Internal classification name of task',
  `object_id` varchar(255) DEFAULT NULL COMMENT 'VMware object ID',
  `object_type` tinyint(3) unsigned DEFAULT NULL COMMENT 'The type of the subject',
  `task_id` varchar(255) NOT NULL COMMENT 'VMware cloud task ID',
  `status` tinyint(3) unsigned NOT NULL COMMENT 'Task status',
  `created` datetime NOT NULL COMMENT 'UTC timestamp when it is created',
  `server_id` varchar(36) DEFAULT NULL COMMENT 'Scalr server ID',
  `hostname` varchar(255) DEFAULT NULL COMMENT 'VMware vCenter hostname',
  PRIMARY KEY (`id`),
  KEY `idx_cloud_credentials_id` (`cloud_credentials_id`),
  KEY `idx_status_created` (`status`,`created`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_hostname` (`hostname`),
  KEY `idx_server_operation_status` (`server_id`,`operation`,`status`),
  KEY `idx_credentials_task_id` (`cloud_credentials_id`,`task_id`),
  KEY `idx_credentials_status` (`cloud_credentials_id`,`status`),
  CONSTRAINT `fk_5e07db7f7860` FOREIGN KEY (`cloud_credentials_id`) REFERENCES `cloud_credentials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VMware cloud tasks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volume_disks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_disks` (
  `cloud_resource_id` binary(16) NOT NULL COMMENT 'UUID',
  `name` varchar(255) DEFAULT NULL,
  `avail_zone` varchar(255) DEFAULT NULL,
  `volume_type` varchar(255) DEFAULT NULL,
  `device` text,
  `fs_type` varchar(255) DEFAULT NULL,
  `mpoint` text,
  `snap` text,
  `iops` text,
  `size` int(11) unsigned NOT NULL,
  `template` text,
  `encrypted` tinyint(4) DEFAULT '0',
  `recreate_if_missing` tinyint(4) DEFAULT '0',
  `tags` text,
  PRIMARY KEY (`cloud_resource_id`),
  CONSTRAINT `fk_9726b5e4400f0867` FOREIGN KEY (`cloud_resource_id`) REFERENCES `cloud_resources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_config_endpoints`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_config_endpoints` (
  `webhook_id` binary(16) NOT NULL COMMENT 'UUID',
  `endpoint_id` binary(16) NOT NULL COMMENT 'UUID',
  PRIMARY KEY (`webhook_id`,`endpoint_id`),
  KEY `idx_endpoint_id` (`endpoint_id`),
  CONSTRAINT `fk_4d800abd81968700c` FOREIGN KEY (`webhook_id`) REFERENCES `webhook_configs` (`webhook_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_6d8c137f54109dcaa` FOREIGN KEY (`endpoint_id`) REFERENCES `webhook_endpoints` (`endpoint_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_config_events`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_config_events` (
  `webhook_id` binary(16) NOT NULL COMMENT 'UUID',
  `event_type` varchar(128) NOT NULL,
  PRIMARY KEY (`webhook_id`,`event_type`),
  KEY `idx_event_type` (`event_type`),
  CONSTRAINT `fk_40db098cb4b5c6797` FOREIGN KEY (`webhook_id`) REFERENCES `webhook_configs` (`webhook_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_config_farms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_config_farms` (
  `webhook_id` binary(16) NOT NULL COMMENT 'UUID',
  `farm_id` int(11) NOT NULL,
  PRIMARY KEY (`webhook_id`,`farm_id`),
  KEY `idx_farm_id` (`farm_id`),
  CONSTRAINT `fk_24503b0f582804419` FOREIGN KEY (`webhook_id`) REFERENCES `webhook_configs` (`webhook_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_configs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_configs` (
  `webhook_id` binary(16) NOT NULL COMMENT 'UUID',
  `level` tinyint(4) NOT NULL COMMENT '1 - Scalr, 2 - Account, 4 - Env, 8 - Farm',
  `name` varchar(50) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `post_data` text,
  `skip_private_gv` tinyint(1) DEFAULT '0',
  `timeout` int(2) NOT NULL DEFAULT '3',
  `attempts` int(2) NOT NULL DEFAULT '3',
  PRIMARY KEY (`webhook_id`),
  KEY `idx_level` (`level`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_name` (`name`(3)),
  CONSTRAINT `fk_4d3039820abc2a41c` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_dbedab24d097d2a71` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_endpoints`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_endpoints` (
  `endpoint_id` binary(16) NOT NULL COMMENT 'UUID',
  `level` tinyint(4) NOT NULL COMMENT '1 - Scalr, 2 - Account, 4 - Env',
  `account_id` int(11) DEFAULT NULL,
  `env_id` int(11) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - active, 0 - inactive',
  `url` text,
  `validation_token` binary(16) DEFAULT NULL COMMENT 'UUID',
  `is_valid` tinyint(1) NOT NULL DEFAULT '0',
  `security_key` varchar(64) NOT NULL DEFAULT '',
  `is_shared` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Sharing for all lower scopes.',
  PRIMARY KEY (`endpoint_id`),
  KEY `fk_660a12dca2e1dae8a` (`account_id`),
  KEY `fk_816aef24d6e3f9aac` (`env_id`),
  CONSTRAINT `fk_660a12dca2e1dae8a` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_816aef24d6e3f9aac` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_history` (
  `history_id` binary(16) NOT NULL COMMENT 'UUID',
  `webhook_id` binary(16) DEFAULT NULL COMMENT 'UUID',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endpoint_id` binary(16) NOT NULL COMMENT 'UUID',
  `event_id` char(36) DEFAULT NULL COMMENT 'The event UUID',
  `account_id` int(11) DEFAULT NULL COMMENT 'The account identifier',
  `env_id` int(11) DEFAULT NULL COMMENT 'The environment identifier',
  `farm_id` int(11) DEFAULT NULL COMMENT 'The farm identifier',
  `server_id` varchar(36) DEFAULT NULL,
  `event_type` varchar(128) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `response_code` smallint(6) DEFAULT NULL,
  `payload` text,
  `error_msg` mediumtext COMMENT 'Webhook endpoint response',
  `handle_attempts` int(2) DEFAULT '0',
  `dtlasthandleattempt` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `idx_webhook_id` (`webhook_id`),
  KEY `idx_endpoint_id` (`endpoint_id`),
  KEY `idx_event_id` (`event_id`),
  KEY `idx_status` (`status`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_farm_id` (`farm_id`),
  KEY `idx_created` (`created`),
  KEY `idx_env_id` (`env_id`),
  KEY `idx_account_id` (`account_id`),
  CONSTRAINT `fk_2fa13e63bff387aa2` FOREIGN KEY (`webhook_id`) REFERENCES `webhook_configs` (`webhook_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_35d689dd5c9d257f3` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_4572d5cd4d19cd8c1` FOREIGN KEY (`endpoint_id`) REFERENCES `webhook_endpoints` (`endpoint_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_8ae952aec85ebfb2` FOREIGN KEY (`env_id`) REFERENCES `client_environments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_97f8f022ad6ebd0d` FOREIGN KEY (`account_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'scalr'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-19 23:13:31
