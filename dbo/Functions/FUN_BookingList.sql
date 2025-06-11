
Create Function FUN_BookingList
(
	 @strIDD_SEQ_ID bigint				/*IBL_IDD_SEQ_ID*/
)
RETURNS TABLE 
AS
RETURN 
(
	select A.*
		,(case IBL_IDD_IS_BOOKING when '1' then '已叫料' when '0' then '取消叫料' else '' end) as BookStatus
		,B.U_USER_NAME
		from Inventory_BookingLog as A
		inner join Users as B on B.U_USER_ID=A.IBL_UPD_USER
		where IBL_IDD_SEQ_ID=@strIDD_SEQ_ID 
)