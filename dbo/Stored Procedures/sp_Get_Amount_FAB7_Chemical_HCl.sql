


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB7_Chemical_HCl]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2022-12-15'
	DECLARE @StartDate AS DATE 

	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_RECL int
	DECLARE @M_SEQ_ID_W_MBR int
	DECLARE @Plant varchar(50) ='FAB7';
	DECLARE @CName varchar(50) ='HCl';
	DECLARE @MAmount_UPWS decimal(18,  4)=0
	DECLARE @MAmount_UPWS1 decimal(18,  4)=0
	DECLARE @MAmount_UPWS2 decimal(18,  4)=0
	DECLARE @MAmount_RECL decimal(18,  4)=0
	DECLARE @MAmount_MBR decimal(18,  4)=0


	DECLARE @RECL_1_1 decimal(18,  4)=0
	DECLARE @RECL_1_2 decimal(18,  4)=0
	DECLARE @RECL_1_5 decimal(18,  4)=0

	DECLARE @UPWS_1_1 decimal(18,  4)=0
	DECLARE @UPWS_1_2 decimal(18,  4)=0
	DECLARE @UPWS_1_5 decimal(18,  4)=0
	DECLARE @UPWS_2_1 decimal(18,  4)=0
	DECLARE @UPWS_2_2 decimal(18,  4)=0
	DECLARE @UPWS_2_3 decimal(18,  4)=0
	DECLARE @UPWS_2_5 decimal(18,  4)=0
	DECLARE @UPWS_3_1 decimal(18,  4)=0
	DECLARE @UPWS_3_2 decimal(18,  4)=0
	DECLARE @UPWS_3_3 decimal(18,  4)=0
	DECLARE @UPWS_3_5 decimal(18,  4)=0
	DECLARE @UPWS_4_1 decimal(18,  4)=0
	DECLARE @UPWS_4_2 decimal(18,  4)=0
	DECLARE @UPWS_4_5 decimal(18,  4)=0


	DECLARE @M_FillingQty_UPWS decimal(18,  4)
	DECLARE @M_WeightTransferPara_UPWS decimal(18,  4)



	--指定運算日期
	IF (@CalcDate<>'')
	BEGIN
		SET @StartDate =  @CalcDate ;
	END
	ELSE
	BEGIN
		SET @StartDate = CONVERT(VARCHAR(10), DATEADD(D, -1, GETDATE()), 111)  ;
	END

	--M_SEQ_ID
	SELECT @M_SEQ_ID_W_UPWS = A.M_Seq_ID, @MAmount_UPWS=A.M_Amount, @M_FillingQty_UPWS=A.M_FillingQty, @M_WeightTransferPara_UPWS=A.M_WeightTransferPara  
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(
		select b.MB_SEQ_ID 
		from Material_Base_Data b 
		where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS') 
	AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_RECL = A.M_Seq_ID
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(
		select b.MB_SEQ_ID 
		from Material_Base_Data b 
		where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='RECL') 
	AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_MBR = A.M_Seq_ID
	FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(
		select b.MB_SEQ_ID 
		from Material_Base_Data b 
		where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='MBR') 
	AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_UPWS, @M_SEQ_ID_W_RECL) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS , [M_TotalQty] =@MAmount_UPWS , [M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL , [M_TotalQty] =@MAmount_RECL , [M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_RECL;
		RETURN 
	END
		
	--取得總用量
	--RECL 
	--F7CB1R_RECL_LIT_931C_Total x
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL, 'F7CB1Q_RECL_FIQ_931C_Total', 1, 1, @RECL_1_1 OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL, 'F7CB1R_RECL_LIT_931C_Total_COEF', 5, 3, @RECL_1_5 OUTPUT;

	--UPWS
	--F7C10R_DIWT_LIT_901_PV
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_901_PV', 1, 0, @UPWS_1_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_901_PV_D', 2, 3, @UPWS_1_2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_901_PV_COEF', 5, 3, @UPWS_1_5 OUTPUT;
	SET @UPWS_1_1=@UPWS_1_1*3
									  
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931A', 1, 0, @UPWS_2_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931A_D', 2, 3, @UPWS_2_2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931A_INN', 3, 3, @UPWS_2_3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931A_COEF', 5, 3, @UPWS_2_5 OUTPUT;
	
									  
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931B', 1, 0, @UPWS_3_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931B_D', 2, 3, @UPWS_3_2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931B_INN', 3, 3, @UPWS_3_3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_DIWT_LIT_931B_COEF', 5, 3, @UPWS_3_5 OUTPUT;
	
	
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_UPWS_T431_INN', 1, 3, @UPWS_4_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_UPWS_T431_QTY', 2, 3, @UPWS_4_2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS, 'F7C10R_UPWS_T431_COEF', 5, 3, @UPWS_4_5 OUTPUT;
	SET @UPWS_4_1=@UPWS_4_1*@UPWS_4_2

	--sp_GetAmountPi 高, 直徑, 係數, 比重, 充填, 輸出

	SET @MAmount_RECL=@RECL_1_1*1000*@M_WeightTransferPara_UPWS

	EXEC sp_GetAmountPi  @UPWS_1_1,@UPWS_1_2, @UPWS_1_5, @M_WeightTransferPara_UPWS,  @M_FillingQty_UPWS,  @MAmount_UPWS OUTPUT;
	SET @MAmount_UPWS = @MAmount_UPWS-@MAmount_RECL


	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS , [M_TotalQty] =@MAmount_UPWS+@MAmount_RECL , [M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL , [M_TotalQty] =@MAmount_UPWS+@MAmount_RECL , [M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_RECL;
	--UPDATE [Material_Table] SET [M_Amount] =@MAmount_MBR , [M_TotalQty] =@MAmount_UPWS+@MAmount_RECL+@MAmount_MBR , [M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MBR;
	
END



