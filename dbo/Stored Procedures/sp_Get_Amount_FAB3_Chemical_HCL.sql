


CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB3_Chemical_HCL]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2022-12-15'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W_UPWS int
	DECLARE @M_SEQ_ID_W_MB int
	DECLARE @M_SEQ_ID_W_3B4T1 int
	DECLARE @M_SEQ_ID_W_3B4T2 int
	DECLARE @Plant varchar(50) ='FAB3';
	DECLARE @CName varchar(50) ='HCL';
	DECLARE @MAmount_UPWS decimal(18, 4)=0
	DECLARE @MAmount_MB decimal(18, 4)=0
	DECLARE @MAmount_3B4T1 decimal(18, 4)=0
	DECLARE @MAmount_3B4T2 decimal(18, 4)=0
	--DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
	--DECLARE @MAmount_T2IN decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T3C decimal(18, 4)=0
	DECLARE @MAmount_T4 decimal(18, 4)=0
	DECLARE @MAmount_T4A decimal(18, 4)=0
	DECLARE @MAmount_T4C decimal(18, 4)=0
	DECLARE @M_FillingQty_UPWS decimal(18, 4)
	DECLARE @M_WeightTransferPara_UPWS decimal(18, 4)
	DECLARE @M_FillingQty_MB decimal(18, 4)
	DECLARE @M_WeightTransferPara_MB decimal(18, 4)
	DECLARE @M_FillingQty_3B4T1 decimal(18, 4)
	DECLARE @M_WeightTransferPara_3B4T1 decimal(18, 4)
	DECLARE @M_FillingQty_3B4T2 decimal(18, 4)
	DECLARE @M_WeightTransferPara_3B4T2 decimal(18, 4)


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

	SELECT @M_SEQ_ID_W_MB = A.M_Seq_ID,@MAmount_MB=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='MB') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_3B4T1 = A.M_Seq_ID,@MAmount_3B4T1=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='3B4T 一期') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_W_3B4T2 = A.M_Seq_ID,@MAmount_3B4T2=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='3B4T 二期') AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_UPWS ,@M_SEQ_ID_W_MB,@M_SEQ_ID_W_3B4T1,@M_SEQ_ID_W_3B4T2) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_MB ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MB;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T1 ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T1;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T2 ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T2;
		RETURN 
	END
	
		
	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F310_UPW_LIA_1201_PV',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F310_UPW_LIA_1201_PV_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_UPWS,'F310_UPW_LIA_1201_PV_COFF',5,3,@MAmount_T1C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MB,'F310_UPW_MBK_403_OPEN_INN',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_MB,'F310_UPW_MBK_403_OPEN_INN_D',2,3,@MAmount_T2A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2C10_UPWS_HCL_MBLIT402_COEF',5,3,@MAmount_T2C OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2C10_UPWS_HCL_IN',3,3,@MAmount_T2IN OUTPUT;
	--SET @MAmount_T2=@MAmount_T2+@MAmount_T2IN


	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T1,'F310_UPW_HFK_203_OPEN_INN',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T1,'F310_UPW_HFK_203_OPEN_INN_D',2,3,@MAmount_T3A OUTPUT;
	--EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_HCL_D2006CM_COEF',5,3,@MAmount_T3C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T2,'F310_UPW_HFK_205_OPEN_INN',1,0,@MAmount_T4 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_3B4T2,'F310_UPW_HFK_205_OPEN_INN_D',2,3,@MAmount_T3A OUTPUT;

	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara_UPWS,@M_FillingQty_UPWS,@MAmount_UPWS OUTPUT;

	SET @MAmount_MB = ROUND(@MAmount_T2*@MAmount_T2A,4);
	SET @MAmount_3B4T1 = ROUND(@MAmount_T3*@MAmount_T3A,4);
	SET @MAmount_3B4T2 = ROUND(@MAmount_T4*@MAmount_T4A,4);
	--EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara_UPWS,0,@MAmount_MB OUTPUT;
	--EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3C,@M_WeightTransferPara_WWTS,@M_FillingQty_WWTS,@MAmount_3B4T1 OUTPUT;

	SELECT @MAmount_UPWS,@MAmount_MB,@MAmount_3B4T1,@MAmount_3B4T2;
	IF @MAmount_UPWS<1 BEGIN SET @MAmount_UPWS=0 END 
	
	IF @MAmount_MB<1 BEGIN SET @MAmount_MB=0 END 
	IF @MAmount_3B4T1<1 BEGIN SET @MAmount_3B4T1=0 END 
	IF @MAmount_3B4T2<1 BEGIN SET @MAmount_3B4T2=0 END 
	
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_UPWS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_MB ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2 ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_MB;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T1 ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T1;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_3B4T2 ,[M_TotalQty] =@MAmount_MB+@MAmount_3B4T1+@MAmount_3B4T2,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_3B4T2;
END



