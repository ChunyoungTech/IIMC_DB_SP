





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<庫存異常 庫存< 0日 &未確認排程>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ipm_7_stock_smaller_than_0days]
	@date date
 AS

BEGIN
--DECLARE @date AS DATE ='2024-02-22'


if @date is null or @date=''
	set @date=GETDATE()
declare @days decimal(18,3)
declare @scheduledDate date
DECLARE  @MappMSg NVARCHAR(255);

--20240625 clark remark
--select @days=IDD_AvailableDays from fun_mapp_stock_left_days( 'fab2','水務課','UPWS','NaCl',@date)

--select @scheduledDate=SOM_DELIVERY_DATE from [fun_mapp_scheduled_delivery_in_days]( 'tt02','水務課','UPWS','NaCl',@date,0)

--if(@days<0 and @scheduledDate is null)
--	exec sp_mapp_insert 'FAC2_IIMC_GROUP', 'NaCl 化學品 庫存 <0日, 請確認庫存及排程'



-- 宣告變數
DECLARE @ID INT, @SHOP NVARCHAR(255),@sysName NVARCHAR(255),@MATERIAL NVARCHAR(255);

-- 宣告游標 先做二廠的
DECLARE source_cursor CURSOR FOR
select IBD_SEQ_ID,IBD_SHOP,IBD_SYSTEM,IBD_MATERIAL from FUN_Inventory_DailyData_List('fab2',@date) 
 where IDD_AvailableDays <=0 AND IBD_AUTO_ORDER='N' ;

-- 開啟游標
OPEN source_cursor;

-- 提取下一行資料到變數中
FETCH NEXT FROM source_cursor INTO @id, @SHOP,@sysName,@MATERIAL;

-- 迴圈處理每一行資料
WHILE @@FETCH_STATUS = 0
BEGIN
    -- 將資料插入到 target_table
	select @scheduledDate=SOM_DELIVERY_DATE from [fun_mapp_scheduled_delivery_in_days]( 'tt02',@SHOP,@sysName,@MATERIAL,@date,1)
	set @MappMSg =　FORMAT(@date, 'yyyy-MM-dd')  + '「' + @MATERIAL + '」化學品庫存<=0日且未排入料請速確認排程。';

if(@scheduledDate is null)
	--exec sp_mapp_insert 'FAC2_IIMC_GROUP',@MappMSg ;
	exec sp_insert_ipm 'FAC02',@SHOP,@sysName,@MappMSg ;


    -- 提取下一行資料
    FETCH NEXT FROM source_cursor INTO @id, @SHOP,@sysName,@MATERIAL;
END;

-- 關閉游標
CLOSE source_cursor;

-- 釋放游標
DEALLOCATE source_cursor;




END

