/****** Object:  StoredProcedure [dbo].[Proc_Exo2_RankWeek]    Script Date: 09/01/2025 11:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[Proc_Exo2_RankWeek]
CREATE PROCEDURE [dbo].[Proc_Exo2_RankWeek]
@GameId int,
@StartDate DATETIME 
AS 
SELECT 
	DATEPART(MM,@StartDate) AS 'Month',
	DATEPART(YY, @StartDate) AS 'Year',
	y.Game AS 'Game',
	y.Player AS 'Player',
	SUM(y.NBPoint) AS 'Pts'
FROM (
	SELECT
	*,
	RANK()OVER(PARTITION BY x.Week ORDER BY x.VictoryRatio DESC) Rank,
	[dbo].[PtsOnRank](RANK()OVER(PARTITION BY x.Week ORDER BY  x.VictoryRatio DESC)) AS 'NBPoint'
	FROM (
		SELECT 
			DATEPART(YY , MAX(gp.StartDate)) AS 'Year',
			DATEPART(WW, MAX(gp.StartDate)) AS 'Week',
			pgp.PlayerId,
			MAX(p.FirstName) as 'Player',
			MAX(g.Name) as 'Game',
			COUNT(pgp.GamePlayId) AS 'NbGame',
			SUM(CAST(pgp.Iswinner AS int)) AS 'NbWin',
			cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 as 'VictoryRatio'
		FROM 
			Exo2_PlayerGamePlay pgp
			INNER JOIN [dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id
			INNER JOIN [dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
			INNER JOIN [dbo].[Exo2_Game] g ON gp.GameId = g.Id
		WHERE 
			g.Id = @GameId
			AND dbo.IsSameMonth(gp.StartDate, @StartDate) = 1
		GROUP BY 
			pgp.PlayerId,
			DATEPART(WW,gp.StartDate)
		)x
) y
GROUP BY 
	y.Game,
	y.Player
ORDER BY
SUM(y.NBPoint) DESC 
GO

--------------------------------------------------------
EXEC [dbo].[Proc_Exo2_RankWeek] 4, '2024-02-20'

--------------------------------------------------------

DECLARE @GameId AS INT
DECLARE @StartDate AS DATE
SET @GameId = 4;
SET @StartDate = '2024-02-20'

SELECT 
	*
FROM (
	SELECT
	*,
	DENSE_RANK()OVER(PARTITION BY x.Week ORDER BY x.VictoryRatio DESC) Rank,
	[dbo].[PtsOnRank](DENSE_RANK()OVER(PARTITION BY x.Week ORDER BY  x.VictoryRatio DESC)) AS 'NBPoint'
	FROM (
		SELECT 
			DATEPART(YY , MAX(gp.StartDate)) AS 'Year',
			DATEPART(WW, MAX(gp.StartDate)) AS 'Week',
			pgp.PlayerId,
			MAX(p.FirstName) as 'Player',
			MAX(g.Name) as 'Game',
			COUNT(pgp.GamePlayId) AS 'NbGame',
			SUM(CAST(pgp.Iswinner AS int)) AS 'NbWin',
			cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 as 'VictoryRatio'
		FROM 
			Exo2_PlayerGamePlay pgp
			INNER JOIN [dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id
			INNER JOIN [dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
			INNER JOIN [dbo].[Exo2_Game] g ON gp.GameId = g.Id
		WHERE 
			g.Id = @GameId
			AND dbo.IsSameMonth(gp.StartDate, @StartDate) = 1
		GROUP BY 
			pgp.PlayerId,
			DATEPART(WW,gp.StartDate)
		)x
) y
GROUP BY 
	y.Game,
	y.Player
ORDER BY
SUM(y.NBPoint) DESC 
GO
