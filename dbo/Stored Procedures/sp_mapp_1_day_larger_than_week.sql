





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<用量預警 平均週用量 >設定最高百分比 或 日用量 <最低百分比 或不在設定警報用量之間 >
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_1_day_larger_than_week]
	@date date
 AS

BEGIN

--DECLARE @date AS DATE ='2024-12-02'

declare @today decimal(18,3)
declare @7day decimal(18,3)
declare @result bit
 
if @date is null or @date=''
	set @date=GETDATE()

declare @msg varchar(500)

DECLARE @tempTable TABLE 
(
   MB_Seq_ID int,
   MB_Plant varchar(10),
   MB_Shop varchar(15),
   MB_Sysname varchar(15),
   MB_CName varchar(50),
   MB_LimitType char(1),
   MB_HiLimit varchar(50),
   MB_LoLimit varchar(50),
   MB_HiLimitValue decimal(18,3),
   MB_LoLimitValue decimal(18,3)

)

INSERT INTO @tempTable (MB_Seq_ID,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_LimitType,
MB_HiLimit,MB_LoLimit,MB_HiLimitValue,MB_LoLimitValue)
select MB_Seq_ID,MB_Plant,MB_Shop,MB_Sysname,MB_CName,MB_LimitType,
cast((cast(MB_HiLimit as float)/100)+1 as varchar(50)) as MB_HiLimit,
cast((cast(MB_LoLimit as float)/100)+1 as varchar(50)) as MB_LoLimit,
MB_HiLimitValue,MB_LoLimitValue from vMaterial_Base_Data 
--WHERE 1=1 
where MB_Plant = 'FAB2' 


DECLARE @MB_Seq_ID int
DECLARE @MB_Plant varchar(10)
DECLARE @MB_Shop varchar(15)
DECLARE @MB_Sysname varchar(15)
DECLARE @MB_CName varchar(50)
DECLARE @MB_LimitType char(1)
DECLARE @MB_HiLimit varchar(50)
DECLARE @MB_LoLimit varchar(50)
DECLARE @MB_SYS_GROUP varchar(50)
DECLARE @MB_HiLimitValue decimal(18,3)
DECLARE @MB_LoLimitValue decimal(18,3)

DECLARE @getid CURSOR

SET @getid = CURSOR FOR
select * from @tempTable

OPEN @getid
FETCH NEXT
FROM @getid INTO @MB_Seq_ID,@MB_Plant,@MB_Shop,@MB_Sysname,@MB_CName,@MB_LimitType,
@MB_HiLimit,@MB_LoLimit,@MB_HiLimitValue,@MB_LoLimitValue

