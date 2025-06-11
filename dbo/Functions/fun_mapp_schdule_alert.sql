
CREATE Function [dbo].[fun_mapp_schdule_alert]
(
	@date date,
	@fab char(10)

)
RETURNS TABLE 
AS
RETURN 
(
--DECLARE @date AS DATE ='2024-02-07'
select *
from SDP_Order_Master a
inner join (select * from SDP_VW_SRM_CALLED_ORDERS_GCIC union select * from SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE) b
on a.SOM_SDP_NO=b.CALLED_NO
where [VENDOR_ARRIVAL_DATE] >=@date
and [VENDOR_ARRIVAL_DATE] < DATEADD(DAY,1,@date)
and SOM_STATUS='sent' and SOM_PLANT=@fab
	

)
