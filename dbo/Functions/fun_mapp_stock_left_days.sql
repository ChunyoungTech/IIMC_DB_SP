


CREATE Function [dbo].[fun_mapp_stock_left_days]
(
	@MB_Plant varchar(50),
	@MB_Shop varchar(50),
	@MB_Sysname varchar(50),
	@MB_CName varchar(50),
	@date datetime
)
RETURNS TABLE 
AS
RETURN 
(
	select IDD_AvailableDays from FUN_Inventory_DailyData_List(@mb_plant,@date)
	where ibd_shop=@MB_Shop
	AND ibd_system=@MB_Sysname
	AND ibd_material=@MB_CName	

	)
