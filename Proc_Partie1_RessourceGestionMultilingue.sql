DROP PROCEDURE Proc_Exo1  


-----------------------------
CREATE PROCEDURE Proc_Exo1 
	@ApplicationId int, 
	@LangueId int
AS

SELECT *
	



FROM 
	[dbo].[Exo1_LKP_Multilingue] ml

inner join (

	SELECT
	MAX(ml.ApplicationId) AS ApplicationId,
	ml.LangueId,
	ml.ResourceId

	FROM 

	[dbo].[Exo1_LKP_Multilingue] ml 

	WHERE 

	((@ApplicationId = ApplicationId) OR (ApplicationId IS NULL))

	AND (LangueId = @LangueId)

	GROUP BY
	ml.ResourceId, ml.LangueId
	) ml2 ON   COALESCE(ml.ApplicationId, 0) = COALESCE(ml2.ApplicationId, 0)

	AND ml.LangueId = ml2.LangueId
	
	AND ml.ResourceId = ml2.ResourceId
	
LEFT JOIN
	[dbo].[Exo1_LKP_Application] ap ON ml.ApplicationId= ap.Id

LEFT JOIN
	[dbo].[Exo1_LKP_Langue] l on ml.LangueId = l.Id

LEFT JOIN
	[dbo].[Exo1_LKP_Resource] re ON ml.ResourceId = re.Id
---------------------------------------
EXEC Proc_Exo1 1, 1