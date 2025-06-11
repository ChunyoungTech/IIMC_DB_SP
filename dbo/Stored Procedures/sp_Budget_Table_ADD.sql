

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<產生Budget_Table最大化表格>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Budget_Table_ADD]
AS
BEGIN
	INSERT INTO Budget_Table (B_Plant,B_Year, B_Month)
	SELECT B.plant, B.[YEAR], B.[MONTH]
	FROM 
	(select [YEAR],[MONTH],plant from(SELECT 1 ID,[YEAR] FROM [sys_year]) y inner join (SELECT 1 ID,[MONTH] FROM [sys_month]) m on y.ID=m.ID 
	inner join (select top 1 1 ID, 'FAB2' plant from [Material_Base_Data]) mb on m.ID=mb.ID) B
	LEFT JOIN Budget_Table A ON A.B_Plant = B.plant AND A.B_Year = B.[YEAR] AND A.B_Month = B.[MONTH]
	WHERE A.B_Plant IS NULL AND A.B_Year IS NULL AND A.B_Month IS NULL;
END
