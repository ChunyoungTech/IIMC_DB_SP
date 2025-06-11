
Create Function FUN_Inventory_DailyDatag_Q
(
	 @strPlant varchar(50),			/*廠區*/
     @strDate varchar(10)			/*結算日期*/
)
RETURNS TABLE 
AS
RETURN 
(
	select IDD_SEQ_ID,IDD.IBD_SEQ_ID as IBD_SEQ_ID
		,IBD.IBD_MATERIAL,IBD_TYPE
		,convert(varchar(10),IDD_DailyDate,111) as IDD_DailyDate,IDD_DailyTime
		,IDD_UNIT,isnull(convert(varchar(50),IDD_TANK_CAPACITY),'無') as IDD_TANK_CAPACITY
		,IDD_TANK_AMT,IDD_FEED_AMT
		,IDD_MAX_LIMIT,IDD_SETTING_DAYS
		,IBD_BOOKING_LIMIT
		,IDD_INVENTORY_AMT,IDD_PUT_IN_AMT
		,IDD_CHANGE_AMT,IDD_CLAC_DATETIME
		,IDD_CLAC_AVG,IDD_LIMLT_DAYS
		,IDD_IS_BOOKING
		,IDD.UPD_DATETIME as IDD_DATETIME,IDD.UPD_USER as IDD_USER
		,Plant_T,Plant_F
		,IBD_SYSTEM

		from Inventory_DailyData as IDD
		inner join V_ItemNumberCorresponding as INC on INC.INC_SegId=IDD.IBD_SEQ_ID
		inner join Inventory_BaseData as IBD on IBD.IBD_SEQ_ID=IDD.IBD_SEQ_ID
		inner join V_Plant as P on P.Plant_T=INC.INC_Plant and Plant_F=@strPlant
		where IDD_DailyDate=(case when @strDate<>'' then @strDate else IDD_DailyDate end)
)