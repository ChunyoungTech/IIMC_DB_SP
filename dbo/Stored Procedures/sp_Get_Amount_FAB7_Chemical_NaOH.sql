


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB7_Chemical_NaOH]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2025-01-13'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_RECL int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @M_SEQ_ID_H_EXHS int
	DECLARE @M_SEQ_ID_H_EXHC int
	DECLARE @M_SEQ_ID_H_CHST int
	DECLARE @Plant varchar(50) ='FAB7';
	DECLARE @CName varchar(50) ='NaOH';
	DECLARE @MAmount_UPWS decimal(18, 4)=0
	DECLARE @MAmount_UPWS1 decimal(18, 4)=0
	DECLARE @MAmount_UPWS2 decimal(18, 4)=0
	DECLARE @MAmount_RECL decimal(18, 4)=0
	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_EXHS decimal(18, 4)=0
	DECLARE @MAmount_EXHC decimal(18, 4)=0
	DECLARE @MAmount_CHST decimal(18, 4)=0
	DECLARE @MAmount_HCL decimal(18, 4)=0

	DECLARE @MAmount_UPWS_1 decimal(18, 4)=0
	DECLARE @MAmount_UPWS_2 decimal(18, 4)=0
	DECLARE @MAmount_RECL_1 decimal(18, 4)=0
	DECLARE @MAmount_WWTS_1 decimal(18, 4)=0
	DECLARE @MAmount_EXHS_1 decimal(18, 4)=0
	DECLARE @MAmount_EXHC_1 decimal(18, 4)=0
	DECLARE @MAmount_CHST_1 decimal(18, 4)=0
	
	DECLARE @MAmount_UPWS_1A decimal(18, 4)=0
	DECLARE @MAmount_UPWS_2A decimal(18, 4)=0
	DECLARE @MAmount_UPWS_3A decimal(18, 4)=0
	DECLARE @MAmount_RECL_1A decimal(18, 4)=0
	DECLARE @MAmount_WWTS_1A decimal(18, 4)=0
	DECLARE @MAmount_EXHS_1A decimal(18, 4)=0
	DECLARE @MAmount_EXHC_1A decimal(18, 4)=0
	DECLARE @MAmount_CHST_1A decimal(18, 4)=0
	
	DECLARE @MAmount_UPWS_1B decimal(18, 4)=0
	DECLARE @MAmount_UPWS_2B decimal(18, 4)=0
	DECLARE @MAmount_UPWS_3B decimal(18, 4)=0
	DECLARE @MAmount_RECL_1B decimal(18, 4)=0
	DECLARE @MAmount_WWTS_1B decimal(18, 4)=0
	DECLARE @MAmount_EXHS_1B decimal(18, 4)=0
	
	DECLARE @MAmount_UPWS_1C decimal(18, 4)=0
	DECLARE @MAmount_UPWS_2C decimal(18, 4)=0
	DECLARE @MAmount_UPWS_3C decimal(18, 4)=0
	DECLARE @MAmount_RECL_1C decimal(18, 4)=0
	DECLARE @MAmount_WWTS_1C decimal(18, 4)=0
	DECLARE @MAmount_EXHS_1C decimal(18, 4)=0
	DECLARE @MAmount_EXHC_1C decimal(18, 4)=0
	DECLARE @MAmount_CHST_1C decimal(18, 4)=0

	DECLARE @MAmount decimal(18, 4)=0
	DECLARE @M_FillingQtyUPWS decimal(18, 2)
	DECLARE @M_FillingQtyWWTS decimal(18, 2)
	DECLARE @M_FillingQtyRECL decimal(18, 2)
	DECLARE @M_FillingQtyEXHS decimal(18, 2)
	DECLARE @M_FillingQtyEXHC decimal(18, 2)
	DECLARE @M_FillingQtyCHST decimal(18, 2)
	DECLARE @M_WeightTransferParaUPWS decimal(18, 2)
	DECLARE @M_WeightTransferParaWWTS decimal(18, 2)
	DECLARE @M_WeightTransferParaRECL decimal(18, 2)
	DECLARE @M_WeightTransferParaEXHS decimal(18, 2)
	DECLARE @M_WeightTransferParaEXHC decimal(18, 2)
	DECLARE @M_WeightTransferParaCHST decimal(18, 2)



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
	SELECT @M_SEQ_ID_W_UPWS = A.M_Seq_ID,@MAmount_UPWS=A.M_Amount,@M_FillingQtyUPWS=A.M_FillingQty,@M_WeightTransferParaUPWS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_RECL = A.M_Seq_ID,@MAmount_RECL=A.M_Amount,@M_FillingQtyRECL=A.M_FillingQty,@M_WeightTransferParaRECL=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='RECL') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount,@M_FillingQtyWWTS=A.M_FillingQty,@M_WeightTransferParaWWTS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHS = A.M_Seq_ID,@MAmount_EXHS=A.M_Amount,@M_FillingQtyEXHS=A.M_FillingQty,@M_WeightTransferParaEXHS=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHC = A.M_Seq_ID,@MAmount_EXHC=A.M_Amount,@M_FillingQtyEXHC=A.M_FillingQty,@M_WeightTransferParaEXHC=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHC') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_CHST = A.M_Seq_ID,@MAmount_CHST=A.M_Amount,@M_FillingQtyCHST=A.M_FillingQty,@M_WeightTransferParaCHST=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='CHST') AND m_Date = @StartDate  ;

    SELECT @MAmount_HCL=A.M_Amount   FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName='HCL' AND MB_Plant='FAB7' AND MB_Shop='水務課' AND MB_Sysname='RECL') AND m_Date = @StartDate  ;


	
	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_UPWS,@M_SEQ_ID_W_RECL,@M_SEQ_ID_W_WWTS,@M_SEQ_ID_H_EXHS) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHS+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_WWTS/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHS+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_UPWS/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHS+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_RECL/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_RECL;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHS+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_EXHS/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHS;

		RETURN 
	END
		
	--UPS
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981A_PV',1,0,@MAmount_UPWS_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981A_PV_D',2,3,@MAmount_UPWS_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981A_PV_INN',3,3,@MAmount_UPWS_1B OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981A_PV_COEF',5,3,@MAmount_UPWS_1C OUTPUT;
	

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981B_PV',1,0,@MAmount_UPWS_2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981B_PV_D',2,3,@MAmount_UPWS_2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981B_PV_INN',3,3,@MAmount_UPWS_2B OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_DIWT_LIT_981B_PV_COEF',5,3,@MAmount_UPWS_2C OUTPUT;
	

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_UPWS_T441_INN', 1, 3,  @MAmount_UPWS_3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_UPWS_T441_QTY', 2, 3,  @MAmount_UPWS_3B OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F7C10R_UPWS_T441_COEF', 5, 3, @MAmount_UPWS_3C OUTPUT;
	SET @MAmount_UPWS_3A=@MAmount_UPWS_3A*@MAmount_UPWS_3B

	--RECL
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F7CB1Q_RECL_LIA_981C_PV',1,0,@MAmount_RECL_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F7CB1Q_RECL_LIA_981C_PV_D',2,3,@MAmount_RECL_1A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F7CB1Q_RECL_LIA_981C_PV_INN',3,3,@MAmount_RECL_1B OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F7CB1Q_RECL_LIA_981C_PV_COEF',5,3,@MAmount_RECL_1C OUTPUT;
	
	





	--WWT
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F7W10Y_WWTS_LIA_701B_PV',1,0,@MAmount_WWTS_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F7W10Y_WWTS_LIA_701B_PV_D',2,3,@MAmount_WWTS_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F7W10Y_WWTS_LIA_701B_PV_COEF',5,3,@MAmount_WWTS_1C OUTPUT;
	--701B 3桶連通
	SET @MAmount_WWTS_1=@MAmount_WWTS_1*3
	--EXHS
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F7G40W_EXHS_NAOH_USAGE',1,3,@MAmount_EXHS_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F7G40W_EXHS_NAOH_USAGE_D',2,3,@MAmount_EXHS_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F7G40W_EXHS_NAOH_USAGE_COEF',5,3,@MAmount_EXHS_1C OUTPUT;
	--EXHC
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F7F30F_EXHC_LT_710',1,0,@MAmount_EXHC_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F7F30F_EXHC_LT_710_D',2,3,@MAmount_EXHC_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F7F30F_EXHC_LT_710_COEF',5,3,@MAmount_EXHC_1C OUTPUT;
	--CHST
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_CHST,'F7CR1R_CHST_NAOH',1,0,@MAmount_CHST_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_CHST,'F7CR1R_CHST_NAOH_D',2,3,@MAmount_CHST_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_CHST,'F7CR1R_CHST_NAOH_COEF',5,3,@MAmount_CHST_1C OUTPUT;


	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	--recl

	IF @MAmount_HCL = 0	
		SET @MAmount_RECL = 0*485
	ELSE IF @MAmount_HCL BETWEEN 10 and 1700
		SET @MAmount_RECL = 1*485
	ELSE IF @MAmount_HCL BETWEEN 1700 and 3400
		SET @MAmount_RECL = 2*485

	--upws
	SET @MAmount_UPWS = (@MAmount_UPWS_2B*750 + @MAmount_UPWS_1B*750 + @MAmount_UPWS_3A)*@M_WeightTransferParaWWTS

	--wwts 
	EXEC sp_GetAmountPi @MAmount_WWTS_1,@MAmount_WWTS_1A,@MAmount_WWTS_1C,@M_WeightTransferParaWWTS,@M_FillingQtyWWTS,@MAmount_WWTS OUTPUT;
	SET @MAmount_WWTS= @MAmount_WWTS - @MAmount_UPWS - @MAmount_RECL


	--exhs
	EXEC sp_GetAmountPi @MAmount_EXHS_1,@MAmount_EXHS_1A,@MAmount_EXHS_1C,@M_WeightTransferParaEXHS,0,@MAmount_EXHS  OUTPUT;
	--exhc
	EXEC sp_GetAmountPi @MAmount_EXHC_1,@MAmount_EXHC_1A,@MAmount_EXHC_1C,@M_WeightTransferParaEXHC,@M_FillingQtyEXHC,@MAmount_EXHC  OUTPUT;
	--chst
	EXEC sp_GetAmountPi @MAmount_CHST_1,@MAmount_CHST_1A,@MAmount_CHST_1C,@M_WeightTransferParaCHST,@M_FillingQtyCHST,@MAmount_CHST  OUTPUT;

	--20241211 負值歸零
	IF (@MAmount_WWTS < 0 ) SET @MAmount_WWTS = 0
	IF (@MAmount_UPWS < 0 ) SET @MAmount_UPWS = 0
	IF (@MAmount_RECL < 0 ) SET @MAmount_RECL = 0
	IF (@MAmount_EXHS < 0 ) SET @MAmount_EXHS = 0
	IF (@MAmount_EXHC < 10 ) SET @MAmount_EXHC = 0
	IF (@MAmount_CHST < 10 ) SET @MAmount_CHST = 0


	--總量
	SET @MAmount=@MAmount_RECL+@MAmount_WWTS+@MAmount_UPWS +@MAmount_EXHS+@MAmount_EXHC+@MAmount_CHST

	
	
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_WWTS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_UPWS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_RECL/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_RECL;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_EXHS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHC ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_EXHC/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHC;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_CHST ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_CHST/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_CHST;

END



