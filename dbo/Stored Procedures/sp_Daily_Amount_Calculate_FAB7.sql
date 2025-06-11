


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每日上午07:10及07:20自動執行
-- =============================================
CREATE PROCEDURE [dbo].[sp_Daily_Amount_Calculate_FAB7]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
DECLARE @StartDate AS DATE 

IF (@CalcDate<>'')--如有指定日期，則以指定日期計算
	SET @StartDate =  @CalcDate ;
ELSE
	SELECT @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111)  FROM  dbo.Time_Set;

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_CaCL2 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_DehydrationPolymer @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_FeCl2 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_H2SO4 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_HCl @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_Methanol40 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_Na2S @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_Na2S2O3 @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_NaOCl @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_NaOH @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_NegativePolymer @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  dbo.sp_Get_Amount_FAB7_Chemical_ZC822 @StartDate;
END TRY
BEGIN CATCH END CATCH


END

