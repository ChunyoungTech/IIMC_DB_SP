


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每日上午00:10自動執行(地磅收值)
-- =============================================
CREATE PROCEDURE [dbo].[sp_Daily_Insert_Filling_Data]
@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	SET NOCOUNT ON;
	--DECLARE @CalcDate DATE=''
	DECLARE @strError nvarchar(max)='';
	DECLARE @StartDate DATE

	IF (@CalcDate='')
	BEGIN
		SET @StartDate =   CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111)
	END
	ELSE
	BEGIN
		SET @StartDate=@CalcDate
	END

	DECLARE @SDATE AS nvarchar(10)=CONVERT(varchar(4),YEAR(@StartDate))+'/'+RIGHT(REPLICATE('0',2)+CONVERT(varchar(2),MONTH(@StartDate)),2)+'/'+RIGHT(REPLICATE('0',2)+ CONVERT(varchar(2),DAY(@StartDate)),2)

	SELECT @SDATE

	/* 抓取二廠GATEWAY 資料(測試期間用) */
	/*
	Truncate Table [dbo].[CIC_TABLE]

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
	FROM [10.55.212.228,6060].[INX_CIC].[dbo].[CIC_TABLE]

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
	FROM [10.53.211.100,6060].[INX_CIC].[dbo].[CIC_TABLE]

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
	FROM [10.54.171.151,6060].[INX_IIMC].[dbo].[CIC_TABLE]
	*/

	/* 抓取地磅資料 */

	BEGIN TRY

		Truncate Table [dbo].[LOCAL_LIST]

		INSERT INTO [dbo].[LOCAL_LIST]
				   ([LIST_NO]
				   ,[ASN_NO]
				   ,[MATNO]
				   ,[MATNONAME]
				   ,[INXUNIT]
				   ,[PLANT]
				   ,[VENDORCODE]
				   ,[VENDORNAME]
				   ,[CARCOMPNO]
				   ,[CARCOMPNAME]
				   ,[CAR_NO]
				   ,[NET_WEIGHT]
				   ,[IN_WEIGHT]
				   ,[OUT_WEIGHT]
				   ,[IN_TIME]
				   ,[OUT_TIME]
				   ,[DATE]
				   ,[OUT_DATE])
			 SELECT [LIST_NO]
			  ,[ASN_NO]
			  ,[MATNO]
			  ,[MATNONAME]
			  ,[INXUNIT]
			  ,[PLANT]
			  ,[VENDORCODE]
			  ,[VENDORNAME]
			  ,[CARCOMPNO]
			  ,[CARCOMPNAME]
			  ,[CAR_NO]
			  ,[NET_WEIGHT]
			  ,[IN_WEIGHT]
			  ,[OUT_WEIGHT]
			  ,[IN_TIME]
			  ,[OUT_TIME]
			  ,[DATE]
			  ,[OUT_DATE]
		  FROM [C4C019404].[master].[dbo].[LOCAL_LIST]

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Daily_Insert_Filling_Data','地磅收值異常',@strError,getdate())
	END CATCH 


	/* 填入充填量(透過(充填料號維護)做自動充填) */
	
	BEGIN TRY
		
		UPDATE MT SET M_FillingQty=LL.NET_WEIGHT
		FROM Material_Table MT INNER JOIN Material_Base_Data MB ON MT.MB_SEQ_ID=MB.MB_Seq_ID
		INNER JOIN Fill_Mapping FM ON FM.MB_SEQ_ID=MB.MB_Seq_ID
		INNER JOIN LOCAL_LIST LL ON FM.INXUNIT=LL.INXUNIT AND FM.MATNONAME=LL.MATNONAME AND FM.PLANT=LL.PLANT AND LL.DATE=@SDATE
		WHERE LL.NET_WEIGHT<>'(null)' AND M_Date=LL.DATE

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Daily_Insert_Filling_Data','自動充填量作業異常',@strError,getdate())
	END CATCH 
	

	/* 填入充填量(透過ASN碼串地磅) */
	
	BEGIN TRY
		
		UPDATE [Material_Table] SET M_FillingQty=NET_WEIGHT
		--SELECT *
		FROM [Material_Table] MT INNER JOIN(

			SELECT S6.MB_Seq_ID,S1.NET_WEIGHT FROM (
				SELECT * FROM [INX_CIC].[dbo].[LOCAL_LIST] WHERE [DATE]=@SDATE AND [ASN_NO]<>'(null)' AND [NET_WEIGHT]<>'(null)'
			)S1 INNER JOIN (
				SELECT * FROM [dbo].[SDP_VW_SRM_CALLED_ORDERS_GCIC]
			)S2 ON S1.ASN_NO=S2.ASN INNER JOIN (
				SELECT * FROM [dbo].[SDP_Order_Master]
			)S3 ON S2.CALLED_NO=S3.SOM_SDP_NO INNER JOIN(
				SELECT * FROM [dbo].[Inventory_BaseData]
			)S4 ON S3.IBD_SEQ_ID=S4.IBD_SEQ_ID INNER JOIN(
				SELECT * FROM [dbo].[SDP_Base_Org]
			)S5 ON S4.IBD_PLANT=S5.SBO_PLANT INNER JOIN(
				SELECT * FROM [dbo].[Material_Base_Data]
			)S6 ON S5.SBO_PLANT2=S6.MB_Plant AND S4.IBD_SHOP=S6.MB_Shop AND S4.IBD_SYSTEM=S6.MB_Sysname AND S4.IBD_MATERIAL=S6.MB_CName


		)SS ON MT.MB_SEQ_ID=SS.MB_Seq_ID AND MT.M_Date=@SDATE


	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_Daily_Insert_Filling_Data','ASN自動充填量作業異常',@strError,getdate())
	END CATCH 
	

END

