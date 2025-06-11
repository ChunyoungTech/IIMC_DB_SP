




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<寫入備註>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Budget_Report]
  --@strDate as varchar(8)
AS
BEGIN
    declare @strDate varchar(8) = convert(varchar(8),GETDATE(),112);
    
    declare @curr_date varchar(8) = convert(varchar(8),GETDATE(),112);
	declare @curr_yymm varchar(6) = convert(varchar(6),GETDATE(),112);
	declare @next_date varchar(8) = convert(varchar(8),dateadd(mm,1,DATEADD(mm,DATEDIFF(mm,0,convert(date,@strDate)),0)),112);
	declare @max_date varchar(8);
	declare @strSettlementDate varchar(8);
	--declare @strSettlementDate varchar(8)=@strDate;--convert(varchar(8),DateAdd(day,-1,convert(date,@strDate)),112);
	declare @myDate AS DATETIME
	--指定運算日期
	--最新資料日期
	select @max_date = convert(varchar(8),max(I_Date),112)  from IDMC_Table;
	-- 以 資料最新日為基準點，找出資料最新日該月第一天的日期
	SET @myDate = DATEADD(mm, DATEDIFF(mm, '', convert(date,@max_date)), '');
	--SET @strSettlementDate = convert(varchar(8),DateAdd(day,-1,@next_date),112) ;
	IF (@strDate>=@max_date)
	BEGIN
	    --找出資料最新日上月最後一天的日期
		SET @strSettlementDate = @max_date;--convert(varchar(8),DateAdd(day,-1,@myDate),112) ;
	END
	IF (@strDate<@max_date)
	BEGIN
	    SET @strDate = convert(varchar(8),dateadd(mm,1,DATEADD(mm,DATEDIFF(mm,0,convert(date,@strDate)),0)),112);
	    SET @strSettlementDate = convert(varchar(8),DateAdd(day,-1,@strDate),112) ;
	END
	
	
	--declare @strSettlementDate2 varchar(8)= '20240831';
	declare @lastmon_day int = DAY(@strSettlementDate);--取得本月天數
	declare @curr_year int = YEAR(@next_date);--取得下個月年度
	declare @curr_mon int= MONTH(@next_date);--取得下個月月份
	declare @null_row int;
	SET NOCOUNT ON;

	/* Budget 係數  每月最後一日資料產生*/
	/*IF(SELECT COUNT(1) FROM [kpi_coefficient] where [datetime]=CONVERT(CHAR(10),GETDATE(),120))=0
	BEGIN*/

	    DELETE FROM [dbo].[Use_Budget] where B_Date = @next_date--刪除下個月預算資料
		--寫入下個月預算資料
		INSERT INTO [dbo].[Use_Budget]
				   ([B_Plant]
				   ,[B_sysname]
				   ,[B_Shop]
				   ,[B_material]
				   ,[B_Year]
				   ,[B_Month]
				   ,[B_Budget]
				   ,[B_Date]
				   ,[IDD_ONLINE_INVENTORY_AMT]
				   ,[IDD_INVENTORY_AMT]
				   ,[IBD_BOOKING_LIMIT]
				   ,[IBD_FEED_AMT]
				   ,[IDD_CLAC_AVG]
				   ,[cal_days]
				   ,[Mb_Seq_ID]
				   ,[B_Price]
				   )
		SELECT	
		c.SBO_PLANT2,
		a.IBD_SYSTEM,
		a.IBD_SHOP,
		(case when IBD_MATERIAL2 is null or IBD_MATERIAL2='' then IBD_MATERIAL else IBD_MATERIAL2 end)IBD_MATERIAL,
		@curr_year,
		@curr_mon,
		0 B_Budget,
		CONVERT(INT, @next_date),
		round(e.IDD_ONLINE_INVENTORY_AMT*e.IDD_INVENTORY_AMT,0) IDD_ONLINE_INVENTORY_AMT,

		e.IDD_INVENTORY_AMT,
		round(a.IBD_BOOKING_LIMIT*e.IDD_INVENTORY_AMT,0) IBD_BOOKING_LIMIT,
		round((case when e.IDD_INVENTORY_AMT=0 then 0 else a.IBD_FEED_AMT/e.IDD_INVENTORY_AMT end)*e.IDD_INVENTORY_AMT,0) IBD_FEED_AMT,
		(case when round(e.IDD_CLAC_AVG*e.IDD_INVENTORY_AMT,0) = 0 then 0.1 else round(e.IDD_CLAC_AVG*e.IDD_INVENTORY_AMT,0) end) IDD_CLAC_AVG,
		@lastmon_day,
		ipr.MB_Seq_ID,
		ipr.MB_Price
		
