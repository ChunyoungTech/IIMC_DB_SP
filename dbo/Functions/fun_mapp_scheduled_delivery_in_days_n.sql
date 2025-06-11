




CREATE Function [dbo].[fun_mapp_scheduled_delivery_in_days_n]
(
	@MB_Plant varchar(50),
	--@MB_Shop varchar(50),
	@MB_Sysname varchar(50),
	@MB_CName varchar(50),
	@date date,
	@days int
)
RETURNS TABLE 
AS
RETURN 
(

			select top 10 VENDOR_ARRIVAL_DATE,MATERIAL_NO  
            from SDP_Order_Master as M --廠務叫料單主檔 
            inner join V_Inventory_BaseData as IBD on IBD.IBD_SEQ_ID=M.IBD_SEQ_ID --庫存基本檔
            inner join V_Plant as P on P.Plant_T=SOM_PLANT --廠別代號對照
            inner join (SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC UNION SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE) W on w.CALLED_NO = m.SOM_SDP_NO 
            where som_plant=@MB_Plant
			and som_bom=@MB_CName
			and IBD_SYSTEM=@MB_Sysname
			and VENDOR_ARRIVAL_DATE between cast(convert(char(8), @date, 112) + ' 00:00:00.000' as datetime) 
			and cast(convert(char(8), DATEADD(DAY,@days+1,@date), 112) + ' 23:59:59.999' as datetime) 
			order by VENDOR_ARRIVAL_DATE desc	
	)
