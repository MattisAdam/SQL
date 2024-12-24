
DROP TABLE Car
DROP TABLE Tyre
DROP TABLE TyreSize
DROP TABLE TyreConstructor
DROP TABLE ModelCar
DROP TABLE BrandCar
DROP TABLE ColorCar
DROP TABLE MotorType
DROP TABLE Currency
DROP TABLE RateChange
DROP TABLE TyrePrice




-------------------------------------------------
CREATE TABLE Currency(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar] (max)  NOT NULL, 
	PRIMARY KEY (Id)
	)
-------------------------------------------------
CREATE TABLE MotorType(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL, 
	[Price] [decimal] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_MotorType_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES Currency(Id)
	)
-------------------------------------------------
CREATE TABLE ColorCar(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Color] [varchar](max) NOT NULL, 
	[Price] [decimal] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_ColorCar_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES Currency(Id)
	)
---------------------------------------------
CREATE TABLE BrandCar(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	PRIMARY KEY (Id),
	)
------------------------------------------------------
CREATE TABLE ModelCar(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[BrandCarId] [int] NOT NULL,
	[Price] [decimal] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_ModelCar_BrandCarId FOREIGN KEY (BrandCarId) REFERENCES BrandCar(Id),
	CONSTRAINT FK_Modelcar_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES Currency(Id)
	)
----------------------------------------------------------
CREATE TABLE TyreConstructor(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	PRIMARY KEY (Id),
	)
----------------------------------------------------------
CREATE TABLE TyreSize(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Inch] [int] NOT NULL,
	PRIMARY KEY (Id),
	)
