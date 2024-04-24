CREATE TABLE OCR_admini (
    `ID` INT AUTO_INCREMENT PRIMARY KEY,
    `SERIAL` TEXT NOT NULL,
    `RANK` TEXT NOT NULL,
    `JOINDATE` DATETIME NOT NULL
);

CREATE TABLE `OCR_players` (
  `id` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `bank_money` bigint(20) NOT NULL DEFAULT 0,
  `skin` int(11) NOT NULL DEFAULT 0,
  `weave` int(11) NOT NULL DEFAULT 50,
  `ocrPoints` int(11) NOT NULL DEFAULT 0,
  `category` TEXT NOT NULL DEFAULT '0,0,0', 
  `worker` int(11) NOT NULL DEFAULT 0,
  `hours` int(12) NOT NULL,
  `mandate` int(10) NOT NULL DEFAULT 0,
  `registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `register_serial` varchar(120) DEFAULT NULL,
  `jail` tinyint(1) NOT NULL DEFAULT 0,
  `keys` INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_unique` (`login`),
  KEY `login_index` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `OCR_cars` (
  `id` int(11) NOT NULL,
  `model` int(11) NOT NULL DEFAULT 411,
  `frozen` int(11) NOT NULL DEFAULT 0,
  `pos` varchar(82) NOT NULL DEFAULT '0, 0, 0, 0, 0, 0',
  `health` int(11) NOT NULL DEFAULT 1000,
  `mileage` int(11) NOT NULL DEFAULT 0,
  `driver` text NOT NULL,
  `Colors` varchar(91) NOT NULL DEFAULT 'color NOT NULL DEFAULT, headlights NOT NULL DEFAULT',
  `tuning` text NOT NULL,
  `panelstates` text NOT NULL,
  `rent` varchar(255) CHARACTER SET utf32 COLLATE utf32_bin DEFAULT '0',
  `plateText` text NOT NULL,
  `ownedGroup` varchar(111) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '0',
  `ownedPlayer` int(11) NOT NULL DEFAULT 0,
  `parking` int(11) NOT NULL DEFAULT 0,
  `blokada` text NOT NULL,
  `registered` varchar(10) NOT NULL DEFAULT 'true',
  `TuneWiz` varchar(255) DEFAULT 'drzwi 0, zawieszenie 0, neon 0, paintjob 0, licznik 0, spoiler 0, stereo 0',
  `TuneMech` varchar(255) DEFAULT 'gazZamont 0, nitro 0, silnik 1.6',
  `Fuel` varchar(255) DEFAULT 'PB 0, LPG 0, ON 0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


CREATE TABLE OCR_faction (
    `ID` INT AUTO_INCREMENT PRIMARY KEY,
    `SERIAL` TEXT NOT NULL,
    `RANK` TEXT NOT NULL,
    `FACTION` TEXT NOT NULL DEAFULT,
    JOINDATE DATETIME NOT NULL
);

CREATE TABLE `ocr_org` (
  `id` int(11) NOT NULL,
  `nazwa` text NOT NULL,
  `TAG` varchar(5) NOT NULL,
  `liderid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_orgUsers` (
  `id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `rank` TEXT NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_office` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` text NOT NULL,
  `spaces` int(11) NOT NULL DEFAULT 5,
  `maxspaces` int(11) NOT NULL DEFAULT 0,
  `ocrPoints` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_punish` (
  `kolejnosc` int(11) NOT NULL,
  `serial` text NOT NULL,
  `reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `type` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


CREATE TABLE `ocr_punish_logs` (
  `serial` varchar(24) NOT NULL COMMENT 'serial na jaki kara zostala nadana',
  `type` varchar(15) NOT NULL COMMENT 'typ kary',
  `date` datetime NOT NULL COMMENT 'data do ktorej ta kara wystepowala',
  `date_punish` datetime NOT NULL COMMENT 'Data nadania kary',
  `uid_get_punish` int(10) NOT NULL COMMENT 'Uid ktore dostalo kare',
  `reason` varchar(41) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'powod kary'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_logs` (
  `name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `osoba` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

CREATE TABLE `ocr_jobs` (
  `code` varchar(120) NOT NULL,
  `uid` int(11) NOT NULL,
  `actived` date NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp(),
  `NULL` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_ban` (
  `osoba` int(11) NOT NULL,
  `serial` text NOT NULL,
  `reason` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `type` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_houses` (
  `osoba` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `position` varchar(64) NOT NULL DEFAULT '0, 0, 0',
  `cost` int(11) NOT NULL DEFAULT 1000,
  `owner` text NOT NULL,
  `position2` varchar(64) NOT NULL DEFAULT '',
  `payid` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_logs_login` (
  `name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `serial` varchar(50) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

CREATE TABLE `ocr_vehicles_parking` (
  `idparking` int(11) NOT NULL,
  `idpojazdu` int(20) NOT NULL,
  `funkcjonariusz` varchar(64) NOT NULL,
  `rejestracja` varchar(20) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `powod` varchar(64) NOT NULL,
  `cena` int(10) NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `ocr_interiors` (
  `id` int(11) NOT NULL,
  `wejscie` varchar(64) NOT NULL DEFAULT '[ [ 0.0, 0.0, 0.0, 0.0 ] ]',
  `wyjscie` varchar(64) NOT NULL DEFAULT '[ [ 0.0, 0.0, 0.0, 0.0 ] ]',
  `interior` smallint(6) NOT NULL DEFAULT 0,
  `dimension` int(11) NOT NULL DEFAULT 5000,
  `cost` int(11) NOT NULL DEFAULT 12000,
  `opis` varchar(64) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `ocr_aj` (
  `seg` int(11) NOT NULL,
  `Serial` varchar(128) NOT NULL,
  `Termin` datetime NOT NULL,
  `Cela` int(11) NOT NULL COMMENT 'CELA',
  `Powod` varchar(4092) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

