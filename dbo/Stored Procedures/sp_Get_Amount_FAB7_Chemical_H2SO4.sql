


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB7_Chemical_H2SO4]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-12-10'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_H_EXHA int
	DECLARE @M_SEQ_ID_H_EXHC int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @Plant varchar(50) ='FAB7';
	DECLARE @CName varchar(50) ='H2SO4';

	
	DECLARE @MAmount decimal(18, 4)=0
	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_EXHC decimal(18, 4)=0
	DECLARE @MAmount_EXHA decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2B decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T3B decimal(18, 4)=0
	DECLARE @MAmount_T3C decimal(18, 4)=0
	DECLARE @M_FillingQtyWWT decimal(18, 2)=0
	DECLARE @M_FillingQtyEXHC decimal(18, 2)=0
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
	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount, @M_FillingQtyWWT=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHA = A.M_Seq_ID,@MAmount_EXHA=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHA') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHC = A.M_Seq_ID,@MAmount_EXHC=A.M_Amount,@M_FillingQtyEXHC=a.M_FillingQty  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHC') AND m_Date = @StartDate  ;



	/* 如有備註則不重新計算，只算總量 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_WWTS,@M_SEQ_ID_H_EXHA) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount_WWTS+@MAmount_EXHA ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHA ,[M_TotalQty] =@MAmount_WWTS+@MAmount_EXHA ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHA;
		RETURN
	END
		
	--取得總用量
	--WWT
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F7W10Y_WWTS_LIA_601B',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F7W10Y_WWTS_LIA_601B_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F7W10Y_WWTS_LIA_601B_COEF',5,3,@MAmount_T1C OUTPUT;
	
	--EXHA
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHA,'F7G40W_EXHS_H2SO4_USAGE',1,3,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHA,'F7G40W_EXHS_H2SO4_USAGE_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHA,'F7G40W_EXHS_H2SO4_USAGE_COEF',5,3,@MAmount_T2C OUTPUT;

	--EXHC
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F7F30F_EXHS_LT_700',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F7F30F_EXHS_LT_700_D',2,3,@MAmount_T3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_H_EXHC,'F7F30F_EXHS_LT_700_COEF',5,3,@MAmount_T3C OUTPUT;

	

	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQtyWWT,@MAmount_WWTS OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara,0,@MAmount_EXHA OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3C,@M_WeightTransferPara,@M_FillingQtyEXHC,@MAmount_EXHC OUTPUT;



  if(@MAmount_WWTS<0) set @MAmount_WWTS=0
  if(@MAmount_EXHA<0) set @MAmount_EXHA=0
  if(@MAmount_EXHC<0) set @MAmount_EXHC=0

	SET @MAmount=+@MAmount_WWTS +@MAmount_EXHA+@MAmount_EXHC

	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHA ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHA;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHC ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHC;
	
END



