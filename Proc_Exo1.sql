DROP PROCEDURE Proc_Exo1  


-----------------------------
CREATE PROCEDURE Proc_Exo1 @ApplicationId int, @Langue nvarchar (250)
AS






SELECT ap.ApplicationName, la.LangueName,re.ResourceName,ml.Texte
FROM [dbo].[Exo1_LKP_Multilingue] ml
LEFT JOIN [dbo].[Exo1_LKP_Application] ap ON ml.ApplicationId = ap.Id
LEFT JOIN [dbo].[Exo1_LKP_Langue] la ON ml.LangueId = la.Id
LEFT JOIN [dbo].[Exo1_LKP_Resource] re ON ml.ResourceId = re.Id
WHERE (@ApplicationId is NOT NULL ANd ApplicationId = @ApplicationId) OR (@ApplicationId is  NULL ANd ApplicationId IS NULL)

---------------------------------------



EXEC Proc_Exo1 1, 'fr'