/****** Object:  StoredProcedure [dbo].[Proc_Exo2_RankMonth]    Script Date: 09/01/2025 09:43:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[Proc_Exo2_RankMonth]
CREATE PROCEDURE [dbo].[Proc_Exo2_RankMonth]
@GameId int,
@StartDate DATETIME 

AS 

SELECT 
DATEPART(yy, gp.StartDate) AS 'Year',
DATEPART(MM, gp.StartDate) AS 'Month',
p.Id AS 'PlayerId', 
p.FirstName AS 'PlayerName', 
g.Name,
COUNT(gp.Id) AS 'NbGame',
SUM(CAST(pgp.Iswinner AS int)) AS 'NbWin',
ROUND (CAST (SUM (CAST (IsWinner AS int) ) as float) / COUNT(*)*100, -1) AS 'Victory Ratio',
ISNULL(pgp.Score, 0) AS 'Score',
CAST(RANK() OVER(ORDER BY cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 DESC) AS INT) AS 'Rank'

FROM [dbo].[Exo2_PlayerGamePlay] pgp 

INNER JOIN [dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
INNER JOIN [dbo].[Exo2_Game] g ON gp.GameId = g.Id
INNER JOIN [dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id

WHERE 
[dbo].[IsSameMonth](@StartDate,gp.StartDate) = 1
AND 
@GameId = GameId


GROUP BY
DATEPART(yy, gp.StartDate),
DATEPART(MM, gp.StartDate),
p.Id,
p.FirstName,
g.Name,
pgp.Score



ORDER BY 
RANK() OVER(ORDER BY cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 DESC),
Score DESC,
[dbo].[PtsOnRank](RANK() OVER(ORDER BY cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 DESC));

GO

EXEC [dbo].[Proc_Exo2_RankMonth] 4,'2024-02-11'
