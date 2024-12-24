/****** Object:  View [dbo].[V_Car]    Script Date: 05/12/2024 09:08:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Car] AS

	SELECT
		c.*,
		bc.Name AS 'Brand',
		mc.Name AS 'Model',
		mt.Name AS 'MotorType',
		cc.Color AS 'Color',
		tc.Name + ' ' + CAST(ts.Inch AS VARCHAR(MAX)) + '"' AS 'Tyre',
		mc.Price as 'PriceModelCar',
		mt.Price as 'PriceMotorType', 
		cc.Price as 'PriceColorCar'

	FROM [dbo].[Car] c
	INNER JOIN [dbo].[ModelCar] mc ON c.ModelCarId = mc.Id
	INNER JOIN [dbo].[BrandCar] bc ON mc.BrandCarId = bc.Id
	INNER JOIN [dbo].[MotorType] mt ON c.MotorTypeId = mt.Id
	INNER JOIN [dbo].[ColorCar] cc ON c.ColorCarId = cc.Id
	INNER JOIN [dbo].[Tyre] t ON c.TyreId = t.Id
	INNER JOIN [dbo].[TyreSize] ts ON t.TyreSizeId = ts.Id
	INNER JOIN [dbo].[TyreConstructor] tc ON t.TyreConstructorId = tc.Id
	--INNER JOIN [dbo].[RateChange] rcTyre ON t.CurrencyId = rcTyre.CurrencyFromId
GO


