

CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB1_Chemical_HCL]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2022-12-15'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_UPWSx int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @Plant varchar(50) ='FAB1';
	DECLARE @CName varchar(50) ='HCL';
	DECLARE @MAmount_UPWS decimal(18, 4)=0
	DECLARE @MAmount_UPWSx decimal(18, 4)=0
	DECLARE @MAmount_UPWS1 decimal(18, 4)=0
	DECLARE @MAmount_UPWS2 decimal(18, 4)=0
	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
	DECLARE @MAmount_T2IN decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T3C decimal(18, 4)=0
	DECLARE @M_FillingQty_UPWS decimal(18, 4)
	DECLARE @M_WeightTransferPara_UPWS decimal(18, 4)
	DECLARE @M_FillingQty_WWTS decimal(18, 4)
	DECLARE @M_WeightTransferPara_WWTS decimal(18, 4)


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
	SELECT @M_SEQ_ID_W_UPWS = A.M_Seq_ID,@MAmount_UPWS=A.M_Amount,@M_FillingQty_UPWS=A.M_FillingQty,@M_WeightTransferPara_UPWS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_UPWSx = A.M_Seq_ID,@MAmount_UPWSx=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS~') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount,@M_FillingQty_WWTS=A.M_FillingQty,@M_WeightTransferPara_WWTS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_UPWS,@M_SEQ_ID_W_UPWSx,@M_SEQ_ID_W_WWTS) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount_UPWSx+@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWSx ,[M_TotalQty] =@MAmount_UPWSx+@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWSx;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount_UPWSx+@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		RETURN 
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_MBLIT401',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_MBLIT401_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_MBLIT401_COEF',5,3,@MAmount_T1C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_MBLIT402',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_MBLIT402_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_MBLIT402_COEF',5,3,@MAmount_T2C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1C10_UPWS_HCL_IN',3,3,@MAmount_T2IN OUTPUT;
	SET @MAmount_T2=@MAmount_T2+@MAmount_T2IN


	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1WB1_WWTS_HCL_D2006CM',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1WB1_WWTS_HCL_D2006CM_D',2,3,@MAmount_T3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F1WB1_WWTS_HCL_D2006CM_COEF',5,3,@MAmount_T3C OUTPUT;

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara_UPWS,@M_FillingQty_UPWS,@MAmount_UPWS OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara_UPWS,0,@MAmount_UPWSx OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3C,@M_WeightTransferPara_WWTS,@M_FillingQty_WWTS,@MAmount_WWTS OUTPUT;


	IF @MAmount_UPWS<1 BEGIN SET @MAmount_UPWS=0 END 
	IF @MAmount_UPWSx<1 BEGIN SET @MAmount_UPWSx=0 END 
	IF @MAmount_WWTS<1 BEGIN SET @MAmount_WWTS=0 END 
	
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount_UPWSx+@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWSx ,[M_TotalQty] =@MAmount_UPWSx+@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWSx;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount_UPWSx+@MAmount_WWTS ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	
END



