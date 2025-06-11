

CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB2_Chemical_CH3OH]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2018-10-10'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @M_SEQ_ID_W_WWTSx int
	DECLARE @Plant varchar(50) ='FAB2';
	DECLARE @CName varchar(50) ='甲醇';
	DECLARE @MAmount_WWTS1 decimal(18, 4)=0
	DECLARE @MAmount_WWTS2 decimal(18, 4)=0
	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_WWTSx decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
	DECLARE @MAmount_T2IN decimal(18, 4)=0
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
	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS1=A.M_Amount,@M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTSx = A.M_Seq_ID,@MAmount_WWTS2=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS~') AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_WWTS) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS2 ,[M_TotalQty] =@MAmount_WWTS2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTSx;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS1 ,[M_TotalQty] =@MAmount_WWTS2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		RETURN 
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_CH3OH_LITCH3OHPV',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_CH3OH_LITCH3OHPV_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_CH3OH_LITCH3OHPV_COEF',5,3,@MAmount_T1C OUTPUT;


	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2W10_WWTS_CH3OH_LITCBCM',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2W10_WWTS_CH3OH_LITCBCM_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2W10_WWTS_CH3OH_LITCBCM_COEF',5,3,@MAmount_T2C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2W10_WWTS_CH3OH_IN',3,3,@MAmount_T2IN OUTPUT;
	SET @MAmount_T2=@MAmount_T2+@MAmount_T2IN
	


	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQty,@MAmount_WWTS1 OUTPUT;

	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara,0,@MAmount_WWTS2 OUTPUT;

	SET @MAmount_WWTS=@MAmount_WWTS2

	IF @MAmount_WWTS1<1 BEGIN SET @MAmount_WWTS1=0 END  
	IF @MAmount_WWTS2<1 BEGIN SET @MAmount_WWTS2=0 END  

	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS2 ,[M_TotalQty] =@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTSx;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS1 ,[M_TotalQty] =@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	
END



