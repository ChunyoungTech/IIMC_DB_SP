﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<每日庫存計量後執行，液位警示當日庫存小於安全庫存且今日明日無入料紀錄者發mapp>
-- =============================================
 CREATE PROCEDURE [dbo].[sp_DailyInventory_WarningMapp]
AS
BEGIN
	DECLARE @K1 table(PLANT varchar(10),MATERIAL varchar(50),BOM varchar(50),AMT varchar(50),BOOKING varchar(50))
	DECLARE @K2 table(PLANT varchar(10),BOM varchar(50))

	--取得庫存低於安全庫存者
	INSERT INTO @K1(PLANT,MATERIAL,BOM,AMT,BOOKING) 
	SELECT * FROM (
	SELECT IBD_PLANT,IBD_MATERIAL,IBD_BOM_NO,IDD_ONLINE_INVENTORY_AMT,IBD_BOOKING_LIMIT FROM Inventory_DailyData IDD INNER JOIN Inventory_BaseData IBD ON IDD.IBD_SEQ_ID=IBD.IBD_SEQ_ID 
	WHERE IBD.IBD_SYSTEM='CDSS' AND IBD.IBD_TYPE NOT IN('DRUM','TOTE') AND IBD.IBD_SEQ_ID=806 AND IDD.IDD_ONLINE_INVENTORY_AMT<IBD.IBD_BOOKING_LIMIT AND IDD.IDD_DailyDate=CONVERT(VARCHAR(10),GETDATE(),120) 
	UNION
	SELECT IBD_PLANT,IBD_MATERIAL,IBD_BOM_NO,IDD_INVENTORY_AMT,IBD_BOOKING_LIMIT FROM Inventory_DailyData IDD INNER JOIN Inventory_BaseData IBD ON IDD.IBD_SEQ_ID=IBD.IBD_SEQ_ID 
	WHERE (IBD.IBD_SYSTEM='GMSG' OR IBD.IBD_TYPE IN('DRUM','TOTE')) AND IBD.IBD_SEQ_ID<>806 AND IDD.IDD_INVENTORY_AMT<IBD.IBD_BOOKING_LIMIT AND IDD.IDD_DailyDate=CONVERT(VARCHAR(10),GETDATE(),120) 
	) K1

	--取得今日明日入料
	/*
	INSERT INTO @K2(PLANT,BOM) 
	SELECT * FROM(
	SELECT SOM_PLANT,SOM_BOM FROM SDP_Order_Master SOM INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP SDP ON SOM.SOM_SDP_NO=SDP.CALLED_NO
	WHERE SOM.SOM_STATUS='SENT'  AND CONVERT(VARCHAR(10),GETDATE(),120) =CASE WHEN SDP.VENDOR_ARRIVAL_DATE IS NULL THEN  CONVERT(VARCHAR(10),SOM_DELIVERY_DATE,120) ELSE  CONVERT(VARCHAR(10),VENDOR_ARRIVAL_DATE,120) END
	UNION
	SELECT SOM_PLANT,SOM_BOM FROM SDP_Order_Master SOM INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP SDP ON SOM.SOM_SDP_NO=SDP.CALLED_NO
	WHERE SOM.SOM_STATUS='SENT'  AND CONVERT(VARCHAR(10),DATEADD(D,1,GETDATE()),120) =CASE WHEN SDP.VENDOR_ARRIVAL_DATE IS NULL THEN  CONVERT(VARCHAR(10),SOM_DELIVERY_DATE,120) ELSE  CONVERT(VARCHAR(10),VENDOR_ARRIVAL_DATE,120) END
	UNION
	SELECT SOM_PLANT,SOM_BOM FROM SDP_Order_Master SOM INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP SDP ON SOM.SOM_SDP_NO=SDP.CALLED_NO
	WHERE SOM.SOM_STATUS='SENT'  AND CONVERT(VARCHAR(10),DATEADD(D,2,GETDATE()),120) =CASE WHEN SDP.VENDOR_ARRIVAL_DATE IS NULL THEN  CONVERT(VARCHAR(10),SOM_DELIVERY_DATE,120) ELSE  CONVERT(VARCHAR(10),VENDOR_ARRIVAL_DATE,120) END
	) K2*/
	INSERT INTO @K2(PLANT,BOM) 
	SELECT * FROM(
	SELECT SOM_PLANT,SOM_BOM FROM SDP_Order_Master SOM INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC SDP ON SOM.SOM_SDP_NO=SDP.CALLED_NO
	WHERE SOM.SOM_STATUS='SENT'  AND CONVERT(VARCHAR(10),GETDATE(),120) =CASE WHEN SDP.VENDOR_ARRIVAL_DATE IS NULL THEN  CONVERT(VARCHAR(10),SOM_DELIVERY_DATE,120) ELSE  CONVERT(VARCHAR(10),VENDOR_ARRIVAL_DATE,120) END
	UNION
	SELECT SOM_PLANT,SOM_BOM FROM SDP_Order_Master SOM INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC SDP ON SOM.SOM_SDP_NO=SDP.CALLED_NO
	WHERE SOM.SOM_STATUS='SENT'  AND CONVERT(VARCHAR(10),DATEADD(D,1,GETDATE()),120) =CASE WHEN SDP.VENDOR_ARRIVAL_DATE IS NULL THEN  CONVERT(VARCHAR(10),SOM_DELIVERY_DATE,120) ELSE  CONVERT(VARCHAR(10),VENDOR_ARRIVAL_DATE,120) END
	UNION
	SELECT SOM_PLANT,SOM_BOM FROM SDP_Order_Master SOM INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC SDP ON SOM.SOM_SDP_NO=SDP.CALLED_NO
	WHERE SOM.SOM_STATUS='SENT'  AND CONVERT(VARCHAR(10),DATEADD(D,2,GETDATE()),120) =CASE WHEN SDP.VENDOR_ARRIVAL_DATE IS NULL THEN  CONVERT(VARCHAR(10),SOM_DELIVERY_DATE,120) ELSE  CONVERT(VARCHAR(10),VENDOR_ARRIVAL_DATE,120) END
	) K2



	--取得須通報資料
	
	--INSERT INTO [FACDB].[dbo].[MApp_Table]
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table]
           ([MApp_No]
           ,[MApp_Plant]
           ,[MApp_Date]
           ,[MApp_Time]
           ,[MApp_Value1]
           ,[MApp_Value2]
           ,[MApp_Value3]
           ,[MApp_Sec]
           ,[MApp_Type]
           ,[MApp_Ack_Flag]
           ,[MApp_Provider])
	SELECT '33333',
	B.SBO_PLANT3,
	convert(varchar(10),GETDATE(),111),
	convert(varchar(8),GETDATE(),114),
	'',
	'GCIC庫存警示',
	K1.MATERIAL+'，庫存量低於安全庫存，且後兩天無排程，請調整排程',
	'0',
	'GCI',
	'N',
	'GCIC叫料系統'
	 FROM @K1 K1 LEFT JOIN @K2 K2 ON K1.PLANT=K2.PLANT AND K1.BOM=K2.BOM
	INNER JOIN SDP_Base_Org B ON K1.PLANT=B.SBO_PLANT
	 WHERE K2.BOM IS NULL AND  K1.PLANT IN('TT01','TT02','TT03','TT04','TT05','TT07','TT08','TT09','TT10','T006')


END
