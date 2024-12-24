DROP PROCEDURE GetCarWithCurrencyPrice


CREATE PROCEDURE GetCarWithCurrencyPrice
(
	@CurrencyId INT
)
AS
	SELECT 
		c.*,
		c.TotalPriceUSD * rc.ValueChange AS 'TotalPriceWithCurrency',
		cur.Name AS 'Currency'
	FROM V_Car c
	CROSS JOIN RateChange rc
	INNER JOIN Currency cur ON rc.CurrencyFromId = cur.Id
	WHERE rc.CurrencyFromId = @CurrencyId


EXEC GetCarWithCurrencyPrice 1
EXEC GetCarWithCurrencyPrice 2
EXEC GetCarWithCurrencyPrice 3