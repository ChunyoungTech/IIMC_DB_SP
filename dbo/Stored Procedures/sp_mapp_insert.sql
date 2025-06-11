


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<MAPP發報，庫存<6日>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_insert]
	@group as varchar(50),
	@content AS varchar(4000) 
 AS

BEGIN

INSERT INTO [dbo].[MappMessage]
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
		values(
			@group,
			1,
			@Content,
			NULL,
			NULL,
			'Y',
			NULL,
			GETDATE(),
			'A',
			NULL,
			NULL,
			'IIMC間材智能中心',
			NULL,
			NULL
			)
END

