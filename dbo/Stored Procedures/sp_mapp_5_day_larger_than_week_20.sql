



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<用量異常 日用量 >20% 平均週用量  或設定警報用量 >
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_5_day_larger_than_week_20]
	@date date
 AS

BEGIN

--DECLARE @date AS DATE ='2024-02-06'
declare @today decimal(18,3)
declare @7day decimal(18,3)
declare @result bit
if @date is null or @date=''
	set @date=GETDATE()

set @result= dbo.fun_mapp_usage_alert( 'fab2','水務課','UPWS','NaOH',@date) 

select @today=avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','NaOH',@date,1)

select @7day =avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','NaOH',@date,7)

--if(@today is not null and @7day is not null and @today>(1.2*@7day) and @today <(1.1*@7day) OR @result=1) --新增小於 1.1*@7day 20240611 by Leo 
if(@today is not null and @7day is not null and @today>(1.2*@7day) and @result=1) -- 20240621 by clark
	exec sp_mapp_insert 'FAC2_IIMC_GROUP', '水務課 UPWS NaOH 化學品日用量>20%平均周用量 請注意用量'

set @result= dbo.fun_mapp_usage_alert( 'fab2','水務課','UPWS','NaCL',@date) 

select @today=avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','NaCL',@date,1)

select @7day =avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','NaCL',@date,7)

--if(@today is not null and @7day is not null and @today>(1.2*@7day)  OR @result=1)
--	exec sp_mapp_insert 'FAC2_IIMC_GROUP', '水務課 UPWS NaOH 化學品日用量>20%平均周用量 請注意用量'

--set @result= dbo.fun_mapp_usage_alert( 'fab2','水務課','UPWS','NaCL',@date) 

--select @today=avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','NaCL',@date,1)

--select @7day =avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','NaCL',@date,7)

if(@today is not null and @7day is not null and @today>(1.2*@7day)  and @result=1) -- 20240621 by clark
	exec sp_mapp_insert 'FAC2_IIMC_GROUP', '水務課 UPWS NaCL 化學品日用量>20%平均周用量 請注意用量'

set @result= dbo.fun_mapp_usage_alert( 'fab2','水務課','UPWS','HCL',@date) 

select @today=avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','HCL',@date,1)

select @7day =avg from fun_mapp_usage_average( 'fab2','水務課','UPWS','HCL',@date,7)

if(@today is not null and @7day is not null and @today>(1.2*@7day)  and @result=1) -- 20240621 by clark
	exec sp_mapp_insert 'FAC2_IIMC_GROUP', '水務課 UPWS HCL 化學品日用量>20%平均周用量 請注意用量'



END

