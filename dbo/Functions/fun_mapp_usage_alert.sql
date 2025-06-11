


CREATE function [dbo].[fun_mapp_usage_alert]
(
	@MB_Plant varchar(50),
	@MB_Shop varchar(50),
	@MB_Sysname varchar(50),
	@MB_CName varchar(50),

	@date date
)
RETURNS bit 
AS
begin

	declare @type varchar(50)
	declare @amount decimal(18,3)
	declare	@7day decimal(18,3)
	declare	@hi decimal(18,3)
	declare	@lo decimal(18,3)
	declare	@hiv decimal(18,3)
	declare	@lov decimal(18,3)

	SELECT @amount=mt.M_Amount,@type= mbd.MB_LimitType,@hi=mbd.MB_HiLimit,@hiv=mbd.MB_HiLimitValue,@lo=mbd.MB_LoLimit,@lov=mbd.MB_LoLimitValue
	FROM Material_Base_Data mbd
	JOIN Material_Table mt ON mbd.MB_Seq_ID=mt.MB_SEQ_ID
	WHERE mb_plant=@MB_Plant
	AND mb_shop=@MB_Shop
	AND mb_sysname=@MB_Sysname
	AND mb_cname=@MB_CName
	AND m_date = @date	

	--select @type,@amount

	if(@type='P')
	begin
		select @7day =avg from fun_mapp_usage_average( @MB_Plant,@MB_Shop,@MB_Sysname,@MB_CName,@date,7)
		if(@amount>@7day*@hi OR @amount< @7day*@lo)
			return 1
	end
	else  if(@type='V')
	begin
		if(@amount>@hiv OR @amount< @lov)
			return 1
	end

	return 0
	
end
