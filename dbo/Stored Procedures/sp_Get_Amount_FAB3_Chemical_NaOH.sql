


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB3_Chemical_NaOH]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2023-01-10'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_3B4T1 int
	DECLARE @M_SEQ_ID_W_3B4T2 int
	DECLARE @M_SEQ_ID_W_MB int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @M_SEQ_ID_W_WWTS_CUB int
	DECLARE @M_SEQ_ID_H_EXHC int
	DECLARE @M_SEQ_ID_H_EXHS int
	DECLARE @M_SEQ_ID_H_HPM int
	DECLARE @Plant varchar(50) ='FAB3';
	DECLARE @CName varchar(50) ='NaOH';
	DECLARE @MAmount_UPWS decimal(18, 4)=0
	DECLARE @MAmount_3B4T1 decimal(18, 4)=0
	DECLARE @MAmount_3B4T2 decimal(18, 4)=0
	DECLARE @MAmount_MB decimal(18, 4)=0
	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_WWTS_CUB decimal(18, 4)=0
	DECLARE @MAmount_EXHC decimal(18, 4)=0
	DECLARE @MAmount_EXHS decimal(18, 4)=0
	DECLARE @MAmount_HPM decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T4 decimal(18, 4)=0
	DECLARE @MAmount_T5 decimal(18, 4)=0
	DECLARE @MAmount_T6 decimal(18, 4)=0
	DECLARE @MAmount_T7 decimal(18, 4)=0
	DECLARE @MAmount_T8 decimal(18, 4)=0
	DECLARE @MAmount_T51 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T4A decimal(18, 4)=0
	DECLARE @MAmount_T5A decimal(18, 4)=0
	DECLARE @MAmount_T51A decimal(18, 4)=0
	DECLARE @MAmount_T6A decimal(18, 4)=0
	DECLARE @MAmount_T7A decimal(18, 4)=0
	DECLARE @MAmount_T8A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
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

	DECLARE @M_FillingQtyWWTS_CUB decimal(18, 2)
	DECLARE @M_WeightTransferParaWWTS_CUB decimal(18, 2)

	DECLARE @M_FillingQtyEXHS decimal(18, 2)
	DECLARE @M_WeightTransferParaEXHS decimal(18, 2)
	DECLARE @M_FillingQtyHPM decimal(18, 2)
	DECLARE @M_WeightTransferParaHPM decimal(18, 2)

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

	SELECT @M_SEQ_ID_W_3B4T1 = A.M_Seq_ID,@MAmount_3B4T1=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS 3B4T 一期') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_3B4T2 = A.M_Seq_ID,@MAmount_3B4T2=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS 3B4T 二期') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_MB = A.M_Seq_ID,@MAmount_MB=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS MB') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount,@M_FillingQtyWWTS=A.M_FillingQty,@M_WeightTransferParaWWTS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS_CUB = A.M_Seq_ID,@MAmount_WWTS_CUB=A.M_Amount,@M_FillingQtyWWTS_CUB=A.M_FillingQty,@M_WeightTransferParaWWTS_CUB=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS(CUB)') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHC = A.M_Seq_ID,@MAmount_EXHC=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS') AND m_Date = @StartDate  ;
	
	SELECT @M_SEQ_ID_H_EXHS = A.M_Seq_ID,@MAmount_EXHS=A.M_Amount,@M_FillingQtyEXHS=A.M_FillingQty,@M_WeightTransferParaEXHS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_HPM = A.M_Seq_ID,@MAmount_HPM=A.M_Amount,@M_FillingQtyHPM=A.M_FillingQty,@M_WeightTransferParaHPM=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='HPM') AND m_Date = @StartDate  ;


	--SET @MAmount_UPWS=0
	
	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_UPWS,@M_SEQ_ID_W_3B4T2,@M_SEQ_ID_W_3B4T1,@M_SEQ_ID_W_MB,@M_SEQ_ID_W_WWTS,@M_SEQ_ID_W_WWTS_CUB,@M_SEQ_ID_H_EXHS,@M_SEQ_ID_H_EXHC,@M_SEQ_ID_H_HPM) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_UPWS/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T1 ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_3B4T1/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T1;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T2 ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_3B4T2/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T2;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_MB ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_MB/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MB;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_WWTS/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;

		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS_CUB ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_WWTS_CUB+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_WWTS/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS_CUB;

		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHC ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_EXHC/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHC;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_EXHS/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_HPM ,[M_TotalQty] =(@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) ,[M_TotalPara] =@MAmount_HPM/(@MAmount_UPWS+@MAmount_EXHC+@MAmount_EXHS+@MAmount_HPM+@MAmount_WWTS+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_HPM;
		RETURN 
	END
		
	--資料取值 UPWS
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F310_UPW_LIA_1251_PV',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F310_UPW_LIA_1251_PV_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F310_UPW_LIA_1251_PV_COFF',5,3,@MAmount_T1C OUTPUT;
	
	--資料取值 UPWS 3B4T 一期
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T1,'F310_UPW_SAA_203A_OPEN_INN',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T1,'F310_UPW_SAA_203A_OPEN_INN_D',2,3,@MAmount_T2A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_MBLIT302_COEF',5,3,@MAmount_T4C OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C10_UPWS_NAOH_IN',3,3,@MAmount_T4IN OUTPUT;
	--SET @MAmount_T4=@MAmount_T4+@MAmount_T4IN
	
	--資料取值 UPWS 3B4T 二期
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T2,'F310_UPW_SAA_205_OPEN_INN',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T2,'F310_UPW_SAA_205_OPEN_INN_D',2,3,@MAmount_T3A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C20_EXHS_NAOH_CUB2FLTEU_COEF',5,3,@MAmount_T5C OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2C20_EXHS_NAOH_IN',3,3,@MAmount_T5IN OUTPUT;
	--SET @MAmount_T5=@MAmount_T5+@MAmount_T5IN

	--資料取值 UPWS MB
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MB,'F310_UPW_MBA_403_OPEN_INN',1,0,@MAmount_T4 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MB,'F310_UPW_MBA_403_OPEN_INN_D',2,3,@MAmount_T4A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2WB1_WWTS_NAOH_D2002CM_COEF',5,3,@MAmount_T6C OUTPUT;

	--資料取值 WWTS(CUB)
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_CUB,'F310_UPW_NH_1251A_OPEN_INN',1,0,@MAmount_T5 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_CUB,'F310_UPW_NH_1251A_OPEN_INN_D',2,3,@MAmount_T5A OUTPUT;

	--資料取值 WWTS
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F310Z_WWT_AV_2811_OPEN_INN',1,0,@MAmount_T51 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F310Z_WWT_AV_2811_OPEN_INN_D',2,3,@MAmount_T51A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2SRF_EXHS_NAOH_SUPARFLTEU_COEF',5,3,@MAmount_T7C OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2SRF_EXHS_NAOH_IN',3,3,@MAmount_T7IN OUTPUT;
	--SET @MAmount_T7=@MAmount_T7+@MAmount_T7IN

	--資料取值 EXHC
	
	--資料取值 EXHS
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F365L_EXH_SEX_LT_200',1,0,@MAmount_T7 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F365L_EXH_SEX_LT_200_D',2,3,@MAmount_T7A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F365L_EXH_SEX_LT_200_COFF',5,3,@MAmount_T7C OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F2HRF_EXHS_NAOH_IN',3,3,@MAmount_T8IN OUTPUT;
	--SET @MAmount_T8=@MAmount_T8+@MAmount_T8IN


	--資料取值 HPM
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_HPM,'F365E_EXH_SEX_LT_801',1,0,@MAmount_T8 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_HPM,'F365E_EXH_SEX_LT_801_D',2,3,@MAmount_T8A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_HPM,'F365E_EXH_SEX_LT_801_COFF',5,3,@MAmount_T8C OUTPUT;


	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	--upws充填
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferParaUPWS,@M_FillingQtyUPWS,@MAmount_UPWS OUTPUT;

	SET @MAmount_3B4T1 = ROUND(@MAmount_T2*@MAmount_T2A,4);

	SET @MAmount_3B4T2 = ROUND(@MAmount_T3*@MAmount_T3A,4);

	SET @MAmount_MB = ROUND(@MAmount_T4*@MAmount_T4A,4);

	SET @MAmount_WWTS_CUB = ROUND(@MAmount_T5*@MAmount_T5A,4) ;

	SET @MAmount_WWTS = ROUND(@MAmount_T51*@MAmount_T51A,4);

	--EXHS
	EXEC sp_GetAmountPi @MAmount_T7,@MAmount_T7A,@MAmount_T7C,@M_WeightTransferParaEXHS,0,@MAmount_EXHS OUTPUT;

	--HPM
	EXEC sp_GetAmountPi @MAmount_T8,@MAmount_T8A,@MAmount_T8C,@M_WeightTransferParaHPM,0,@MAmount_HPM OUTPUT;
	--EXEC sp_GetAmountPi @MAmount_T7,@MAmount_T7A,@MAmount_T7C,@M_WeightTransferParaWWTS,0,@MAmount_TK7 OUTPUT;
	--EXEC sp_GetAmountPi @MAmount_T8,@MAmount_T8A,@MAmount_T8C,@M_WeightTransferParaWWTS,0,@MAmount_TK8 OUTPUT;

	--wwts
	--EXEC sp_GetAmountPi @MAmount_T6,@MAmount_T6A,@MAmount_T6C,@M_WeightTransferParaWWTS,@M_FillingQtyWWTS,@MAmount_WWTS OUTPUT;


	SELECT @MAmount_UPWS,@MAmount_3B4T1,@MAmount_3B4T2,@MAmount_MB,@MAmount_WWTS,@MAmount_WWTS_CUB,@MAmount_EXHS,@MAmount_HPM;

	IF @MAmount_WWTS<1 BEGIN SET @MAmount_WWTS=0 END 
	IF @MAmount_WWTS_CUB<1 BEGIN SET @MAmount_WWTS_CUB=0 END
	IF @MAmount_UPWS<1 BEGIN SET @MAmount_UPWS=0 END 
	--SET @MAmount_UPWS=0
	IF @MAmount_3B4T1<1 BEGIN SET @MAmount_3B4T1=0 END
	IF @MAmount_3B4T2<1 BEGIN SET @MAmount_3B4T2=0 END
	IF @MAmount_MB<1 BEGIN SET @MAmount_MB=0 END 
	IF @MAmount_EXHS<1 BEGIN SET @MAmount_EXHS=0 END 
	IF @MAmount_HPM<1 BEGIN SET @MAmount_HPM=0 END
	

	--總量
	--SET @MAmount=@MAmount_UPWS+@MAmount_EXHS+@MAmount_WWTS+@MAmount_WWTS_CUB+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB+@MAmount_HPM
	SET @MAmount=@MAmount_EXHS+@MAmount_WWTS+@MAmount_WWTS_CUB+@MAmount_3B4T1+@MAmount_3B4T2+@MAmount_MB+@MAmount_HPM


	
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_WWTS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS_CUB ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_WWTS_CUB/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS_CUB;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_UPWS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T1 ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_3B4T1/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T1;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T2 ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_3B4T2/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T2;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_MB ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_MB/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MB;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_EXHS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_HPM ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_HPM/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_HPM;


END



