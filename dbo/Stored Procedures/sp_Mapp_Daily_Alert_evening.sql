-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Mapp_Daily_Alert_evening] 
	AS
BEGIN
	Declare @Date Date;
	--Set @Date = DATEADD(DAY, 1, @Date)
	Set @Date = GETDATE()

	EXEC [dbo].[sp_mapp_4_stock_smaller_than_2days] @Date;
	EXEC [dbo].[sp_mapp_6_stock_smaller_than_1days] @Date;
	EXEC [dbo].[sp_mapp_7_stock_smaller_than_0days] @Date;
	EXEC [dbo].[sp_mapp_10_schedule_alert_previous] @Date;

	SET NOCOUNT ON;


END
