
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<超過槽車入料量通報>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_12_schedule_alert_yesterday]
	@date date
 AS

BEGIN
	--DECLARE @date AS DATE ='2023-06-22'
	DECLARE @msg varchar(500)

	if (@date is null or @date='') set @date=GETDATE()

	set @date= DATEADD(day,-1, @date)

	DECLARE @tempTable TABLE 
	(
		SEQ_ID varchar(50),
		SOM_PLANT varchar(50),
		SOM_BOM varchar(50),
		SOM_ORDER_QTY varchar(50),
		SOM_ORDER_UNIT varchar(50),
		SOM_DELIVERY_DATE varchar(50),
		VENDOR_NAME varchar(50)
	)

	INSERT INTO @tempTable (SEQ_ID,SOM_PLANT,SOM_BOM,SOM_ORDER_QTY,SOM_ORDER_UNIT,SOM_DELIVERY_DATE, VENDOR_NAME)
	select SEQ_ID,SOM_PLANT,SOM_BOM,SOM_ORDER_QTY,SOM_ORDER_UNIT,[VENDOR_ARRIVAL_DATE],VENDOR_NAME from [fun_mapp_schdule_alert] (@date,'TT02')

	DECLARE @SEQ_ID varchar(50)
	DECLARE @SOM_PLANT varchar(50)
	DECLARE @SOM_BOM varchar(50)
	DECLARE @SOM_ORDER_QTY varchar(50)
	DECLARE @SOM_ORDER_UNIT varchar(50)
	DECLARE @SOM_DELIVERY_DATE varchar(50)
	DECLARE @VENDOR_NAME varchar(50)


	-- 宣告變數				
	DECLARE @SHOP NVARCHAR(255),@sysName NVARCHAR(255) ;
	DECLARE @getid CURSOR

	SET @getid = CURSOR FOR
	select * from @tempTable


	OPEN @getid
	FETCH NEXT
	FROM @getid INTO @SEQ_ID,@SOM_PLANT,@SOM_BOM,@SOM_ORDER_QTY,@SOM_ORDER_UNIT,@SOM_DELIVERY_DATE,@VENDOR_NAME
	WHILE @@FETCH_STATUS = 0
	BEGIN
		if(@VENDOR_NAME is null) 
			set @VENDOR_NAME=''
		 
		set @msg= '昨日'+@SOM_BOM+'槽車應到料未到貨, 請複查庫存及車次'
		exec sp_mapp_insert 'FAC2_IIMC_GROUP', @msg

		-- 查詢並將結果寫入變數
		SELECT @SHOP = a.IBD_SHOP,	@sysName = IBD_SYSTEM
		from Inventory_BaseData a 
		inner join SDP_Order_Master b on a.IBD_SEQ_ID=b.IBD_SEQ_ID
		where b.SEQ_ID=@SEQ_ID;

		exec sp_insert_ipm 'FAC2',@SHOP,@sysName,@msg ;

		FETCH NEXT
		FROM @getid INTO @SEQ_ID,@SOM_PLANT,@SOM_BOM,@SOM_ORDER_QTY,@SOM_ORDER_UNIT,@SOM_DELIVERY_DATE,@VENDOR_NAME
	END

	CLOSE @getid
	DEALLOCATE @getid

END

