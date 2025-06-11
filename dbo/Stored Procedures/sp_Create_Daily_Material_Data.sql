-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 產生每日用量主檔。每日凌晨12:05自動執行
-- =============================================
CREATE PROCEDURE [dbo].[sp_Create_Daily_Material_Data]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	DECLARE @strError nvarchar(max)='';
	DECLARE @StartDate DATE
	DECLARE @EndDate DATE

	IF (@CalcDate='') SET @CalcDate = GETDATE()--如有指定日期，則以指定日期計算，否則已系統當日日期計算

	SET @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,@CalcDate),111)
	SET @EndDate = CONVERT(VARCHAR(10),@CalcDate,111)
	

	/* 產生每日用量主檔 */
	
	BEGIN TRY
	INSERT INTO Material_Table (M_Date,MB_SEQ_ID,M_HiLimit,M_LoLimit,M_UPDATE_USER,M_UPDATE_TIME,M_TotalTransferPara,M_WeightTransferPara,M_UnitTransferPara,M_Price)
		SELECT  @EndDate,MB_Seq_ID,MB_HiLimit,MB_LoLimit,'SYSTEM'	,GETDATE()		,Mb_TotalTransferPara,Mb_WeightTransferPara,MB_UnitTransferPara,MB_Price
		FROM Material_Base_Data
	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Create_Daily_Material_Data','產生每日用量主檔',@strError,getdate())
	END CATCH 

	/* 產生rowdata主檔 */
	
	BEGIN TRY
		INSERT INTO [dbo].[IDMC_TABLE]
           ([I_Date],[I_Time],[I_Type],[I_Plant],[I_Shop],[I_Sysname],[I_CName],[I_Tag1],[I_Value1],[I_Tag2],[I_Value2],[I_Tag3],[I_Value3],[I_Tag4],[I_Value4],[I_Tag5],[I_Value5],[M_SEQ_ID])
		SELECT @EndDate,'00:00:00','S',[I_Plant],[I_Shop],[I_Sysname],[I_CName],[I_Tag1],[I_Value1],[I_Tag2],[I_Value2],[I_Tag3],[I_Value3],[I_Tag4],[I_Value4],[I_Tag5],[I_Value5],0
		FROM [dbo].[CIC_BASE_TABLE]
	
	
		INSERT INTO [dbo].[IDMC_TABLE]
           ([I_Date],[I_Time],[I_Type],[I_Plant],[I_Shop],[I_Sysname],[I_CName],[I_Tag1],[I_Value1],[I_Tag2],[I_Value2],[I_Tag3],[I_Value3],[I_Tag4],[I_Value4],[I_Tag5],[I_Value5],[M_SEQ_ID])
		SELECT @EndDate,'00:00:00','E',[I_Plant],[I_Shop],[I_Sysname],[I_CName],[I_Tag1],[I_Value1],[I_Tag2],[I_Value2],[I_Tag3],[I_Value3],[I_Tag4],[I_Value4],[I_Tag5],[I_Value5],0
		FROM [dbo].[CIC_BASE_TABLE]

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Create_Daily_Material_Data','產生rowdata主檔',@strError,getdate())
	END CATCH 

	/* 產生[M_SEQ_ID] */
	
	BEGIN TRY

		UPDATE [IDMC_TABLE] SET M_SEQ_ID=C.M_SEQ_ID
		FROM [IDMC_TABLE] A 
			INNER JOIN Material_Base_Data b on a.I_CNAME=b.Mb_CNAME AND a.[I_Plant]=b.mb_plant AND a.I_Shop=b.mb_shop AND a.I_Sysname=b.MB_Sysname
			INNER JOIN Material_Table C ON B.MB_Seq_ID=C.MB_SEQ_ID AND C.M_Date = @StartDate
		WHERE (A.I_Date=@StartDate AND A.I_Type='S') 
	
	
		UPDATE [IDMC_TABLE] SET M_SEQ_ID=C.M_SEQ_ID
		FROM [IDMC_TABLE] A 
			INNER JOIN Material_Base_Data b on a.I_CNAME=b.Mb_CNAME AND a.[I_Plant]=b.mb_plant AND a.I_Shop=b.mb_shop AND a.I_Sysname=b.MB_Sysname
			INNER JOIN Material_Table C ON B.MB_Seq_ID=C.MB_SEQ_ID AND C.M_Date = @StartDate
		WHERE (A.I_Date=@EndDate   AND A.I_Type='E')

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Create_Daily_Material_Data','產生[M_SEQ_ID]',@strError,getdate())
	END CATCH 

	/* 寫入預設數值，虛擬點位由 CIC_BASE_TABLE 產生，這裡只寫入預設值 */

	update i set i.I_Value1=tm.TM_TAG_DEFAULT
	from [IDMC_TABLE] i inner join TAG_MAPPING tm on i.I_Tag1=tm.TM_TAG_NAME and tm.TM_TYPE_OF in(1,2) where i.I_Date=@EndDate

	update i set i.I_Value2=tm.TM_TAG_DEFAULT
	from [IDMC_TABLE] i inner join TAG_MAPPING tm on i.I_Tag2=tm.TM_TAG_NAME and tm.TM_TYPE_OF in(1,2) where i.I_Date=@EndDate

	update i set i.I_Value3=tm.TM_TAG_DEFAULT
	from [IDMC_TABLE] i inner join TAG_MAPPING tm on i.I_Tag3=tm.TM_TAG_NAME and tm.TM_TYPE_OF in(1,2) where i.I_Date=@EndDate
	
	update i set i.I_Value4=tm.TM_TAG_DEFAULT
	from [IDMC_TABLE] i inner join TAG_MAPPING tm on i.I_Tag4=tm.TM_TAG_NAME and tm.TM_TYPE_OF in(1,2) where i.I_Date=@EndDate

	update i set i.I_Value5=tm.TM_TAG_DEFAULT
	from [IDMC_TABLE] i inner join TAG_MAPPING tm on i.I_Tag5=tm.TM_TAG_NAME and tm.TM_TYPE_OF in(1,2) where i.I_Date=@EndDate

END

