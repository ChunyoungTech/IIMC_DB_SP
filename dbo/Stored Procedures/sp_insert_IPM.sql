




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<IPM發報，庫存<6日>
-- =============================================
CREATE PROCEDURE [dbo].[sp_insert_IPM]
	@fac as varchar(50),
	@shop as varchar(50),
	@sysName as varchar(50),
	@content AS varchar(4000) 

 AS

BEGIN

INSERT INTO [dbo].[IPM_TABLE]
           ([DATA_GEN_TIME]
           ,[FAC]
           ,[SECTION]
           ,[SYSTEM]
           ,[MSG]
           ,[UPDATE_TIME])
     VALUES
           (GETDATE()
           ,@fac
           ,@shop
           ,@sysName
           ,@content
           ,NULL
		   )


END

