DROP TABLE [dbo].[Exo2_PlayerGamePlay]
DROP TABLE [dbo].[Exo2_GamePlay]
DROP TABLE [dbo].[Exo2_Player]
DROP TABLE [dbo].[Exo2_OpeningHour]
DROP TABLE [dbo].[Exo2_LKP_DayOfWeek]
DROP TABLE [dbo].[Exo2_Game]
-------------------------------------------------------
CREATE TABLE Exo2_Game(
[Id] [int] IDENTITY(1,1) NOT NULL,
[Name] [varchar] (250) NOT NULL,
[RankingType] [bit] NULL,
PRIMARY KEY (Id)
)
-------------------------------------------------------
CREATE TABLE Exo2_LKP_DayOfWeek(
[Id] [int] IDENTITY(1,1) NOT NULL,
[Name] [varchar] (250) NOT NULL,
PRIMARY KEY (Id)
)
-------------------------------------------------------
CREATE TABLE Exo2_OpeningHour(
[Id] [int] IDENTITY(1,1) NOT NULL,
[DayOfWeekId] [int] NOT NULL,
StartHour [int] NOT NULL,
StartMinute [int] NOT NULL,
EndHour [int] NOT NULL,
EndMinute [int] NOT NULL,
FOREIGN KEY (DayOfWeekId) REFERENCES Exo2_LKP_DayOfWeek(Id),
PRIMARY KEY (Id)
)
-------------------------------------------------------
CREATE TABLE Exo2_Player(
[Id] [int] IDENTITY(1,1) NOT NULL,
[Lastname] [varchar] (250) NOT NULL,
[FirstName] [varchar] (250) NOT NULL,
[Pseudo] [varchar] (250) NULL,
[DateOfBirth][date] NOT NULL
PRIMARY KEY (Id)
)
-------------------------------------------------------
CREATE TABLE Exo2_GamePlay(
[Id] [int] IDENTITY(1,1) NOT NULL,
[StartDate][DateTime] NOT NULL,
[GameId] [int] NOT NULL

PRIMARY KEY (Id),
FOREIGN KEY (GameId) REFERENCES Exo2_Game(Id),
)
-------------------------------------------------------
CREATE TABLE Exo2_PlayerGamePlay
(
[Id] [int] IDENTITY(1,1) NOT NULL,
[PlayerId] [int] NOT NULL,
[GamePlayId] [int] NOT NULL,
[IsWinner] [bit] NOT NULL,
[Score] [int] NULL
PRIMARY KEY (Id),
FOREIGN KEY (PlayerId) REFERENCES [dbo].[Exo2_Player] (Id),
FOREIGN KEY (GamePlayId) REFERENCES [dbo].[Exo2_GamePlay] (Id)
)
-------------------------------------------------------
SET IDENTITY_INSERT [dbo].[Exo2_Game] ON; 
INSERT INTO [dbo].[Exo2_Game] (Id, Name, RankingType) VALUES
(1, 'Cluedo', 1),
(2, 'Monopoly', 1),
(3, 'Scrabble', 0),
(4, 'Echec', 1),
(5, 'Citadelle', 1),
(6, 'Catan', 1);
SET IDENTITY_INSERT [dbo].[Exo2_Game] OFF; 
-------------------------------------------------------
DELETE FROM [dbo].[Exo2_LKP_DayOfWeek] ;
INSERT INTO [dbo].[Exo2_LKP_DayOfWeek] (Name) VALUES
('Lundi'),
('Mardi'),
('Mercredi'),
('Jeudi'),
('Vendredi'),
('Samedi'),
('Dimanche')

-------------------------------------------------------
SET IDENTITY_INSERT [dbo].[Exo2_Player] ON; 
INSERT INTO [dbo].[Exo2_Player] (Id, Lastname, FirstName, Pseudo, DateOfBirth) VALUES
(1, 'Lefranc-Adam', 'Mattis','Le plus fort', '2024-01-11'),
(2, 'Mouttaki', 'Salim', 'Le petit S', '1970-01-01'),
(3, 'Fenu', 'Alex', NULL,  '1970-01-01'),
(4, 'Castel', 'Eric', NULL, '1970-01-01'),
(5, 'Rosales', 'Luca', NULL, '1970-01-01'),
(6, 'Hemissi', 'Ines', NULL, '1970-01-01')
SET IDENTITY_INSERT [dbo].[Exo2_Player] OFF; 
-------------------------------------------------------
INSERT INTO [dbo].[Exo2_OpeningHour] (DayOfWeekId, StartHour, StartMinute, EndHour,EndMinute) VALUES
(1, 9, 0, 12, 0),
(1, 14, 0, 18, 0),
(2, 9, 0, 12, 0),
(2, 14, 0, 18, 0),
(3, 9, 0, 19, 0),
(4, 14, 0, 18, 0),
(4, 9, 0, 12, 0),
(5, 14, 0, 18, 0),
(5, 9, 0, 12, 0),
(3, 9, 0, 19, 0);
-------------------------------------------------------
DELETE FROM [dbo].[Exo2_GamePlay] ;
INSERT INTO [dbo].[Exo2_GamePlay](StartDate, GameId) VALUES
('2024-02-13 00:00:00', 6), 
('2024-01-06 00:00:00', 4), 
('2024-02-21 00:00:00', 4), 
('2024-02-08 00:00:00', 5), 
('2024-01-10 00:00:00', 4), 
('2024-02-09 00:00:00', 5), 
('2024-01-01 00:00:00', 2), 
('2024-01-29 00:00:00', 3), 
('2024-01-04 00:00:00', 6), 
('2024-01-29 00:00:00', 3), 
('2024-01-27 00:00:00', 2), 
('2024-02-16 00:00:00', 5), 
('2024-02-28 00:00:00', 3), 
('2024-02-05 00:00:00', 1), 
('2024-01-06 00:00:00', 6), 
('2024-02-12 00:00:00', 5), 
('2024-02-07 00:00:00', 1), 
('2024-02-02 00:00:00', 5), 
('2024-01-23 00:00:00', 4), 
('2024-02-19 00:00:00', 3),

