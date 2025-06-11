



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ReportDayFill]
	@StartDate AS DATE,@EndDate AS DATE
 AS

BEGIN
--DECLARE @StartDate AS DATE='2023-02-10'
--DECLARE @EndDate AS DATE='2023-02-16'
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
SET @sql = N' SELECT MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_UNIT,' + @cols + '
FROM 
(
  SELECT M_Date,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_UNIT,M_FillingQty FROM Material_Table MT inner join Material_Base_Data MB ON MT.MB_SEQ_ID=MB.MB_SEQ_ID WHERE MB_IsVisable=''Y''
) AS j

PIVOT
(
  SUM(M_FillingQty) 
  FOR [M_Date] IN ('  + @cols  + ')
) AS t 
ORDER BY MB_Plant,MB_Shop,MB_Sysname,MB_CName'
--print @sql
EXEC sp_executesql @sql

END

