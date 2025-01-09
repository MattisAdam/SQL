/****** Object:  UserDefinedFunction [dbo].[IsSameWeek]    Script Date: 03/01/2025 09:25:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[IsSameMonth](
	@Date1 DATETIME,
	@Date2 DATETIME
) 
RETURNS BIT   
AS
BEGIN
	DECLARE @Result AS BIT
	SET @Result = 1;

	IF (DATEPART(yy, @Date1) <> DATEPART(yy, @Date2))
		SET @Result = 0;
	IF (DATEPART(MM, @Date1) <> DATEPART(MM, @Date2))
		SET @Result = 0;

	RETURN @Result;
END
GO


