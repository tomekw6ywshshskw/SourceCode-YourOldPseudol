```
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
```