



CREATE PROCEDURE [dbo].[sp_Get_Amount_FABC_Chemical_NaOH_F]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-03-07'
	DECLARE @StartDate AS DATE 
	DECLARE @Plant varchar(50) = 'FABC';
	DECLARE @CName varchar(50) = 'NaOH_F系';

	DECLARE @ftss_water_ad_id int
	DECLARE @gsts_gas_bf_id	  int
	DECLARE @exhs_air_c_id	  int
	DECLARE @ftss_gas_e_id	  int

	DECLARE @ftss_water_ad_amount	decimal(18, 4)
	DECLARE @gsts_gas_bf_amount		decimal(18, 4)
	DECLARE @exhs_air_c_amount		decimal(18, 4)
	DECLARE @ftss_gas_e_amount		decimal(18, 4)

	DECLARE @ftss_water_ad_weight	decimal(18, 4)
	DECLARE @gsts_gas_bf_weight		decimal(18, 4)
	DECLARE @exhs_air_c_weight		decimal(18, 4)
	DECLARE @ftss_gas_e_weight		decimal(18, 4)

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

	DECLARE @MAmount_c_v3 decimal(18, 4)=0

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

	DECLARE @M_SUMQty decimal(18, 4)



	--指定運算日期
	IF (@CalcDate<>'')
	BEGIN
		SET @StartDate =  @CalcDate ;
	END
	ELSE
	BEGIN
		SET @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111)  ;
	END

	--M_SEQ_ID
	SELECT 
		@ftss_water_ad_id	  = A.M_Seq_ID,
		@ftss_water_ad_amount = A.M_Amount,
		@M_FillingQty_a		  = A.M_FillingQty,
		@ftss_water_ad_weight = A.M_WeightTransferPara  
	FROM dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND	MB_Shop = '水務課' 
		AND MB_Sysname='FTSS~'
	) AND m_Date = @StartDate;
	
	SELECT 
		@gsts_gas_bf_id		= A.M_Seq_ID,
		@gsts_gas_bf_amount	= A.M_Amount,
		@M_FillingQty_b		= A.M_FillingQty,
		@gsts_gas_bf_weight	= A.M_WeightTransferPara  
	FROM dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName 
		AND MB_Plant = @Plant 
		AND	MB_Shop = '氣化課' 
		AND MB_Sysname='GSTS~'
	) AND m_Date = @StartDate;

	SELECT 
		@exhs_air_c_id	   = A.M_Seq_ID,
		@exhs_air_c_amount = A.M_Amount,
		@exhs_air_c_weight = A.M_WeightTransferPara  
	FROM dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND MB_Shop = '空調課' 
		AND MB_Sysname='EXHS~'
	) AND m_Date = @StartDate;
	
	SELECT 
		@ftss_gas_e_id	   = A.M_Seq_ID,
		@ftss_gas_e_amount = A.M_Amount,
		@ftss_gas_e_weight = A.M_WeightTransferPara  
	FROM dbo.Material_Table A 
	WHERE a.MB_SEQ_ID = (select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND	MB_Shop = '氣化課' 
		AND	MB_Sysname = 'FTSS~'
	) AND m_Date = @StartDate;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@ftss_water_ad_id,
																		 @gsts_gas_bf_id,	
																		 @exhs_air_c_id,
																		 @ftss_gas_e_id
	) AND M_MenuRemark<>'')


	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] = @ftss_water_ad_amount, [M_TotalQty] = @ftss_water_ad_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @ftss_water_ad_id;
		UPDATE [Material_Table] SET [M_Amount] = @gsts_gas_bf_amount,   [M_TotalQty] = @gsts_gas_bf_amount,   [M_TotalPara] = 1 WHERE [M_Seq_ID] = @gsts_gas_bf_id;	
		UPDATE [Material_Table] SET [M_Amount] = @exhs_air_c_amount,	[M_TotalQty] = @exhs_air_c_amount,	  [M_TotalPara] = 1 WHERE [M_Seq_ID] = @exhs_air_c_id;
		UPDATE [Material_Table] SET [M_Amount] = @ftss_gas_e_amount,	[M_TotalQty] = @ftss_gas_e_amount,	  [M_TotalPara] = 1 WHERE [M_Seq_ID] = @ftss_gas_e_id;
		RETURN 
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93W10A_WWTS_LIA_200_PV',		1,0,@MAmount_a_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93W10A_WWTS_LIA_200_PV_D',		2,3,@MAmount_a_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93W10A_WWTS_LIA_200_PV_COEF',	5,3,@MAmount_a_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_T_722_LT',				1,0,@MAmount_b_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_T_722_LT_D',			2,3,@MAmount_b_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_T_722_LT_COEF',			5,3,@MAmount_b_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @exhs_air_c_id,		'L2BRF_K93_SEX_NAOH_LT',			1,0,@MAmount_c_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @exhs_air_c_id,		'L2BRF_K93_SEX_NAOH_LT_D',			2,3,@MAmount_c_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @exhs_air_c_id,		'L2BRF_K93_SEX_NAOH_LT_INN',		3,3,@MAmount_c_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @exhs_air_c_id,		'L2BRF_K93_SEX_NAOH_LT_DF',			4,3,@MAmount_c_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @exhs_air_c_id,		'L2BRF_K93_SEX_NAOH_LT_COEF',		5,3,@MAmount_c_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93WWTS_500T_NaOH_TOTOL',		1,1,@MAmount_d_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93WWTS_500T_NaOH_TOTOL_D',		2,3,@MAmount_d_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93WWTS_500T_NaOH_TOTOL_DF',		4,3,@MAmount_d_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ad_id,	'L2K93WWTS_500T_NaOH_TOTOL_COEF',	5,3,@MAmount_d_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @ftss_gas_e_id,		'L2K93WWTS_FIQ202_TOTOL',			1,1,@MAmount_e_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_e_id,		'L2K93WWTS_FIQ202_TOTOL_D',			2,3,@MAmount_e_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_e_id,		'L2K93WWTS_FIQ202_TOTOL_DF',		4,3,@MAmount_e_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_e_id,		'L2K93WWTS_FIQ202_TOTOL_COEF',		5,3,@MAmount_e_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_NaOH_FT_ALL',			1,1,@MAmount_f_v1 OUTPUT;
	--EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_NaOH_FT_ALL_D',			2,3,@MAmount_f_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_NaOH_FT_ALL_DF',		4,3,@MAmount_f_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @gsts_gas_bf_id,		'L2B1F_WWTS_NaOH_FT_ALL_COEF',		5,3,@MAmount_f_v5 OUTPUT;

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出

	--EXEC sp_GetAmountPi @MAmount_b_v1, @MAmount_b_v2, @MAmount_b_v5, @gsts_gas_bf_weight,   @M_FillingQty_b, @MAmount_b OUTPUT;

	SET @MAmount_c = (@MAmount_c_v1/100+@MAmount_c_v3/100)*3000/@MAmount_c_v4*@exhs_air_c_weight;

	SET @MAmount_d = @MAmount_d_v1 * @gsts_gas_bf_weight / @MAmount_d_v4;

	SET @MAmount_e = @MAmount_e_v1 * @ftss_gas_e_weight	 / @MAmount_e_v4;

	SET @MAmount_f = (@MAmount_f_v1*@MAmount_f_v5)/@MAmount_f_v4 * @gsts_gas_bf_weight;

	select @MAmount_e, @MAmount_e_v1, @MAmount_e_v2, @MAmount_e_v4, @MAmount_e_v5;


	set @ftss_water_ad_amount	= ISNULL( @MAmount_a, 0) + ISNULL( @MAmount_d, 0);

	set @gsts_gas_bf_amount		= ISNULL( @MAmount_b, 0)+ ISNULL(@MAmount_f, 0);

	set @exhs_air_c_amount		= ISNULL( @MAmount_c, 0);	

	set @ftss_gas_e_amount		= ISNULL( @MAmount_e, 0);


	set @M_SUMQty = @ftss_water_ad_amount + @gsts_gas_bf_amount + @exhs_air_c_amount + @ftss_gas_e_amount;

	IF @ftss_water_ad_amount	< 1 BEGIN SET @ftss_water_ad_amount	=0 END 
	IF @gsts_gas_bf_amount		< 1 BEGIN SET @gsts_gas_bf_amount	=0 END 
	IF @exhs_air_c_amount		< 1 BEGIN SET @exhs_air_c_amount	=0 END 
	IF @ftss_gas_e_amount		< 1 BEGIN SET @ftss_gas_e_amount	=0 END 

	UPDATE [Material_Table] SET [M_Amount] = @ftss_water_ad_amount, [M_TotalQty] =@M_SUMQty, [M_TotalPara] = 1 WHERE  [M_Seq_ID] = @ftss_water_ad_id;
	UPDATE [Material_Table] SET [M_Amount] = @gsts_gas_bf_amount,   [M_TotalQty] =0,		 [M_TotalPara] = 1 WHERE  [M_Seq_ID] = @gsts_gas_bf_id;
	UPDATE [Material_Table] SET [M_Amount] = @exhs_air_c_amount,	[M_TotalQty] =0,		 [M_TotalPara] = 1 WHERE  [M_Seq_ID] = @exhs_air_c_id;
	UPDATE [Material_Table] SET [M_Amount] = @ftss_gas_e_amount,	[M_TotalQty] =0,		 [M_TotalPara] = 1 WHERE  [M_Seq_ID] = @ftss_gas_e_id;

END



