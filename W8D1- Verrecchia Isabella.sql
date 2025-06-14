#W8D1- Verrecchia Isabella
#È necessario implementare uno schema che consenta di gestire le anagrafiche degli store di unʼipotetica azienda. 
#Uno store è collocato in una precisa area geografica. In unʼarea geografica possono essere collocati store diversi.

#creo un database che contenga le mie tabelle
CREATE DATABASE negozi;
USE negozi;

#PUNTO 1 E 2
#Crea una tabella Store per la gestione degli store (ID, nome, data apertura, ecc.)
#Crea una tabella Region per la gestione delle aree geografiche (ID, città, regione, area geografica, …)

CREATE TABLE Region (
RegionID INT AUTO_INCREMENT PRIMARY KEY,
Citta VARCHAR(50),
Regione VARCHAR(40),
AreaGeografica VARCHAR(30)
);

CREATE TABLE Store (
StoreID INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(40),
Indirizzo VARCHAR(50),
RegionID INT,
DataApertura DATE,
CONSTRAINT Fk_Region
FOREIGN KEY (RegionID) REFERENCES Region (RegionID)
);

#PUNTO 3
#Popola le tabelle con pochi record esemplificativi

INSERT INTO Region (RegionID,Citta,Regione,AreaGeografica)
VALUES 
(1, 'Milano', 'Lombardia', 'Nord'),
(2, 'Torino', 'Piemonte', 'Nord'),
(3, 'Venezia', 'Veneto', 'Nord-Est'),
(4, 'Bologna', 'Emilia-Romagna', 'Centro-Nord'),
(5, 'Firenze', 'Toscana', 'Centro'),
(6, 'Roma', 'Lazio', 'Centro'),
(7, 'Napoli', 'Campania', 'Sud'),
(8, 'Bari', 'Puglia', 'Sud-Est'),
(9, 'Palermo', 'Sicilia', 'Sud'),
(10, 'Cagliari', 'Sardegna', 'Isole');

SELECT * FROM Region; 

INSERT INTO Store (Nome, Indirizzo, RegionID, DataApertura)
VALUES 
('La Dolce Boutique Milano', 'Via Torino 15, Milano', 1, '2018-03-15'),
('Amalfi Artisans Torino', 'Corso Francia 33, Torino', 2, '2019-06-10'),
('Venezia Vibes Boutique', 'Campo San Polo 4, Venezia', 3, '2020-04-21'),
('Eclettica Bologna', 'Via Rizzoli 8, Bologna', 4, '2021-01-11'),
('Fior di Toscana Firenze', 'Via dei Calzaiuoli 21, Firenze', 5, '2017-09-25'),
('Su Misura Roma', 'Via del Corso 101, Roma', 6, '2022-02-14'),
('Sapori di Napoli', 'Via Toledo 45, Napoli', 7, '2016-12-01'),
('Bari Boutique', 'Via Sparano 32, Bari', 8, '2020-08-03'),
('Palermo Pasticceria', 'Via Maqueda 50, Palermo', 9, '2015-07-19'),
('Cagliari Creativo', 'Via Roma 12, Cagliari', 10, '2021-10-05');

SELECT * FROM Store;

#PUNTO 4
#Esegui operazioni di aggiornamento, modifica ed eliminazione record

#modifico la data di apertura dello store 4
START TRANSACTION;
SELECT DataApertura FROM Store WHERE StoreID=4;
UPDATE Store
SET DataApertura =DATE_ADD(DataApertura, INTERVAL 3 DAY)
WHERE StoreID=4;
SELECT DataApertura FROM Store WHERE StoreID=4;
COMMIT;
#ROLLBACK;

#elimino i record con DataApertura < 2018
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
SELECT DataApertura FROM Store WHERE DataApertura < '2018-01-01';
DELETE FROM Store
WHERE DataApertura < '2018-01-01';
SELECT * FROM Store;
ROLLBACK;

