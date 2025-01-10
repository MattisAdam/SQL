DROP TABLE [dbo].[Exo1_RateChange]
DROP TABLE [dbo].[Exo1_Car]
DROP TABLE [dbo].[Exo1_TyrePrice]
DROP TABLE [dbo].[Exo1_Tyre]
DROP TABLE [dbo].[Exo1_LKP_TyreSize]
DROP TABLE [dbo].[Exo1_LKP_TyreConstructor]
DROP TABLE [dbo].[Exo1_ModelCar]
DROP TABLE [dbo].[Exo1_LKP_BrandCar]
DROP TABLE [dbo].[Exo1_ColorCar]
DROP TABLE [dbo].[Exo1_LKP_MotorType]
DROP TABLE [dbo].[Exo1_LKP_Currency]
-------------------------------------------------
CREATE TABLE dbo.Exo1_LKP_Currency(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar] (max)  NOT NULL, 
	PRIMARY KEY (Id)
	)
-------------------------------------------------
CREATE TABLE dbo.Exo1_LKP_MotorType(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL, 
	[Price] [decimal] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_MotorType_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES [dbo].[Exo1_LKP_Currency](Id)
	)
-------------------------------------------------
CREATE TABLE dbo.Exo1_ColorCar(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Color] [varchar](max) NOT NULL, 
	[Price] [decimal] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_ColorCar_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES [dbo].[Exo1_LKP_Currency](Id)
	)
---------------------------------------------
CREATE TABLE dbo.Exo1_LKP_BrandCar(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	PRIMARY KEY (Id),
	)
------------------------------------------------------
CREATE TABLE dbo.Exo1_ModelCar(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[BrandCarId] [int] NOT NULL,
	[Price] [decimal] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_ModelCar_BrandCarId FOREIGN KEY (BrandCarId) REFERENCES [dbo].[Exo1_LKP_BrandCar](Id),
	CONSTRAINT FK_Modelcar_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES [dbo].[Exo1_LKP_Currency](Id)
	)
----------------------------------------------------------
CREATE TABLE dbo.Exo1_LKP_TyreConstructor(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	PRIMARY KEY (Id),
	)
----------------------------------------------------------
CREATE TABLE dbo.Exo1_LKP_TyreSize(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[Inch] [int] NOT NULL,
	PRIMARY KEY (Id),
	)
