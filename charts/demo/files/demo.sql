/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute` (`attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'security.reset_ttl','86400'),(2,'version','21.03.18'),(3,'session_lifetime','604800'),(4,'cache_expire.db','3600'),(5,'cache_expire.minify','86400'),(6,'cache_expire.attachments','2592000'),(7,'parse.ids','1'),(8,'parse.hashtags','1'),(9,'parse.urls','1'),(10,'parse.emoticons','1'),(11,'site.description','A high performance full-featured project management system'),(12,'site.demo','2'),(13,'site.theme','css/bootstrap-phproject.css'),(14,'site.public_registration','0'),(15,'security.block_ccs','0'),(16,'security.min_pass_len','6'),(17,'issue_type.task','1'),(18,'issue_type.project','2'),(19,'issue_type.bug','3'),(20,'issue_priority.default','0'),(21,'gravatar.rating','pg'),(22,'gravatar.default','mm'),(23,'mail.truncate_lines','<--->,--- ---,------------------------------'),(24,'files.maxsize','2097152'),(25,'parse.markdown','0'),(26,'parse.textile','1'),(27,'site.name','Phproject'),(28,'site.timezone','Etc/UTC'),(29,'mail.from',''),(30,'site.key','7e583862192a2e407654b07247443a9100f43a2c'),(31,'security.file_blacklist','/.(ph(p([3457s]|-s)?|t|tml)|aspx?|shtml|exe|dll)$/i');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` int unsigned NOT NULL DEFAULT '1',
  `type_id` int unsigned NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size_estimate` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `author_id` int unsigned NOT NULL,
  `owner_id` int unsigned DEFAULT NULL,
  `priority` int NOT NULL DEFAULT '0',
  `hours_total` double unsigned DEFAULT NULL,
  `hours_remaining` double unsigned DEFAULT NULL,
  `hours_spent` double unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `closed_date` datetime DEFAULT NULL,
  `deleted_date` datetime DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `repeat_cycle` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sprint_id` int unsigned DEFAULT NULL,
  `due_date_sprint` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sprint_id` (`sprint_id`),
  KEY `repeat_cycle` (`repeat_cycle`),
  KEY `due_date` (`due_date`),
  KEY `type_id` (`type_id`),
  KEY `parent_id` (`parent_id`),
  KEY `issue_author_id` (`author_id`),
  KEY `issue_owner_id` (`owner_id`),
  KEY `issue_priority` (`priority`),
  KEY `issue_status` (`status`),
  CONSTRAINT `issue_author_id` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `issue_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `issue_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `issue` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `issue_priority` FOREIGN KEY (`priority`) REFERENCES `issue_priority` (`value`) ON UPDATE CASCADE,
  CONSTRAINT `issue_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `sprint` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `issue_status` FOREIGN KEY (`status`) REFERENCES `issue_status` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `issue_type_id` FOREIGN KEY (`type_id`) REFERENCES `issue_type` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue`
--

LOCK TABLES `issue` WRITE;
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` VALUES (1,1,2,'A Big Project',NULL,'This is a project.  Projects group tasks and bugs, and can go into sprints.',NULL,2,2,0,NULL,NULL,NULL,'2020-04-08 21:21:49',NULL,NULL,NULL,NULL,NULL,1,0),(2,1,1,'A Simple Task',NULL,'This is a sample task.',1,1,2,0,2,2,NULL,'2020-04-08 21:21:49',NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_backlog`
--

DROP TABLE IF EXISTS `issue_backlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_backlog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sprint_id` int unsigned DEFAULT NULL,
  `issues` blob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_backlog_sprint_id` (`sprint_id`),
  CONSTRAINT `issue_backlog_sprint_id` FOREIGN KEY (`sprint_id`) REFERENCES `sprint` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_backlog`
--

