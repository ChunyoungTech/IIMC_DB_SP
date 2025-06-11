
CREATE Function [dbo].[FUN_OrderFailureRecordList]
(
	 @strPlant		varchar(50),		/*廠區*/
     @strDateS		varchar(10),		/*起始日期*/
     @strDateE		varchar(10),		/*結束日期*/
	 @strOrderType	nvarchar(50),		/*叫貨類別*/
	 @strLogType	nvarchar(50)		/*錯誤類別*/
)
RETURNS TABLE 
AS
RETURN 
(
	select SOM_PLANT,SOM_TYPE
		,IBD.IBD_MATERIAL,SOM_BOM
		,SOM_ORDER_QTY,SOM_ORDER_UNIT
		,CONVERT(VARCHAR,SOM_DELIVERY_DATE,120)as SOM_DELIVERY_DATE
		,SOM_USER
		,SOM_REMARK
		,SOL_TYPE,SOL_ErrMsg
	
		from SDP_Order_Master as M
		inner join V_Plant as P on P.Plant_T=M.SOM_PLANT
		inner join V_Inventory_BaseData as IBD on IBD_BOM_NO=M.SOM_BOM and IBD.IBD_PLANT=M.SOM_PLANT	
		inner join SDP_ORDER_Log as L on L.SOM_ID=M.SEQ_ID	

		where Plant_F=@strPlant
			and convert(varchar(10),SOM_DELIVERY_DATE,112) between @strDateS and @strDateE

)