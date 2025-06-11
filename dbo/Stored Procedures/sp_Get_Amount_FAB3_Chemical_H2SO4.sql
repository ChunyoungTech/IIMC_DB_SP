


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB3_Chemical_H2SO4]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-10-24'
	DECLARE @StartDate AS DATE
	DECLARE @M_SEQ_ID_H_EXHA int
	DECLARE @M_SEQ_ID_H_EXHC int
	DECLARE @M_SEQ_ID_H_EXHT int
	DECLARE @M_SEQ_ID_H_HPM int
	DECLARE @M_SEQ_ID_W_TMAH int
	DECLARE @M_SEQ_ID_W_WWTS_BIO int
	DECLARE @M_SEQ_ID_W_WWTS_CUB int

	DECLARE @Plant varchar(50) ='FAB3';
	DECLARE @CName varchar(50) ='H2SO4';

	DECLARE @MAmount_TMAH decimal(18, 4)=0
	DECLARE @MAmount_WWTS_BIO decimal(18, 4)=0
	DECLARE @MAmount_WWTS_CUB decimal(18, 4)=0
	DECLARE @MAmount_EXHA decimal(18, 4)=0
	DECLARE @MAmount_EXHC decimal(18, 4)=0
	DECLARE @MAmount_EXHT decimal(18, 4)=0
	DECLARE @MAmount_HPM decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T3C decimal(18, 4)=0
	DECLARE @MAmount_T4 decimal(18, 4)=0
	DECLARE @MAmount_T4A decimal(18, 4)=0
	DECLARE @MAmount_T4C decimal(18, 4)=0
	DECLARE @MAmount_T5 decimal(18, 4)=0
	DECLARE @MAmount_T5A decimal(18, 4)=0
	DECLARE @MAmount_T5C decimal(18, 4)=0
	DECLARE @MAmount_T6 decimal(18, 4)=0
	DECLARE @MAmount_T6A decimal(18, 4)=0
	DECLARE @MAmount_T6C decimal(18, 4)=0
	DECLARE @MAmount_T7 decimal(18, 4)=0
	DECLARE @MAmount_T7A decimal(18, 4)=0
	DECLARE @MAmount_T7C decimal(18, 4)=0
	DECLARE @M_FillingQty decimal(18, 2)
	DECLARE @M_WeightTransferPara decimal(18, 2)

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
	SELECT @M_SEQ_ID_W_TMAH = A.M_Seq_ID,@MAmount_TMAH=A.M_Amount, @M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='TMAH') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS_BIO = A.M_Seq_ID,@MAmount_WWTS_BIO=A.M_Amount, @M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS(BIO)') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS_CUB = A.M_Seq_ID,@MAmount_WWTS_CUB=A.M_Amount, @M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS(CUB)') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHA = A.M_Seq_ID,@MAmount_EXHA=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHA') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHC = A.M_Seq_ID,@MAmount_EXHC=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHC') AND m_Date = @StartDate  ;
	
	SELECT @M_SEQ_ID_H_EXHT = A.M_Seq_ID,@MAmount_EXHT=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHT') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_HPM = A.M_Seq_ID,@MAmount_HPM=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='HPM') AND m_Date = @StartDate  ;


	SET @MAmount_EXHT=0;

	select @M_SEQ_ID_W_TMAH,@MAmount_WWTS_BIO,@MAmount_WWTS_CUB,@MAmount_EXHA,@MAmount_EXHC,@MAmount_EXHT,@MAmount_HPM

	/* 如有備註則不重新計算，只算總量 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_TMAH,@MAmount_WWTS_BIO,@MAmount_WWTS_CUB,@MAmount_EXHA,@MAmount_EXHC,@MAmount_EXHT,@M_SEQ_ID_H_HPM) AND M_MenuRemark<>'')
	BEGIN 
	    UPDATE [Material_Table] SET [M_Amount] =@MAmount_TMAH ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_TMAH;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS_BIO ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS_BIO;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS_CUB ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS_CUB;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHA ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHA;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHC ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHC;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHT ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHT;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_HPM ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_HPM;
		RETURN
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_TMAH,'F3CB1D_WTM_LIT_T06_PV',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_TMAH,'F3CB1D_WTM_LIT_T06_PV_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_TMAH,'F3CB1D_WTM_LIT_T06_PV_COFF',5,3,@MAmount_T1C OUTPUT;


	--將F2SRF_EXHT_H2SO4_SUPBRFLTUE 寫到F2SRF_EXHT_H2SO4_LT
	--UPDATE IDMC_Table
	--SET I_Value1=(SELECT TOP 1 [I_Value] FROM [CIC_TABLE] WHERE [I_Tag]='F2SRF_EXHT_H2SO4_SUPBRFLTUE' AND [I_Date]= CONVERT(VARCHAR(10),GETDATE(),120))
	--WHERE I_Tag1='F2SRF_EXHT_H2SO4_LT' AND I_Date= CONVERT(VARCHAR(10),GETDATE(),120)

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_BIO,'F310Z_WWT_LIA_2801',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_BIO,'F310Z_WWT_LIA_2801_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_BIO,'F310Z_WWT_LIA_2801_COFF',5,3,@MAmount_T2C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_CUB,'F3B1F_WWT_LIA_2941',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_CUB,'F3B1F_WWT_LIA_2941_D',2,3,@MAmount_T3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS_CUB,'F3B1F_WWT_LIA_2941_COFF',5,3,@MAmount_T3C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHA,'F365M_EXH_AMX_LT_400',1,0,@MAmount_T4 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHA,'F365M_EXH_AMX_LT_400_D',2,3,@MAmount_T4A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHA,'F365M_EXH_AMX_LT_400_COFF',5,3,@MAmount_T4C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F365K_EXH_CVD_LT_700',1,0,@MAmount_T5 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F365K_EXH_CVD_LT_700_D',2,3,@MAmount_T5A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F365K_EXH_CVD_LT_700_COFF',5,3,@MAmount_T5C OUTPUT;

	--EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHT,'F365K_EXH_CVD_LT_700',1,0,@MAmount_T6 OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHT,'F365K_EXH_CVD_LT_700_D',2,3,@MAmount_T6A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHT,'F365K_EXH_CVD_LT_700_COFF',5,3,@MAmount_T6C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_HPM,'F365E_EXH_AMX_LT_802',1,0,@MAmount_T7 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_HPM,'F365E_EXH_AMX_LT_802_D',2,3,@MAmount_T7A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_HPM,'F365E_EXH_AMX_LT_802_COFF',5,3,@MAmount_T7C OUTPUT;


	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQty,@MAmount_TMAH OUTPUT;

	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara,@M_FillingQty,@MAmount_WWTS_BIO OUTPUT;

	EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3C,@M_WeightTransferPara,@M_FillingQty,@MAmount_WWTS_CUB OUTPUT;

	EXEC sp_GetAmountPi @MAmount_T4,@MAmount_T4A,@MAmount_T4C,@M_WeightTransferPara,0,@MAmount_EXHA OUTPUT;

	EXEC sp_GetAmountPi @MAmount_T5,@MAmount_T5A,@MAmount_T5C,@M_WeightTransferPara,0,@MAmount_EXHC OUTPUT;
	
	--EXEC sp_GetAmountPi @MAmount_T6,@MAmount_T6A,@MAmount_T6C,@M_WeightTransferPara,0,@MAmount_EXHT OUTPUT;

	EXEC sp_GetAmountPi @MAmount_T7,@MAmount_T7A,@MAmount_T7C,@M_WeightTransferPara,0,@MAmount_HPM OUTPUT;
	
	IF @MAmount_TMAH<1 BEGIN SET @MAmount_TMAH=0 END
	IF @MAmount_WWTS_BIO<1 BEGIN SET @MAmount_WWTS_BIO=0 END
	IF @MAmount_WWTS_CUB<1 BEGIN SET @MAmount_WWTS_CUB=0 END
	IF @MAmount_EXHA<1 BEGIN SET @MAmount_EXHA=0 END
	IF @MAmount_EXHC<1 BEGIN SET @MAmount_EXHC=0 END
	--IF @MAmount_EXHT<1 BEGIN SET @MAmount_EXHT=0 END 
	IF @MAmount_HPM<1 BEGIN SET @MAmount_HPM=0 END

	UPDATE [Material_Table] SET [M_Amount] =@MAmount_TMAH ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_TMAH;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS_BIO ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS_BIO;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS_CUB ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS_CUB;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHA ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHA;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHC ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHC;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHT ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHT;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_HPM ,[M_TotalQty] =@MAmount_TMAH+@MAmount_WWTS_BIO+@MAmount_WWTS_CUB+@MAmount_EXHA+@MAmount_EXHC+@MAmount_EXHT+@MAmount_HPM ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_HPM;
	
END



