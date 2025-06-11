




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<MAPP發報，MappMessage資料sent [INX_WorkCheckingDB2].[dbo].[MappMessage]>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MappMessage_SENT]
 AS

BEGIN

INSERT INTO [INX_WorkCheckingDB2].[dbo].[MappMessage]
           ([MS_SYS_NAME]
           ,[MM_CONTENT_TYPE]
           ,[MM_TEXT_CONTENT]
           ,[MM_MEDIA_CONTENT]
           ,[MM_FILE_SHOW_NAME]
           ,[MM_SENDED_FLAG]
           ,[UPDATE_USER]
           ,[UPDATE_TIME]
           ,[MM_TYPE]
           ,[MM_SendToOA]
           ,[MM_SyncFromOA]
           ,[MM_subject]
           ,[MM_ExtFileName]
           ,[MM_TRANS_NAME])
SELECT [MS_SYS_NAME]
      ,[MM_CONTENT_TYPE]
      ,[MM_TEXT_CONTENT]
      ,[MM_MEDIA_CONTENT]
      ,[MM_FILE_SHOW_NAME]
      ,'N'
      ,[UPDATE_USER]
      ,[UPDATE_TIME]
      ,[MM_TYPE]
      ,[MM_SendToOA]
      ,[MM_SyncFromOA]
      ,[MM_subject]
      ,[MM_ExtFileName]
      ,[MM_TRANS_NAME]
  FROM [dbo].[MappMessage]
  WHERE [MM_FLAG]='N' 

  UPDATE [dbo].[MappMessage] SET [MM_FLAG]='Y'  WHERE [MM_FLAG]='N'

END

