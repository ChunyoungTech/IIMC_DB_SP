


CREATE PROCEDURE [dbo].[sp_Get_Amount_FABC_Chemical_CaCl2]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-03-17'
	DECLARE @StartDate AS DATE 
	DECLARE @Plant varchar(50) ='FABC';
	DECLARE @CName varchar(50) ='CaCl2';
	DECLARE @ftss_water_ab_id	int
	DECLARE @ftss_gas_cd_id		int
	DECLARE @gsts_gas_e_id		int

	DECLARE @ftss_water_ab_amount	decimal(18, 4)
	DECLARE @ftss_gas_cd_amount		decimal(18, 4)
	DECLARE @gsts_gas_e_amount		decimal(18, 4)

	DECLARE @ftss_water_ab_weight	decimal(18, 4)
	DECLARE @ftss_gas_cd_weight		decimal(18, 4)
	DECLARE @gsts_gas_e_weight		decimal(18, 4)

	DECLARE @MAmount_a	  decimal(18, 4)=0
	DECLARE @MAmount_b    decimal(18, 4)=0
	DECLARE @MAmount_c    decimal(18, 4)=0
	DECLARE @MAmount_d    decimal(18, 4)=0
	DECLARE @MAmount_e    decimal(18, 4)=0

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

	DECLARE @MAmount_a_v4 decimal(18, 4)=0
	DECLARE @MAmount_b_v4 decimal(18, 4)=0
	DECLARE @MAmount_c_v4 decimal(18, 4)=0
	DECLARE @MAmount_d_v4 decimal(18, 4)=0
	DECLARE @MAmount_e_v4 decimal(18, 4)=0

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
		@ftss_water_ab_id		= A.M_Seq_ID,
		@ftss_water_ab_amount	=A.M_Amount,
		@M_FillingQty_A			=A.M_FillingQty,
		@ftss_water_ab_weight	=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND 
	MB_Shop='水務課' 
	AND MB_Sysname='FTSS~'
	) AND m_Date = @StartDate  ;
	
	SELECT @ftss_gas_cd_id = A.M_Seq_ID,@ftss_gas_cd_amount=A.M_Amount,@ftss_gas_cd_weight=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='氣化課' AND MB_Sysname='FTSS~') AND m_Date = @StartDate  ;
	
	SELECT @gsts_gas_e_id = A.M_Seq_ID,@gsts_gas_e_amount=A.M_Amount,@gsts_gas_e_weight=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='氣化課' AND MB_Sysname='GSTS~') AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@ftss_water_ab_id,
																		 @ftss_gas_cd_id,	
																		 @gsts_gas_e_id	
	) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@ftss_water_ab_amount	,[M_TotalQty] =@ftss_water_ab_amount	 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@ftss_water_ab_id	;
		UPDATE [Material_Table] SET [M_Amount] =@ftss_gas_cd_amount		,[M_TotalQty] =@ftss_gas_cd_amount		 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@ftss_gas_cd_id	;	
		UPDATE [Material_Table] SET [M_Amount] =@gsts_gas_e_amount		,[M_TotalQty] =@gsts_gas_e_amount		 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@gsts_gas_e_id		;
		RETURN 
	END

	--取得總用量
	EXEC sp_Get_FT_Amount @ftss_water_ab_id,'L2K93W10A_WWTS_LIT_209C_PV',			1,0,@MAmount_a_v1 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ab_id,'L2K93W10A_WWTS_LIT_209C_PV_D',			2,3,@MAmount_a_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ab_id,'L2K93W10A_WWTS_LIT_209C_PV_COEF',		5,3,@MAmount_a_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @ftss_water_ab_id,'L2K93WWTS_500T_CaCl2_TOTOL',			1,1,@MAmount_b_v1 OUTPUT;
	--EXEC sp_Get_FT_Amount @ftss_water_ab_id,'L2K93WWTS_500T_CaCl2_TOTOL_D',			2,3,@MAmount_b_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_water_ab_id,'L2K93WWTS_500T_CaCl2_TOTOL_COEF',		5,3,@MAmount_b_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303A_TOTOL',				1,1,@MAmount_c_v1 OUTPUT;
	--EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303A_TOTOL_D',				2,3,@MAmount_c_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303A_TOTOL_DF',				4,3,@MAmount_c_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303A_TOTOL_COEF',			5,3,@MAmount_c_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303B_TOTOL',				1,1,@MAmount_d_v1 OUTPUT;
	--EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303B_TOTOL_D',				2,3,@MAmount_d_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303B_TOTOL_DF',				4,3,@MAmount_d_v4 OUTPUT;
	EXEC sp_Get_FT_Amount @ftss_gas_cd_id,'L2K93WWTS_FIQ303B_TOTOL_COEF',			5,3,@MAmount_d_v5 OUTPUT;

	EXEC sp_Get_FT_Amount @gsts_gas_e_id,'L2B1F_WWTS_CaCL2_FT_ALL',					1,1,@MAmount_e_v1 OUTPUT;
	--EXEC sp_Get_FT_Amount @gsts_gas_e_id,'L2B1F_WWTS_CaCL2_FT_ALL_D',				2,3,@MAmount_e_v2 OUTPUT;
	EXEC sp_Get_FT_Amount @gsts_gas_e_id,'L2B1F_WWTS_CaCL2_FT_ALL_COEF',			5,3,@MAmount_e_v5 OUTPUT;

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	--流量計計算:L * 比重
	EXEC sp_GetAmountPi @MAmount_a_v1, @MAmount_a_v2, @MAmount_a_v5, @ftss_water_ab_weight, @M_FillingQty_A, @MAmount_a OUTPUT;
	set @MAmount_b = @MAmount_b_v1 * @ftss_water_ab_weight;
	set @MAmount_c = @MAmount_c_v1 * @ftss_water_ab_weight / @MAmount_c_v4;
	set @MAmount_d = @MAmount_d_v1 * @ftss_water_ab_weight / @MAmount_d_v4;
	set @MAmount_e = @MAmount_e_v1 * @gsts_gas_e_weight;

	--計算各系統別用量總和
	set @ftss_water_ab_amount	=@MAmount_b; --=@MAmount_a + @MAmount_b;
	set @ftss_gas_cd_amount		=@MAmount_c + @MAmount_d;
	set @gsts_gas_e_amount		=@MAmount_e;

	IF @ftss_water_ab_amount	<1 BEGIN SET @ftss_water_ab_amount	=0 END 
	IF @ftss_gas_cd_amount		<1 BEGIN SET @ftss_gas_cd_amount	=0 END 
	IF @gsts_gas_e_amount		<1 BEGIN SET @gsts_gas_e_amount		=0 END 

	UPDATE [Material_Table] SET [M_Amount] =@ftss_water_ab_amount	,[M_TotalQty] =@ftss_water_ab_amount+@ftss_gas_cd_amount+@gsts_gas_e_amount	,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@ftss_water_ab_id	;
	UPDATE [Material_Table] SET [M_Amount] =@ftss_gas_cd_amount		,[M_TotalQty] =0		,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@ftss_gas_cd_id		;
	UPDATE [Material_Table] SET [M_Amount] =@gsts_gas_e_amount		,[M_TotalQty] =0		,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@gsts_gas_e_id		;
	
END



