
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_IPM_Daily_Alert]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	Declare @Date Date;
	--Set @Date = DATEADD(DAY, 1, @Date)
	Set @Date = GETDATE()
	EXEC [dbo].[sp_ipm_6_stock_smaller_than_1days] @Date;
	EXEC [dbo].[sp_ipm_7_stock_smaller_than_0days] @Date;
	EXEC [dbo].[sp_ipm_12_schedule_alert_yesterday] @Date;
	SET NOCOUNT ON;


END