----------------------------------------------------------
CREATE TABLE dbo.Exo1_Tyre(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[TyreSizeId] [int] NOT NULL,
	[TyreConstructorId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Tyre_TyreSizeId FOREIGN KEY (TyreSizeId) REFERENCES [dbo].[Exo1_LKP_TyreSize](Id),
	CONSTRAINT FK_Tyre_TyreConstructorId FOREIGN KEY (TyreConstructorId) REFERENCES [dbo].[Exo1_LKP_TyreConstructor](Id)
	)
----------------------------------------------------------
CREATE TABLE dbo.Exo1_TyrePrice (
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[Price] [decimal] (5,2) NOT NULL, 
	[StartDate] [datetime2] NOT NULL,
	[EndDate] [datetime2] NULL,
	[TyreId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_TyrePrice_CurrencyId FOREIGN KEY (CurrencyId) REFERENCES [dbo].[Exo1_LKP_Currency](Id),
	CONSTRAINT FK_TyrePrice_TyreId FOREIGN KEY (TyreId) REFERENCES [dbo].[Exo1_Tyre](Id),
	)
-----------------------------------------------------------------------------
CREATE TABLE dbo.Exo1_Car(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[MotorTypeId] [int] NOT NULL,
	[ColorCarId] [int] NOT NULL,
	[ModelCarId] [int] NOT NULL,
	[TyreId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Car_MotorTypeId FOREIGN KEY (MotorTypeId) REFERENCES [dbo].[Exo1_LKP_MotorType](Id),
	CONSTRAINT FK_Car_ColorCarId FOREIGN KEY (ColorCarId) REFERENCES [dbo].[Exo1_ColorCar](Id),
	CONSTRAINT FK_Car_ModelCarId FOREIGN KEY (ModelCarId) REFERENCES [dbo].[Exo1_ModelCar](Id),
	CONSTRAINT FK_Car_TyreId FOREIGN KEY (TyreId) REFERENCES [dbo].[Exo1_Tyre](Id)
	)
-----------------------------------------------------------------------------
CREATE TABLE dbo.Exo1_RateChange(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[ValueChange] [decimal](18,3) NOT NULL,
	[CurrencyToId] [int] NOT NULL,
	[CurrencyFromId] [int] NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_RateChange_CurrencyToId FOREIGN KEY (CurrencyToId) REFERENCES [dbo].[Exo1_LKP_Currency](Id),
	CONSTRAINT FK_RateChange_CurrencyFromId FOREIGN KEY (CurrencyFromId) REFERENCES [dbo].[Exo1_LKP_Currency](Id)
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




INSERT INTO [dbo].[Exo1_LKP_Currency](Name) VALUES
('USD'),
('EUR'),
('CHF');

INSERT INTO  [dbo].[Exo1_LKP_BrandCar](Name) VALUES 
('Ferrari'),
('Peugeot'),
('Renault'),
('Citroen');
GO

INSERT INTO [dbo].[Exo1_ModelCar](Name, BrandCarId, Price, CurrencyId) VALUES 
('Enzo', 1, 150000, 1),
('205', 2, 12300, 2),
('C3', 4, 13400, 3),
('Laguna', 3, 18600, 1);
GO

INSERT INTO [dbo].[Exo1_LKP_MotorType](Name, Price, CurrencyId) VALUES
('Essence', 1000.0, 1), 
('Diesel', 1200.0, 1),
('Hybride', 1500.0, 2),
('Electrique', 2000.0, 3);
GO

INSERT INTO [dbo].[Exo1_ColorCar](Color, Price, CurrencyId) VALUES
('Blanc', 0.0, 2), 
('Noir', 400.0, 3),
('Rouge', 400.0, 3),
('Bleu', 400.0, 2),
('Gris métallisé', 600.0, 1);
GO

INSERT INTO [dbo].[Exo1_LKP_TyreConstructor] (Name) VALUES 
('Michelin'),
('Goodyear'),
('Continental');
GO

INSERT INTO [dbo].[Exo1_LKP_TyreSize] (Inch) VALUES
('15'),
('16');
GO



INSERT INTO [dbo].[Exo1_Tyre] (TyreConstructorId, TyreSizeId) VALUES 
(1,1),
(1,2),
(2,1),
(2,2),
(3,1),
(3,2)

INSERT INTO [dbo].[Exo1_Car] (ModelCarId, MotorTypeId, ColorCarId, TyreId) VALUES 
(1, 4, 1, 1),
(1, 3, 3, 6),
(1, 1, 4, 5),
(2, 2, 4, 4),
(3, 4, 2, 3),
(2, 1, 2, 3),
(3, 3, 5, 2);



INSERT INTO [dbo].[Exo1_RateChange] (ValueChange, CurrencyToId, CurrencyFromId) VALUES
(1.00, 1, 1),
(0.95, 1, 2),
(0.88, 1, 3);


INSERT INTO [dbo].[Exo1_TyrePrice](Price, CurrencyId, StartDate, EndDate,TyreId) VALUES
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
SELECT 
*
FROM 

[dbo].[Exo1_Car]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_ColorCar]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_LKP_BrandCar]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_LKP_Currency]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_LKP_MotorType]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_LKP_TyreConstructor]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_LKP_TyreSize]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_ModelCar]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_RateChange]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_Tyre]
-------------------------------------------------------------------------
SELECT 
*
FROM 
[dbo].[Exo1_TyrePrice]
-------------------------------------------------------------------------
