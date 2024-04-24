CREATE TABLE OCR_admini (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    SERIAL TEXT NOT NULL,
    RANK TEXT NOT NULL,
    JOINDATE DATETIME NOT NULL
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
    ID INT AUTO_INCREMENT PRIMARY KEY,
    SERIAL TEXT NOT NULL,
    RANK TEXT NOT NULL,
    FACTION TEXT NOT NULL DEAFULT,
    JOINDATE DATETIME NOT NULL
);
