SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


-- Database: `Centro Sportivo`

-- Creazione delle tabelle

-- Tabella `MembroOrdinario`
-- Rappresenta i membri ordinari del centro sportivo
CREATE TABLE centro_sportivo.MembroOrdinario (
  CodiceIdentificativo INT PRIMARY KEY,
  Mansione VARCHAR(50)
);

-- Tabella `SalaCombattimento`
-- Rappresenta le sale per combattimenti nel centro sportivo
CREATE TABLE centro_sportivo.SalaCombattimento (
  NumSala INT PRIMARY KEY,
  NumRing INT,
  Specialita VARCHAR(50),
  NumMacchinari INT
);

-- Tabella `Piscina`
-- Rappresenta le piscine nel centro sportivo
CREATE TABLE centro_sportivo.Piscina (
  NumSala INT PRIMARY KEY,
  NumCorsie INT,
  Lunghezza INT,
  Larghezza INT
);

-- Tabella `SalaPesi`
-- Rappresenta le sale pesi nel centro sportivo
CREATE TABLE centro_sportivo.SalaPesi (
  NumSala INT PRIMARY KEY,
  NumMacchinari INT,
  Specialita VARCHAR(50)
);

-- Tabella `Struttura`
-- Rappresenta le strutture del centro sportivo
CREATE TABLE centro_sportivo.Struttura (
  Codice INT PRIMARY KEY,
  NumSale INT,
  NumStaff INT,
  NumTesserati INT,
  Indirizzo VARCHAR(100)
);

-- Tabella `Sala`
-- Rappresenta le sale nel centro sportivo
CREATE TABLE centro_sportivo.Sala (
  NumSala INT PRIMARY KEY,
  NumIstruttori INT,
  NumPersoneMassime INT,
  CodiceStruttura INT,
  FOREIGN KEY (CodiceStruttura) REFERENCES Struttura (Codice)
);

-- Tabella `Istruttore`
-- Rappresenta gli istruttori nel centro sportivo
CREATE TABLE centro_sportivo.Istruttore (
  CodiceIdentificativo INT PRIMARY KEY,
  PersoneSeguite INT,
  Maestria VARCHAR(50),
  Titolo VARCHAR(50),
  NumeroSala INT,
  FOREIGN KEY (NumeroSala) REFERENCES Sala (NumSala)
);

-- Tabella `Staff`
-- Rappresenta lo staff del centro sportivo
CREATE TABLE centro_sportivo.Staff (
  CodiceIdentificativo INT PRIMARY KEY,
  Nome VARCHAR(50),
  Cognome VARCHAR(50),
  NumTelefono VARCHAR(20),
  Stipendio DECIMAL(10, 2),
  TipoContratto VARCHAR(50),
  Turno VARCHAR(50)
);



-- Tabella `Abbonamento`
-- Rappresenta gli abbonamenti nel centro sportivo
CREATE TABLE centro_sportivo.Abbonamento (
  NumAbbonamento INT PRIMARY KEY,
  Durata INT,
  NumSaleAccedibili INT,
  DataInizio DATE
);

-- Tabella `Cliente1`
-- Rappresenta i clienti con numero di tessera nel centro sportivo
CREATE TABLE centro_sportivo.Cliente1 (
  NumTessera INT PRIMARY KEY,
  Email VARCHAR(100),
  NumTelefono VARCHAR(20),
  Residenza VARCHAR(100),
  NumeroAbb INT,
  CF VARCHAR(10),
  FOREIGN KEY (NumeroAbb) REFERENCES Abbonamento (NumAbbonamento)
);

-- Tabella `Cliente2`
-- Rappresenta i clienti con codice fiscale nel centro sportivo
CREATE TABLE centro_sportivo.Cliente2 (
  CF VARCHAR(10) PRIMARY KEY,
  Nome VARCHAR(50),
  Cognome VARCHAR(50),
  DataNascita DATE
);

