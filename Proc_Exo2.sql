DROP PROCEDURE Proc_Exo2

CREATE PROCEDURE Proc_Exo2
@GameId int,
@StartDate DATETIME 

AS 

SELECT 
MAX(p.FirstName) AS 'Name', 
MAX(g.Name) AS 'Game',
COUNT(*) AS 'NbGame', 
SUM(CAST(IsWinner AS int)) AS 'NbWin',
cast(SUM(CAST(IsWinner AS int)) as float) /COUNT(*)*100 as 'VictoryRatio'


FROM [dbo].[Exo2_PlayerGamePlay] pgp

LEFT JOIN [dbo].[Exo2_GamePlay] gp ON pgp.GamePlayId = gp.Id
LEFT JOIN [dbo].[Exo2_Game] g ON gp.GameId = g.Id
INNER JOIN  [dbo].[Exo2_Player] p ON pgp.PlayerId = p.Id

WHERE 
(g.Id = @GameId)
AND 
dbo.IsSameWeek(@StartDate, gp.StartDate) = 1

GROUP BY 
PlayerId
------------------------------------------------------


EXEC Proc_Exo2  4, '2024-02-19'