FROM Inventory_BaseData a INNER JOIN SDP_Base_Org c on a.IBD_PLANT=c.SBO_PLANT

left join( --當日氣櫃壓力/重量
	SELECT I_Plant,I_Tag1,I_Value1,I_Tag2,I_Value2,I_Tag3,I_Value3,I_Tag4,I_Value4,I_Tag5,I_Value5,I_Date FROM IDMC_Table 
	WHERE I_Date=@strSettlementDate AND I_Type='E'
	GROUP BY  I_Plant,I_Tag1,I_Value1,I_Tag2,I_Value2,I_Tag3,I_Value3,I_Tag4,I_Value4,I_Tag5,I_Value5,I_Date
	) d on c.SBO_PLANT2=d.I_Plant 
INNER JOIN(
	SELECT * FROM Inventory_DailyData WHERE IDD_DailyDate=@strSettlementDate 
	 )e on a.IBD_SEQ_ID=e.IBD_SEQ_ID
left join [dbo].[Inventory_ReceiptMapping] irm on a.IBD_SEQ_ID=irm.IBD_SEQ_ID 
left join [dbo].[Material_Base_Data] ipr on c.SBO_PLANT2 = ipr.MB_Plant 
and ( a.IBD_SYSTEM = ipr.MB_Sysname or a.IBD_SYSTEM = SUBSTRING(ipr.MB_Sysname, 0,CHARINDEX('~', ipr.MB_Sysname))) and a.IBD_SHOP = ipr.MB_Shop 
and (IBD_MATERIAL = ipr.MB_CName) 
GROUP BY a.IBD_SEQ_ID,
		c.SBO_PLANT2,
		a.IBD_SYSTEM,
		a.IBD_SHOP,
		(case when IBD_MATERIAL2 is null or IBD_MATERIAL2='' then IBD_MATERIAL else IBD_MATERIAL2 end)
		,d.I_Date,e.IDD_ONLINE_INVENTORY_AMT,e.IDD_INVENTORY_AMT,a.IBD_BOOKING_LIMIT,IBD_FEED_AMT,
		e.IDD_CLAC_AVG,ipr.MB_Seq_ID,ipr.MB_Price


UPDATE [dbo].[Use_Budget] set 
 Budget_Car = (case when IBD_FEED_AMT = 0 then 0 
 --when IBD_BOOKING_LIMIT >= IDD_ONLINE_INVENTORY_AMT then 
 --CEILING((cal_days*IDD_CLAC_AVG)/IBD_FEED_AMT) 
 else 
 CEILING(((cal_days-(IDD_ONLINE_INVENTORY_AMT- IBD_BOOKING_LIMIT)/IDD_CLAC_AVG)*IDD_CLAC_AVG)/IBD_FEED_AMT) end) 
 where B_Date = @next_date

 UPDATE [dbo].[Use_Budget] set 
 Budget_Car = 0 
 where B_Date = @next_date and Budget_Car < 0

 UPDATE [dbo].[Use_Budget] set 
 Budget_Car = 0 
 where B_Date = @next_date and Budget_Car > 50


 UPDATE [dbo].[Use_Budget] set 
 B_Budget = Budget_Car * IBD_FEED_AMT * B_Price 
 where B_Date = @next_date

