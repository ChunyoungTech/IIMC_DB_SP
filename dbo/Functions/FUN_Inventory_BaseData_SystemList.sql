
CREATE Function [dbo].[FUN_Inventory_BaseData_SystemList]
(
	 @strPlant varchar(50),
	 @strMaterialType	varchar(10)	/*物料別*/

)
RETURNS TABLE 
AS
RETURN 
(
	select IBD_SEQ_ID
		,IBD_PLANT,IBD_SYSTEMNO
		,IBD_SYSTEM,IBD_MATERIAL
		,IBD_BOM_NO, IBD_UNIT
		, IBD_FEED_AMT, IBD_TRANSFER_PARA
		from V_Inventory_BaseData as IB
		inner join V_Plant as P on P.Plant_T=IB.IBD_PLANT and Plant_F=@strPlant

		where IBD_SYSTEMNO=(case when @strMaterialType<>'' then @strMaterialType else IBD_SYSTEMNO end)

)