-- Tabella `LavoraPer`
-- Rappresenta l'associazione tra membri e strutture
CREATE TABLE centro_sportivo.LavoraPer (
  CodiceMembro INT,
  CodiceStruttura INT,
  PRIMARY KEY (CodiceMembro, CodiceStruttura),
  FOREIGN KEY (CodiceMembro) REFERENCES MembroOrdinario (CodiceIdentificativo),
  FOREIGN KEY (CodiceStruttura) REFERENCES Struttura (Codice)
);

-- Tabella `ValidoPer`
-- Rappresenta l'associazione tra abbonamenti e sale
CREATE TABLE centro_sportivo.ValidoPer (
  NumeroAbb INT,
  NumeroSala INT,
  PRIMARY KEY (NumeroAbb, NumeroSala),
  FOREIGN KEY (NumeroAbb) REFERENCES Abbonamento (NumAbbonamento),
  FOREIGN KEY (NumeroSala) REFERENCES Sala (NumSala)
);


-- Creazione dei vincoli di integrità referenziale

-- Vincolo per la tabella `Cliente1`
ALTER TABLE centro_sportivo.Cliente1
ADD FOREIGN KEY (CF) REFERENCES Cliente2 (CF);

-- Vincolo per la tabella `Istruttore`
ALTER TABLE centro_sportivo.Istruttore
ADD FOREIGN KEY (NumeroSala) REFERENCES Sala (NumSala);

-- Vincolo per la tabella `MembroOrdinario`
 ALTER TABLE centro_sportivo.MembroOrdinario
 ADD FOREIGN KEY (CodiceIdentificativo) REFERENCES STAFF (CodiceIdentificativo);


-- Vincolo per la tabella `Istruttore`
 ALTER TABLE centro_sportivo.Istruttore
 ADD FOREIGN KEY (CodiceIdentificativo) REFERENCES STAFF (CodiceIdentificativo);


-- Vincolo per la tabella `Sala`
ALTER TABLE centro_sportivo.Sala
ADD FOREIGN KEY (CodiceStruttura) REFERENCES Struttura (Codice);

-- Vincolo per la tabella `ValidoPer`
ALTER TABLE centro_sportivo.ValidoPer
ADD FOREIGN KEY (NumeroAbb) REFERENCES Abbonamento (NumAbbonamento),
ADD FOREIGN KEY (NumeroSala) REFERENCES Sala (NumSala);

-- Vincolo per la tabella `LavoraPer`
ALTER TABLE centro_sportivo.LavoraPer
ADD FOREIGN KEY (CodiceMembro) REFERENCES MembroOrdinario (CodiceIdentificativo),
ADD FOREIGN KEY (CodiceStruttura) REFERENCES Struttura (Codice);


-- Dump dei dati per la tabella `Struttura`
INSERT INTO centro_sportivo.Struttura (Codice, NumSale, NumStaff, NumTesserati, Indirizzo) VALUES
  (01, 8, 10, 10, 'Via Fogazzini 10, FERRARA'),
  (02, 7, 5, 10, 'Via Ambrosini 1, FERRARA');
  
  -- Dump dei dati per la tabella `Staff`
