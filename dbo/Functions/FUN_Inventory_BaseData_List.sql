
CREATE Function [dbo].[FUN_Inventory_BaseData_List]
(
	 @strPlant varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	select IBD_SEQ_ID
		,IBD_PLANT
		,IBD_SHOP
		,IBD_SYSTEM
		,(case when IBD_MATERIAL2 is null or IBD_MATERIAL2='' then IBD_MATERIAL else IBD_MATERIAL2 end)IBD_MATERIAL
		,IBD_TYPE
		,IBD_UNIT
		,IBD_FAB_UNIT
		,isnull(convert(varchar(50),IBD_TANK_CAPACITY),'') as IBD_TANK_CAPACITY
		,IBD_TANK_AMT
		,IBD_FEED_AMT
		,IBD_MAX_LIMIT
		,IBD_BOOKING_LIMIT
		,IBD_TRANSFER_PARA
		,IBD_WATER_VOL
		,IBD_AUTO_ORDER
		,UPD_DATETIME
		,UPD_USER
		,IBD_InitialStock
		,isnull(IBD_BOM_NO,'') as IBD_BOM_NO
		,isnull(IBD_PackingUnit,'') as IBD_PackingUnit
		from Inventory_BaseData as IB
		inner join V_Plant as P on P.Plant_T=IB.IBD_PLANT and Plant_F=@strPlant
)