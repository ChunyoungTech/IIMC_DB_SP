



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	每日執行，判斷下次入料日期，預測幾日後入料=(今日液位-安全庫存)/平均用量
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoOrderAdd]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CalcDate AS DATE=GETDATE()
	DECLARE @FILL TABLE(IBD_SEQ_ID INT,FILLDATE DATE)
	--SELECT @CalcDate

	/* 刪除先前預測 */
	DELETE [dbo].[SDP_Order_Master] WHERE [SOM_STATUS]='TEMP'

	;WITH LatestData AS (
		SELECT IBD_SEQ_ID,
			@CalcDate [date],
			CAST(IDD_ONLINE_INVENTORY_AMT AS DECIMAL(18, 2)) AS IDD_ONLINE_INVENTORY_AMT,
			CAST(IBD_BOOKING_LIMIT AS DECIMAL(18, 2)) AS IBD_BOOKING_LIMIT,
			CAST(IBD_FEED_AMT AS DECIMAL(18, 2)) AS IBD_FEED_AMT,
			CAST(IDD_CLAC_AVG AS DECIMAL(18, 2)) AS IDD_CLAC_AVG
		FROM FUN_Inventory_DailyData_List('FABC',@CalcDate) WHERE IBD_AUTO_ORDER='N'
	),
		Forecast AS (
			-- Anchor (第一天)
			SELECT IBD_SEQ_ID,
				CAST(DATEADD(DAY, 1, [date]) AS DATE) AS forecast_date,
				CAST(
					CASE 
						WHEN IDD_ONLINE_INVENTORY_AMT - IDD_CLAC_AVG < IBD_BOOKING_LIMIT
						THEN IDD_ONLINE_INVENTORY_AMT - IDD_CLAC_AVG + IBD_FEED_AMT
						ELSE IDD_ONLINE_INVENTORY_AMT - IDD_CLAC_AVG
					END AS DECIMAL(18, 2)
				) AS inventory,
				IBD_BOOKING_LIMIT,
				IBD_FEED_AMT,
				IDD_CLAC_AVG,
				CASE 
					WHEN IDD_ONLINE_INVENTORY_AMT - IDD_CLAC_AVG < IBD_BOOKING_LIMIT THEN 1 ELSE 0 
				END AS need_feed,
				1 AS day_count
			FROM LatestData

			UNION ALL

			-- Recursive part (第2~60天)
			SELECT IBD_SEQ_ID,
				DATEADD(DAY, 1, forecast_date),
				CAST(
					CASE 
						WHEN inventory - IDD_CLAC_AVG < IBD_BOOKING_LIMIT
						THEN inventory - IDD_CLAC_AVG + IBD_FEED_AMT
						ELSE inventory - IDD_CLAC_AVG
					END AS DECIMAL(18, 2)
				),
				IBD_BOOKING_LIMIT,
				IBD_FEED_AMT,
				IDD_CLAC_AVG,
				CASE 
					WHEN inventory - IDD_CLAC_AVG < IBD_BOOKING_LIMIT THEN 1 ELSE 0 
				END,
				day_count + 1
			FROM Forecast
			WHERE day_count < 60
		)
	
	INSERT INTO @FILL
    SELECT IBD_SEQ_ID,forecast_date
    FROM Forecast
    WHERE need_feed = 1


	/* 預測下一次入料時間，產生叫料預排單 */
	/*
	INSERT INTO [dbo].[SDP_Order_Master]
           ([IBD_SEQ_ID]
           ,[SOM_PLANT]
           ,[SOM_BOM]
           ,[SOM_ORDER_QTY]
           ,[SOM_ORDER_UNIT]
           ,[SOM_DELIVERY_DATE]
           ,[SOM_STATUS]
		   ,[SOM_SDP_NO]
           ,[SOM_USER]
           ,[SOM_TYPE]
           ,[update_user]
           ,[update_time])*/

	SELECT IBD.IBD_SEQ_ID,IBD.IBD_PLANT,IBD.IBD_BOM_NO,IBD.IBD_FEED_AMT,IBD.IBD_FAB_UNIT,
	CONVERT(VARCHAR(10),FILLDATE,120)+' 17:00:00' [SOM_DELIVERY_DATE]
	,'TEMP' [SOM_STATUS],'' [SOM_SDP_NO],'SYSTEM' [SOM_USER],'A' [SOM_TYPE],'system' [update_user],GETDATE() [update_time]
	FROM @FILL IDD INNER JOIN [dbo].[Inventory_BaseData] IBD ON IDD.IBD_SEQ_ID=IBD.IBD_SEQ_ID



	
END