INSERT INTO centro_sportivo.Staff (CodiceIdentificativo, Nome, Cognome, NumTelefono, Stipendio, TipoContratto, Turno) VALUES
  (110, 'Marcella', 'Robiatta', '3334455777', 5500.00, 'Indeterminato FT', 'ALL'),
  (111, 'Giovanni', 'Caldarrosto', '3334455999', 2000.00, 'Full-Time', 'SOLO MATTINA'),
  (112, 'Luca', 'Serafini', '3334455888', 1700.00, 'Indeterminato FT', 'SOLO POMERIGGIO'),
  (113, 'Matteo', 'Sedia', '0776122345', 1000.00, 'Full-Time', 'SOLO MATTINA'),
  (114, 'Valeria', 'Caldarroste', '0776152235', 2800.00, 'Indeterminato FT', 'MATTINA + POMERIGGIO'),
  (115, 'Oronzo', 'Caldarrosti', '0771522345', 2000.00, 'Full-Time', 'SOLO NOTTE'),
  (116, 'Valeria', 'Piric', '0776152235', 2100.00, 'Indeterminato FT', 'MATTINA + POMERIGGIO'),
  (117, 'Oronzo', 'Vividi', '0771522345', 2050.00, 'Full-Time', 'SOLO NOTTE'),
  (01, 'Alfredo', 'Robiatta', '3312233999', 1500.00, 'Part-Time', 'ALL'),
  (02, 'Simone', 'Tavolo', '1112233444', 2000.00, 'Full-Time', 'SOLO MATTINA'),
  (03, 'Gianni', 'Serafini', '555555555', 1700.00, 'Indeterminato FT', 'SOLO POMERIGGIO'),
  (04, 'Matteo', 'Saponaro', '0776122345', 1000.00, 'Full-Time', 'SOLO MATTINA'),
  (05, 'Valerio', 'Domenichini', '0776152235', 2800.00, 'Indeterminato FT', 'MATTINA + POMERIGGIO'),
  (06, 'Oronzo', 'Canà', '0771522345', 2000.00, 'Full-Time', 'SOLO NOTTE'),
  (07, 'Alessandra', 'Robiatta', '777777777', 2500.00, 'Part-Time', 'ALL'),
  (08, 'Giulia', 'Caldarrosto', '3334455999', 2000.00, 'Full-Time', 'SOLO MATTINA'),
  (09, 'Rafael', 'Serafini', '99999999', 1700.00, 'Indeterminato FT', 'SOLO POMERIGGIO'),
  (010, 'Alexis', 'Ciaccarè', '0776122345', 1000.00, 'Full-Time', 'SOLO MATTINA'),
  (011, 'Valeria', 'Vivident', '10101010', 3800.00, 'Indeterminato FT', 'MATTINA + POMERIGGIO'),
  (012, 'Mike', 'Peterson', '0771522345', 2000.00, 'Full-Time', 'SOLO NOTTE'),
  (013, 'Davide', 'Robiola', '3334455777', 1500.00, 'Part-Time', 'ALL'),
  (014, 'Abbie', 'Marinotto', '0776152234', 1500.00, 'Indeterminato FT', 'ALL');
  
  -- Dump dei dati per la tabella `Sala`
INSERT INTO centro_sportivo.Sala (NumSala, NumIstruttori, NumPersoneMassime, CodiceStruttura) VALUES
  (01, 1, 40, 1),
  (02, 1, 45, 2),
  (03, 1, 35, 1),
  (04, 1, 15, 2),
  (05, 1, 25, 1),
  (010, 1, 25, 1),
  (011, 1, 40, 1),
  (012, 1, 45, 2),
  (013, 1, 35, 1),
  (014, 1, 15, 2),
  (015, 1, 25, 1),
  (020, 1, 25, 1),
  (021, 1, 40, 1),
  (022, 1, 45, 2);
  
-- Dump dei dati per la tabella `MembroOrdinario`
INSERT INTO centro_sportivo.MembroOrdinario (CodiceIdentificativo, Mansione) VALUES
  (110, 'Direttore'),
  (111, 'Receptionist'),
  (112, 'Receptionist'),
  (113, 'Magazziniere'),
  (114, 'Manutentore'),
  (115, 'Assistente'),
  (116, 'Tecnico'),
  (117, 'Tecnico');

-- Dump dei dati per la tabella `SalaCombattimento`
INSERT INTO centro_sportivo.SalaCombattimento (NumSala, NumRing, Specialita, NumMacchinari) VALUES
  (01, 3, 'Boxe', 5),
  (02, 2, 'MMA', 3), 
  (03, 1, 'Muay Thai', 5),
  (04, 2, 'Judo', 3),
  (05, 2, 'Brazilian jiu-jitsu', 3);

-- Dump dei dati per la tabella `Piscina`
INSERT INTO centro_sportivo.Piscina (NumSala, NumCorsie, Lunghezza, Larghezza) VALUES
  (020, 4, 20, 10),
  (021, 1, 25, 35),
  (022, 1, 30, 35);

-- Dump dei dati per la tabella `SalaPesi`
INSERT INTO centro_sportivo.SalaPesi (NumSala, NumMacchinari, Specialita) VALUES
  (010, 10, 'Calisthenics'), --
  (011, 50, 'Body Building'), --
  (012, 38, 'Power Lifting'), --
  (013, 10, 'Body Building'), --
  (014, 38, 'Calisthenics'), --
  (015, 18, 'Corpo Libero'); --


