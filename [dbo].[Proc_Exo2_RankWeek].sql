/****** Object:  StoredProcedure [dbo].[Proc_Exo2]    Script Date: 02/01/2025 16:20:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[Proc_Exo2_RankWeek]

CREATE PROCEDURE [dbo].[Proc_Exo2_RankWeek]
@GameId int,
@StartDate DATETIME 

AS 
BEGIN
	WITH PlayerStats AS ( 
			SELECT 
				DATEPART(yy, gp.StartDate) AS 'Year',
				DATEPART(WW, gp.StartDate) AS 'WEEK',
				p.Id AS 'PlayerId', 
				p.FirstName AS 'PlayerName', 
				g.Name,
				COUNT(gp.Id) AS 'NbGame',
				SUM(CAST(pgp.Iswinner AS int)) AS 'NbWin',
				cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 as 'VictoryRatio',
				ISNULL(pgp.Score, 0) AS 'Score',
				CAST(RANK() OVER(ORDER BY cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 DESC) AS INT) AS 'Rank',
				[dbo].[PtsOnRank](RANK() OVER(ORDER BY cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 DESC)) AS 'Pts'

			FROM 
				[dbo].[Exo2_PlayerGamePlay] pgp 
			INNER JOIN 
				[dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
			INNER JOIN 
				[dbo].[Exo2_Game] g ON gp.GameId = g.Id
			INNER JOIN 
				[dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id
			WHERE 
				[dbo].[IsSameWeek](@StartDate,gp.StartDate) = 1
				AND 
				@GameId = gp.GameId
			GROUP BY
				DATEPART(yy, gp.StartDate),
				DATEPART(WW, gp.StartDate),
				p.Id,
				p.FirstName,
				g.Name,
				pgp.Score
	)
	
	SELECT *
	FROM PlayerStats
	ORDER BY 
	WEEK;
	
	
	END



EXEC Proc_Exo2_RankWeek 1, '2024-01-20'
