-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 12. Apr 2024 um 09:37
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `db_schokolade`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tb_geschmacksrichtung`
--

CREATE TABLE `tb_geschmacksrichtung` (
  `geschmack_id` int(11) NOT NULL,
  `geschmack` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tb_geschmacksrichtung`
--

INSERT INTO `tb_geschmacksrichtung` (`geschmack_id`, `geschmack`) VALUES
(1, 'Vollmilch'),
(2, 'bitter'),
(3, 'weiss'),
(4, 'chili'),
(5, 'orange'),
(6, 'feinherb');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tb_marke`
--

CREATE TABLE `tb_marke` (
  `marke_id` int(11) NOT NULL,
  `marke_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tb_marke`
--

INSERT INTO `tb_marke` (`marke_id`, `marke_name`) VALUES
(1, 'Rausch'),
(2, 'Lindt');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tb_merkmal`
--

CREATE TABLE `tb_merkmal` (
  `merkmal_id` int(11) NOT NULL,
  `merkmal` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tb_merkmal`
--

INSERT INTO `tb_merkmal` (`merkmal_id`, `merkmal`) VALUES
(1, 'vegetarisch'),
(2, 'vegan');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tb_schokolade`
--

CREATE TABLE `tb_schokolade` (
  `schoko_id` int(11) NOT NULL,
  `schoko_name` varchar(40) DEFAULT NULL,
  `kakaoanteil` int(11) DEFAULT NULL,
  `links` varchar(200) DEFAULT NULL,
  `marke_id` int(11) DEFAULT NULL,
  `geschmack_id` int(11) DEFAULT NULL,
  `merkmal_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tb_schokolade`
--

INSERT INTO `tb_schokolade` (`schoko_id`, `schoko_name`, `kakaoanteil`, `links`, `marke_id`, `geschmack_id`, `merkmal_id`) VALUES
(1, 'Venezuela', 43, 'https://www.rausch.de/produkte/schokoladen/rausch-plantagen/venezuela-43-tafel/1825?c=130', 1, 1, 1),
(2, 'Peru', 60, 'https://www.rausch.de/produkte/schokoladen/rausch-plantagen/peru-60-tafel/1802?c=130', 1, 2, 2),
(3, 'Costa Rica', 75, 'https://www.rausch.de/produkte/schokoladen/rausch-plantagen/costa-rica-75-tafel/3390?c=130', 1, 2, 2),
(4, 'Excellence Chili', 48, 'https://www.lindt.de/excellence-chili-100g', 2, 4, 1),
(5, 'Excellence Chili', 48, 'https://www.lindt.de/excellence-chili-100g', 2, 6, 1),
(6, 'Edelbitter Mouse Orange', 70, 'https://www.lindt.de/edelbitter-mousse-orange-150g', 2, 5, 2),
(7, 'Edelbitter Mouse Orange', 70, 'https://www.lindt.de/edelbitter-mousse-orange-150g', 2, 2, 2),
(8, 'Weiss', 0, 'https://www.lindt.de/weisse-tafel-100g', 2, 3, 1);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tb_geschmacksrichtung`
--
ALTER TABLE `tb_geschmacksrichtung`
  ADD PRIMARY KEY (`geschmack_id`);

--
-- Indizes für die Tabelle `tb_marke`
--
ALTER TABLE `tb_marke`
  ADD PRIMARY KEY (`marke_id`);

--
-- Indizes für die Tabelle `tb_merkmal`
--
ALTER TABLE `tb_merkmal`
  ADD PRIMARY KEY (`merkmal_id`);

--
-- Indizes für die Tabelle `tb_schokolade`
--
ALTER TABLE `tb_schokolade`
  ADD PRIMARY KEY (`schoko_id`),
  ADD KEY `marke_id` (`marke_id`),
  ADD KEY `geschmack_id` (`geschmack_id`),
  ADD KEY `merkmal_id` (`merkmal_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tb_marke`
--
ALTER TABLE `tb_marke`
  MODIFY `marke_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `tb_schokolade`
--
ALTER TABLE `tb_schokolade`
  MODIFY `schoko_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tb_schokolade`
--
ALTER TABLE `tb_schokolade`
  ADD CONSTRAINT `tb_schokolade_ibfk_1` FOREIGN KEY (`marke_id`) REFERENCES `tb_marke` (`marke_id`),
  ADD CONSTRAINT `tb_schokolade_ibfk_2` FOREIGN KEY (`geschmack_id`) REFERENCES `tb_geschmacksrichtung` (`geschmack_id`),
  ADD CONSTRAINT `tb_schokolade_ibfk_3` FOREIGN KEY (`merkmal_id`) REFERENCES `tb_merkmal` (`merkmal_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
