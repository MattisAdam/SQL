DROP TABLE dbo.Exo1_LKP_Multilingue
DROP TABLE dbo.Exo1_LKP_Application
DROP TABLE dbo.Exo1_LKP_Resource
DROP TABLE dbo.Exo1_LKP_Langue


--------------------------------------
CREATE TABLE Exo1_LKP_Langue (
[Id] [int] IDENTITY(1,1) NOT NULL,
[LangueName][varchar] (100) NOT NULL,
PRIMARY KEY (Id),
)
GO
ALTER TABLE Exo1_LKP_Langue
ADD CONSTRAINT UK_Exo1_LKP_Langue_LangueName UNIQUE(LangueName) 
GO
--------------------------------------
CREATE TABLE Exo1_LKP_Resource (
[Id] [int] IDENTITY(1,1) NOT NULL,
[ResourceName][varchar](100) NOT NULL, 
PRIMARY KEY (Id),
)
GO
ALTER TABLE Exo1_LKP_Resource
ADD CONSTRAINT UK_Exo1_LKP_Resource_ResourceName UNIQUE(ResourceName) 
GO
--------------------------------------
CREATE TABLE Exo1_LKP_Application(
[Id] [int] IDENTITY(1,1) NOT NULL,
[ApplicationName] [varchar](100) NOT NULL,
PRIMARY KEY (Id)
)
GO
--------------------------------------
ALTER TABLE Exo1_LKP_Application
ADD CONSTRAINT UK_Exo1_LKP_Application_ApplicationName UNIQUE(ApplicationName) 
GO
--------------------------------------


CREATE TABLE Exo1_LKP_Multilingue(
[Id] [int] IDENTITY(1,1) NOT NULL,
[ApplicationId] [int] NULL,
[LangueId] [int] NOT NULL,
[ResourceId] [int] NOT NULL,
[Texte] [varchar](250) NOT NULL,
PRIMARY KEY (Id),
FOREIGN KEY (LangueId) REFERENCES Exo1_LKP_Langue(ID),
FOREIGN KEY (ResourceId) REFERENCES Exo1_LKP_Resource(ID),
FOREIGN KEY (ApplicationId) REFERENCES Exo1_LKP_Application(ID)
)
GO


ALTER TABLE Exo1_LKP_Multilingue
ADD CONSTRAINT UK_Exo1_LKP_Multilingue_ResourceId_LangueId_Texte UNIQUE(ResourceId, LangueId, Texte)

GO
--------------------------------------------
SET IDENTITY_INSERT dbo.[Exo1_LKP_Langue] ON; 
INSERT INTO [dbo].[Exo1_LKP_Langue] (Id, LangueName) VALUES
(1,'fr'),
(2,'en'),
(3,'it');
SET IDENTITY_INSERT dbo.[Exo1_LKP_Langue] OFF; 
--------------------------------------------
SET IDENTITY_INSERT dbo.[Exo1_LKP_Resource] ON; 
INSERT INTO [dbo].[Exo1_LKP_Resource] (Id, ResourceName) VALUES 
(1, 'sCancel'),
(2, 'sWelcome');
SET IDENTITY_INSERT dbo.[Exo1_LKP_Resource] OFF; 
--------------------------------------------
SET IDENTITY_INSERT dbo.[Exo1_LKP_Application] ON; 
INSERT INTO [dbo].[Exo1_LKP_Application] (Id, ApplicationName) VALUES 
(1, 'App1'),
(2, 'App2');
SET IDENTITY_INSERT dbo.[Exo1_LKP_Application] OFF; 
--------------------------------------------
DELETE FROM [dbo].[Exo1_LKP_Multilingue];
INSERT INTO [dbo].[Exo1_LKP_Multilingue] (ApplicationId, LangueId, ResourceId, Texte) Values
(NULL, 1, 1, 'Annuler'),
(1, 1, 1, 'Annuler2'),
(2, 1, 1, 'Retour en arriere'),
(NULL, 2, 1, 'Cancel'),
(1, 2, 1, 'Cancel2'),
(2, 2, 1, 'Step-back'),
(NULL, 3, 1, 'Cancella'),
(1, 3, 1, 'Cancella2'),
(2, 3, 1, 'Disdire'),
(1, 2, 2, 'Welcome inside application 1'),
(2, 2, 2, 'The world of application 2 is now open'),
(1, 1, 2, 'Bienvenue dans l’application 1'),
(2, 1, 2, 'Le monde de l’application 2 est maintenant ouvert'),
(1, 3, 2, 'Benvenuto all interno dell applicazione 1'),
(2, 3, 2, 'Il mondo del l applicazione 2 è ora aperto');

-------------------------------------------

SELECT ap.ApplicationName, la.LangueName,re.ResourceName,ml.Texte
FROM [dbo].[Exo1_LKP_Multilingue] ml
LEFT JOIN [dbo].[Exo1_LKP_Application] ap ON ml.ApplicationId = ap.Id
LEFT JOIN [dbo].[Exo1_LKP_Langue] la ON ml.LangueId = la.Id
LEFT JOIN [dbo].[Exo1_LKP_Resource] re ON ml.ResourceId = re.Id
--WHERE ApplicationId IS NULL

SELECT re.ResourceName, ml.Texte
FROM [dbo].[Exo1_LKP_Multilingue] ml
INNER JOIN [dbo].[Exo1_LKP_Resource] re ON ml.ResourceId = re.Id 



--SELECT re.ResourceName, ml.Texte
--FROM [dbo].[Exo1_LKP_Multilingue] ml
--INNER JOIN [dbo].[Exo1_LKP_Resource] re ON ml.ResourceId = re.Id
--GROUP BY re.ResourceName, ml.Texte, ml.LangueId
--HAVING COUNT(*) > 1

