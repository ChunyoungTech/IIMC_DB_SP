



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ReportMonthFill_price]
	@StartYM AS int,@EndYM AS int
 AS
BEGIN
--DECLARE @StartYM AS int='202303'
--DECLARE @EndYM AS int='202303'
DECLARE @cols NVARCHAR(MAX)= N'' --儲存動態欄位之用
DECLARE @sql NVARCHAR(MAX)

--取得所需要的日期範圍資料列表
 SELECT @cols = @cols + N',' + QUOTENAME(MMA_YM) FROM 
(
    SELECT DISTINCT([MMA_YM])
    FROM [vMeterial_Month_Amount] where [MMA_YM] >= @StartYM and [MMA_YM] <= @EndYM
) t

set @cols = SUBSTRING(@cols,2,LEN(@cols))
print @cols

--將所需要的欄位與日期組合起來，Material_Table 組合 Material_Base_Data
SET @sql = N' SELECT MB_SEQ_ID,MB_IsVisable,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_UNIT,MB_DECIMAL_BITS,' + @cols + '
FROM 
(
  select MMA.MB_SEQ_ID,MB_IsVisable,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_UNIT,MMA_YM,M_FillingQty,MB.MB_DECIMAL_BITS,MB_IsFilling from vMeterial_Month_Amount_p as MMA inner join Material_Base_Data as MB on MMA.MB_SEQ_ID = MB.MB_SEQ_ID
) AS j

PIVOT
(
  SUM(M_FillingQty) 
  FOR [MMA_YM] IN ('  + @cols  + ')
) AS t 
WHERE MB_IsVisable=''Y''
ORDER BY MB_Plant,MB_Shop,MB_Sysname,MB_CName'

--WHERE MB_IsVisable=''Y'' AND MB_IsFilling=''Y''

EXEC sp_executesql @sql

END