-- Dump dei dati per la tabella `Istruttore`
INSERT INTO centro_sportivo.Istruttore (CodiceIdentificativo, PersoneSeguite, Maestria, Titolo, NumeroSala) VALUES
  (01, 1, 'Arti Marziali', 'Diploma', 02),
  (02, 1, 'Istruttore Fitness', 'Diploma', 011),
  (03, 1, 'Personal Trainer', 'Laurea Triennale', 013),
  (04, 1, 'Ginnasta', 'Diploma', 014),
  (05, 1, 'Arti Marziali', 'Diploma', 03),
  (06, 1, 'Maestro di nuoto', 'Laurea Magistrale', 020),
  (07, 1, 'Maestro di nuoto', 'Diploma', 021),
  (08, 1, 'Maestro di nuoto', 'Laurea Triennale', 022),
  (09, 1, 'Ginnasta', 'Diploma', 010),
  (10, 1, 'Pugile', 'Diploma', 01),
  (11, 1, 'Arti Marziali', 'Diploma', 04),
  (12, 1, 'Arti Marziali', 'Diploma', 05),
  (13, 1, 'Personal Trainer', 'Laurea Triennale', 012),
  (14, 1, 'Ginnasta', 'Diploma', 015);



-- Dump dei dati per la tabella `Abbonamento`
INSERT INTO centro_sportivo.Abbonamento (NumAbbonamento, Durata, NumSaleAccedibili, DataInizio) VALUES
  (1001, 30, 2, '2021-01-01'),
  (2002, 90, 3, '2021-02-01'),
  (3003, 60, 1, '2021-03-01'),
  (4004, 60, 3, '2021-04-01'),
  (5005, 180, 3, '2021-05-01'),
  (6006, 30, 2, '2021-06-01'),
  (7007, 60, 3, '2021-07-01'),
  (8008, 180, 1, '2021-08-01'),
  (9009, 90, 3, '2021-09-01'),
  (1010, 60, 2, '2021-10-01'),
  (1111, 30, 3, '2021-11-01'),
  (1212, 180, 3, '2021-12-01'),
  (1313, 60, 1, '2022-01-01'),
  (1414, 30, 3, '2022-02-01'),
  (1515, 90, 2, '2022-03-01'),
  (1616, 180, 3, '2022-04-01'),
  (1717, 60, 3, '2023-05-01'),
  (1818, 30, 1, '2023-06-01'),
  (1919, 90, 2, '2023-07-01'),
  (2020, 180, 3, '2022-08-01'),
  (2121, 90, 3, '2023-01-01'),
  (2222, 60, 1, '2023-02-01'),
  (2323, 30, 2, '2023-03-01'),
  (2424, 180, 3, '2023-04-01'),
  (2525, 30, 3, '2023-05-01'),
  (2626, 90, 2, '2023-06-01'),
  (2727, 60, 3, '2023-07-01'),
  (2828, 180, 1, '2023-08-01'),
  (2929, 30, 2, '2023-09-01'),
  (3030, 90, 3, '2023-10-01'),
  (3131, 60, 1, '2023-11-01'),
  (3232, 30, 3, '2023-12-01'),
  (3333, 180, 2, '2023-01-15'),
  (3434, 90, 3, '2023-02-15'),
  (3535, 60, 1, '2023-03-15'),
  (3636, 30, 3, '2023-04-15'),
  (3737, 180, 2, '2023-05-15'),
  (3838, 90, 3, '2023-06-15'),
  (3939, 60, 1, '2023-07-15'),
  (4040, 30, 3, '2023-08-15');

 