('2024-02-07 00:00:00', 5), 
('2024-01-17 00:00:00', 1), 
('2024-02-07 00:00:00', 2), 
('2024-02-24 00:00:00', 2), 
('2024-02-27 00:00:00', 3), 
('2024-01-03 00:00:00', 2), 
('2024-02-26 00:00:00', 2), 
('2024-02-18 00:00:00', 4), 
('2024-02-26 00:00:00', 6), 
('2024-02-24 00:00:00', 5), 
('2024-02-01 00:00:00', 2), 
('2024-01-13 00:00:00', 6), 
('2024-02-06 00:00:00', 1), 
('2024-01-29 00:00:00', 5), 
('2024-02-15 00:00:00', 3), 
('2024-02-12 00:00:00', 2), 
('2024-02-24 00:00:00', 5), 
('2024-02-19 00:00:00', 2), 
('2024-02-22 00:00:00', 4), 
('2024-01-15 00:00:00', 1);
-------------------------------------------------------
DELETE FROM [dbo].[Exo2_PlayerGamePlay] ;
INSERT INTO [dbo].[Exo2_PlayerGamePlay] (PlayerId,GamePlayId, IsWinner, Score) VALUES
(1, 1, 0, NULL),
(2, 1, 1, NULL),
(3, 1, 0, NULL),
(4, 1, 0, NULL),
(5, 1, 0, NULL),
(6, 1, 0, NULL),

(1, 2, 0, NULL),
(2, 2, 1, NULL),
(3, 2, 0, NULL),
(4, 2, 0, NULL),
(5, 2, 0, NULL),
(6, 2, 0, NULL),

(1, 3, 0, 180),
(2, 3, 1, 215),
(3, 3, 0, 210),
(4, 3, 0, 136),
(5, 3, 0, 250),
(6, 3, 0, 150),

(1, 4, 0, NULL),
(2, 4, 0, NULL),
(3, 4, 1, NULL),
(4, 4, 0, NULL),
(5, 4, 0, NULL),
(6, 4, 0, NULL),

(1, 5, 0, NULL),
(2, 5, 0, NULL),
(3, 5, 0, NULL),
(4, 5, 0, NULL),
(5, 5, 1, NULL),
(6, 5, 0, NULL),

(1, 6, 0, NULL),
(2, 6, 0, NULL),
(3, 6, 0, NULL),
(4, 6, 0, NULL),
(5, 6, 0, NULL),
(6, 6, 1, NULL),

(1, 7, 1, NULL),
(2, 7, 0, NULL),
(3, 7, 0, NULL),
(4, 7, 0, NULL),
(5, 7, 0, NULL),
(6, 7, 0, NULL),

(1, 8, 0, 215),
(2, 8, 1, 269),
(3, 8, 0, 123),
(4, 8, 0, 139),
(5, 8, 0, 115),
(6, 8, 0, 160),

(1, 9, 0, 180),
(2, 9, 0, 215),
(3, 9, 1, 210),
(4, 9, 0, 136),
(5, 9, 0, 250),
(6, 9, 0, 150),

(1, 10, 0, 132),
(2, 10, 0, 156),
(3, 10, 0, 120),
(4, 10, 1, 286),
(5, 10, 0, 205),
(6, 10, 0, 199),

(1, 11, 0, NULL),
(2, 11, 0, NULL),
(3, 11, 0, NULL),
(4, 11, 0, NULL),
(5, 11, 1, NULL),
(6, 11, 0, NULL),

(1, 12, 0, NULL),
(2, 12, 1, NULL),
(3, 12, 0, NULL),
(4, 12, 0, NULL),
(5, 12, 0, NULL),
(6, 12, 0, NULL),

