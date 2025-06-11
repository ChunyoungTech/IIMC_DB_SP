





CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB7_Chemical_DehydrationPolymer]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2018-10-10'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W int
	DECLARE @Plant varchar(50) ='FAB7';
	DECLARE @CName varchar(50) ='Polymer脫水機';
	DECLARE @MB_Shop varchar(50) ='水務課';
	DECLARE @MB_Sysname varchar(50) ='WWTS';

	DECLARE @MAmount decimal(18, 4)=0
	DECLARE @MAmount1 decimal(18, 4)=0
	DECLARE @MAmount2 decimal(18, 4)=0
	DECLARE @MAmount3 decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
	DECLARE @MAmount_T2 decimal(18, 4)=0
	DECLARE @MAmount_T2A decimal(18, 4)=0
	DECLARE @MAmount_T2B decimal(18, 4)=0
	DECLARE @MAmount_T2C decimal(18, 4)=0
	DECLARE @MAmount_T2D decimal(18, 4)=0
	DECLARE @MAmount_T3 decimal(18, 4)=0
	DECLARE @MAmount_T3A decimal(18, 4)=0
	DECLARE @MAmount_T3B decimal(18, 4)=0
	DECLARE @MAmount_T3C decimal(18, 4)=0
	DECLARE @MAmount_T3D decimal(18, 4)=0
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
	SELECT @M_SEQ_ID_W = A.M_Seq_ID,@MAmount=A.M_Amount,@M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A 
	WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop=@MB_Shop AND MB_Sysname=@MB_Sysname) AND m_Date = @StartDate  ;

	/* 如有備註則終止計算 */
	IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_W) AND M_MenuRemark<>'')
	BEGIN 
		UPDATE [Material_Table] SET [M_Amount] =@MAmount ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W;
	RETURN 
	END
		


	--取得總用量
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_705',1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_705_D',2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_705_COEF',5,3,@MAmount_T1C OUTPUT;

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706A',1,0,@MAmount_T2 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706A_D',2,3,@MAmount_T2A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706A_INN',3,3,@MAmount_T2B OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706A_DF',4,3,@MAmount_T2C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706A_COEF',5,3,@MAmount_T2D OUTPUT;
	SET @MAmount_T2=@MAmount_T2+@MAmount_T2B

	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706B',1,0,@MAmount_T3 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706B_D',2,3,@MAmount_T3A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706B_INN',3,3,@MAmount_T3B OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706B_DF',4,3,@MAmount_T3C OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,'F7W10Y_WWTS_LIA_706B_COEF',5,3,@MAmount_T3D OUTPUT;
	SET @MAmount_T2=@MAmount_T3+@MAmount_T3B

	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQty,@MAmount1 OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T2,@MAmount_T2A,@MAmount_T2D,@M_WeightTransferPara,0,@MAmount2 OUTPUT;
	EXEC sp_GetAmountPi @MAmount_T3,@MAmount_T3A,@MAmount_T3D,@M_WeightTransferPara,0,@MAmount3 OUTPUT;

	if(@MAmount1<0)set @MAmount1=0

	SET @MAmount=@MAmount1

	UPDATE [Material_Table] SET [M_Amount] =@MAmount ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W;
	
END