WHILE @@FETCH_STATUS = 0
BEGIN
	--if(@VENDOR_NAME is null) 
	--	set @VENDOR_NAME=''

	set @result= dbo.fun_mapp_usage_alert( @MB_Plant,@MB_Shop,@MB_Sysname,@MB_CName,@date)
	select @today=avg from fun_mapp_usage_average( @MB_Plant,@MB_Shop,@MB_Sysname,@MB_CName,@date,1)
	select @7day =avg from fun_mapp_usage_average( @MB_Plant,@MB_Shop,@MB_Sysname,@MB_CName,@date,7)

    --SELECT @result, @today, @7day;
	SET @MB_SYS_GROUP = 'FAC2_IIMC_GROUP' 

	IF (@MB_Plant = 'FAB1')
	  SET @MB_SYS_GROUP = 'FAC1_IIMC_GROUP' 
	
	IF (@MB_Plant = 'FAB2')
	  SET @MB_SYS_GROUP = 'FAC2_IIMC_GROUP' 

	IF (@MB_Plant = 'FAB3')
	  SET @MB_SYS_GROUP = 'FAC3_IIMC_GROUP' 

	IF (@MB_Plant = 'FAB4')
	  SET @MB_SYS_GROUP = 'FAC4_IIMC_GROUP' 

	IF (@MB_Plant = 'FAB5')
	  SET @MB_SYS_GROUP = 'FAC5_IIMC_GROUP' 

	IF (@MB_Plant = 'FAB6')
	  SET @MB_SYS_GROUP = 'FAC6_IIMC_GROUP' 

    IF (@MB_Plant = 'FAB7')
	  SET @MB_SYS_GROUP = 'FAC7_IIMC_GROUP'  

	IF (@MB_Plant = 'FAB8A')
	  SET @MB_SYS_GROUP = 'FAC8A_IIMC_GROUP' 

	IF (@MB_Plant = 'FAB8B')
	  SET @MB_SYS_GROUP = 'FAC8B_IIMC_GROUP' 

	IF (@MB_Plant = 'FABT6')
	  SET @MB_SYS_GROUP = 'FACT6_IIMC_GROUP' 

	IF (@MB_Plant = 'FABC')
	  SET @MB_SYS_GROUP = 'FACC_IIMC_GROUP' 

	if @MB_LimitType = 'P'
	begin
	  --set @msg= '明日槽車叫料 '
	    if(@today is not null and @7day is not null and (@today between (@MB_LoLimit*@7day)  and (@MB_HiLimit*@7day)) and @result=1)-- 20240621 by clark
	    begin
		  set @msg= FORMAT(@date, 'yyyy-MM-dd') + ' ' + @MB_Plant + ' ' + @MB_Shop + ' ' + @MB_Sysname + ' ' + @MB_CName + ' ' + '化學品日用量>'+ cast((cast(@MB_LoLimit as float)*100)-100 as varchar(50))+'%平均周用量 請注意用量'
      	  --SELECT @MB_CName, @today,@7day, @MB_LoLimit*@7day,@MB_HiLimit*@7day,@msg;
		  exec sp_mapp_insert @MB_SYS_GROUP, @msg
		end

		if(@today is not null and @7day is not null and (@today > (@MB_HiLimit*@7day)) and @result=1)-- 20240621 by clark
	    begin
		  set @msg= FORMAT(@date, 'yyyy-MM-dd') + ' ' + @MB_Plant + ' ' + @MB_Shop + ' ' + @MB_Sysname + ' ' + @MB_CName + ' ' + '化學品日用量>'+ cast((cast(@MB_HiLimit as float)*100)-100 as varchar(50))+'%平均周用量 請注意用量'
      	  --SELECT @MB_CName, @today,@7day, @MB_LoLimit*@7day,@MB_HiLimit*@7day,@msg;
		  exec sp_mapp_insert @MB_SYS_GROUP, @msg
		end
	end

	if @MB_LimitType = 'V'
	begin
	  if(@today is not null and @7day is not null and (@today < @MB_LoLimitValue ) and @result=1)-- 20240621 by clark
	    begin
		  set @msg= FORMAT(@date, 'yyyy-MM-dd') + ' ' + @MB_Plant + ' ' + @MB_Shop + ' ' + @MB_Sysname + ' ' + @MB_CName + ' ' + '化學品日用量<下限 請注意用量'
      	  --SELECT @MB_CName, @today,@7day, @MB_LoLimit*@7day,@MB_HiLimit*@7day,@msg;
		  exec sp_mapp_insert @MB_SYS_GROUP, @msg
	  end
	  if(@today is not null and @7day is not null and (@today > @MB_HiLimitValue ) and @result=1)-- 20240621 by clark
	    begin
		  set @msg= FORMAT(@date, 'yyyy-MM-dd') + ' ' + @MB_Plant + ' ' + @MB_Shop + ' ' + @MB_Sysname + ' ' + @MB_CName + ' ' + '化學品日用量>上限 請注意用量'
      	  --SELECT @MB_CName, @today,@7day, @MB_LoLimit*@7day,@MB_HiLimit*@7day,@msg;
		  exec sp_mapp_insert @MB_SYS_GROUP, @msg
	  end
	end


    
	FETCH NEXT
    FROM @getid INTO @MB_Seq_ID,@MB_Plant,@MB_Shop,@MB_Sysname,@MB_CName,@MB_LimitType,
@MB_HiLimit,@MB_LoLimit,@MB_HiLimitValue,@MB_LoLimitValue
END

CLOSE @getid
DEALLOCATE @getid

END



