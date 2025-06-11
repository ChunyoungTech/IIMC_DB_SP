








CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB3_Chemical_PAC]
	@CalcDate AS DATE --重新指定運算日期
AS
BEGIN
	
	SET NOCOUNT ON;
	--DECLARE @CalcDate AS DATE ='2018-10-10'
	DECLARE @StartDate AS DATE 
	DECLARE @M_SEQ_ID_W int
	DECLARE @Plant varchar(50) ='FAB3';
	DECLARE @CName varchar(50) ='PAC';
	DECLARE @MB_Shop varchar(50) ='水務課';
	DECLARE @MB_Sysname varchar(50) ='RECL';
	DECLARE @tagName varchar(50) ='F310_UPW_LIA_1211_PV';
	DECLARE @tagName_D varchar(50) = @tagName + '_D';
	DECLARE @tagName_COEF varchar(50) = @tagName + '_COFF';

	DECLARE @MAmount decimal(18, 4)=0
	DECLARE @MAmount_T1 decimal(18, 4)=0
	DECLARE @MAmount_T1A decimal(18, 4)=0
	DECLARE @MAmount_T1C decimal(18, 4)=0
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
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,@tagName,1,0,@MAmount_T1 OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,@tagName_D,2,3,@MAmount_T1A OUTPUT;
	EXEC sp_Get_FT_Amount @M_SEQ_ID_W,@tagName_COEF,5,3,@MAmount_T1C OUTPUT;

	SELECT @MAmount_T1,@MAmount_T1A,@MAmount_T1C;

	--計算
	--sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
	EXEC sp_GetAmountPi @MAmount_T1,@MAmount_T1A,@MAmount_T1C,@M_WeightTransferPara,@M_FillingQty,@MAmount OUTPUT;

	SELECT @MAmount;

	IF @MAmount	<1 BEGIN SET @MAmount	=0 END 

	UPDATE [Material_Table] SET [M_Amount] =@MAmount ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_W;
	
END



