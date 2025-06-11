


CREATE Function [dbo].[fun_mapp_scheduled_delivery_in_days]
(
	@MB_Plant varchar(50),
	@MB_Shop varchar(50),
	@MB_Sysname varchar(50),
	@MB_CName varchar(50),

	@date date,
	@days int
)
RETURNS TABLE 
AS
RETURN 
(

			select top 10 SOM_DELIVERY_DATE,som_bom,IBD_SYSTEM
			from SDP_Order_Master as M --廠務叫料單主檔
			inner join V_Inventory_BaseData as IBD on IBD.IBD_SEQ_ID=M.IBD_SEQ_ID --庫存基本檔
			inner join V_Plant as P on P.Plant_T=SOM_PLANT --廠別代號對照
			left join (SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC UNION SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE)  as D on D.CALLED_NO=M.SOM_SDP_NO --物管叫料單主檔
			left join Users as U on U.U_USER_ID=D.CREATE_BY --使用者
			left join (SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS UNION SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE) as H on H.CALLED_NO=M.SOM_SDP_NO  --物管叫料單歷史
			left join SDP_ORDER_Log as L on L.SOM_ID = m.SEQ_ID  --叫料單錯誤訊息
			where som_plant=@MB_Plant
			and som_bom=@MB_CName
			and IBD_SYSTEM=@MB_Sysname
			and SOM_DELIVERY_DATE between @date and DATEADD(DAY,@days+1,@date)
			and SOM_STATUS='temp'
			order by SOM_DELIVERY_DATE desc	
	)
