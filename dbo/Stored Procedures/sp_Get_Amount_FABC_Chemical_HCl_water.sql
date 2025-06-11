



CREATE PROCEDURE [dbo].[sp_Get_Amount_FABC_Chemical_HCl_water]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-12-12'
	DECLARE @StartDate AS DATE 
	DECLARE @Plant varchar(50) ='FABC';
	DECLARE @CName varchar(50) ='HCl_水棟';
	DECLARE @wwts_ade_id int
	DECLARE @wwtb_bc_id	 int
	DECLARE @diwt_id	 int


	DECLARE @wwts_ade_amount	decimal(18, 4)
	DECLARE @wwtb_bc_amount		decimal(18, 4)
	DECLARE @diwt_amount		decimal(18, 4)


	DECLARE @wwts_ade_weight	decimal(18, 4)
	DECLARE @wwtb_bc_weight		decimal(18, 4)
	DECLARE @diwt_weight		decimal(18, 4)


	DECLARE @MAmount_a decimal(18, 4)=0
	DECLARE @MAmount_b decimal(18, 4)=0
	DECLARE @MAmount_c decimal(18, 4)=0
	DECLARE @MAmount_d decimal(18, 4)=0
	DECLARE @MAmount_e decimal(18, 4)=0

	DECLARE @MAmount_a_v1 decimal(18, 4)=0
	DECLARE @MAmount_b_v1 decimal(18, 4)=0
	DECLARE @MAmount_c_v1 decimal(18, 4)=0
	DECLARE @MAmount_d_v1 decimal(18, 4)=0
	DECLARE @MAmount_e_v1 decimal(18, 4)=0

	DECLARE @MAmount_a_v2 decimal(18, 4)=0
	DECLARE @MAmount_b_v2 decimal(18, 4)=0
	DECLARE @MAmount_c_v2 decimal(18, 4)=0
	DECLARE @MAmount_d_v2 decimal(18, 4)=0
	DECLARE @MAmount_e_v2 decimal(18, 4)=0

	DECLARE @MAmount_b_v3 decimal(18, 4)=0
	DECLARE @MAmount_c_v3 decimal(18, 4)=0
	DECLARE @MAmount_d_v3 decimal(18, 4)=0
	DECLARE @MAmount_e_v3 decimal(18, 4)=0
	DECLARE @MAmount_c_v4 decimal(18, 4)=0

	DECLARE @MAmount_a_v5 decimal(18, 4)=0
	DECLARE @MAmount_b_v5 decimal(18, 4)=0
	DECLARE @MAmount_c_v5 decimal(18, 4)=0
	DECLARE @MAmount_d_v5 decimal(18, 4)=0
	DECLARE @MAmount_e_v5 decimal(18, 4)=0

	DECLARE @M_FillingQty_A decimal(18, 4)



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
		@wwts_ade_id		= A.M_Seq_ID,
		@wwts_ade_amount	= A.M_Amount,
		@M_FillingQty_A		= A.M_FillingQty,
		@wwts_ade_weight	= A.M_WeightTransferPara  
	FROM dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant 
		AND MB_Shop='水務課' 
		AND MB_Sysname='WWTS'
	) AND m_Date = @StartDate;
	
	SELECT 
		@wwtb_bc_id		= A.M_Seq_ID,
		@wwtb_bc_amount = A.M_Amount,
		@wwtb_bc_weight = A.M_WeightTransferPara  
	FROM dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant
		AND MB_Shop = '水務課' 
		AND MB_Sysname = 'WWTB~'
	) AND m_Date = @StartDate;

	SELECT 
		@diwt_id		= A.M_Seq_ID,
		@diwt_amount = A.M_Amount,
		@diwt_weight = A.M_WeightTransferPara  
	FROM dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName = @CName 
		AND MB_Plant = @Plant
		AND MB_Shop = '水務課' 
		AND MB_Sysname = 'DIWT~'
	) AND m_Date = @StartDate;
	
	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(
		@wwts_ade_id,
		@wwtb_bc_id,
		@diwt_id
	) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] = @wwts_ade_amount, [M_TotalQty] = @wwts_ade_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwts_ade_id;
		UPDATE [Material_Table] SET [M_Amount] = @wwtb_bc_amount , [M_TotalQty] = @wwtb_bc_amount , [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwtb_bc_id;
		UPDATE [Material_Table] SET [M_Amount] = @diwt_amount , [M_TotalQty] = @diwt_amount , [M_TotalPara] = 1 WHERE [M_Seq_ID] = @diwt_id;
		RETURN 
	END

	--取得總用量
	EXEC sp_Get_FT_Amount @wwts_ade_id,'C3DIW_LIA_801A_PV',			1,0,@MAmount_a_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_ade_id,'C3DIW_LIA_801A_PV_D',		2,3,@MAmount_a_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwts_ade_id,'C3DIW_LIA_801A_PV_COEF',	5,3,@MAmount_a_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_528_PV',			1,0,@MAmount_b_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_528_PV_D',		2,3,@MAmount_b_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_528_PV_INN',		3,3,@MAmount_b_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_528_PV_COEF',		5,3,@MAmount_b_v5 OUTPUT;
	set @MAmount_b_v1=@MAmount_b_v1+@MAmount_b_v3

	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_603_PV',			1,0,@MAmount_c_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_603_PV_D',		2,3,@MAmount_c_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_603_PV_INN',		3,3,@MAmount_c_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_603_PV_DF',		4,3,@MAmount_c_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @wwtb_bc_id,'L2_BRWW_LT_603_PV_COEF',		5,3,@MAmount_c_v5 OUTPUT;
	set @MAmount_c_v1=@MAmount_c_v1+@MAmount_c_v3

	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_271_PV',			1,0,@MAmount_d_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_271_PV_D',			2,3,@MAmount_d_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_271_PV_INN',			3,3,@MAmount_d_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_271_PV_COEF',		5,3,@MAmount_d_v5 OUTPUT;
	SET @MAmount_d_v1=@MAmount_d_v1+@MAmount_d_v3



	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_431_PV',			1,0,@MAmount_e_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_431_PV_D',			2,3,@MAmount_e_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_431_PV_INN',			3,3,@MAmount_e_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @diwt_id,'C3DIW_LIA_431_PV_COEF',		5,3,@MAmount_e_v5 OUTPUT;
	SET @MAmount_e_v1=@MAmount_e_v1+@MAmount_e_v3

	SELECT @MAmount_d_v1,@MAmount_d_v3,@MAmount_e_v1,@MAmount_e_v3

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_a_v1, @MAmount_a_v2, @MAmount_a_v5, @wwts_ade_weight, @M_FillingQty_A, @MAmount_a OUTPUT;
	EXEC sp_GetAmountPi @MAmount_b_v1, @MAmount_b_v2, @MAmount_b_v5, @wwtb_bc_weight,  0			  , @MAmount_b OUTPUT;
	EXEC sp_GetAmountPi @MAmount_c_v1, @MAmount_c_v2, @MAmount_c_v5, @wwtb_bc_weight,  0			  , @MAmount_c OUTPUT;
	EXEC sp_GetAmountPi @MAmount_d_v1, @MAmount_d_v2, @MAmount_d_v5, @wwts_ade_weight, 0			  , @MAmount_d OUTPUT;
	EXEC sp_GetAmountPi @MAmount_e_v1, @MAmount_e_v2, @MAmount_e_v5, @wwts_ade_weight, 0			  , @MAmount_e OUTPUT;

	SET @wwts_ade_amount = @MAmount_a-- + @MAmount_d + @MAmount_e;
	SET @diwt_amount=@MAmount_d+@MAmount_e
	SET @wwts_ade_amount=@MAmount_a-@diwt_amount
	SET @wwtb_bc_amount  = isnull(@MAmount_c, 0) / @MAmount_c_v4 + isnull(@MAmount_b, 0);

	IF @wwts_ade_amount	< 1 BEGIN SET @wwts_ade_amount = 0 END 
	IF @wwtb_bc_amount	< 1 BEGIN SET @wwtb_bc_amount  = 0 END 
	IF @diwt_amount	< 1 BEGIN SET @diwt_amount  = 0 END 

	SELECT @wwts_ade_amount,@wwtb_bc_amount,@diwt_amount


	UPDATE [Material_Table] SET [M_Amount] = @wwts_ade_amount, [M_TotalQty] = @wwts_ade_amount + @wwtb_bc_amount, [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwts_ade_id;
	UPDATE [Material_Table] SET [M_Amount] = @wwtb_bc_amount,  [M_TotalQty] = 0,								  [M_TotalPara] = 1 WHERE [M_Seq_ID] = @wwtb_bc_id;
	UPDATE [Material_Table] SET [M_Amount] = @diwt_amount,  [M_TotalQty] = 0,								  [M_TotalPara] = 1 WHERE [M_Seq_ID] = @diwt_id;

END



