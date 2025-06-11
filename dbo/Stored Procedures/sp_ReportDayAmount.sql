

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ReportDayAmount]
	@StartDate AS DATE,@EndDate AS DATE
 AS
BEGIN
--DECLARE @StartDate AS DATE='2018-02-10'
--DECLARE @EndDate AS DATE='2018-02-16'
DECLARE @cols NVARCHAR(MAX)= N'' --儲存動態欄位之用
DECLARE @sql NVARCHAR(MAX)




--取得所需要的日期範圍資料列表
 SELECT @cols = @cols + N',' + QUOTENAME([M_Date]) FROM 
(
    SELECT DISTINCT([M_Date]) 
    FROM [Material_Table] where [M_Date] >= @StartDate and [M_Date] <= @EndDate
) t

set @cols = SUBSTRING(@cols,2,LEN(@cols))
--print @cols

--將所需要的欄位與日期組合起來，Material_Table 組合 Material_Base_Data
SET @sql = N' SELECT MB_SEQ_ID,MB_IsVisable,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_UNIT,MB_DECIMAL_BITS,' + @cols + '
FROM 
(
  SELECT MT.MB_SEQ_ID,MB_IsVisable,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_UNIT,M_Date,M_Amount,MB_DECIMAL_BITS FROM Material_Table as MT inner join Material_Base_Data as MB on MT.MB_SEQ_ID = MB.MB_SEQ_ID
) AS j

PIVOT
(
  SUM(M_Amount) 
  FOR [M_Date] IN ('  + @cols  + ')
) AS t 
WHERE MB_IsVisable=''Y''
ORDER BY MB_Plant,MB_Shop,MB_Sysname,MB_CName'

EXEC sp_executesql @sql

END

