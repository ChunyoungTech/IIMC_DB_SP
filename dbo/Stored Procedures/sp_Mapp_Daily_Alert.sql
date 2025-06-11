-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Mapp_Daily_Alert]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	Declare @Date Date;
	--Set @Date = DATEADD(DAY, 1, @Date)
	Set @Date = GETDATE()
	EXEC [dbo].[sp_mapp_1_day_larger_than_week_10] @Date;


	EXEC [dbo].[sp_mapp_4_stock_smaller_than_2days] @Date;
	EXEC [dbo].[sp_mapp_5_day_larger_than_week_20] @Date;
	EXEC [dbo].[sp_mapp_6_stock_smaller_than_1days] @Date;
	EXEC [dbo].[sp_mapp_7_stock_smaller_than_0days] @Date;
	EXEC [dbo].[sp_mapp_8_budget_ratio_over90] @Date;
	EXEC [dbo].[sp_mapp_9_budget_ratio_over100] @Date;
	--EXEC [dbo].[sp_mapp_10_schedule_alert_previous] @Date;
	EXEC [dbo].[sp_mapp_11_schedule_alert_today] @Date;
	--EXEC [dbo].[sp_mapp_12_schedule_alert_yesterday] @Date;
	EXEC [dbo].[sp_mapp_13_po_exhausted]
	EXEC [dbo].[sp_mapp_14_VENDOR_Wait_Confirm]

	

END