/*避免2邊名稱不一致*/
UPDATE [dbo].[Use_Budget] set 
B_Material = (select top 1 MB_CName from  v_FillPrice where MB_CName = Use_Budget.B_Material);

--沒有資料時寫入一筆
select @null_row=count(*) from Use_Budget where B_Plant = 'FAB2' and B_Date = @next_date 
if (@null_row = 0)
begin
  INSERT INTO [dbo].[Use_Budget]
				   ([B_Plant]
				   ,[B_sysname]
				   ,[B_Shop]
				   ,[B_material]
				   ,[B_Year]
				   ,[B_Month]
				   ,[B_Budget]
				   ,[B_Date]
				   ,[IDD_ONLINE_INVENTORY_AMT]
				   ,[IDD_INVENTORY_AMT]
				   ,[IBD_BOOKING_LIMIT]
				   ,[IBD_FEED_AMT]
				   ,[IDD_CLAC_AVG]
				   ,[cal_days]
				   ,[Mb_Seq_ID]
				   ,[B_Price]
				   )
				   values
				   (
				   'FAB2'
				   ,''
				   ,''
				   ,''
				   ,@curr_year
				   ,@curr_mon
				   ,0
				   ,@next_date
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   )
end 

select @null_row=count(*) from Use_Budget where B_Plant = 'FAB7' and B_Date = @next_date 
if (@null_row = 0)
begin
  INSERT INTO [dbo].[Use_Budget]
				   ([B_Plant]
				   ,[B_sysname]
				   ,[B_Shop]
				   ,[B_material]
				   ,[B_Year]
				   ,[B_Month]
				   ,[B_Budget]
				   ,[B_Date]
				   ,[IDD_ONLINE_INVENTORY_AMT]
				   ,[IDD_INVENTORY_AMT]
				   ,[IBD_BOOKING_LIMIT]
				   ,[IBD_FEED_AMT]
				   ,[IDD_CLAC_AVG]
				   ,[cal_days]
				   ,[Mb_Seq_ID]
				   ,[B_Price]
				   )
				   values
				   (
				   'FAB7'
				   ,''
				   ,''
				   ,''
				   ,@curr_year
				   ,@curr_mon
				   ,0
				   ,@next_date
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   )
end

select @null_row=count(*) from Use_Budget where B_Plant = 'FABC' and B_Date = @next_date 
if (@null_row = 0)
begin
  INSERT INTO [dbo].[Use_Budget]
				   ([B_Plant]
				   ,[B_sysname]
				   ,[B_Shop]
				   ,[B_material]
				   ,[B_Year]
				   ,[B_Month]
				   ,[B_Budget]
				   ,[B_Date]
				   ,[IDD_ONLINE_INVENTORY_AMT]
				   ,[IDD_INVENTORY_AMT]
				   ,[IBD_BOOKING_LIMIT]
				   ,[IBD_FEED_AMT]
				   ,[IDD_CLAC_AVG]
				   ,[cal_days]
				   ,[Mb_Seq_ID]
				   ,[B_Price]
				   )
				   values
				   (
				   'FABC'
				   ,''
				   ,''
				   ,''
				   ,@curr_year
				   ,@curr_mon
				   ,0
				   ,@next_date
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   )
end

	/*END*/


	/* 各廠產能 由ifm抓取，目前使用舊資料產生 */
	
--去除重複資料
BEGIN TRY
with temp as(
SELECT *, ROW_NUMBER() over(order by B_Plant,B_Sysname,B_Shop,B_Material,B_Date) as rnk
FROM Use_Budget  
)

DELETE temp where rnk NOT IN (Select Max(rnk) From temp Group By B_Plant,B_Sysname,B_Shop,B_Material,B_Date)
END TRY
BEGIN CATCH END CATCH

END
