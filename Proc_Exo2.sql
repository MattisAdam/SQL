DROP PROCEDURE Proc_Exo2

CREATE PROCEDURE Proc_Exo2
@GameId int,
@StartDate DATETIME 

AS 

SELECT 
DATEPART(yy, gp.StartDate) AS 'Year',
DATEPART(WW, gp.StartDate) AS 'WEEK',
p.Id AS 'PlayerId', 
p.FirstName AS 'PlayerName', 
g.Name,
COUNT(gp.Id) AS 'NbGame',
SUM(CAST(pgp.Iswinner AS int)) AS 'NbWin',
cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 as 'VictoryRatio',
RANK() OVER(PARTITION BY p.FirstName ORDER BY (cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100) DESC) RANK
 
FROM [dbo].[Exo2_PlayerGamePlay] pgp 

INNER JOIN [dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
INNER JOIN [dbo].[Exo2_Game] g ON gp.GameId = g.Id
INNER JOIN [dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id

WHERE 
[dbo].[IsSameWeek](@StartDate,gp.StartDate) = 1


GROUP BY
DATEPART(yy, gp.StartDate),
DATEPART(WW, gp.StartDate),
p.Id,
p.FirstName,
g.Name


ORDER BY 
p.FirstName,
RANK


------------------------------------------------------


EXEC Proc_Exo2  3, '2024-02-19'