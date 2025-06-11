




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMonthBom]
	@StartYM AS int,@EndYM AS int
 AS
BEGIN
	SET NOCOUNT ON;
	--DECLARE @StartYM AS int='201805'
	--DECLARE @EndYM AS int='201806'
	DECLARE @cols NVARCHAR(MAX)= N'' --儲存動態欄位之用
	DECLARE @sql NVARCHAR(MAX)

	--取得所需要的日期範圍資料列表
	 SELECT @cols = @cols + N',' + QUOTENAME(BMA_YM) FROM 
	(
		SELECT DISTINCT([BMA_YM])
		FROM [vBOM_Month_Amount] where [BMA_YM] >= @StartYM and [BMA_YM] <= @EndYM
	) t

	set @cols = SUBSTRING(@cols,2,LEN(@cols))
	print @cols

	--將所需要的欄位與日期組合起來，Material_Table 組合 Material_Base_Data
	SET @sql = N' SELECT * FROM(
	  SELECT * FROM View_BOM_MONTH_USEAGE
	) AS j
	PIVOT
	(
	  SUM(M_USEAGE) 
	  FOR [YYMM] IN ('  + @cols  + ')
	) AS t 
	ORDER BY MB_Plant,MB_Sysname,MB_CName,MB_Shop,BS_BOM_NO'

	EXEC sp_executesql @sql

END





