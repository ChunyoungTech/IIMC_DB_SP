




CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB3_Chemical_NaOCl]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-12-11'
	DECLARE @StartDate AS DATE 
	--DECLARE @M_SEQ_ID_W_MBRS int
	DECLARE @M_SEQ_ID_W_RECL int
	--DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @M_SEQ_ID_H_EXHT int
	DECLARE @M_SEQ_ID_H_CHSC int
	DECLARE @Plant varchar(50) ='FAB3';
	DECLARE @CName varchar(50) ='NaOCl';
	--DECLARE @MAmount_MBRS decimal(18, 4)=0
	DECLARE @MAmount_RECL decimal(18, 4)=0
	--DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_EXHT decimal(18, 4)=0
	DECLARE @MAmount_CHSC decimal(18, 4)=0

	--DECLARE @MAmount_MBRS_1 decimal(18, 4)=0
	DECLARE @MAmount_RECL_1 decimal(18, 4)=0
	--DECLARE @MAmount_WWTS_1 decimal(18, 4)=0
	DECLARE @MAmount_EXHT_1 decimal(18, 4)=0
	DECLARE @MAmount_CHSC_1 decimal(18, 4)=0
	
	--DECLARE @MAmount_MBRS_1A decimal(18, 4)=0
	DECLARE @MAmount_RECL_1A decimal(18, 4)=0
	--DECLARE @MAmount_WWTS_1A decimal(18, 4)=0
	DECLARE @MAmount_EXHT_1A decimal(18, 4)=0
	DECLARE @MAmount_CHSC_1A decimal(18, 4)=0
	
	--DECLARE @MAmount_MBRS_1B decimal(18, 4)=0
	DECLARE @MAmount_RECL_1B decimal(18, 4)=0
	--DECLARE @MAmount_WWTS_1B decimal(18, 4)=0
	DECLARE @MAmount_EXHT_1B decimal(18, 4)=0
	DECLARE @MAmount_CHSC_1B decimal(18, 4)=0

	--DECLARE @MAmount_MBRS_1C decimal(18, 4)=0
	DECLARE @MAmount_RECL_1C decimal(18, 4)=0
	--DECLARE @MAmount_WWTS_1C decimal(18, 4)=0
	DECLARE @MAmount_EXHT_1C decimal(18, 4)=0
	DECLARE @MAmount_CHSC_1C decimal(18, 4)=0



	DECLARE @MAmount decimal(18, 4)=0
	--DECLARE @M_FillingQtyMBRS decimal(18, 2)
	--DECLARE @M_FillingQtyWWTS decimal(18, 2)
	DECLARE @M_FillingQtyRECL decimal(18, 2)
	DECLARE @M_FillingQtyEXHT decimal(18, 2)
	DECLARE @M_FillingQtyCHSC decimal(18, 2)
	--DECLARE @M_WeightTransferParaMBRS decimal(18, 2)
	--DECLARE @M_WeightTransferParaWWTS decimal(18, 2)
	DECLARE @M_WeightTransferParaRECL decimal(18, 2)
	DECLARE @M_WeightTransferParaEXHT decimal(18, 2)
	DECLARE @M_WeightTransferParaCHSC decimal(18, 2)



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
	--SELECT @M_SEQ_ID_W_MBRS = A.M_Seq_ID,@MAmount_MBRS=A.M_Amount,@M_FillingQtyMBRS=A.M_FillingQty,@M_WeightTransferParaMBRS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	--WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='MBRS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_RECL = A.M_Seq_ID,@MAmount_RECL=A.M_Amount,@M_FillingQtyRECL=A.M_FillingQty,@M_WeightTransferParaRECL=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='RECL') AND m_Date = @StartDate  ;

	--SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount,@M_FillingQtyWWTS=A.M_FillingQty,@M_WeightTransferParaWWTS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	--WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHT = A.M_Seq_ID,@MAmount_EXHT=A.M_Amount,@M_FillingQtyEXHT=A.M_FillingQty,@M_WeightTransferParaEXHT=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHT') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_CHSC = A.M_Seq_ID,@MAmount_CHSC=A.M_Amount,@M_FillingQtyCHSC=A.M_FillingQty,@M_WeightTransferParaCHSC=A.M_WeightTransferPara    FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='CHSC') AND m_Date = @StartDate  ;



	
	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_RECL,@M_SEQ_ID_H_CHSC,@M_SEQ_ID_H_EXHT) AND M_MenuRemark<>'')
	BEGIN 
		--UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHT+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_WWTS/(@MAmount_MBRS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		--UPDATE [Material_Table] SET [M_Amount] =@MAmount_MBRS ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHT+@MAmount_WWTS) ,[M_TotalPara] =@MAmount_MBRS/(@MAmount_MBRS+@MAmount_WWTS) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MBRS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHT+@MAmount_CHSC) ,[M_TotalPara] =@MAmount_RECL/(@MAmount_RECL+@MAmount_EXHT+@MAmount_CHSC) WHERE  [M_Seq_ID]=@M_SEQ_ID_W_RECL;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHT ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHT+@MAmount_CHSC) ,[M_TotalPara] =@MAmount_EXHT/(@MAmount_RECL+@MAmount_EXHT+@MAmount_CHSC) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHT;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_CHSC ,[M_TotalQty] =(@MAmount_RECL+@MAmount_EXHT+@MAmount_CHSC) ,[M_TotalPara] =@MAmount_CHSC/(@MAmount_RECL+@MAmount_EXHT+@MAmount_CHSC) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_CHSC;
		RETURN 
	END
		
	--MBR
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MBRS,'F7S20Y_MBR_LIT_1861_PV',1,0,@MAmount_MBRS_1 OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MBRS,'F7S20Y_MBR_LIT_1861_PV_D',2,3,@MAmount_MBRS_1A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MBRS,'F7S20Y_MBR_LIT_1861_PV_INN',3,3,@MAmount_MBRS_1B OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MBRS,'F7S20Y_MBR_LIT_1861_PV_COEF',5,3,@MAmount_MBRS_1C OUTPUT;
	--SET @MAmount_MBRS_1=@MAmount_MBRS_1+@MAmount_MBRS_1B*0.4
		
	--RECL
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F3_REC_LIA430',1,0,@MAmount_RECL_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F3_REC_LIA430_D',2,3,@MAmount_RECL_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_RECL,'F3_REC_LIA430_COFF',5,3,@MAmount_RECL_1C OUTPUT;


	--EXHT
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHT,'F365L_EXH_SEX_LT_300',1,3,@MAmount_EXHT_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHT,'F365L_EXH_SEX_LT_300_D',2,3,@MAmount_EXHT_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHT,'F365L_EXH_SEX_LT_300_COFF',5,3,@MAmount_EXHT_1C OUTPUT;
	--CHSC
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_CHSC,'F320F_NaOCl_LT',1,0,@MAmount_CHSC_1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_CHSC,'F320F_NaOCl_LT_D',2,3,@MAmount_CHSC_1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_CHSC,'F320F_NaOCl_LT_COFF',5,3,@MAmount_CHSC_1C OUTPUT;
	SET @MAmount_CHSC_1=@MAmount_CHSC_1*2



	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	--MBRS充填
	--EXEC sp_GetAmountPi @MAmount_MBRS_1,@MAmount_MBRS_1A,@MAmount_MBRS_1C,@M_WeightTransferParaMBRS,0,@MAmount_MBRS OUTPUT;

	--recl
	EXEC sp_GetAmountPi @MAmount_RECL_1,@MAmount_RECL_1A,@MAmount_RECL_1C,@M_WeightTransferParaRECL,0,@MAmount_RECL OUTPUT;

	--wwts
	--EXEC sp_GetAmountPi @MAmount_WWTS_1,@MAmount_WWTS_1A,@MAmount_WWTS_1C,@M_WeightTransferParaWWTS,@M_FillingQtyWWTS,@MAmount_WWTS OUTPUT;
	
	--exht
	EXEC sp_GetAmountPi @MAmount_EXHT_1,@MAmount_EXHT_1A,@MAmount_EXHT_1C,@M_WeightTransferParaEXHT,0,@MAmount_EXHT OUTPUT;
	--chsC
	EXEC sp_GetAmountPi @MAmount_CHSC_1,@MAmount_CHSC_1A,@MAmount_CHSC_1C,@M_WeightTransferParaCHSC,@M_FillingQtyCHSC,@MAmount_CHSC OUTPUT;


	--SET @MAmount_WWTS=@MAmount_WWTS-@MAmount_MBRS 
	
	--20241211 負值歸零
	
	IF @MAmount_EXHT < 0 
	BEGIN
	  SET @MAmount_EXHT = 0
	END
	IF @MAmount_CHSC < 0 
	BEGIN
	  SET @MAmount_CHSC = 0
	END
	IF @MAmount_RECL < 0 
	BEGIN
	  SET @MAmount_RECL = 0
	END
	--IF @MAmount_MBRS < 0 
	--BEGIN
	--  SET @MAmount_MBRS = 0
	--END
	
	--總量
	SET @MAmount=@MAmount_EXHT+@MAmount_CHSC+@MAmount_RECL--+@MAmount_WWTS+@MAmount_MBRS --

	
	
	--UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_WWTS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	--UPDATE [Material_Table] SET [M_Amount] =@MAmount_MBRS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_MBRS/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MBRS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_RECL/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_W_RECL;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHT ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_EXHT/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHT;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_CHSC ,[M_TotalQty] =@MAmount ,[M_TotalPara] =@MAmount_CHSC/@MAmount WHERE  [M_Seq_ID]=@M_SEQ_ID_H_CHSC;

END



