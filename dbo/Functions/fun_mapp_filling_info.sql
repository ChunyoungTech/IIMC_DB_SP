


CREATE Function [dbo].[fun_mapp_filling_info]
(
	@MB_Plant varchar(50),
	@MB_Shop varchar(50),
	@MB_Sysname varchar(50),
	@MB_CName varchar(50),

	@date date

)
RETURNS TABLE 
AS
RETURN 
(

select M_FillingQty, M.M_FillingQty * M.M_Price AS FillingPrice
FROM dbo.Material_Base_Data AS MB INNER JOIN
dbo.Material_Table AS M ON MB.MB_Seq_ID = M.MB_SEQ_ID AND MB.MB_IsFilling = 'Y'
	WHERE mb_plant=@MB_Plant
	AND mb_shop=@MB_Shop
	AND mb_sysname=@MB_Sysname
	AND mb_cname=@MB_CName
	AND m_date = @date	
	

)
