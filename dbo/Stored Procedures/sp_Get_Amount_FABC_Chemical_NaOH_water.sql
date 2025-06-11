




CREATE PROCEDURE [dbo].[sp_Get_Amount_FABC_Chemical_NaOH_water]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-12-28'
	DECLARE @StartDate AS DATE 
	DECLARE @Plant varchar(50) = 'FABC';
	DECLARE @CName varchar(50) = 'NaOH_水棟';

	DECLARE @wwts_a_id		int
	DECLARE @wwts_b_id		int
	DECLARE @diwt_cd_id		int
	DECLARE @wwtb_ef_id		int
	DECLARE @ftss_gas_e_id	int

	DECLARE @wwts_a_amount		decimal(18, 4)
	DECLARE @wwts_b_amount		decimal(18, 4)
	DECLARE @diwt_cd_amount		decimal(18, 4)
	DECLARE @wwtb_ef_amount		decimal(18, 4)
	DECLARE @ftss_gas_e_amount	decimal(18, 4)

	DECLARE @wwts_a_weight		decimal(18, 4)
	DECLARE @wwts_b_weight		decimal(18, 4)
	DECLARE @diwt_cd_weight		decimal(18, 4)
	DECLARE @wwtb_ef_weight		decimal(18, 4)
	DECLARE @ftss_gas_e_weight	decimal(18, 4)

	DECLARE @MAmount_a decimal(18, 4)=0
	DECLARE @MAmount_b decimal(18, 4)=0
	DECLARE @MAmount_c decimal(18, 4)=0
	DECLARE @MAmount_d decimal(18, 4)=0
	DECLARE @MAmount_e decimal(18, 4)=0
	DECLARE @MAmount_f decimal(18, 4)=0

	DECLARE @MAmount_a_v1 decimal(18, 4)=0
	DECLARE @MAmount_b_v1 decimal(18, 4)=0
	DECLARE @MAmount_c_v1 decimal(18, 4)=0
	DECLARE @MAmount_d_v1 decimal(18, 4)=0
	DECLARE @MAmount_e_v1 decimal(18, 4)=0
	DECLARE @MAmount_f_v1 decimal(18, 4)=0

	DECLARE @MAmount_a_v2 decimal(18, 4)=0
	DECLARE @MAmount_b_v2 decimal(18, 4)=0
	DECLARE @MAmount_c_v2 decimal(18, 4)=0
	DECLARE @MAmount_d_v2 decimal(18, 4)=0
	DECLARE @MAmount_e_v2 decimal(18, 4)=0
	DECLARE @MAmount_f_v2 decimal(18, 4)=0

	DECLARE @MAmount_b_v3 decimal(18, 4)=0
	DECLARE @MAmount_c_v3 decimal(18, 4)=0
	DECLARE @MAmount_d_v3 decimal(18, 4)=0
	DECLARE @MAmount_e_v3 decimal(18, 4)=0
	DECLARE @MAmount_f_v3 decimal(18, 4)=0

	DECLARE @MAmount_a_v4 decimal(18, 4)=0
	DECLARE @MAmount_b_v4 decimal(18, 4)=0
	DECLARE @MAmount_c_v4 decimal(18, 4)=0
	DECLARE @MAmount_d_v4 decimal(18, 4)=0
	DECLARE @MAmount_e_v4 decimal(18, 4)=0
	DECLARE @MAmount_f_v4 decimal(18, 4)=0

	DECLARE @MAmount_a_v5 decimal(18, 4)=0
	DECLARE @MAmount_b_v5 decimal(18, 4)=0
	DECLARE @MAmount_c_v5 decimal(18, 4)=0
	DECLARE @MAmount_d_v5 decimal(18, 4)=0
	DECLARE @MAmount_e_v5 decimal(18, 4)=0
	DECLARE @MAmount_f_v5 decimal(18, 4)=0

	DECLARE @M_FillingQty_a decimal(18, 4)
	DECLARE @M_FillingQty_b decimal(18, 4)


	--指定運算日期
	IF (@CalcDate<>'')
	BEGIN
		SET @StartDate =  @CalcDate;
	END
	ELSE
	BEGIN
		SET @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111);
	END

	--M_SEQ_ID
	SELECT 
		@wwts_a_id		= A.M_Seq_ID,
		@wwts_a_amount	= A.M_Amount,
		@M_FillingQty_a	= A.M_FillingQty,
		@wwts_a_weight	= A.M_WeightTransferPara  
	FROM  dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND	MB_Shop ='水務課' 
		AND MB_Sysname='WWTS'
	) AND m_Date = @StartDate;

	SELECT 
		@wwts_b_id		= A.M_Seq_ID,
		@wwts_b_amount	= A.M_Amount,
		@M_FillingQty_a	= A.M_FillingQty,
		@wwts_b_weight	= A.M_WeightTransferPara  
	FROM  dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND	MB_Shop ='水務課' 
		AND MB_Sysname='WWTS~'
	) AND m_Date = @StartDate;
	
	SELECT 
		@diwt_cd_id		= A.M_Seq_ID,
		@diwt_cd_amount	= A.M_Amount,
		@diwt_cd_weight	= A.M_WeightTransferPara  
	FROM  dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND MB_Shop = '水務課' 
		AND MB_Sysname = 'DIWT~'
	) AND m_Date = @StartDate;

	SELECT 
		@wwtb_ef_id		= A.M_Seq_ID,
		@wwtb_ef_amount = A.M_Amount,
		@wwtb_ef_weight = A.M_WeightTransferPara  
	FROM  dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND MB_Shop = '水務課' 
		AND	MB_Sysname = 'WWTB~'
	) AND m_Date = @StartDate;
	
	SELECT 
		@ftss_gas_e_id	   = A.M_Seq_ID,
		@ftss_gas_e_amount = A.M_Amount,
		@ftss_gas_e_weight = A.M_WeightTransferPara  
	FROM dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName
		AND MB_Plant = @Plant 
		AND	MB_Shop = '氣化課' 
		AND	MB_Sysname = 'FTSS'
	) AND m_Date = @StartDate;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN (@wwts_b_id,
																		  @diwt_cd_id,	
																		  @wwtb_ef_id
																		 
	) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] = @wwts_b_amount, [M_TotalQty] = @wwts_b_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwts_b_id;
		UPDATE [Material_Table] SET [M_Amount] = @diwt_cd_amount, [M_TotalQty] = @diwt_cd_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @diwt_cd_id;	
		UPDATE [Material_Table] SET [M_Amount] = @wwtb_ef_amount, [M_TotalQty] = @wwtb_ef_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwtb_ef_id;
		--UPDATE [Material_Table] SET [M_Amount] =@ftss_gas_e_amount		,[M_TotalQty] =@ftss_gas_e_amount		 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@ftss_gas_e_id		;
		RETURN 
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @wwts_a_id,'L2C3W10W_WWTS_LIA_1703A_PV',			1,0,@MAmount_a_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_a_id,'L2C3W10W_WWTS_LIA_1703A_PV_D',		2,3,@MAmount_a_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_a_id,'L2C3W10W_WWTS_LIA_1703A_PV_COEF',	5,3,@MAmount_a_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @wwts_b_id,'L2C3W10W_WWTS_LIA_1704_PV',			1,0,@MAmount_b_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_b_id,'L2C3W10W_WWTS_LIA_1704_PV_D',		2,3,@MAmount_b_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_b_id,'L2C3W10W_WWTS_LIA_1704_PV_INN',		3,3,@MAmount_b_v3 OUTPUT; --補藥閥開關液位差
	EXEC sp_Get_FT_Amount @wwts_b_id,'L2C3W10W_WWTS_LIA_1704_PV_DF',		4,3,@MAmount_b_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_b_id,'L2C3W10W_WWTS_LIA_1704_PV_COEF',		5,3,@MAmount_b_v5 OUTPUT;
	set @MAmount_b_v1=@MAmount_b_v1/2+@MAmount_b_v3

	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_281_PV',					1,0,@MAmount_c_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_281_PV_D',					2,3,@MAmount_c_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_281_PV_INN',				3,3,@MAmount_c_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_281_PV_COEF',				5,3,@MAmount_c_v5 OUTPUT;
	set @MAmount_c_v1=@MAmount_c_v1+@MAmount_c_v3
	
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_441_PV',					1,0,@MAmount_d_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_441_PV_D',					2,3,@MAmount_d_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_441_PV_INN',				3,3,@MAmount_d_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_cd_id,'C3DIW_LIA_441_PV_COEF',				5,3,@MAmount_d_v5 OUTPUT;
	set @MAmount_d_v1=@MAmount_d_v1+@MAmount_d_v3

	--SELECT @MAmount_c_v1,@MAmount_d_v1,@MAmount_c_v2,@MAmount_d_v2,@MAmount_c_v5,@MAmount_d_v5

	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_633_PV',					1,0,@MAmount_e_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_633_PV_D',				2,3,@MAmount_e_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_633_PV_INN',				3,3,@MAmount_e_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_633_PV_DF',				4,3,@MAmount_e_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_633_PV_COEF',				5,3,@MAmount_e_v5 OUTPUT;
	set @MAmount_e_v1=@MAmount_e_v1+@MAmount_e_v3

	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_527_PV',					1,0,@MAmount_f_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_527_PV_D',				2,3,@MAmount_f_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_527_PV_INN',				3,3,@MAmount_f_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_ef_id,'L2_BRWW_LT_527_PV_COEF',				5,3,@MAmount_f_v5 OUTPUT;
	set @MAmount_f_v1=@MAmount_f_v1+@MAmount_f_v3

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_a_v1, @MAmount_a_v2, @MAmount_a_v5, @wwts_b_weight, @M_FillingQty_a, @MAmount_a OUTPUT;
	EXEC sp_GetAmountPi @MAmount_b_v1, @MAmount_b_v2, @MAmount_b_v5, @wwts_b_weight, 0,			   @MAmount_b OUTPUT;
	EXEC sp_GetAmountPi @MAmount_c_v1, @MAmount_c_v2, @MAmount_c_v5, @diwt_cd_weight, 0,			   @MAmount_c OUTPUT;
	EXEC sp_GetAmountPi @MAmount_d_v1, @MAmount_d_v2, @MAmount_d_v5, @diwt_cd_weight, 0,			   @MAmount_d OUTPUT;
	EXEC sp_GetAmountPi @MAmount_e_v1, @MAmount_e_v2, @MAmount_e_v5, @wwtb_ef_weight, 0,			   @MAmount_e OUTPUT;
	EXEC sp_GetAmountPi @MAmount_f_v1, @MAmount_f_v2, @MAmount_f_v5, @wwtb_ef_weight, 0,			   @MAmount_f OUTPUT;

	if @MAmount_a is null  BEGIN set @MAmount_a = 0 end
	if @MAmount_b is null  BEGIN set @MAmount_b = 0 end
	if @MAmount_c is null  BEGIN set @MAmount_c = 0 end
	if @MAmount_d is null  BEGIN set @MAmount_d = 0 end
	if @MAmount_e is null  BEGIN set @MAmount_e = 0 end
	if @MAmount_f is null  BEGIN set @MAmount_f = 0 end

	--SELECT @wwts_b_amount,@diwt_cd_amount,@wwtb_ef_amount

	set @wwts_a_amount = @MAmount_a
	set @wwts_b_amount = @MAmount_b
	set @diwt_cd_amount = @MAmount_c + @MAmount_d;
	set @wwtb_ef_amount = @MAmount_e/@MAmount_e_v4 + @MAmount_f;	

	select @wwts_a_amount,@wwts_b_amount,@diwt_cd_amount,@wwtb_ef_amount

	IF @wwts_a_amount < 1 BEGIN SET @wwts_a_amount = 0 END 
	IF @wwts_b_amount < 1 BEGIN SET @wwts_b_amount = 0 END 
	IF @diwt_cd_amount < 1 BEGIN SET @diwt_cd_amount = 0 END 
	IF @wwtb_ef_amount < 1 BEGIN SET @wwtb_ef_amount = 0 END 
	

	UPDATE [Material_Table] SET [M_Amount] = @wwts_a_amount, [M_TotalQty] = @wwts_a_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwts_a_id;
	UPDATE [Material_Table] SET [M_Amount] = @wwts_b_amount, [M_TotalQty] = @wwts_b_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwts_b_id;
	UPDATE [Material_Table] SET [M_Amount] = @diwt_cd_amount, [M_TotalQty] = @diwt_cd_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @diwt_cd_id;
	UPDATE [Material_Table] SET [M_Amount] = @wwtb_ef_amount, [M_TotalQty] = @wwtb_ef_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwtb_ef_id;
	
END