----------------------------------------------------------
CREATE TABLE Tyre(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[TyreSizeId] [int] NOT NULL,
	[TyreConstructorId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Tyre_TyreSizeId FOREIGN KEY (TyreSizeId) REFERENCES TyreSize(Id),
	CONSTRAINT FK_Tyre_TyreConstructorId FOREIGN KEY (TyreConstructorId) REFERENCES TyreConstructor(Id)
	)
----------------------------------------------------------
CREATE TABLE TyrePrice (
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[Price] [decimal] (5,2) NOT NULL, 
	[StartDate] [datetime2] NOT NULL,
	[EndDate] [datetime2] NULL,
	[TyreId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_TyrePrice_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES Currency(Id),
	CONSTRAINT FK_TyrePrice_TyreId FOREIGN KEY (TyreId) REFERENCES Tyre(Id),
	)
-----------------------------------------------------------------------------
CREATE TABLE Car(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[MotorTypeId] [int] NOT NULL,
	[ColorCarId] [int] NOT NULL,
	[ModelCarId] [int] NOT NULL,
	[TyreId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Car_MotorTypeId FOREIGN KEY (MotorTypeId) REFERENCES MotorType(Id),
	CONSTRAINT FK_Car_ColorCarId FOREIGN KEY (ColorCarId) REFERENCES ColorCar(Id),
	CONSTRAINT FK_Car_ModelCarId FOREIGN KEY (ModelCarId) REFERENCES ModelCar(Id),
	CONSTRAINT FK_Car_TyreId FOREIGN KEY (TyreId) REFERENCES Tyre(Id)
	)
-----------------------------------------------------------------------------
CREATE TABLE RateChange(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[ValueChange] [decimal](18,3) NOT NULL,
	[CurrencyToId] [int] NOT NULL,
	[CurrencyFromId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_RateChange_CurrencyToId FOREIGN KEY (CurrencyToId) REFERENCES Currency(Id),
	CONSTRAINT FK_RateChange_CurrencyFromId FOREIGN KEY (CurrencyFromId) REFERENCES Currency(Id)
	)

-------------------------------------------------------------------------------
--SELECT * FROM [dbo].[MotorType]
--SELECT * FROM [dbo].[ColorCar]
--SELECT * FROM [dbo].[BrandCar]
--SELECT * FROM [dbo].[ModelCar]
--SELECT * FROM [dbo].[TyreConstructor]
--SELECT * FROM [dbo].[TyreSize]
--SELECT * FROM [dbo].[Tyre]
--SELECT * FROM [dbo].[Car]
--SELECT * FROM [dbo].[RateChange]




INSERT INTO [dbo].[Currency](Name) VALUES
('USD'),
('EUR'),
('CHF');

INSERT INTO [dbo].[BrandCar] (Name) VALUES 
('Ferrari'),
('Peugeot'),
('Renault'),
('Citroen');
GO

INSERT INTO [dbo].[ModelCar] (Name, BrandCarId, Price, CurrencyId) VALUES 
('Enzo', 1, 150000, 1),
('205', 2, 12300, 2),
('C3', 4, 13400, 3),
('Laguna', 3, 18600, 1);
GO

INSERT INTO [dbo].[MotorType] (Name, Price, CurrencyId) VALUES
('Essence', 1000.0, 1), 
('Diesel', 1200.0, 1),
('Hybride', 1500.0, 2),
('Electrique', 2000.0, 3);
GO

INSERT INTO [dbo].[ColorCar] (Color, Price, CurrencyId) VALUES
('Blanc', 0.0, 2), 
('Noir', 400.0, 3),
('Rouge', 400.0, 3),
('Bleu', 400.0, 2),
('Gris métallisé', 600.0, 1);
GO

INSERT INTO [dbo].[TyreConstructor] (Name) VALUES 
('Michelin'),
('Goodyear'),
('Continental');
GO

INSERT INTO [dbo].[TyreSize] (Inch) VALUES
('15'),
('16');
GO



INSERT INTO [dbo].[Tyre] (TyreConstructorId, TyreSizeId) VALUES 
(1,1),
(1,2),
(2,1),
(2,2),
(3,1),
(3,2)

INSERT INTO [dbo].[Car] (ModelCarId, MotorTypeId, ColorCarId, TyreId) VALUES 
(1, 4, 1, 1),
(1, 3, 3, 6),
(1, 1, 4, 5),
(2, 2, 4, 4),
(3, 4, 2, 3),
(2, 1, 2, 3),
(3, 3, 5, 2);



INSERT INTO [dbo].[RateChange](ValueChange, CurrencyToId, CurrencyFromId) VALUES
(1.00, 1, 1),
(0.95, 1, 2),
(0.88, 1, 3);


INSERT INTO [dbo].[TyrePrice](Price, CurrencyId, StartDate, EndDate,TyreId) VALUES
(258.00, 1, '2024-01-01', '2024-04-30', 1),
(265.00, 2, '2024-05-01', '2024-06-30', 1),
(286.00, 3, '2024-07-01', NULL,1),
(314.00, 1, '2024-01-01', '2024-04-30', 2),
(330.00, 2, '2024-05-01', '2024-06-30', 2),
(320.00, 3, '2024-07-01', NULL, 2),
(230.00, 1, '2024-01-01', '2024-04-30', 3),
(215.00, 2, '2024-05-01', '2024-06-30', 3),
(295.00, 3, '2024-07-01', NULL, 3),
(249.00, 1, '2024-01-01', '2024-04-30', 4),
(260.00, 2, '2024-05-01', '2024-06-30', 4),
(300.00, 3, '2024-07-01', NULL, 4),
(240.00, 1, '2024-01-01', '2024-04-30', 5),
(250.00, 2, '2024-05-01', '2024-06-30', 5),
(280.00, 3, '2024-07-01', NULL, 5),
(290.00, 1, '2024-01-01', '2024-04-30', 6),
(252.00, 2, '2024-05-01', '2024-06-30', 6),
(245.00, 3, '2024-07-01', NULL, 6);

-------------------------------------------------------------------------
SELECT mc.*, bc.Name 
FROM [dbo].[ModelCar] mc
INNER JOIN [dbo].[BrandCar] bc ON mc.BrandCarId = bc.Id 
SELECT * 
FROM [dbo].[MotorType]
SELECT *
FROM [dbo].[ColorCar]

SELECT* 
FROM [dbo].[Tyre] Ty
INNER JOIN [dbo].[TyreConstructor] TC ON Ty.Id = TC.Id

SELECT* 
FROM [dbo].[TyreConstructor]

SELECT* 
FROM [dbo].[Tyre]

SELECT* 
FROM [dbo].[TyrePrice]

