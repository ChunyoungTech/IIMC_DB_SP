﻿
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<本日槽車入料通報>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_11_schedule_alert_today]
	@date date
 AS

BEGIN
	--DECLARE @date AS DATE ='2024-12-25'
	DECLARE @msg varchar(500)
	DECLARE  @IPM_PLANT NVARCHAR(255);
	DECLARE  @MAPP_TYPE NVARCHAR(255);

	if (@date is null or @date='')	set @date=GETDATE()


	DECLARE @tempTable TABLE 
	(
		SEQ_ID varchar(50),
		IBD_PLANT varchar(50),
		IBD_SHOP varchar(50),
		IBD_SYSTEM varchar(50),
		IBD_MATERIAL varchar(50),
		SOM_BOM varchar(50),
		SOM_ORDER_QTY varchar(50),
		SOM_ORDER_UNIT varchar(50),
		SOM_DELIVERY_DATE varchar(50),
		VENDOR_NAME varchar(50)
	)

	INSERT INTO @tempTable (SEQ_ID,IBD_PLANT,IBD_SHOP,IBD_SYSTEM,IBD_MATERIAL,SOM_BOM,SOM_ORDER_QTY,SOM_ORDER_UNIT,SOM_DELIVERY_DATE, VENDOR_NAME)
	SELECT S1.SEQ_ID,S3.IBD_PLANT,S3.IBD_SHOP,S3.IBD_SYSTEM,S3.IBD_MATERIAL,S1.SOM_BOM,S2.SHIP_QTY,S2.UNIT,S2.VENDOR_ARRIVAL_DATE,S2.VENDOR_NAME
		FROM [SDP_Order_Master] S1 INNER JOIN (SELECT * FROM [SDP_VW_SRM_CALLED_ORDERS_GCIC] UNION SELECT * FROM [SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE])S2
		ON S1.[SOM_SDP_NO]=S2.CALLED_NO INNER JOIN [Inventory_BaseData] S3
		ON S1.IBD_SEQ_ID=S3.IBD_SEQ_ID
		WHERE CONVERT(DATE,S2.VENDOR_ARRIVAL_DATE)=@date and s1.SOM_STATUS='SENT'


	--SELECT * FROM @tempTable


	DECLARE @SEQ_ID varchar(50)
	DECLARE @IBD_PLANT varchar(50)
	DECLARE @IBD_SHOP varchar(50)
	DECLARE @IBD_SYSTEM varchar(50)
	DECLARE @IBD_MATERIAL varchar(50)
	DECLARE @SOM_BOM varchar(50)
	DECLARE @SOM_ORDER_QTY varchar(50)
	DECLARE @SOM_ORDER_UNIT varchar(50)
	DECLARE @SOM_DELIVERY_DATE varchar(50)
	DECLARE @VENDOR_NAME varchar(50)



	DECLARE @getid CURSOR

	SET @getid = CURSOR FOR
	select * from @tempTable


	OPEN @getid
	FETCH NEXT
	FROM @getid INTO @SEQ_ID,@IBD_PLANT,@IBD_SHOP,@IBD_SYSTEM,@IBD_MATERIAL,@SOM_BOM,@SOM_ORDER_QTY,@SOM_ORDER_UNIT,@SOM_DELIVERY_DATE,@VENDOR_NAME
	WHILE @@FETCH_STATUS = 0
	BEGIN
		if(@VENDOR_NAME is null) 
			set @VENDOR_NAME=''

		set @msg= '本日槽車叫料 '+@IBD_SHOP+@IBD_SYSTEM+'系統['+@IBD_MATERIAL+'], 入料量'+ @SOM_ORDER_QTY +' ' + @SOM_ORDER_UNIT --+', 廠商' + @VENDOR_NAME
	
		SET @IPM_PLANT=NULL
		SET @MAPP_TYPE=NULL
		
		SELECT @IPM_PLANT=[MM_IPM_PLANT],@MAPP_TYPE=[MM_MAPPTYPE] FROM [dbo].[Mapp_Type_Table] WHERE MM_PLANT=@IBD_PLANT AND MM_SHOP=@IBD_SHOP

	
		exec sp_mapp_insert @MAPP_TYPE, @msg


		--SELECT @IFM_PLANT,@MAPP_TYPE,@msg

		FETCH NEXT
		FROM @getid INTO @SEQ_ID,@IBD_PLANT,@IBD_SHOP,@IBD_SYSTEM,@IBD_MATERIAL,@SOM_BOM,@SOM_ORDER_QTY,@SOM_ORDER_UNIT,@SOM_DELIVERY_DATE,@VENDOR_NAME
	END

	CLOSE @getid
	DEALLOCATE @getid

END

