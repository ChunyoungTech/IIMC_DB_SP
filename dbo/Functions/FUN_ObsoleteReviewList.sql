
CREATE Function [dbo].[FUN_ObsoleteReviewList]
(
	 @strPlant		varchar(50)		/*廠區*/
     --@strDateS		varchar(10),		/*起始年月*/
     --@strDateE		varchar(10)		/*結束年月*/
)
RETURNS TABLE 
AS
RETURN 
(
	select DISTINCT SEQ_ID
		,SOM_PLANT,SOM_SDP_NO,m.SOM_CANCEL_REMARK as CANCEL_REMARK
		,IBD.IBD_MATERIAL,SOM_BOM
		,SOM_ORDER_QTY,SOM_ORDER_UNIT
		,CONVERT(VARCHAR,SOM_DELIVERY_DATE,120)as SOM_DELIVERY_DATE
		,'作廢申請' as JobStatus
		,isnull(SOM_REMARK,'') as SOM_REMARK
		,(CASE WHEN U.U_USER_NAME IS NULL THEN 'System' ELSE U.U_USER_NAME END) as M_UpdateUser
		,M.update_time as M_UpdateTime
	
		from SDP_Order_Master as M
		inner join V_Plant as P on P.Plant_T=M.SOM_PLANT
		inner join V_Inventory_BaseData as IBD on IBD_BOM_NO=M.SOM_BOM and IBD.IBD_PLANT=M.SOM_PLANT
		LEFT JOIN Users AS U ON M.update_user=U.U_USER_ID

		where Plant_F=@strPlant
			--and convert(varchar(10),SOM_DELIVERY_DATE,112) between convert(varchar(10),@strDateS,112) and  convert(varchar(10),@strDateE,112) 
			and m.SOM_STATUS='Wait_Cancel'

)