-- Bans Table
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `playername` varchar(255) DEFAULT NULL,
  `reason` text NOT NULL,
  `bannedby` varchar(255) NOT NULL,
  `bandate` int(11) NOT NULL DEFAULT unix_timestamp(),
  `duration` int(11) NOT NULL DEFAULT '-1',
  `unbantime` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `steam` (`steam`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Warns Table
CREATE TABLE IF NOT EXISTS `warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `playername` varchar(255) DEFAULT NULL,
  `reason` text NOT NULL,
  `warnedby` varchar(255) NOT NULL,
  `warndate` int(11) NOT NULL DEFAULT unix_timestamp(),
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Jails Table
CREATE TABLE IF NOT EXISTS `jails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `playername` varchar(255) DEFAULT NULL,
  `reason` text NOT NULL,
  `jailedby` varchar(255) NOT NULL,
  `jaildate` int(11) NOT NULL DEFAULT unix_timestamp(),
  `duration` int(11) NOT NULL,
  `unjailtime` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `steam` (`steam`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
