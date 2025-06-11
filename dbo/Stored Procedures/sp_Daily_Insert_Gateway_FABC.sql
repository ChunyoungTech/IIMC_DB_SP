


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 抓取Gateway
-- =============================================
Create PROCEDURE [dbo].[sp_Daily_Insert_Gateway_FABC]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';

	BEGIN TRY
		
		INSERT INTO [dbo].[CIC_TABLE]
				([UPDATETIME]
				,[I_Date]
				,[I_Time]
				,[I_Plant]
				,[I_Tag]
				,[I_Value])
		SELECT [UPDATETIME]
			,[I_Date]
			,[I_Time]
			,[I_Plant]
			,[I_Tag]
			,[I_Value]
		FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] WHERE UPLOAD_FLAG='N'

		UPDATE  [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] 
		SET UPLOAD_FLAG='Y'
		WHERE UPLOAD_FLAG='N'

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Daily_Insert_Gateway_FABC','Gateway抓取作業異常',@strError,getdate())
	END CATCH 
	
END

