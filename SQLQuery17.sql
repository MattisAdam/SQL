SELECT TOP (1000) [Id]
      ,[MotorTypeId]
      ,[ColorCarId]
      ,[ModelCarId]
      ,[TyreId]
  FROM [dbo].[Car]

  DELETE FROM Car WHERE MotorTypeId = 4
  DELETE FROM [dbo].[MotorType] WHERE Id = 4