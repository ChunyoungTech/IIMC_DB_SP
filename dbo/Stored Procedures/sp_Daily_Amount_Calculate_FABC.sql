



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每日上午07:10及07:20自動執行
-- =============================================
CREATE PROCEDURE [dbo].[sp_Daily_Amount_Calculate_FABC]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
DECLARE @StartDate AS DATE 

IF (@CalcDate<>'')--如有指定日期，則以指定日期計算
	SET @StartDate =  @CalcDate ;
ELSE
	SELECT @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111)  FROM  dbo.Time_Set;


BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_anti_corrosion]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC   [dbo].[sp_Get_Amount_FABC_Chemical_CaCl2]  @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_CH3OH]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_H2SO4]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_HCl_GAS]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_HCl_water]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_Na2S2O3]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_NaOCl]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_NaOH_F]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_NaOH_water]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC   [dbo].[sp_Get_Amount_FABC_Chemical_PAC]  @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC  [dbo].[sp_Get_Amount_FABC_Chemical_polymer_F]   @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC   [dbo].[sp_Get_Amount_FABC_Chemical_polymer_plus]  @StartDate;
END TRY
BEGIN CATCH END CATCH

BEGIN TRY
EXEC   [dbo].[sp_Get_Amount_FABC_Chemical_polymer_water]  @StartDate;
END TRY
BEGIN CATCH END CATCH




END

