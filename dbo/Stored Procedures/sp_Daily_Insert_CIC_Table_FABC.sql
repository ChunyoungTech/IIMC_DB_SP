



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每日上午07:10自動執行(收值)  [10.55.212.228,6060].[dbo].[CIC_TABLE]
-- =============================================
CREATE PROCEDURE [dbo].[sp_Daily_Insert_CIC_Table_FABC]
 @CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';
	--DECLARE @CalcDate AS DATE=''

	IF (@CalcDate='')
	BEGIN
		SET @CalcDate =  CONVERT(VARCHAR(10),GETDATE(),111)
	END;	

	--select 	  @CalcDate
	--[FAB7 GATEWAY 收值]
	BEGIN TRY

		update A set A.[I_VALUE1]=t.[I_Value]
		FROM [dbo].[idmc_TABLE] A INNER JOIN  (SELECT * FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] WHERE I_Date=@CalcDate ) t ON A.[I_Tag1]=t.I_Tag AND A.i_date=t.I_Date
		
		update A set A.[I_VALUE2]=t.[I_Value]
		FROM [dbo].[idmc_TABLE] A INNER JOIN  (SELECT * FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] WHERE I_Date=@CalcDate ) t ON A.[I_Tag2]=t.I_Tag AND A.i_date=t.I_Date

		update A set A.[I_VALUE3]=t.[I_Value]
		FROM [dbo].[idmc_TABLE] A INNER JOIN  (SELECT * FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] WHERE I_Date=@CalcDate ) t ON A.[I_Tag3]=t.I_Tag AND A.i_date=t.I_Date

		update A set A.[I_VALUE4]=t.[I_Value]
		FROM [dbo].[idmc_TABLE] A INNER JOIN  (SELECT * FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] WHERE I_Date=@CalcDate ) t ON A.[I_Tag4]=t.I_Tag AND A.i_date=t.I_Date

		update A set A.[I_VALUE5]=t.[I_Value]
		FROM [dbo].[idmc_TABLE] A INNER JOIN  (SELECT * FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE] WHERE I_Date=@CalcDate ) t ON A.[I_Tag5]=t.I_Tag AND A.i_date=t.I_Date
		

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Daily_Insert_CIC_Table_FABC','LCM廠gateway收值異常',@strError,getdate())
	END CATCH 
END

