

CREATE Function [dbo].[fun_mapp_usage_average]
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

	SELECT mt.M_Seq_ID, mt.M_Amount,mt.M_Date,
	avg(M_Amount) OVER (PARTITION BY MB_Plant) as avg,
	sum(M_Amount) OVER (PARTITION BY MB_Plant) as sum
	FROM Material_Base_Data mbd
	JOIN Material_Table mt ON mbd.MB_Seq_ID=mt.MB_SEQ_ID
	WHERE mb_plant=@MB_Plant
	AND mb_shop=@MB_Shop
	AND mb_sysname=@MB_Sysname
	AND mb_cname=@MB_CName
	AND m_date BETWEEN DATEADD(DAY,-@days+1,@date) AND @date		
	)
