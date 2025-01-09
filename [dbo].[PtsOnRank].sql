/****** Object:  UserDefinedFunction [dbo].[IsSameMonth]    Script Date: 03/01/2025 11:09:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[PtsOnRank](
	@Rank INT
) 
RETURNS INT   
AS
BEGIN
	DECLARE @Point AS INT
	SET @Point = 0


	IF(@Rank = 1)
		SET @Point = 5;

	IF(@Rank = 2)
		SET @Point = 3;

	IF(@Rank = 3)
		SET @Point = 1;

	IF (@Rank >=4)
		SET @Point = 0;
	
	RETURN @Point;
	
END
GO