-- Dump dei dati per la tabella `Cliente2`
INSERT INTO centro_sportivo.Cliente2 (CF, Nome, Cognome, DataNascita) VALUES
  ('CF00000001', 'Nome 1', 'Cognome 1', '1998-01-01'),
  ('CF00000002', 'Nome 2', 'Cognome 2', '1999-02-01'),
  ('CF00000003', 'Nome 3', 'Cognome 3', '1965-03-01'),
  ('CF00000004', 'Nome 4', 'Cognome 4', '1972-01-01'),
  ('CF00000005', 'Nome 5', 'Cognome 5', '1974-02-01'),
  ('CF00000006', 'Nome 6', 'Cognome 6', '1975-03-01'),
  ('CF00000007', 'Nome 7', 'Cognome 7', '1999-01-01'),
  ('CF00000008', 'Nome 8', 'Cognome 8', '2005-02-01'),
  ('CF00000009', 'Nome 9', 'Cognome 9', '2002-03-01'),
  ('CF00000010', 'Nome 10', 'Cognome 10', '1990-01-01'),
  ('CF00000011', 'Nome 12', 'Cognome 12', '1985-02-01'),
  ('CF00000012', 'Nome 13', 'Cognome 13', '1995-03-01'),
  ('CF00000013', 'Nome 11', 'Cognome 11', '1970-01-01'),
  ('CF00000014', 'Nome 14', 'Cognome 14', '1955-02-01');
  
  
-- Dump dei dati per la tabella `Cliente1`
INSERT INTO centro_sportivo.Cliente1 (NumTessera, Email, NumTelefono, Residenza, NumeroAbb, CF) VALUES
  (1, 'email1@example.com', '1111111111', 'Residenza 1', 1111, 'CF00000001'),
  (2, 'email2@example.com', '2222222222', 'Residenza 2', 1313, 'CF00000002'),
  (3, 'email3@example.com', '3333333333', 'Residenza 3', 1515, 'CF00000003'),
  (4, 'email4@example.com', '1111111111', 'Residenza 4', 7007, 'CF00000004'),
  (5, 'email5@example.com', '2222222222', 'Residenza 5', 6006, 'CF00000005'),
  (6, 'email6@example.com', '3333333333', 'Residenza 6', 1616, 'CF00000006'),
  (7, 'email7@example.com', '1111111111', 'Residenza 7', 3232, 'CF00000007'),
  (8, 'email8@example.com', '2222222222', 'Residenza 8', 3333, 'CF00000008'),
  (9, 'email9@example.com', '3333333333', 'Residenza 9', 3030, 'CF00000009'),
  (11, 'email10@example.com', '1111111111', 'Residenza 10', 3131, 'CF00000010'),
  (12, 'email11@example.com', '2222222222', 'Residenza 11', 3535, 'CF00000011'),
  (13, 'email12@example.com', '3333333333', 'Residenza 13', 3636, 'CF00000012'),
  (14, 'email13@example.com', '1111111111', 'Residenza 12', 3737, 'CF00000013'),
  (10, 'email14@example.com', '2222222222', 'Residenza 24', 3838, 'CF00000014');


-- Dump dei dati per la tabella `LavoraPer`
INSERT INTO centro_sportivo.LavoraPer (CodiceMembro, CodiceStruttura) VALUES
  (110, 1),
  (111, 2),
  (112, 1),
  (113, 1),
  (114, 2),
  (115, 1),
  (116, 2),
  (117, 1);


-- Dump dei dati per la tabella `ValidoPer`
INSERT INTO centro_sportivo.ValidoPer (NumeroAbb, NumeroSala) VALUES
  (1001, 01),
  (2002, 02),
  (3003, 03),
   (4004, 03),
   (5005,04),
   (6006,05),
   (7007,011),
   (8008,015),
   (9009,013),
   (1010,020),
   (1111,021),
   (1212,022),
   (1313,011),
   (1414,010),
   (1515,01),
   (1616,013),
   (1717,01),
   (1818,04),
   (1919,014),
   (2020,01),
   (2121,02),
   (2222,02),
   (2323,022),
   (2424,021),
   (2525,020),
   (2626,011),
   (2727,014),
   (2828,015),
   (2929,011),
   (3030,010),
   (3131,010),
   (3232,01),
   (3333,03),
   (3434,03),
   (3535,01),
   (3636,02),
   (3737,010),
   (3838,01),
   (3939,010),
   (4040,021);