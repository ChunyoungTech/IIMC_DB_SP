



CREATE Function [dbo].[fun_mapp_filling_price_budget_ratio]
(
	@MB_Plant varchar(50),
	--@MB_Shop varchar(50),
	--@MB_Sysname varchar(50),
	--@MB_CName varchar(50),

	@date date

)

RETURNS decimal (18,3)
AS
begin


DECLARE @fp decimal(18,3)
DECLARE @budget decimal(18,3)

SELECT  @fp= SUM(m_fp)
FROM v_FillPrice
WHERE mb_plant=@MB_Plant
AND m_year=year(@date)
AND m_month=month(@date)

SELECT @budget = b_budget FROM
Budget_Table
WHERE B_Plant=@MB_Plant 
and b_year=year(@date)
and b_month=month(@date)



RETURN 
(
@fp/@budget

)
end



