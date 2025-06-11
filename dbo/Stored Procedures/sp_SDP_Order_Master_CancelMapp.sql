



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<每日執行，將昨日入料自動結案，CHEMICAL 比對ASN 有入料及結案，GAS 比對ASN及數量，皆符合才結案>
-- =============================================
 CREATE PROCEDURE [dbo].[sp_SDP_Order_Master_CancelMapp]
	@seq_id int
AS
BEGIN
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
	SELECT '33333'
	,B.SBO_PLANT3
	,convert(varchar(10),GETDATE(),111)
	,convert(varchar(8),GETDATE(),114)
	,''
	,'GCIC作廢通知'
	,'到貨日期:'+(CASE WHEN C.VENDOR_ARRIVAL_DATE IS NULL THEN convert(varchar(10),A.SOM_DELIVERY_DATE,111) ELSE convert(varchar(10),C.VENDOR_ARRIVAL_DATE,111) END)+' 物料:'+D.IBD_MATERIAL
	,'0'
	,'GCI'
	,'N'
	,'GCIC叫料系統'
	FROM SDP_Order_Master A 
	INNER JOIN SDP_Base_Org B ON A.SOM_PLANT=B.SBO_PLANT
	INNER JOIN SDP_VW_SRM_CALLED_ORDERS_GCIC C ON A.SOM_SDP_NO=C.CALLED_NO
	INNER JOIN Inventory_BaseData D ON A.SOM_PLANT=D.IBD_PLANT AND A.SOM_BOM=D.IBD_BOM_NO
	WHERE A.SEQ_ID=@seq_id
END
