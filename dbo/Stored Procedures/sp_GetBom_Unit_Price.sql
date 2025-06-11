





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBom_Unit_Price]
	@StartDate AS DATE,@EndDate AS DATE
 AS
BEGIN
DECLARE @cols NVARCHAR(MAX)= N'' --儲存動態欄位之用
DECLARE @sql NVARCHAR(MAX)
--DECLARE @StartDate AS DATE='2018-03-01'
--DECLARE @EndDate AS DATE='2018-03-04'

SELECT @cols = @cols + N',' + QUOTENAME([BU_Date]) FROM 
(
SELECT DISTINCT([BU_Date]) 
FROM [BOM_USEAGE] where [BU_Date] >= @StartDate and [BU_Date] <= @EndDate

) t

set @cols = SUBSTRING(@cols,2,LEN(@cols))


SET @sql = N' SELECT * FROM(
	SELECT BU_DATE,MB_Plant,MB_Shop,MB_Sysname,MB_CName,BS_TAG,BS_BOM_NO,BS_UNIT,BS_UNIT_PRICE FROM view_BOM_USEAGE
) AS BU
PIVOT
(
	SUM(BS_UNIT_PRICE)
	FOR BU_DATE IN('  + @cols  + ')
) AS P
ORDER BY MB_Plant,MB_Sysname,MB_CName,MB_Shop,BS_BOM_NO'

EXEC sp_executesql @sql
END





