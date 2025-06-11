

CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB2_Chemical_NaOH]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2023-01-10'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_UPWSx int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @M_SEQ_ID_H_EXHSx int
	DECLARE @Plant varchar(50) ='FAB2';
	DECLARE @CName varchar(50) ='NaOH';
	DECLARE @MAmount_UPWS decimal(18, 4)=0
	DECLARE @MAmount_UPWSx decimal(18, 4)=0
	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_EXHSx decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T4 decimal(18, 4)=0
	DECLARE @MAmount_T5 decimal(18, 4)=0
	DECLARE @MAmount_T6 decimal(18, 4)=0
	DECLARE @MAmount_T7 decimal(18, 4)=0
	DECLARE @MAmount_T8 decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T4A decimal(18, 4)=0
	DECLARE @MAmount_T5A decimal(18, 4)=0
	DECLARE @MAmount_T6A decimal(18, 4)=0
	DECLARE @MAmount_T7A decimal(18, 4)=0
	DECLARE @MAmount_T8A decimal(18, 4)=0
	DECLARE @MAmount_T3C decimal(18, 4)=0
	DECLARE @MAmount_T4C decimal(18, 4)=0
	DECLARE @MAmount_T5C decimal(18, 4)=0
	DECLARE @MAmount_T6C decimal(18, 4)=0
	DECLARE @MAmount_T7C decimal(18, 4)=0
	DECLARE @MAmount_T8C decimal(18, 4)=0
	DECLARE @MAmount_T4IN decimal(18, 4)=0
	DECLARE @MAmount_T5IN decimal(18, 4)=0
	DECLARE @MAmount_T7IN decimal(18, 4)=0
	DECLARE @MAmount_T8IN decimal(18, 4)=0
	DECLARE @MAmount_TK3 decimal(18, 4)=0
	DECLARE @MAmount_TK5 decimal(18, 4)=0
	DECLARE @MAmount_TK6 decimal(18, 4)=0
	DECLARE @MAmount decimal(18, 4)=0
	DECLARE @M_FillingQtyUPWS decimal(18, 2)
	DECLARE @M_WeightTransferParaUPWS decimal(18, 2)
	DECLARE @M_FillingQtyWWTS decimal(18, 2)
	DECLARE @M_WeightTransferParaWWTS decimal(18, 2)

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

	SELECT @M_SEQ_ID_W_UPWSx = A.M_Seq_ID,@MAmount_UPWSx=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS~') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount,@M_FillingQtyWWTS=A.M_FillingQty,@M_WeightTransferParaWWTS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHSx = A.M_Seq_ID,@MAmount_EXHSx=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS~') AND m_Date = @StartDate  ;



	
	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_UPWS,@M_SEQ_ID_W_UPWSx,@M_SEQ_ID_W_WWTS,@M_SEQ_ID_H_EXHSx) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =(@MAmount_UPWSx+@MAmount_EXHSx+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_WWTS/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =(@MAmount_UPWSx+@MAmount_EXHSx+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_UPWS/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWSx ,[M_TotalQty] =(@MAmount_UPWSx+@MAmount_EXHSx+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_UPWSx/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWSx;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHSx ,[M_TotalQty] =(@MAmount_UPWSx+@MAmount_EXHSx+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_EXHSx/(@MAmount_UPWS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHSx;
		RETURN 
	END
		
	--資料取值C3
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_LT207',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_LT207_D',2,3,@MAmount_T3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_LT207_COEF',5,3,@MAmount_T3C OUTPUT;
	
	--資料取值C4x
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_MBLIT302',1,0,@MAmount_T4 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_MBLIT302_D',2,3,@MAmount_T4A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_MBLIT302_COEF',5,3,@MAmount_T4C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_IN',3,3,@MAmount_T4IN OUTPUT;
	SET @MAmount_T4=@MAmount_T4+@MAmount_T4IN
	
	--資料取值C5x
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C20_EXHS_NAOH_CUB2FLTEU',1,0,@MAmount_T5 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C20_EXHS_NAOH_CUB2FLTEU_D',2,3,@MAmount_T5A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C20_EXHS_NAOH_CUB2FLTEU_COEF',5,3,@MAmount_T5C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C20_EXHS_NAOH_IN',3,3,@MAmount_T5IN OUTPUT;
	SET @MAmount_T5=@MAmount_T5+@MAmount_T5IN

	--資料取值C6
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2WB1_WWTS_NAOH_D2002CM',1,0,@MAmount_T6 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2WB1_WWTS_NAOH_D2002CM_D',2,3,@MAmount_T6A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2WB1_WWTS_NAOH_D2002CM_COEF',5,3,@MAmount_T6C OUTPUT;

	--資料取值C7x
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2SRF_EXHS_NAOH_SUPARFLTEU',1,0,@MAmount_T7 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2SRF_EXHS_NAOH_SUPARFLTEU_D',2,3,@MAmount_T7A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2SRF_EXHS_NAOH_SUPARFLTEU_COEF',5,3,@MAmount_T7C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2SRF_EXHS_NAOH_IN',3,3,@MAmount_T7IN OUTPUT;
	SET @MAmount_T7=@MAmount_T7+@MAmount_T7IN

	--資料取值C8x
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2HRF_EXHS_NAOH_HVACEXHSLT',1,0,@MAmount_T8 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2HRF_EXHS_NAOH_HVACEXHSLT_D',2,3,@MAmount_T8A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2HRF_EXHS_NAOH_HVACEXHSLT_COEF',5,3,@MAmount_T8C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2HRF_EXHS_NAOH_IN',3,3,@MAmount_T8IN OUTPUT;
	SET @MAmount_T8=@MAmount_T8+@MAmount_T8IN


	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	--upws充填
	EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3C,@M_WeightTransferParaUPWS,@M_FillingQtyUPWS,@MAmount_UPWS OUTPUT;

	--upes
	EXEC sp_GetAmountPi @MAmount_T4,@MAmount_T4A,@MAmount_T4C,@M_WeightTransferParaUPWS,0,@MAmount_UPWSx OUTPUT;

	--exhs
	EXEC sp_GetAmountPi @MAmount_T5,@MAmount_T5A,@MAmount_T5C,@M_WeightTransferParaWWTS,0,@MAmount_EXHSx OUTPUT;
	--EXEC sp_GetAmountPi @MAmount_T7,@MAmount_T7A,@MAmount_T7C,@M_WeightTransferParaWWTS,0,@MAmount_TK7 OUTPUT;
	--EXEC sp_GetAmountPi @MAmount_T8,@MAmount_T8A,@MAmount_T8C,@M_WeightTransferParaWWTS,0,@MAmount_TK8 OUTPUT;

	--wwts
	EXEC sp_GetAmountPi @MAmount_T6,@MAmount_T6A,@MAmount_T6C,@M_WeightTransferParaWWTS,@M_FillingQtyWWTS,@MAmount_WWTS OUTPUT;

	IF @MAmount_WWTS<1 BEGIN SET @MAmount_WWTS=0 END 
	IF @MAmount_UPWS<1 BEGIN SET @MAmount_UPWS=0 END 
	IF @MAmount_UPWSx<1 BEGIN SET @MAmount_UPWSx=0 END 
	IF @MAmount_EXHSx<1 BEGIN SET @MAmount_EXHSx=0 END 
	

	--總量
	SET @MAmount=@MAmount_UPWSx+@MAmount_EXHSx+@MAmount_WWTS


	
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_WWTS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_UPWS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWSx ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_UPWSx/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWSx;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHSx ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_EXHSx/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHSx;

END



