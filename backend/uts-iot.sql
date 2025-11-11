-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for uts-iot
CREATE DATABASE IF NOT EXISTS `uts-iot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `uts-iot`;

-- Dumping structure for table uts-iot.data_sensor
CREATE TABLE IF NOT EXISTS `data_sensor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `suhu` float NOT NULL COMMENT 'Suhu dalam Celcius',
  `kelembapan` float NOT NULL COMMENT 'Kelembapan dalam persen',
  `pompa_status` enum('true','false') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'false',
  `lux` float NOT NULL COMMENT 'Kecerahan dalam Lux',
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu pencatatan data',
  `status_led` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_timestamp` (`timestamp`),
  KEY `idx_suhu` (`suhu`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabel penyimpanan data sensor hidroponik';

-- Dumping data for table uts-iot.data_sensor: ~104 rows (approximately)
INSERT INTO `data_sensor` (`id`, `suhu`, `kelembapan`, `pompa_status`, `lux`, `timestamp`, `status_led`, `device_id`) VALUES
	(1, 25.3, 70.5, 'false', 420, '2025-11-11 14:07:31', NULL, NULL),
	(2, 26.8, 68.2, 'false', 445.5, '2025-11-11 14:07:31', NULL, NULL),
	(3, 28.2, 65.8, 'false', 460.3, '2025-11-11 14:07:31', NULL, NULL),
	(4, 27.5, 67.1, 'false', 438.7, '2025-11-11 14:07:31', NULL, NULL),
	(5, 30.5, 62.3, 'false', 485.2, '2025-11-11 14:07:31', NULL, NULL),
	(6, 32.1, 58.7, 'false', 520.8, '2025-11-11 14:07:31', NULL, NULL),
	(7, 33.8, 55.4, 'false', 545.1, '2025-11-11 14:07:31', NULL, NULL),
	(8, 31.2, 60.5, 'false', 502.3, '2025-11-11 14:07:31', NULL, NULL),
	(9, 36.2, 52.1, 'false', 580.5, '2025-11-11 14:07:31', NULL, NULL),
	(10, 37.5, 48.3, 'false', 605.2, '2025-11-11 14:07:31', NULL, NULL),
	(11, 35.8, 50.7, 'false', 592.8, '2025-11-11 14:07:31', NULL, NULL),
	(12, 44.8, 40, 'false', 0, '2025-11-11 16:33:14', 'merah', 'uts-iot'),
	(13, 44.8, 40, 'false', 0, '2025-11-11 16:33:25', 'merah', 'uts-iot'),
	(14, 44.8, 40, 'false', 0, '2025-11-11 16:33:36', 'merah', 'uts-iot'),
	(15, 44.8, 40, 'false', 0, '2025-11-11 16:33:47', 'merah', 'uts-iot'),
	(16, 44.8, 40, 'false', 0, '2025-11-11 16:33:58', 'merah', 'uts-iot'),
	(17, 44.8, 40, 'false', 0, '2025-11-11 16:34:08', 'merah', 'uts-iot'),
	(18, 44.8, 40, 'false', 0, '2025-11-11 16:34:19', 'merah', 'uts-iot'),
	(19, 44.8, 40, 'false', 0, '2025-11-11 16:34:30', 'merah', 'uts-iot'),
	(20, 44.8, 40, 'false', 0, '2025-11-11 16:34:41', 'merah', 'uts-iot'),
	(21, 44.8, 40, 'false', 0, '2025-11-11 16:34:52', 'merah', 'uts-iot'),
	(22, 44.8, 40, 'false', 0, '2025-11-11 16:35:04', 'merah', 'uts-iot'),
	(23, 44.8, 40, 'true', 0, '2025-11-11 16:35:15', 'merah', 'uts-iot'),
	(24, 44.8, 40, 'true', 0, '2025-11-11 16:35:26', 'merah', 'uts-iot'),
	(25, 44.8, 40, 'true', 0, '2025-11-11 16:35:37', 'merah', 'uts-iot'),
	(26, 44.8, 40, 'true', 0, '2025-11-11 16:35:48', 'merah', 'uts-iot'),
	(27, 24, 40, 'false', 0, '2025-11-11 16:46:31', 'hijau', 'uts-iot'),
	(28, 24, 40, 'false', 0, '2025-11-11 16:46:42', 'hijau', 'uts-iot'),
	(29, 24, 40, 'false', 0, '2025-11-11 16:46:53', 'hijau', 'uts-iot'),
	(30, 24, 40, 'true', 0, '2025-11-11 16:47:04', 'hijau', 'uts-iot'),
	(31, 37.3, 40, 'true', 0, '2025-11-11 16:47:14', 'merah', 'uts-iot'),
	(32, 37.3, 40, 'true', 0, '2025-11-11 16:47:25', 'merah', 'uts-iot'),
	(33, 37.3, 40, 'false', 0, '2025-11-11 16:47:36', 'merah', 'uts-iot'),
	(34, 37.3, 40, 'false', 0, '2025-11-11 16:47:46', 'merah', 'uts-iot'),
	(35, 37.3, 40, 'false', 0, '2025-11-11 16:47:57', 'merah', 'uts-iot'),
	(36, 37.3, 40, 'false', 0, '2025-11-11 16:48:07', 'merah', 'uts-iot'),
	(37, 37.3, 40, 'false', 0, '2025-11-11 16:48:18', 'merah', 'uts-iot'),
	(38, 37.3, 40, 'false', 0, '2025-11-11 16:48:29', 'merah', 'uts-iot'),
	(39, 37.3, 40, 'false', 0, '2025-11-11 16:48:40', 'merah', 'uts-iot'),
	(40, 37.3, 40, 'false', 0, '2025-11-11 16:48:50', 'merah', 'uts-iot'),
	(41, 37.3, 40, 'false', 0, '2025-11-11 16:49:00', 'merah', 'uts-iot'),
	(42, 37.3, 40, 'false', 0, '2025-11-11 16:49:11', 'merah', 'uts-iot'),
	(43, 37.3, 40, 'false', 0, '2025-11-11 16:49:21', 'merah', 'uts-iot'),
	(44, 37.3, 40, 'false', 0, '2025-11-11 16:49:32', 'merah', 'uts-iot'),
	(45, 37.3, 40, 'false', 0, '2025-11-11 16:49:44', 'merah', 'uts-iot'),
	(46, 37.3, 40, 'false', 0, '2025-11-11 16:49:55', 'merah', 'uts-iot'),
	(47, 37.3, 40, 'false', 0, '2025-11-11 16:50:06', 'merah', 'uts-iot'),
	(48, 37.3, 40, 'false', 7, '2025-11-11 16:53:57', 'merah', 'uts-iot'),
	(49, 37.3, 40, 'false', 10, '2025-11-11 16:54:08', 'merah', 'uts-iot'),
	(50, 37.3, 40, 'false', 11, '2025-11-11 16:54:18', 'merah', 'uts-iot'),
	(51, 37.3, 40, 'false', 14, '2025-11-11 16:54:29', 'merah', 'uts-iot'),
	(52, 37.3, 40, 'false', 20, '2025-11-11 16:54:39', 'merah', 'uts-iot'),
	(53, 37.3, 40, 'false', 20, '2025-11-11 16:54:50', 'merah', 'uts-iot'),
	(54, 37.3, 40, 'false', 19, '2025-11-11 16:55:00', 'merah', 'uts-iot'),
	(55, 37.3, 40, 'false', 17, '2025-11-11 16:55:11', 'merah', 'uts-iot'),
	(56, 37.3, 40, 'false', 21, '2025-11-11 16:55:21', 'merah', 'uts-iot'),
	(57, 37.3, 40, 'false', 20, '2025-11-11 16:55:31', 'merah', 'uts-iot'),
	(58, 37.3, 40, 'false', 21, '2025-11-11 16:55:42', 'merah', 'uts-iot'),
	(59, 37.3, 40, 'false', 26, '2025-11-11 16:55:52', 'merah', 'uts-iot'),
	(60, 37.3, 40, 'false', 26, '2025-11-11 16:56:03', 'merah', 'uts-iot'),
	(61, 37.3, 40, 'false', 28, '2025-11-11 16:56:13', 'merah', 'uts-iot'),
	(62, 37.3, 40, 'false', 34, '2025-11-11 16:56:24', 'merah', 'uts-iot'),
	(63, 37.3, 40, 'false', 35, '2025-11-11 16:56:34', 'merah', 'uts-iot'),
	(64, 37.3, 40, 'false', 37, '2025-11-11 16:56:45', 'merah', 'uts-iot'),
	(65, 37.3, 40, 'false', 36, '2025-11-11 16:56:55', 'merah', 'uts-iot'),
	(66, 37.3, 40, 'false', 42, '2025-11-11 16:57:05', 'merah', 'uts-iot'),
	(67, 37.3, 40, 'false', 40, '2025-11-11 16:57:15', 'merah', 'uts-iot'),
	(68, 37.3, 40, 'false', 40, '2025-11-11 16:57:25', 'merah', 'uts-iot'),
	(69, 37.3, 40, 'false', 41, '2025-11-11 16:57:35', 'merah', 'uts-iot'),
	(70, 37.3, 40, 'false', 37, '2025-11-11 16:57:46', 'merah', 'uts-iot'),
	(71, 37.3, 40, 'false', 40, '2025-11-11 16:57:57', 'merah', 'uts-iot'),
	(72, 37.3, 40, 'false', 38, '2025-11-11 16:58:07', 'merah', 'uts-iot'),
	(73, 37.3, 40, 'false', 39, '2025-11-11 16:58:17', 'merah', 'uts-iot'),
	(74, 37.3, 40, 'false', 44, '2025-11-11 16:58:27', 'merah', 'uts-iot'),
	(75, 37.3, 40, 'false', 48, '2025-11-11 16:58:37', 'merah', 'uts-iot'),
	(76, 37.3, 40, 'false', 63, '2025-11-11 16:58:47', 'merah', 'uts-iot'),
	(77, 37.3, 40, 'false', 50, '2025-11-11 16:58:57', 'merah', 'uts-iot'),
	(78, 37.3, 40, 'false', 64, '2025-11-11 16:59:08', 'merah', 'uts-iot'),
	(79, 37.3, 40, 'false', 48, '2025-11-11 16:59:19', 'merah', 'uts-iot'),
	(80, 37.3, 40, 'false', 49, '2025-11-11 16:59:31', 'merah', 'uts-iot'),
	(81, 37.3, 40, 'false', 66, '2025-11-11 16:59:41', 'merah', 'uts-iot'),
	(82, 37.3, 40, 'false', 57, '2025-11-11 16:59:51', 'merah', 'uts-iot'),
	(83, 37.3, 40, 'false', 49, '2025-11-11 17:00:01', 'merah', 'uts-iot'),
	(84, 37.3, 40, 'false', 46, '2025-11-11 17:00:11', 'merah', 'uts-iot'),
	(85, 37.3, 40, 'false', 45, '2025-11-11 17:00:22', 'merah', 'uts-iot'),
	(86, 37.3, 40, 'false', 41, '2025-11-11 17:00:34', 'merah', 'uts-iot'),
	(87, 37.3, 40, 'false', 43, '2025-11-11 17:00:45', 'merah', 'uts-iot'),
	(88, 37.3, 40, 'false', 46, '2025-11-11 17:00:56', 'merah', 'uts-iot'),
	(89, 37.3, 40, 'false', 44, '2025-11-11 17:01:07', 'merah', 'uts-iot'),
	(90, 37.3, 40, 'false', 40, '2025-11-11 17:01:17', 'merah', 'uts-iot'),
	(91, 37.3, 40, 'false', 38, '2025-11-11 17:01:28', 'merah', 'uts-iot'),
	(92, 37.3, 40, 'false', 39, '2025-11-11 17:01:38', 'merah', 'uts-iot'),
	(93, 37.3, 40, 'false', 40, '2025-11-11 17:01:50', 'merah', 'uts-iot'),
	(94, 37.3, 40, 'false', 37, '2025-11-11 17:02:00', 'merah', 'uts-iot'),
	(95, 37.3, 40, 'false', 41, '2025-11-11 17:02:11', 'merah', 'uts-iot'),
	(96, 37.3, 40, 'false', 39, '2025-11-11 17:02:21', 'merah', 'uts-iot'),
	(97, 37.3, 40, 'false', 37, '2025-11-11 17:02:32', 'merah', 'uts-iot'),
	(98, 37.3, 40, 'false', 40, '2025-11-11 17:02:42', 'merah', 'uts-iot'),
	(99, 37.3, 40, 'false', 38, '2025-11-11 17:02:53', 'merah', 'uts-iot'),
	(100, 37.3, 40, 'false', 43, '2025-11-11 17:03:03', 'merah', 'uts-iot'),
	(101, 37.3, 40, 'false', 46, '2025-11-11 17:03:14', 'merah', 'uts-iot'),
	(102, 37.3, 40, 'false', 46, '2025-11-11 17:03:25', 'merah', 'uts-iot'),
	(103, 37.3, 40, 'false', 57, '2025-11-11 17:03:35', 'merah', 'uts-iot'),
	(104, 37.3, 40, 'false', 48, '2025-11-11 17:03:45', 'merah', 'uts-iot'),
	(105, 37.3, 40, 'false', 52, '2025-11-11 17:03:55', 'merah', 'uts-iot'),
	(106, 37.3, 40, 'false', 49, '2025-11-11 17:04:06', 'merah', 'uts-iot'),
	(107, 37.3, 40, 'false', 65, '2025-11-11 17:04:17', 'merah', 'uts-iot'),
	(108, 37.3, 40, 'false', 58, '2025-11-11 17:04:27', 'merah', 'uts-iot'),
	(109, 37.3, 40, 'false', 85, '2025-11-11 17:04:38', 'merah', 'uts-iot'),
	(110, 37.3, 40, 'false', 69, '2025-11-11 17:04:48', 'merah', 'uts-iot'),
	(111, 37.3, 40, 'false', 49, '2025-11-11 17:05:00', 'merah', 'uts-iot'),
	(112, 37.3, 40, 'false', 50, '2025-11-11 17:05:10', 'merah', 'uts-iot'),
	(113, 37.3, 40, 'false', 70, '2025-11-11 17:05:21', 'merah', 'uts-iot'),
	(114, 37.3, 40, 'false', 49, '2025-11-11 17:05:32', 'merah', 'uts-iot'),
	(115, 37.3, 40, 'false', 44, '2025-11-11 17:05:42', 'merah', 'uts-iot'),
	(116, 37.3, 40, 'false', 40, '2025-11-11 17:05:52', 'merah', 'uts-iot'),
	(117, 37.3, 40, 'false', 46, '2025-11-11 17:06:03', 'merah', 'uts-iot'),
	(118, 37.3, 40, 'false', 50, '2025-11-11 17:06:13', 'merah', 'uts-iot'),
	(119, 37.3, 40, 'false', 50, '2025-11-11 17:06:23', 'merah', 'uts-iot'),
	(120, 37.3, 40, 'false', 47, '2025-11-11 17:06:33', 'merah', 'uts-iot'),
	(121, 37.3, 40, 'false', 48, '2025-11-11 17:06:43', 'merah', 'uts-iot');

-- Dumping structure for view uts-iot.latest_sensor_data
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `latest_sensor_data` (
	`id` INT(10) NOT NULL,
	`suhu` FLOAT NOT NULL COMMENT 'Suhu dalam Celcius',
	`kelembapan` FLOAT NOT NULL COMMENT 'Kelembapan dalam persen',
	`lux` FLOAT NOT NULL COMMENT 'Kecerahan dalam Lux',
	`timestamp` DATETIME NULL COMMENT 'Waktu pencatatan data',
	`status_suhu` VARCHAR(7) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Dumping structure for view uts-iot.sensor_statistics
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `sensor_statistics` (
	`total_records` BIGINT(19) NOT NULL,
	`avg_suhu` DOUBLE NULL,
	`min_suhu` DOUBLE NULL,
	`max_suhu` DOUBLE NULL,
	`avg_kelembapan` DOUBLE NULL,
	`avg_lux` DOUBLE NULL,
	`last_update` DATE NULL
) ENGINE=MyISAM;

-- Dumping structure for view uts-iot.latest_sensor_data
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `latest_sensor_data`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `latest_sensor_data` AS select `data_sensor`.`id` AS `id`,`data_sensor`.`suhu` AS `suhu`,`data_sensor`.`kelembapan` AS `kelembapan`,`data_sensor`.`lux` AS `lux`,`data_sensor`.`timestamp` AS `timestamp`,(case when (`data_sensor`.`suhu` > 35) then 'BAHAYA' when (`data_sensor`.`suhu` >= 30) then 'WASPADA' else 'NORMAL' end) AS `status_suhu` from `data_sensor` order by `data_sensor`.`timestamp` desc limit 1;

-- Dumping structure for view uts-iot.sensor_statistics
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `sensor_statistics`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `sensor_statistics` AS select count(0) AS `total_records`,round(avg(`data_sensor`.`suhu`),2) AS `avg_suhu`,round(min(`data_sensor`.`suhu`),2) AS `min_suhu`,round(max(`data_sensor`.`suhu`),2) AS `max_suhu`,round(avg(`data_sensor`.`kelembapan`),2) AS `avg_kelembapan`,round(avg(`data_sensor`.`lux`),2) AS `avg_lux`,cast(max(`data_sensor`.`timestamp`) as date) AS `last_update` from `data_sensor`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
