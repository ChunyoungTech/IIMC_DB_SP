

CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB2_Chemical_H2SO4]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2024-10-24'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_H_EXHT int
	DECLARE @M_SEQ_ID_W_WWTS int
	DECLARE @Plant varchar(50) ='FAB2';
	DECLARE @CName varchar(50) ='H2SO4';

	DECLARE @MAmount_WWTS decimal(18, 4)=0
	DECLARE @MAmount_EXHT decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
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
	SELECT @M_SEQ_ID_W_WWTS = A.M_Seq_ID,@MAmount_WWTS=A.M_Amount, @M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

	SELECT @M_SEQ_ID_H_EXHT = A.M_Seq_ID,@MAmount_EXHT=A.M_Amount  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHT') AND m_Date = @StartDate  ;


	select @MAmount_WWTS,@MAmount_EXHT

	/* 如有備註則不重新計算，只算總量 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W_WWTS,@M_SEQ_ID_H_EXHT) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount_WWTS+@MAmount_EXHT ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
		UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHT ,[M_TotalQty] =@MAmount_WWTS+@MAmount_EXHT ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHT;
		RETURN
	END
		
	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_H2SO4_D2001CM',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_H2SO4_D2001CM_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2WB1_WWTS_H2SO4_D2001CM_COEF',5,3,@MAmount_T1C OUTPUT;


	--將F2SRF_EXHT_H2SO4_SUPBRFLTUE 寫到F2SRF_EXHT_H2SO4_LT
	UPDATE IDMC_Table
	SET I_Value1=(SELECT TOP 1 [I_Value] FROM [CIC_TABLE] WHERE [I_Tag]='F2SRF_EXHT_H2SO4_SUPBRFLTUE' AND [I_Date]= CONVERT(VARCHAR(10),GETDATE(),120))
	WHERE I_Tag1='F2SRF_EXHT_H2SO4_LT' AND I_Date= CONVERT(VARCHAR(10),GETDATE(),120)

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2SRF_EXHT_H2SO4_LT',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2SRF_EXHT_H2SO4_LT_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W_WWTS,'F2SRF_EXHT_H2SO4_LT_COEF',5,3,@MAmount_T2C OUTPUT;


	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQty,@MAmount_WWTS OUTPUT;
	
	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2C,@M_WeightTransferPara,0,@MAmount_EXHT OUTPUT;
	
	IF @MAmount_WWTS<1 BEGIN SET @MAmount_WWTS=0 END 
	IF @MAmount_EXHT<1 BEGIN SET @MAmount_EXHT=0 END 

	UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWTS ,[M_TotalQty] =@MAmount_WWTS+@MAmount_EXHT ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W_WWTS;
	UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHT ,[M_TotalQty] =@MAmount_WWTS+@MAmount_EXHT ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H_EXHT;
	
END



