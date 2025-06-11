



CREATE PROCEDURE [dbo].[sp_Get_Amount_FABC_Chemical_NaOCl]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-03-22'
	DECLARE @StartDate AS DATE 
	DECLARE @Plant varchar(50) ='FABC';
	DECLARE @CName varchar(50) ='NaOCl';

	DECLARE @a_id	int
	DECLARE @b_id	int
	DECLARE @c_id	int
	DECLARE @d_id	int
	DECLARE @e_id	int
	DECLARE @f_id	int
	DECLARE @g_id	int

	DECLARE @a_amount	decimal(18, 4)=0
	DECLARE @b_amount	decimal(18, 4)=0
	DECLARE @c_amount	decimal(18, 4)=0
	DECLARE @d_amount	decimal(18, 4)=0
	DECLARE @e_amount	decimal(18, 4)=0
	DECLARE @f_amount	decimal(18, 4)=0
	DECLARE @g_amount	decimal(18, 4)=0

	DECLARE @a_weight	decimal(18, 4)=0
	DECLARE @b_weight	decimal(18, 4)=0
	DECLARE @c_weight	decimal(18, 4)=0
	DECLARE @d_weight	decimal(18, 4)=0
	DECLARE @e_weight	decimal(18, 4)=0
	DECLARE @f_weight	decimal(18, 4)=0
	DECLARE @g_weight	decimal(18, 4)=0

	DECLARE @MAmount_a decimal(18, 4)=0
	DECLARE @MAmount_b decimal(18, 4)=0
	DECLARE @MAmount_c decimal(18, 4)=0
	DECLARE @MAmount_d decimal(18, 4)=0
	DECLARE @MAmount_e decimal(18, 4)=0
	DECLARE @MAmount_f decimal(18, 4)=0
	DECLARE @MAmount_g decimal(18, 4)=0

	DECLARE @MAmount_a_v1 decimal(18, 4)=0
	DECLARE @MAmount_b_v1 decimal(18, 4)=0
	DECLARE @MAmount_c_v1 decimal(18, 4)=0
	DECLARE @MAmount_d_v1 decimal(18, 4)=0
	DECLARE @MAmount_e_v1 decimal(18, 4)=0
	DECLARE @MAmount_f_v1 decimal(18, 4)=0
	DECLARE @MAmount_g_v1 decimal(18, 4)=0

	DECLARE @MAmount_a_v2 decimal(18, 4)=0
	DECLARE @MAmount_b_v2 decimal(18, 4)=0
	DECLARE @MAmount_c_v2 decimal(18, 4)=0
	DECLARE @MAmount_d_v2 decimal(18, 4)=0
	DECLARE @MAmount_e_v2 decimal(18, 4)=0
	DECLARE @MAmount_f_v2 decimal(18, 4)=0
	DECLARE @MAmount_g_v2 decimal(18, 4)=0

	DECLARE @MAmount_d_v3 decimal(18, 4)=0
	DECLARE @MAmount_e_v3 decimal(18, 4)=0
	DECLARE @MAmount_f_v3 decimal(18, 4)=0
	DECLARE @MAmount_g_v3 decimal(18, 4)=0

	DECLARE @MAmount_a_v5 decimal(18, 4)=0
	DECLARE @MAmount_b_v5 decimal(18, 4)=0
	DECLARE @MAmount_c_v5 decimal(18, 4)=0
	DECLARE @MAmount_d_v5 decimal(18, 4)=0
	DECLARE @MAmount_e_v5 decimal(18, 4)=0
	DECLARE @MAmount_f_v5 decimal(18, 4)=0
	DECLARE @MAmount_g_v5 decimal(18, 4)=0

	DECLARE @M_FillingQty_a decimal(18, 4)


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
		@a_id		= A.M_Seq_ID,
		@a_amount	=A.M_Amount,
		@M_FillingQty_a			=A.M_FillingQty,
		@a_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='水務課' 
	AND MB_Sysname='WWTS'
	) AND m_Date = @StartDate  ;
	
	SELECT 
		@b_id		= A.M_Seq_ID,
		@b_amount	= A.M_Amount,
		@b_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='水務課' 
	AND MB_Sysname='MBRR~'
	) AND m_Date = @StartDate  ;
	
	SELECT 
		@c_id		= A.M_Seq_ID,
		@c_amount	= A.M_Amount,
		@c_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='空調課' 
	AND MB_Sysname='EXHO-RF~'
	) AND m_Date = @StartDate  ;

	SELECT 
		@d_id		= A.M_Seq_ID,
		@d_amount	= A.M_Amount,
		@d_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='空調課' 
	AND MB_Sysname='EXHO-FF2~'
	) AND m_Date = @StartDate  ;

	SELECT 
		@e_id		= A.M_Seq_ID,
		@e_amount	= A.M_Amount,
		@e_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='空調課' 
	AND MB_Sysname='EXHO-CarUX~'
	) AND m_Date = @StartDate  ;

	SELECT 
		@f_id		= A.M_Seq_ID,
		@f_amount	= A.M_Amount,
		@f_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='空調課' 
	AND MB_Sysname='EXHO-MOD~'
	) AND m_Date = @StartDate  ;

	SELECT 
		@g_id		= A.M_Seq_ID,
		@g_amount	= A.M_Amount,
		@g_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='空調課' 
	AND MB_Sysname='CHST~'
	) AND m_Date = @StartDate  ;



	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@a_id,
																		 @b_id,
																		 @c_id,
																		 @d_id,
																		 @e_id,
																		 @f_id,
																		 @g_id


																		 
	) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@a_amount	,[M_TotalQty] =@a_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@a_id	;
		UPDATE [Material_Table] SET [M_Amount] =@b_amount	,[M_TotalQty] =@b_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@b_id	;
		UPDATE [Material_Table] SET [M_Amount] =@c_amount	,[M_TotalQty] =@c_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@c_id	;
		UPDATE [Material_Table] SET [M_Amount] =@d_amount	,[M_TotalQty] =@d_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@d_id	;
		UPDATE [Material_Table] SET [M_Amount] =@e_amount	,[M_TotalQty] =@e_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@e_id	;
		UPDATE [Material_Table] SET [M_Amount] =@f_amount	,[M_TotalQty] =@f_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@f_id	;
		UPDATE [Material_Table] SET [M_Amount] =@g_amount	,[M_TotalQty] =@g_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@g_id	;

		RETURN 
	END

	--取得總用量
	EXEC sp_Get_FT_Amount @a_id,'L2C3W10W_WWTS_LIA_1701_PV',			1,0,@MAmount_a_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @a_id,'L2C3W10W_WWTS_LIA_1701_PV_D',		2,3,@MAmount_a_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @a_id,'L2C3W10W_WWTS_LIA_1701_PV_COEF',		5,3,@MAmount_a_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @b_id,'A-C (計算值)',			1,0,@MAmount_b_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @b_id,'A-C (計算值)_D',		2,3,@MAmount_b_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @b_id,'A-C (計算值)_COEF',		5,3,@MAmount_b_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @c_id,'L2BRF_CHE_Bleach_LT_622',			1,0,@MAmount_c_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @c_id,'L2BRF_CHE_Bleach_LT_622_D',		2,3,@MAmount_c_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @c_id,'L2BRF_CHE_Bleach_LT_622_COEF',	5,3,@MAmount_c_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @d_id,'L2BRF_C3_EXH_TANK_709_LT',			1,0,@MAmount_d_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @d_id,'L2BRF_C3_EXH_TANK_709_LT_D',		2,3,@MAmount_d_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @d_id,'L2BRF_C3_EXH_TANK_709_LT_INN',		3,3,@MAmount_d_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @d_id,'L2BRF_C3_EXH_TANK_709_LT_COEF',	5,3,@MAmount_d_v5 OUTPUT;
	set @MAmount_d_v1=@MAmount_d_v1+@MAmount_d_v3

	EXEC sp_Get_FT_Amount @e_id,'L2BRF_C3_EXH_TANK_707_LT',			1,0,@MAmount_e_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @e_id,'L2BRF_C3_EXH_TANK_707_LT_D',		2,3,@MAmount_e_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @e_id,'L2BRF_C3_EXH_TANK_707_LT_INN',		3,3,@MAmount_e_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @e_id,'L2BRF_C3_EXH_TANK_707_LT_COEF',	5,3,@MAmount_e_v5 OUTPUT;
	set @MAmount_e_v1=@MAmount_e_v1+@MAmount_e_v3

	EXEC sp_Get_FT_Amount @f_id,'L2BRF_C3_EXH_MOD_TANK_LT',		1,0,@MAmount_f_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @f_id,'L2BRF_C3_EXH_MOD_TANK_LT_D',		2,3,@MAmount_f_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @f_id,'L2BRF_C3_EXH_MOD_TANK_LT_INN',		3,3,@MAmount_f_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @f_id,'L2BRF_C3_EXH_MOD_TANK_LT_COEF',	5,3,@MAmount_f_v5 OUTPUT;
	set @MAmount_f_v1=@MAmount_f_v1+@MAmount_f_v3

	EXEC sp_Get_FT_Amount @g_id,'L2BRF_CHE_Bleach_LT_623',		1,0,@MAmount_g_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @g_id,'L2BRF_CHE_Bleach_LT_623_D',		2,3,@MAmount_g_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @g_id,'L2BRF_CHE_Bleach_LT_623_INN',		3,3,@MAmount_g_v3 OUTPUT;
	EXEC sp_Get_FT_Amount @g_id,'L2BRF_CHE_Bleach_LT_623_COEF',	5,3,@MAmount_g_v5 OUTPUT;
	set @MAmount_g_v1=@MAmount_g_v1+(@MAmount_g_v3*2.6)

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_a_v1,@MAmount_a_v2,@MAmount_a_v5,@a_weight	,@M_FillingQty_a,@MAmount_a OUTPUT;
	EXEC sp_GetAmountPi @MAmount_b_v1,@MAmount_b_v2,@MAmount_b_v5,@b_weight	,0				,@MAmount_b OUTPUT;
	EXEC sp_GetAmountPi @MAmount_c_v1,@MAmount_c_v2,@MAmount_c_v5,@c_weight	,0				,@MAmount_c OUTPUT;
	EXEC sp_GetAmountPi @MAmount_d_v1,@MAmount_d_v2,@MAmount_d_v5,@d_weight	,0				,@MAmount_d OUTPUT;
	EXEC sp_GetAmountPi @MAmount_e_v1,@MAmount_e_v2,@MAmount_e_v5,@e_weight	,0				,@MAmount_e OUTPUT;
	EXEC sp_GetAmountPi @MAmount_f_v1,@MAmount_f_v2,@MAmount_f_v5,@f_weight	,0				,@MAmount_f OUTPUT;
	--EXEC sp_GetAmountPi @MAmount_g_v1,@MAmount_g_v2,@MAmount_g_v5,@g_weight	,0				,@MAmount_g OUTPUT;


	SET @MAmount_g=((@MAmount_g_v1*@MAmount_g_v5)/100)*1000*@g_weight

	SET @a_amount = ISNULL(@MAmount_a, 0)
	SET @c_amount = ISNULL(@MAmount_c, 0)
	SET @d_amount = ISNULL(@MAmount_d, 0)
	SET @e_amount = ISNULL(@MAmount_e, 0)
	SET @f_amount = ISNULL(@MAmount_f, 0)
	SET @g_amount = ISNULL(@MAmount_g, 0)

	IF @a_amount < 1 BEGIN SET @a_amount = 0 END 
	IF @c_amount < 1 BEGIN SET @c_amount = 0 END 
	IF @d_amount < 1 BEGIN SET @d_amount = 0 END 
	IF @e_amount < 1 BEGIN SET @e_amount = 0 END 
	IF @f_amount < 1 BEGIN SET @f_amount = 0 END 
	IF @g_amount < 1 BEGIN SET @g_amount = 0 END 


	SET @c_amount = @d_amount + @e_amount + @f_amount + @g_amount
	SET @b_amount = @a_amount - @c_amount

	--因為@a_amount目前收值都為 0 所以 B = A -C 會有負值，所以再一次判別
	IF @b_amount < 1 BEGIN SET @b_amount = 0 END 

	UPDATE [Material_Table] SET [M_Amount] = @a_amount,	[M_TotalQty] =	@b_amount + @c_amount, [M_TotalPara] =1 WHERE  [M_Seq_ID]=@a_id	;
	UPDATE [Material_Table] SET [M_Amount] = @b_amount,	[M_TotalQty] = 0,					   [M_TotalPara] =1 WHERE  [M_Seq_ID]=@b_id	;
	UPDATE [Material_Table] SET [M_Amount] = @c_amount,	[M_TotalQty] = 0,					   [M_TotalPara] =1 WHERE  [M_Seq_ID]=@c_id	;
	UPDATE [Material_Table] SET [M_Amount] = @d_amount,	[M_TotalQty] = 0,					   [M_TotalPara] =1 WHERE  [M_Seq_ID]=@d_id	;
	UPDATE [Material_Table] SET [M_Amount] = @e_amount,	[M_TotalQty] = 0,					   [M_TotalPara] =1 WHERE  [M_Seq_ID]=@e_id	;
	UPDATE [Material_Table] SET [M_Amount] = @f_amount,	[M_TotalQty] = 0,					   [M_TotalPara] =1 WHERE  [M_Seq_ID]=@f_id	;
	UPDATE [Material_Table] SET [M_Amount] = @g_amount,	[M_TotalQty] = 0,					   [M_TotalPara] =1 WHERE  [M_Seq_ID]=@g_id	;


END