(1, 12, 0, NULL),
(2, 12, 0, NULL),
(3, 12, 0, NULL),
(4, 12, 1, NULL),
(5, 12, 0, NULL),
(6, 12, 0, NULL),

(1, 13, 0, 282),
(2, 13, 0, 290),
(3, 13, 0, 205),
(4, 13, 0, 235),
(5, 13, 0, 159),
(6, 13, 1, 301),

(1, 14, 0, NULL),
(2, 14, 0, NULL),
(3, 14, 0, NULL),
(4, 14, 0, NULL),
(5, 14, 0, NULL),
(6, 14, 1, NULL),

(1, 15, 1, NULL),
(2, 15, 0, NULL),
(3, 15, 0, NULL),
(4, 15, 0, NULL),
(5, 15, 0, NULL),
(6, 15, 0, NULL),

(1, 16, 0, NULL),
(2, 16, 0, NULL),
(3, 16, 0, NULL),
(4, 16, 1, NULL),
(5, 16, 0, NULL),
(6, 16, 0, NULL),

(1, 17, 0, NULL),
(2, 17, 0, NULL),
(3, 17, 1, NULL),
(4, 17, 0, NULL),
(5, 17, 0, NULL),
(6, 17, 0, NULL),

(1, 18, 0, NULL),
(2, 18, 0, NULL),
(3, 18, 0, NULL),
(4, 18, 0, NULL),
(5, 18, 1, NULL),
(6, 18, 0, NULL),

(1, 19, 0, NULL),
(2, 19, 1, NULL),
(3, 19, 0, NULL),
(4, 19, 0, NULL),
(5, 19, 0, NULL),
(6, 19, 0, NULL),


(1, 20, 0, 175),
(2, 20, 0, 169),
(3, 20, 0, 166),
(4, 20, 1, 36),
(5, 20, 0, 105),
(6, 20, 0, 205),


(1, 21, 0, NULL),
(2, 21, 0, NULL),
(3, 21, 0, NULL),
(4, 21, 0, NULL),
(5, 21, 0, NULL),
(6, 21, 1, NULL),


(1, 22, 0, NULL),
(2, 22, 0, NULL),
(3, 22, 0, NULL),
(4, 22, 1, NULL),
(5, 22, 0, NULL),
(6, 22, 0, NULL),


(1, 23, 0, NULL),
(2, 23, 1, NULL),
(3, 23, 0, NULL),
(4, 23, 0, NULL),
(5, 23, 0, NULL),
(6, 23, 0, NULL),


(1, 24, 1, NULL),
(2, 24, 0, NULL),
(3, 24, 0, NULL),
(4, 24, 0, NULL),
(5, 24, 0, NULL),
(6, 24, 0, NULL),


(1, 25, 1, 302),
(2, 25, 0, 268),
(3, 25, 0, 156),
(4, 25, 0, 300),
(5, 25, 0, 270),
(6, 25, 0, 75),


(1, 26, 0, NULL),
(2, 26, 1, NULL),
(3, 26, 0, NULL),
(4, 26, 0, NULL),
(5, 26, 0, NULL),
(6, 26, 0, NULL),


(1, 27, 0, NULL),
(2, 27, 0, NULL),
(3, 27, 1, NULL),
(4, 27, 0, NULL),
(5, 27, 0, NULL),
(6, 27, 0, NULL),


(1, 28, 0, NULL),
(2, 28, 0, NULL),
(3, 28, 0, NULL),
(4, 28, 0, NULL),
(5, 28, 0, NULL),
(6, 28, 1, NULL),


(1, 29, 0, NULL),
(2, 29, 0, NULL),
(3, 29, 0, NULL),
(4, 29, 1, NULL),
(5, 29, 0, NULL),
(6, 29, 0, NULL),


(1, 30, 0, NULL),
(2, 30, 0, NULL),
(3, 30, 1, NULL),
(4, 30, 0, NULL),
(5, 30, 0, NULL),
(6, 30, 0, NULL)

-------------------------------------------------------
SELECT p.FirstName, p.Pseudo, g.Name, gp.StartDate, pgp.IsWinner, pgp.Score, pgp.GamePlayId
FROM [dbo].[Exo2_PlayerGamePlay] pgp
INNER JOIN [dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id
INNER JOIN [dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
INNER JOIN [dbo].[Exo2_Game] g ON gp.GameId = g.Id

WHERE GameId = 3
-------------------------------------------------------
SELECT * 
FROM 
[dbo].[Exo2_PlayerGamePlay]


SELECT DATEPART(ww, StartDate), g.Name
fROM [dbo].[Exo2_GamePlay]gp
INNER JOIN [dbo].[Exo2_Game]g ON gp.GameId = g.Id

SELECT *
FROM [dbo].[Exo2_GamePlay] gp

WHERE gp.GameId = 3 