



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每月1日上午06:50自動執行
-- =============================================
CREATE PROCEDURE [dbo].[sp_month_budget]
	--@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
DECLARE @CalcDate AS varchar(8);
DECLARE @StartDate AS varchar(8); 
DECLARE @CURRDate AS varchar(8) = convert(varchar(8),GETDATE(),112);

declare @curr_year int = YEAR(@CURRDate);
--declare @curr_year int = 2023;

--IF (@CalcDate<>'')--如有指定日期，則以指定日期計算
--	SET @StartDate =  @CalcDate ;
--ELSE
--	SELECT @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111)  FROM  dbo.Time_Set;

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0101';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0201';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0301';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0401';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0501';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0601';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0701';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0801';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '0901';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '1001';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '1101';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
SET @StartDate = CONVERT(VARCHAR(4),@curr_year,111) + '1201';
EXEC  dbo.sp_Budget_Report @StartDate;
END TRY
BEGIN CATCH END CATCH

--去除重複資料
BEGIN TRY
with temp as(
SELECT *, ROW_NUMBER() over(order by B_Plant,B_Sysname,B_Shop,B_Material,B_Date) as rnk
FROM Use_Budget  
)

DELETE temp where rnk NOT IN (Select Max(rnk) From temp Group By B_Plant,B_Sysname,B_Shop,B_Material,B_Date)
END TRY
BEGIN CATCH END CATCH



END

