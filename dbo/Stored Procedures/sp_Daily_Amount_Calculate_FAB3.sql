


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每日上午07:10及07:20自動執行
-- =============================================
CREATE PROCEDURE [dbo].[sp_Daily_Amount_Calculate_FAB3]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
DECLARE @StartDate AS DATE 

--DECLARE @CalcDate AS DATE = '2025-01-13';
IF (@CalcDate<>'')--如有指定日期，則以指定日期計算
	SET @StartDate =  @CalcDate ;
ELSE
	SELECT @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111)  FROM  dbo.Time_Set;

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_ZC822 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_H2SO4 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_Na2S @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_NaOCl @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_PAC @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_polymer @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_TMAH @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_polymer_plus @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_salt @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_HCL @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB3_Chemical_NaOH @StartDate;
END TRY
BEGIN CATCH END CATCH

END

