Alter VIEW V_Car AS

	SELECT
		c.*,
		bc.Name AS 'Brand',
		mc.Name AS 'Model',
		mt.Name AS 'MotorType',
		cc.Color AS 'Color',
		tc.Name + ' ' + CAST(ts.Inch AS VARCHAR(MAX)) + '"' AS 'Tyre',
		--mc.Price + mt.Price + cc.Price + (t.Price * 4 / rcTyre.ValueChange) AS  'TotalPriceUSD'

	FROM [dbo].[Car] c
	INNER JOIN [dbo].[ModelCar] mc ON c.ModelCarId = mc.Id
	INNER JOIN [dbo].[BrandCar] bc ON mc.BrandCarId = bc.Id
	INNER JOIN [dbo].[MotorType] mt ON c.MotorTypeId = mt.Id
	INNER JOIN [dbo].[ColorCar] cc ON c.ColorCarId = cc.Id
	INNER JOIN [dbo].[Tyre] t ON c.TyreId = t.Id
	INNER JOIN [dbo].[TyreSize] ts ON t.TyreSizeId = ts.Id
	INNER JOIN [dbo].[TyreConstructor] tc ON t.TyreConstructorId = tc.Id
	INNER JOIN [dbo].[RateChange] rcTyre ON t.CurrencyId = rcTyre.CurrencyFromId
	
-----------------------------------------------------------------------------
SELECT * FROM V_Car 
SELECT 
	Model,
	AVG(TotalPrice) as 'AvgPrice',
	MIN(TotalPrice) as 'MinValue',
	MAX(TotalPrice) as 'MaxValue'
FROM V_Car
GROUP BY Model



-----------------------------------------------------------------------------


SELECT c.Brand, COUNT(c.Model)
FROM [dbo].[V_Car] c
GROUP BY c.Brand
--WHERE MotorTypeId = 3

SELECT * 
FROM [dbo].[ModelCar] mc
INNER JOIN [dbo].[BrandCar] bc ON mc.BrandCarId = bc.Id

SELECT Name AS 'brand'
FROM MotorType
WHERE Id IN (1, 2, 3);

SELECT BrandCar, COUNT 
FROM ColorCar
GROUP BY BrandCar;


SELECT mt.Name AS 'MotorType' , COUNT(*) AS Number
FROM [dbo].[Car] c
INNER JOIN [dbo].[MotorType] mt ON c.MotorTypeId = mt.Id
GROUP BY mt.Name


