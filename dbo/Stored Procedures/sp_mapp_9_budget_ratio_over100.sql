





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<充填費用> 100%時警報>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_9_budget_ratio_over100]
	@date date
 AS

BEGIN
--DECLARE @date AS DATE ='2024-02-22'


if @date is null or @date=''
	set @date=GETDATE()

if(dbo.[fun_mapp_filling_price_budget_ratio] ('fab2', @date)>1)
	exec sp_mapp_insert 'FAC2_IIMC_GROUP', '化學品月預算>100%請盤查入料需求'

END

