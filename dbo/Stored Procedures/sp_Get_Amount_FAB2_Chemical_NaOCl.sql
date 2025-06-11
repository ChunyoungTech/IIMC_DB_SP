


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB2_Chemical_NaOCl]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2023-03-22'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_H_EXHS int
	DECLARE @M_SEQ_ID_H_EXHSx int
	DECLARE @M_SEQ_ID_H_EXHTx int
	DECLARE @M_SEQ_ID_H_CHRSx int


	DECLARE @Plant varchar(50) ='FAB2';
	DECLARE @CName varchar(50) ='NaOCl';
	DECLARE @MAmount decimal(18, 4)=0
	DECLARE @MAmount_EXHS decimal(18, 4)=0
	DECLARE @MAmount_EXHSx decimal(18, 4)=0
	DECLARE @MAmount_EXHTx decimal(18, 4)=0
	DECLARE @MAmount_CHRSx decimal(18, 4)=0
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
	DECLARE @MAmount_T2IN decimal(18, 4)=0
	DECLARE @MAmount_T3IN decimal(18, 4)=0
	DECLARE @MAmount_T4IN decimal(18, 4)=0

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
	SELECT @M_SEQ_ID_H_EXHS = A.M_Seq_ID,@MAmount_EXHS=A.M_Amount,@M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS') AND m_Date = @StartDate  ;
	
	SELECT @M_SEQ_ID_H_EXHSx = A.M_Seq_ID,@MAmount_EXHSx=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS~') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_CHRSx = A.M_Seq_ID,@MAmount_CHRSx=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='CHST~') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHTx = A.M_Seq_ID,@MAmount_EXHTx=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHT~') AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_H_EXHS,@M_SEQ_ID_H_EXHSx,@M_SEQ_ID_H_CHRSx,@M_SEQ_ID_H_EXHTx) AND M_MenuRemark<>'')
	BEGIN 

		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =@MAmount_EXHS ,[M_TotalPara] =@MAmount_EXHS/@MAmount_EXHS WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHSx ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =@MAmount_EXHSx/(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHSx
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHTx ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =@MAmount_EXHTx/(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHTx;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_CHRSx ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =@MAmount_CHRSx/(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_CHRSx;
	
		RETURN 
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2C10_EXHS_NAOCL_CUB1FLTEU',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2C10_EXHS_NAOCL_CUB1FLTEU_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2C10_EXHS_NAOCL_CUB1FLTEU_COEF',5,3,@MAmount_T1C OUTPUT;

	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2CRF_CHRS_NAOCL_CUBRFLTEU',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2CRF_CHRS_NAOCL_CUBRFLTEU_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2CRF_CHRS_NAOCL_CUBRFLTEU_COEF',5,3,@MAmount_T2C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2CRF_CHRS_NAOCL_IN',3,3,@MAmount_T2IN OUTPUT;
	SET @MAmount_T2=@MAmount_T2+@MAmount_T2IN
	

	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHT_NAOCL_STRIPPERLTEU',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHT_NAOCL_STRIPPERLTEU_D',2,3,@MAmount_T3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHT_NAOCL_STRIPPERLTEU_COEF',5,3,@MAmount_T3C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHT_NAOCL_IN',3,3,@MAmount_T3IN OUTPUT;
	SET @MAmount_T3=@MAmount_T3+@MAmount_T3IN

	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHS_NAOCL_ACIDLTEU',1,0,@MAmount_T4 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHS_NAOCL_ACIDLTEU_D',2,3,@MAmount_T4A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHS_NAOCL_ACIDLTEU_COEF',5,3,@MAmount_T4C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHS,'F2SRF_EXHS_NAOCL_IN',3,3,@MAmount_T4IN OUTPUT;
	SET @MAmount_T4=@MAmount_T4+@MAmount_T4IN

	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQty,@MAmount_EXHS OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara,0,@MAmount_CHRSx OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3C,@M_WeightTransferPara,0,@MAmount_EXHTx OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T4,@MAmount_T4A,@MAmount_T4C,@M_WeightTransferPara,0,@MAmount_EXHSx OUTPUT;

	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHSx ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =@MAmount_EXHSx/(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHSx
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHTx ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =@MAmount_EXHTx/(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHTx;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_CHRSx ,[M_TotalQty] =(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) ,[M_TotalPara] =@MAmount_CHRSx/(@MAmount_CHRSx+@MAmount_EXHTx+@MAmount_EXHSx) WHERE  [M_Seq_ID]=@M_SEQ_ID_H_CHRSx;
	
END



