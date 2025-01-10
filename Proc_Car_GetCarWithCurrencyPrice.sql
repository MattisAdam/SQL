/****** Object:  StoredProcedure [dbo].[GetCarWithCurrencyPrice]    Script Date: 05/12/2024 11:00:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[GetCarWithCurrencyPrice]

GO
-------------------------------
CREATE PROCEDURE [dbo].[GetCarWithCurrencyPrice]
(
	@CurrencyId INT,
	@DatePrice DATETIME
)
AS
	DECLARE @CurrencyName VARCHAR(MAX)

	SELECT @CurrencyName = Name FROM [dbo].[Currency] WHERE Id = @CurrencyId

	SELECT 
		bc.Name AS 'Brand',
		mc.Name AS 'Model',
		mt.Name AS 'MotorType',
		cc.Color AS 'Color',
		tc.Name + ' ' + CAST(ts.Inch AS VARCHAR(MAX)) + '"' AS 'Tyre',
		dbo.ConvertPrice(cc.Price, cc.CurrencyId, @CurrencyId) + dbo.ConvertPrice(mc.Price, mc.CurrencyId, @CurrencyId) + dbo.ConvertPrice(mt.Price, mt.CurrencyId, @CurrencyId) + (dbo.ConvertPrice(tp.Price, tp.CurrencyId, @CurrencyId) * 4) AS 'TotalPrice',
		@CurrencyName AS 'Currency'
	FROM [dbo].[Car] c
		INNER JOIN [dbo].[ModelCar] mc ON c.ModelCarId = mc.Id
		INNER JOIN [dbo].[BrandCar] bc ON mc.BrandCarId = bc.Id
		INNER JOIN [dbo].[MotorType] mt ON c.MotorTypeId = mt.Id
		INNER JOIN [dbo].[ColorCar] cc ON c.ColorCarId = cc.Id
		INNER JOIN [dbo].[Tyre] t ON c.TyreId = t.Id
		INNER JOIN [dbo].[TyreSize] ts ON t.TyreSizeId = ts.Id
		INNER JOIN [dbo].[TyreConstructor] tc ON t.TyreConstructorId = tc.Id
		INNER JOIN [dbo].[TyrePrice] tp ON t.Id = tp.TyreId
	WHERE
		tp.StartDate <= @DatePrice AND (tp.EndDate >= @DatePrice OR tp.EndDate IS NULL)
GO

-------------------------------

EXEC [dbo].[GetCarWithCurrencyPrice] 3, '2024-06-01'