LOCK TABLES `issue_backlog` WRITE;
/*!40000 ALTER TABLE `issue_backlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_backlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_comment`
--

DROP TABLE IF EXISTS `issue_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_comment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_id` int unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_id` (`issue_id`),
  KEY `user` (`user_id`),
  CONSTRAINT `comment_issue` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_comment`
--

LOCK TABLES `issue_comment` WRITE;
/*!40000 ALTER TABLE `issue_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `issue_comment_detail`
--

DROP TABLE IF EXISTS `issue_comment_detail`;
/*!50001 DROP VIEW IF EXISTS `issue_comment_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `issue_comment_detail` AS SELECT
 1 AS `id`,
 1 AS `issue_id`,
 1 AS `user_id`,
 1 AS `text`,
 1 AS `file_id`,
 1 AS `created_date`,
 1 AS `user_username`,
 1 AS `user_email`,
 1 AS `user_name`,
 1 AS `user_role`,
 1 AS `user_task_color`,
 1 AS `file_filename`,
 1 AS `file_filesize`,
 1 AS `file_content_type`,
 1 AS `file_downloads`,
 1 AS `file_created_date`,
 1 AS `file_deleted_date`,
 1 AS `issue_deleted_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `issue_comment_user`
--

DROP TABLE IF EXISTS `issue_comment_user`;
/*!50001 DROP VIEW IF EXISTS `issue_comment_user`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `issue_comment_user` AS SELECT
 1 AS `id`,
 1 AS `issue_id`,
 1 AS `user_id`,
 1 AS `text`,
 1 AS `file_id`,
 1 AS `created_date`,
 1 AS `user_username`,
 1 AS `user_email`,
 1 AS `user_name`,
 1 AS `user_role`,
 1 AS `user_task_color`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `issue_dependency`
--

DROP TABLE IF EXISTS `issue_dependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_dependency` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int unsigned NOT NULL,
  `dependency_id` int unsigned NOT NULL,
  `dependency_type` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_id_dependency_id` (`issue_id`,`dependency_id`),
  KEY `dependency_id` (`dependency_id`),
  CONSTRAINT `issue_dependency_ibfk_2` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `issue_dependency_ibfk_3` FOREIGN KEY (`dependency_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_dependency`
--

LOCK TABLES `issue_dependency` WRITE;
/*!40000 ALTER TABLE `issue_dependency` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_dependency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `issue_detail`
--

DROP TABLE IF EXISTS `issue_detail`;
/*!50001 DROP VIEW IF EXISTS `issue_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `issue_detail` AS SELECT
 1 AS `id`,
 1 AS `status`,
 1 AS `type_id`,
 1 AS `name`,
 1 AS `size_estimate`,
 1 AS `description`,
 1 AS `parent_id`,
 1 AS `author_id`,
 1 AS `owner_id`,
 1 AS `priority`,
 1 AS `hours_total`,
 1 AS `hours_remaining`,
 1 AS `hours_spent`,
 1 AS `created_date`,
 1 AS `closed_date`,
 1 AS `deleted_date`,
 1 AS `start_date`,
 1 AS `due_date`,
 1 AS `has_due_date`,
 1 AS `repeat_cycle`,
 1 AS `sprint_id`,
 1 AS `due_date_sprint`,
 1 AS `sprint_name`,
 1 AS `sprint_start_date`,
 1 AS `sprint_end_date`,
 1 AS `type_name`,
 1 AS `status_name`,
 1 AS `status_closed`,
 1 AS `priority_id`,
 1 AS `priority_name`,
 1 AS `author_username`,
 1 AS `author_name`,
 1 AS `author_email`,
 1 AS `author_task_color`,
 1 AS `owner_username`,
 1 AS `owner_name`,
 1 AS `owner_email`,
 1 AS `owner_task_color`,
 1 AS `parent_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `issue_file`
--

DROP TABLE IF EXISTS `issue_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_file` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `disk_filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `disk_directory` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filesize` int NOT NULL DEFAULT '0',
  `content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `digest` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `downloads` int NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL,
  `deleted_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_issue_id` (`issue_id`),
  KEY `index_user_id` (`user_id`),
  KEY `index_created_on` (`created_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_file`
--

LOCK TABLES `issue_file` WRITE;
/*!40000 ALTER TABLE `issue_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `issue_file_detail`
--

DROP TABLE IF EXISTS `issue_file_detail`;
/*!50001 DROP VIEW IF EXISTS `issue_file_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `issue_file_detail` AS SELECT
 1 AS `id`,
 1 AS `issue_id`,
 1 AS `filename`,
 1 AS `disk_filename`,
 1 AS `disk_directory`,
 1 AS `filesize`,
 1 AS `content_type`,
 1 AS `digest`,
 1 AS `downloads`,
 1 AS `user_id`,
 1 AS `created_date`,
 1 AS `deleted_date`,
 1 AS `user_username`,
 1 AS `user_email`,
 1 AS `user_name`,
 1 AS `user_task_color`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `issue_priority`
--

DROP TABLE IF EXISTS `issue_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_priority` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `value` int NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `priority` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_priority`
--

LOCK TABLES `issue_priority` WRITE;
/*!40000 ALTER TABLE `issue_priority` DISABLE KEYS */;
INSERT INTO `issue_priority` VALUES (1,0,'Normal'),(2,1,'High'),(3,-1,'Low');
/*!40000 ALTER TABLE `issue_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_status`
--

DROP TABLE IF EXISTS `issue_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `taskboard` tinyint(1) NOT NULL DEFAULT '1',
  `taskboard_sort` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_status`
--

LOCK TABLES `issue_status` WRITE;
/*!40000 ALTER TABLE `issue_status` DISABLE KEYS */;
INSERT INTO `issue_status` VALUES (1,'New',0,2,1),(2,'Active',0,2,2),(3,'Completed',1,2,3),(4,'On Hold',0,1,4);
/*!40000 ALTER TABLE `issue_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_tag`
--

DROP TABLE IF EXISTS `issue_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_tag` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issue_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_tag_tag` (`tag`,`issue_id`),
  KEY `issue_tag_issue` (`issue_id`),
  CONSTRAINT `issue_tag_issue` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_tag`
--

LOCK TABLES `issue_tag` WRITE;
/*!40000 ALTER TABLE `issue_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_type`
--

DROP TABLE IF EXISTS `issue_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('task','project','bug') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'task',
  `default_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `issue_type_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_type`
--

LOCK TABLES `issue_type` WRITE;
/*!40000 ALTER TABLE `issue_type` DISABLE KEYS */;
INSERT INTO `issue_type` VALUES (1,'Task','task',NULL),(2,'Project','project',NULL),(3,'Bug','bug',NULL);
/*!40000 ALTER TABLE `issue_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_update`
--

DROP TABLE IF EXISTS `issue_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_update` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `comment_id` int unsigned DEFAULT NULL,
  `notify` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue` (`issue_id`),
  KEY `user` (`user_id`),
  CONSTRAINT `update_issue` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_update`
--

LOCK TABLES `issue_update` WRITE;
/*!40000 ALTER TABLE `issue_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `issue_update_detail`
--

DROP TABLE IF EXISTS `issue_update_detail`;
/*!50001 DROP VIEW IF EXISTS `issue_update_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `issue_update_detail` AS SELECT
 1 AS `id`,
 1 AS `issue_id`,
 1 AS `user_id`,
 1 AS `created_date`,
 1 AS `user_username`,
 1 AS `user_name`,
 1 AS `user_email`,
 1 AS `comment_id`,
 1 AS `comment_text`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `issue_update_field`
--

DROP TABLE IF EXISTS `issue_update_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_update_field` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `issue_update_id` int unsigned NOT NULL,
  `field` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_update_field_update_id` (`issue_update_id`),
  CONSTRAINT `issue_update_field_update` FOREIGN KEY (`issue_update_id`) REFERENCES `issue_update` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_update_field`
--

LOCK TABLES `issue_update_field` WRITE;
/*!40000 ALTER TABLE `issue_update_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_update_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_watcher`
--

DROP TABLE IF EXISTS `issue_watcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_watcher` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_watch` (`issue_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_watcher`
--

LOCK TABLES `issue_watcher` WRITE;
/*!40000 ALTER TABLE `issue_watcher` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_watcher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `issue_watcher_user`
--

DROP TABLE IF EXISTS `issue_watcher_user`;
/*!50001 DROP VIEW IF EXISTS `issue_watcher_user`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `issue_watcher_user` AS SELECT
 1 AS `watcher_id`,
 1 AS `issue_id`,
 1 AS `id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `name`,
 1 AS `password`,
 1 AS `role`,
 1 AS `task_color`,
 1 AS `created_date`,
 1 AS `deleted_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `token` varbinary(64) NOT NULL,
  `ip` varbinary(39) NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_token` (`token`,`ip`),
  KEY `session_user_id` (`user_id`),
  CONSTRAINT `session_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (1,_binary 'cba8c8a02efb4b4b609e163c770d4487e07720f89cb8730cefbf6a6b3c4f1a27',_binary '98.202.224.177',1,'2020-04-08 21:19:25'),(2,_binary 'aaa4f304da031b66be0d31f167254e475edd8124c984bbca392d284726f20f58',_binary '98.202.224.177',2,'2020-04-08 21:22:00'),(3,_binary 'bb47d7f72cea2f9012c03c66156847c151dd69e9ce369f1761336d48c25425b3',_binary '98.202.224.177',2,'2020-04-08 21:22:56'),(4,_binary '43e19ed772b017feed429ca3ff6ce542465458231f4ab912bcef365e562623cb',_binary '69.162.124.235',2,'2023-03-23 00:11:37'),(5,_binary 'b738630c13db5eaac813f0bd3ff8b0247f16f2df5e7c70bb70d121d05928f314',_binary '69.162.124.235',2,'2023-03-23 00:26:55'),(6,_binary 'df1d343278aa3326e5299f1387561d3e1424d504578efa9741b306e304a75a9f',_binary '69.162.124.235',2,'2023-03-23 00:42:15'),(7,_binary 'a931b6243ad7e8dd42a33c9f1ae2350a016faa27d8e8811d740ed8f9f5e49ba5',_binary '51.222.253.13',2,'2023-03-23 00:48:42'),(8,_binary '8d5aa74e7bd8f8e7e420a97b13fbb0e9ec2d0f5590db555c4807e40099f95b5d',_binary '69.162.124.235',2,'2023-03-23 00:57:35'),(9,_binary 'c2d41e669e1ffae16f9956e3521ef738e5f18b7fba42403be31a11c47a8c6fd5',_binary '69.162.124.235',2,'2023-03-23 01:12:55'),(10,_binary 'c35f889b30bff6bdac4ab4aa9731698c047913ee43d0cce6e740fc9426dfcd2b',_binary '69.162.124.235',2,'2023-03-23 01:28:15'),(11,_binary 'fda9f65ce5cb7f139d76f93d18e76a05c5c17c251f026e6d9fccfc61dd5c03b9',_binary '69.162.124.235',2,'2023-03-23 01:43:35'),(12,_binary '5751cb7811cf2cff04804bf3b7f576fcef75e0f70fce1837d445b775c193f299',_binary '69.162.124.235',2,'2023-03-23 01:58:55'),(13,_binary '295bdd975aed02764be4427401a6d5b3404797005bde8604898b6c45da805c2a',_binary '69.162.124.235',2,'2023-03-23 02:14:15'),(14,_binary '0e31667807693d148c01dfe52e5ee57cc2e334492857ac4ab905585cd0b46435',_binary '67.199.175.247',2,'2023-03-23 02:22:56');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint`
--

DROP TABLE IF EXISTS `sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprint` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint`
--

LOCK TABLES `sprint` WRITE;
/*!40000 ALTER TABLE `sprint` DISABLE KEYS */;
INSERT INTO `sprint` VALUES (1,'First Sprint','2020-04-07','2020-04-20');
/*!40000 ALTER TABLE `sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` char(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_token` char(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('user','admin','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `rank` tinyint unsigned NOT NULL DEFAULT '0',
  `task_color` char(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_filename` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` blob,
  `api_key` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_visible` tinyint unsigned NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL,
  `deleted_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin@phproject.org','Admin','b800cc56bcff6ea1558b180b71efaa0a23c9b157','995a38df0cf89171e6601faacfb92f39',NULL,'admin',5,NULL,NULL,NULL,NULL,NULL,'ae0b4596b42426b55bac3c5a43a8493702f8f09d',1,'2020-04-08 21:19:21',NULL),(2,'demo','demo@demo','Demo User',NULL,NULL,NULL,'user',3,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-04-08 21:21:49',NULL),(3,NULL,NULL,'Demo Group',NULL,NULL,NULL,'group',0,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-04-08 21:21:49',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `group_id` int unsigned NOT NULL,
  `manager` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `group_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,1,3,0),(2,2,3,0);
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_group_user`
--

DROP TABLE IF EXISTS `user_group_user`;
/*!50001 DROP VIEW IF EXISTS `user_group_user`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_group_user` AS SELECT
 1 AS `id`,
 1 AS `group_id`,
 1 AS `user_id`,
 1 AS `user_username`,
 1 AS `user_email`,
 1 AS `user_name`,
 1 AS `user_role`,
 1 AS `user_task_color`,
 1 AS `deleted_date`,
 1 AS `manager`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `issue_comment_detail`
--

/*!50001 DROP VIEW IF EXISTS `issue_comment_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `issue_comment_detail` AS select `c`.`id` AS `id`,`c`.`issue_id` AS `issue_id`,`c`.`user_id` AS `user_id`,`c`.`text` AS `text`,`c`.`file_id` AS `file_id`,`c`.`created_date` AS `created_date`,`u`.`username` AS `user_username`,`u`.`email` AS `user_email`,`u`.`name` AS `user_name`,`u`.`role` AS `user_role`,`u`.`task_color` AS `user_task_color`,`f`.`filename` AS `file_filename`,`f`.`filesize` AS `file_filesize`,`f`.`content_type` AS `file_content_type`,`f`.`downloads` AS `file_downloads`,`f`.`created_date` AS `file_created_date`,`f`.`deleted_date` AS `file_deleted_date`,`i`.`deleted_date` AS `issue_deleted_date` from (((`issue_comment` `c` join `user` `u` on((`c`.`user_id` = `u`.`id`))) left join `issue_file` `f` on((`c`.`file_id` = `f`.`id`))) join `issue` `i` on((`i`.`id` = `c`.`issue_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `issue_comment_user`
--

/*!50001 DROP VIEW IF EXISTS `issue_comment_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `issue_comment_user` AS select `c`.`id` AS `id`,`c`.`issue_id` AS `issue_id`,`c`.`user_id` AS `user_id`,`c`.`text` AS `text`,`c`.`file_id` AS `file_id`,`c`.`created_date` AS `created_date`,`u`.`username` AS `user_username`,`u`.`email` AS `user_email`,`u`.`name` AS `user_name`,`u`.`role` AS `user_role`,`u`.`task_color` AS `user_task_color` from (`issue_comment` `c` join `user` `u` on((`c`.`user_id` = `u`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `issue_detail`
--

/*!50001 DROP VIEW IF EXISTS `issue_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `issue_detail` AS select `issue`.`id` AS `id`,`issue`.`status` AS `status`,`issue`.`type_id` AS `type_id`,`issue`.`name` AS `name`,`issue`.`size_estimate` AS `size_estimate`,`issue`.`description` AS `description`,`issue`.`parent_id` AS `parent_id`,`issue`.`author_id` AS `author_id`,`issue`.`owner_id` AS `owner_id`,`issue`.`priority` AS `priority`,`issue`.`hours_total` AS `hours_total`,`issue`.`hours_remaining` AS `hours_remaining`,`issue`.`hours_spent` AS `hours_spent`,`issue`.`created_date` AS `created_date`,`issue`.`closed_date` AS `closed_date`,`issue`.`deleted_date` AS `deleted_date`,`issue`.`start_date` AS `start_date`,`issue`.`due_date` AS `due_date`,(`issue`.`due_date` is null) AS `has_due_date`,`issue`.`repeat_cycle` AS `repeat_cycle`,`issue`.`sprint_id` AS `sprint_id`,`issue`.`due_date_sprint` AS `due_date_sprint`,`sprint`.`name` AS `sprint_name`,`sprint`.`start_date` AS `sprint_start_date`,`sprint`.`end_date` AS `sprint_end_date`,`type`.`name` AS `type_name`,`status`.`name` AS `status_name`,`status`.`closed` AS `status_closed`,`priority`.`id` AS `priority_id`,`priority`.`name` AS `priority_name`,`author`.`username` AS `author_username`,`author`.`name` AS `author_name`,`author`.`email` AS `author_email`,`author`.`task_color` AS `author_task_color`,`owner`.`username` AS `owner_username`,`owner`.`name` AS `owner_name`,`owner`.`email` AS `owner_email`,`owner`.`task_color` AS `owner_task_color`,`parent`.`name` AS `parent_name` from (((((((`issue` left join `user` `author` on((`issue`.`author_id` = `author`.`id`))) left join `user` `owner` on((`issue`.`owner_id` = `owner`.`id`))) left join `issue_status` `status` on((`issue`.`status` = `status`.`id`))) left join `issue_priority` `priority` on((`issue`.`priority` = `priority`.`value`))) left join `issue_type` `type` on((`issue`.`type_id` = `type`.`id`))) left join `sprint` on((`issue`.`sprint_id` = `sprint`.`id`))) left join `issue` `parent` on((`issue`.`parent_id` = `parent`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `issue_file_detail`
--

/*!50001 DROP VIEW IF EXISTS `issue_file_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `issue_file_detail` AS select `f`.`id` AS `id`,`f`.`issue_id` AS `issue_id`,`f`.`filename` AS `filename`,`f`.`disk_filename` AS `disk_filename`,`f`.`disk_directory` AS `disk_directory`,`f`.`filesize` AS `filesize`,`f`.`content_type` AS `content_type`,`f`.`digest` AS `digest`,`f`.`downloads` AS `downloads`,`f`.`user_id` AS `user_id`,`f`.`created_date` AS `created_date`,`f`.`deleted_date` AS `deleted_date`,`u`.`username` AS `user_username`,`u`.`email` AS `user_email`,`u`.`name` AS `user_name`,`u`.`task_color` AS `user_task_color` from (`issue_file` `f` join `user` `u` on((`f`.`user_id` = `u`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `issue_update_detail`
--

/*!50001 DROP VIEW IF EXISTS `issue_update_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `issue_update_detail` AS select `i`.`id` AS `id`,`i`.`issue_id` AS `issue_id`,`i`.`user_id` AS `user_id`,`i`.`created_date` AS `created_date`,`u`.`username` AS `user_username`,`u`.`name` AS `user_name`,`u`.`email` AS `user_email`,`i`.`comment_id` AS `comment_id`,`c`.`text` AS `comment_text` from ((`issue_update` `i` join `user` `u` on((`i`.`user_id` = `u`.`id`))) left join `issue_comment` `c` on((`i`.`comment_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `issue_watcher_user`
--

/*!50001 DROP VIEW IF EXISTS `issue_watcher_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `issue_watcher_user` AS select `w`.`id` AS `watcher_id`,`w`.`issue_id` AS `issue_id`,`u`.`id` AS `id`,`u`.`username` AS `username`,`u`.`email` AS `email`,`u`.`name` AS `name`,`u`.`password` AS `password`,`u`.`role` AS `role`,`u`.`task_color` AS `task_color`,`u`.`created_date` AS `created_date`,`u`.`deleted_date` AS `deleted_date` from (`issue_watcher` `w` join `user` `u` on((`w`.`user_id` = `u`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_group_user`
--

/*!50001 DROP VIEW IF EXISTS `user_group_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_group_user` AS select `g`.`id` AS `id`,`g`.`group_id` AS `group_id`,`g`.`user_id` AS `user_id`,`u`.`username` AS `user_username`,`u`.`email` AS `user_email`,`u`.`name` AS `user_name`,`u`.`role` AS `user_role`,`u`.`task_color` AS `user_task_color`,`u`.`deleted_date` AS `deleted_date`,`g`.`manager` AS `manager` from (`user_group` `g` join `user` `u` on((`g`.`user_id` = `u`.`id`))) */;
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
