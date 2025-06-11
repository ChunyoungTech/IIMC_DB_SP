
-- Batch submitted through debugger: SQLQuery5.sql|7|0|C:\Users\CMOF8\AppData\Local\Temp\~vs7B.sql

-- =============================================
-- Author:		Clark
-- Create date: 2018/1/1
-- Exec Sample: exec [sp_Get_FT_Amount] @M_SEQ_ID,@TagName,@ValueSEQ,@Reverse,@Amount output;
-- @M_SEQ_ID  : 傳入用量主檔流水號
-- @TagName   : 傳入I_TAG要查詢的TAGNAME，若@ValueSEQ=1就是查詢I_TAG1=@TagName
-- @ValueSEQ  : 傳入1~5，代表查詢I_VALUE1或I_VALUE2、I_VALUE3、I_VALUE4、I_VALUE5
-- @Reverse   : 是否反向，0為前減後，1為後減前,2為傳出StartValue,3為傳出EndValue
-- @Amount   : 回傳的運算結果值
-- Description:	單一TAG計算
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_FT_Amount]
	@M_SEQ_ID int,
	@TagName AS varchar(100),
	@ValueSEQ AS int,
	@Reverse AS int,
	@MAmount as decimal(18, 4) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @StartValue  varchar(50);
	DECLARE @EndValue varchar(50);
	
	IF (@ValueSEQ=1)
	BEGIN
		select top 1  @StartValue=I_Value1 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag1=@TagName AND I_Type='S';
		select top 1  @EndValue=I_Value1 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag1=@TagName  AND I_Type='E'  ;
	END;
	IF (@ValueSEQ=2)
	BEGIN
		select top 1  @StartValue=I_Value2 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag2=@TagName AND I_Type='S';
		select top 1  @EndValue=I_Value2 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag2=@TagName  AND I_Type='E'  ;
	END;
	IF (@ValueSEQ=3)
	BEGIN
		select top 1  @StartValue=I_Value3 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag3=@TagName  AND I_Type='S';
	    select top 1  @EndValue=I_Value3 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag3=@TagName AND I_Type='E'  ; 
	END;
	IF (@ValueSEQ=4)
	BEGIN
		select top 1  @StartValue=I_Value4 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag4=@TagName  AND I_Type='S';
	    select top 1  @EndValue=I_Value4 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag4=@TagName  AND I_Type='E'  ;
	END;
	IF (@ValueSEQ=5)
	BEGIN
		select top 1  @StartValue=I_Value5 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag5=@TagName  AND I_Type='S';
	    select top 1  @EndValue=I_Value5 from IDMC_Table where M_SEQ_ID=@M_SEQ_ID and I_Tag5=@TagName  AND I_Type='E'   ;
	END;
	
	--液位計用	
	if (@Reverse=0)
	Begin 
		SET @MAmount=ROUND( @StartValue ,4)-ROUND( @EndValue,4);
		--set @MAmount=ROUND( CONVERT(decimal, @StartValue) ,2)-ROUND( CONVERT(decimal, @EndValue),2);
	end
	
	--流量計用
	if (@Reverse=1) 
	Begin
		set @MAmount=ROUND( @EndValue,4)-ROUND( @StartValue ,4);
		--set @MAmount=ROUND(CONVERT(decimal, @EndValue),2)-ROUND(CONVERT(decimal, @StartValue) ,2);
		
		
	end 
 
	--取開始值
 	if (@Reverse=2) 
	Begin
		set @MAmount=ROUND( @StartValue ,4) ;
		--set @MAmount=ROUND( CONVERT(decimal, @StartValue) ,2) ;
		
	end 
	
	--取結束值
	if (@Reverse=3) 
	Begin
		set @MAmount=ROUND( @EndValue ,4) ;
		--set @MAmount=ROUND( CONVERT(decimal, @EndValue) ,2) ;
	end 
	
	--O2 用
	if (@Reverse=4)
	Begin 
		SET @StartValue=ROUND(@StartValue,4)
		SET @EndValue=ROUND(@EndValue,4)
		SELECT @StartValue=[AOM_KG] FROM [AR_O2_MAPPING]WHERE MB_SEQ_ID=13 AND AOM_PERCENT=@StartValue;
		SELECT @EndValue=[AOM_KG] FROM [AR_O2_MAPPING]WHERE MB_SEQ_ID=13 AND AOM_PERCENT=@EndValue;
		SET @StartValue=ROUND(@StartValue,4)-ROUND(@EndValue,4)
		set @MAmount=@StartValue;
	end

 	RETURN;
 	
 	
END

 



