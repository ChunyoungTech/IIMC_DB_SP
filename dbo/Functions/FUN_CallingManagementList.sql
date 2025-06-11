
CREATE Function [dbo].[FUN_CallingManagementList]
(
	 @strPlant		varchar(50),		/*廠區*/
     @strDateS		varchar(10),		/*起始日期*/
     @strDateE		varchar(10),		/*結束日期*/
	 @strMaterialType	varchar(10),	/*物料別*/
	 @strMaterialNo		varchar(20),	/*品名*/
	 @strOrderStatus	nvarchar(50),	/*叫貨單狀態*/
	 @strOrderStatus_D	nvarchar(50)	/*叫貨單明細狀態*/
)
RETURNS TABLE 
AS
RETURN 
(
	select SEQ_ID
		,SOM_SDP_NO,P.Plant_F as SOM_PLANT
		,IBD.IBD_MATERIAL,SOM_BOM
		,IBD.IBD_SYSTEMNO
		,SOM_STATUS,D.STATUS
		,(case when SOM_STATUS='TEMP' then '未叫料' 
			when SOM_STATUS='FAIL' then '叫料失敗'
			when SOM_STATUS='Urgent' then '警急叫料'
			when SOM_STATUS='Wait_Cancel' then '叫貨單待作廢' 
			when SOM_STATUS='SENT' and D.STATUS='Wait_Confirm' then '待供應商確認'
			when SOM_STATUS='SENT' and D.STATUS='Wait_Shipping' then '待供應商出貨'
			when SOM_STATUS='SENT' and D.STATUS='Shipped' then '供應商已出貨'
			when SOM_STATUS='Cancel' then '叫貨單已作廢'
			when SOM_STATUS='Closed' then '叫貨單已結案'
			else '' end) as OrderStatus
		,isnull(SOM_DELIVERY_DATE,'') as SOM_DELIVERY_DATE
		,isnull(convert(varchar(100),D.VENDOR_ARRIVAL_DATE,120),'') as VENDOR_ARRIVAL_DATE
		,(convert(varchar(20),SOM_ORDER_QTY) + ' ' + SOM_ORDER_UNIT) as OrderQty
		,isnull((convert(varchar(20),SHIP_QTY) + ' ' + D.UNIT),'') as SuppliersQty
		,M.update_time as M_UPDATE_DATE
		,D.UPDATE_DATE as D_UPDATE_DATE
		,(case when DATEDIFF(second,M.update_time,isnull(D.UPDATE_DATE,M.update_time))>1 then D.UPDATE_DATE
			else M.update_time end) as UpdateTime

		from SDP_Order_Master as M
		inner join V_Plant as P on P.Plant_T=M.SOM_PLANT
		inner join V_Inventory_BaseData as IBD on IBD_BOM_NO=M.SOM_BOM and IBD.IBD_PLANT=M.SOM_PLANT
		left join SDP_VW_SRM_CALLED_ORDERS_GCIC	as D on D.CALLED_NO=M.SOM_SDP_NO

		where Plant_F=@strPlant
			and (( VENDOR_ARRIVAL_DATE IS NULL AND convert(varchar(10),SOM_DELIVERY_DATE,120) between @strDateS and @strDateE )
				OR	( VENDOR_ARRIVAL_DATE IS NOT NULL AND convert(varchar(10),VENDOR_ARRIVAL_DATE,120) between @strDateS and @strDateE ))
			
			and IBD.IBD_SYSTEMNO=(case when @strMaterialType<>'' then @strMaterialType else IBD.IBD_SYSTEMNO end)
			and SOM_BOM=(case when @strMaterialNo<>'' then @strMaterialNo else SOM_BOM end)
			and SOM_STATUS=(case when @strOrderStatus<>'' then @strOrderStatus else SOM_STATUS end)
			and ISNULL(D.STATUS,'0')=(case when @strOrderStatus_D<>'' then @strOrderStatus_D else ISNULL(D.STATUS,'0') end)

)