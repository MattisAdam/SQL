CREATE TABLE Car2(
	[Id] [int] IDENTITY(1, 1) NOT NULL,
	[MotorTypeId] [int] NOT NULL,
	[ColorCarId] [int] NOT NULL,
	[ModelCarId] [int] NOT NULL,
	[TyreId] [int] NOT NULL,
	PRIMARY KEY (Id)
	)

ALTER TABLE Car2 ADD CONSTRAINT UK_ColorCarId UNIQUE (ColorCarId)

SELECT * FROM Car2