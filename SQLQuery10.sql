CREATE FUNCTION ConvertPrice(
	@Price DECIMAL(18,3),
	@FromCurrencyId INT,
	@ToCurrencyId INT
) 
RETURNS DECIMAL(18,3)   
AS
BEGIN
	DECLARE @rateFrom DECIMAL(18,3)
	DECLARE @rateTo DECIMAL(18,3)
	SELECT @rateFrom = ValueChange FROM [dbo].[RateChange] WHERE CurrencyFromId = @FromCurrencyId
	SELECT @rateTo = ValueChange FROM [dbo].[RateChange] WHERE CurrencyFromId = @ToCurrencyId

	RETURN @Price * @rateTo / @rateFrom;
END

GO

SELECT dbo.ConvertPrice(100,2,3)