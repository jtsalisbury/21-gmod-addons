-- --------------------------------------------------------
-- Host:                         ascendanceservers.net
-- Server version:               5.6.22 - Source distribution
-- Server OS:                    Linux
-- HeidiSQL Version:             9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for ascendance_administration
CREATE DATABASE IF NOT EXISTS `ascendance_administration` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ascendance_administration`;


-- Dumping structure for table ascendance_administration.am_banned
CREATE TABLE IF NOT EXISTS `am_banned` (
  `uniqueid` varchar(255) NOT NULL DEFAULT '',
  `BannedName` varchar(255) NOT NULL DEFAULT '',
  `BannerID` varchar(255) NOT NULL DEFAULT '',
  `BannerName` varchar(255) NOT NULL DEFAULT '',
  `BannedAtDate` varchar(255) NOT NULL DEFAULT '',
  `BannedAtTime` varchar(255) NOT NULL DEFAULT '',
  `BannedFor` varchar(255) NOT NULL DEFAULT '',
  `Reason` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table ascendance_administration.am_banned: 0 rows
/*!40000 ALTER TABLE `am_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `am_banned` ENABLE KEYS */;


-- Dumping structure for table ascendance_administration.am_groups
CREATE TABLE IF NOT EXISTS `am_groups` (
  `uniqueid` varchar(255) DEFAULT '',
  `admin` int(100) DEFAULT '0',
  `superadmin` int(100) DEFAULT '0',
  `owner` int(100) DEFAULT '0',
  `server_director` int(100) DEFAULT '0',
  `developer` int(100) DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `moderator` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table ascendance_administration.am_groups: 7 rows
/*!40000 ALTER TABLE `am_groups` DISABLE KEYS */;
INSERT INTO `am_groups` (`uniqueid`, `admin`, `superadmin`, `owner`, `server_director`, `developer`, `name`, `moderator`) VALUES
	('STEAM_0:0:10434389', 0, 0, 1, 0, 0, 'Sports', NULL),
	('STEAM_0:0:2000834', 0, 0, 1, 0, 0, 'Sports2', NULL),
	('STEAM_0:1:53961993', 0, 0, 1, 0, 0, 'crazyscouter', NULL),
	('STEAM_0:0:54663185', 1, 0, 0, 0, 0, 'Mercy', NULL),
	('STEAM_0:1:18168851 01:26', 1, 0, 0, 0, 0, 'Proximity', NULL),
	('STEAM_0:1:50607811', 1, 0, 0, 0, 0, 'Menace', NULL),
	('STEAM_0:1:30317957', 1, 0, 0, 0, 0, 'Samme', 0);
/*!40000 ALTER TABLE `am_groups` ENABLE KEYS */;


-- Dumping structure for table ascendance_administration.am_permissions
CREATE TABLE IF NOT EXISTS `am_permissions` (
  `group` varchar(255) NOT NULL DEFAULT '""',
  `permissions` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table ascendance_administration.am_permissions: 5 rows
/*!40000 ALTER TABLE `am_permissions` DISABLE KEYS */;
INSERT INTO `am_permissions` (`group`, `permissions`) VALUES
	('admin', 'Physgun,AdminChat,TP,Goto,Slay,Kick,Freeze,UnFreeze,Help'),
	('superadmin', 'Physgun,AdminChat,TP,Goto,Slay,Kick,Freeze,UnFreeze,SuperAdminChat,God,UnGod,NoClip,Help'),
	('owner', 'Physgun,AdminChat,TP,Goto,Slay,Kick,Freeze,UnFreeze,SuperAdminChat,God,UnGod,NoClip,Help,Ban'),
	('developer', 'Physgun,AdminChat,TP,Goto,Slay,Kick,Freeze,UnFreeze,SuperAdminChat,God,UnGod,NoClip,Help'),
	('server_director', 'Physgun,AdminChat,TP,Goto,Slay,Kick,Freeze,UnFreeze,SuperAdminChat,God,UnGod,NoClip,Help,Ban'),
	('moderator', 'Physgun,AdminChat,TP,Goto,Slay,Freeze,UnFreeze');
/*!40000 ALTER TABLE `am_permissions` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
