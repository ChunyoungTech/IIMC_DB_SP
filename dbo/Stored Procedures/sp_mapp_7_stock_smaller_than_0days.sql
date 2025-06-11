




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<庫存異常 庫存< 0日 &未確認排程>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_7_stock_smaller_than_0days]
	@date date
 AS

BEGIN

--DECLARE @date AS DATE ='2024-12-25'
DECLARE @scheduledDate date
DECLARE  @MappMSg NVARCHAR(255);
DECLARE  @IPM_PLANT NVARCHAR(255);
DECLARE  @MAPP_TYPE NVARCHAR(255);

IF (@date is null or @date='') SET @date=GETDATE()


-- 宣告變數
DECLARE @ID INT, @PLANT NVARCHAR(255), @SHOP NVARCHAR(255),@sysName NVARCHAR(255),@MATERIAL NVARCHAR(255);

-- 宣告游標
DECLARE source_cursor CURSOR FOR
SELECT S1.IBD_SEQ_ID,S1.IBD_PLANT,S1.IBD_SHOP,S1.IBD_SYSTEM,S1.IBD_MATERIAL
  FROM [Inventory_BaseData] S1 inner join [Inventory_DailyData] S2
  ON S1.IBD_SEQ_ID=S2.IBD_SEQ_ID
  WHERE S2.IDD_DailyDate=@date
  AND S2.IDD_ONLINE_INVENTORY_AMT<S1.IBD_BOOKING_LIMIT
  AND IBD_AUTO_ORDER='Y'
  --AND S1.IBD_PLANT='TT02'

-- 開啟游標
OPEN source_cursor;

-- 提取下一行資料到變數中
FETCH NEXT FROM source_cursor INTO @id,@PLANT,@SHOP,@sysName,@MATERIAL;

-- 迴圈處理每一行資料
WHILE @@FETCH_STATUS = 0
BEGIN
    -- 將資料插入到 target_table
	SET @MappMSg =　FORMAT(@date, 'yyyy-MM-dd')  +' '+@SHOP+@sysName+ '系統「' + @MATERIAL + '」化學品庫存<0日且未排入料請速確認排程。';

	--SELECT @scheduledDate=VENDOR_ARRIVAL_DATE
		SELECT @scheduledDate=[ARRIVAL_DATE] --20250306改抓[ARRIVAL_DATE]避免廠商未確認一直發報
		FROM [SDP_Order_Master] S1 INNER JOIN (SELECT * FROM [SDP_VW_SRM_CALLED_ORDERS_GCIC] UNION SELECT * FROM [SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE])S2
		ON S1.[SOM_SDP_NO]=S2.CALLED_NO
		WHERE S2.VENDOR_ARRIVAL_DATE>=@date
		AND S1.IBD_SEQ_ID=@id

	--若無則送出mapp訊息
	IF(@scheduledDate is null)
	BEGIN
		
		SET @IPM_PLANT=NULL
		SET @MAPP_TYPE=NULL
		
		SELECT @IPM_PLANT=[MM_IPM_PLANT],@MAPP_TYPE=[MM_MAPPTYPE] FROM [dbo].[Mapp_Type_Table] WHERE MM_PLANT=@PLANT AND MM_SHOP=@SHOP

		exec sp_mapp_insert @MAPP_TYPE,@MappMSg ;
		exec sp_insert_ipm @IPM_PLANT,@SHOP,@sysName,@MappMSg ;

	END


    -- 提取下一行資料
    FETCH NEXT FROM source_cursor INTO @id,@PLANT, @SHOP,@sysName,@MATERIAL;
END;

-- 關閉游標
CLOSE source_cursor;

-- 釋放游標
DEALLOCATE source_cursor;

END