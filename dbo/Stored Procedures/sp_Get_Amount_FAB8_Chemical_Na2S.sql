




CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB8_Chemical_Na2S]
        @CalcDate AS DATE --重新指定運算日期
AS
BEGIN

        SET NOCOUNT ON;
        --DECLARE @CalcDate AS DATE ='2018-10-10'
        DECLARE @StartDate AS DATE
        DECLARE @M_SEQ_ID_EXHS int
        DECLARE @M_SEQ_ID_DIWT int
        DECLARE @Plant varchar(50) ='FAB8';
        DECLARE @CName varchar(50) ='Na2S';
        DECLARE @tagName_EXHS varchar(50) ='F8FRFK_EXHS_LT_201A';
        DECLARE @tagName_EXHS_D varchar(50) = @tagName_EXHS + '_D';
        DECLARE @tagName_EXHS_COEF varchar(50) = @tagName_EXHS + '_COEF';
        DECLARE @tagName_DIWT varchar(50) ='F8W10W_DIWT_LIA_2971A_HMI';
        DECLARE @tagName_DIWT_D varchar(50) = @tagName_DIWT + '_D';
        DECLARE @tagName_DIWT_COEF varchar(50) = @tagName_DIWT + '_COEF';

        DECLARE @MAmount decimal(18, 4)=0
        DECLARE @MAmount_EXHS decimal(18, 4)=0
        DECLARE @MAmount_EXHS_T1 decimal(18, 4)=0
        DECLARE @MAmount_EXHS_T1A decimal(18, 4)=0
        DECLARE @MAmount_EXHS_T1C decimal(18, 4)=0
        DECLARE @M_FillingQty_EXHS decimal(18, 2)
        DECLARE @M_WeightTransferPara_EXHS decimal(18, 2)

        DECLARE @MAmount_DIWT decimal(18, 4)=0
        DECLARE @MAmount_DIWT_T1 decimal(18, 4)=0
        DECLARE @MAmount_DIWT_T1A decimal(18, 4)=0
        DECLARE @MAmount_DIWT_T1C decimal(18, 4)=0
        DECLARE @M_FillingQty_DIWT decimal(18, 2)
        DECLARE @M_WeightTransferPara_DIWT decimal(18, 2)

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
        SELECT @M_SEQ_ID_EXHS = A.M_Seq_ID,@MAmount_EXHS=A.M_Amount,@M_FillingQty_EXHS=A.M_FillingQty,@M_WeightTransferPara_EXHS=A.M_WeightTransferPara  FROM  dbo.Material_Table  A
        WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='空調課' AND MB_Sysname='EXHS') AND m_Date = @StartDate  ;

        SELECT @M_SEQ_ID_DIWT = A.M_Seq_ID,@MAmount_DIWT=A.M_Amount,@M_FillingQty_DIWT=A.M_FillingQty,@M_WeightTransferPara_DIWT=A.M_WeightTransferPara  FROM  dbo.Material_Table  A
        WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWTS') AND m_Date = @StartDate  ;

        /* 如有備註則不重新計算，只算總量 */
        IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_EXHS,@M_SEQ_ID_DIWT) AND M_MenuRemark<>'')
        BEGIN
                SET @MAmount=@MAmount_EXHS+@MAmount_DIWT;
                UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_EXHS;
                UPDATE [Material_Table] SET [M_Amount] =@MAmount_DIWT ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_DIWT;
        RETURN
        END

        --取得總用量
        --EXHS
        EXEC sp_Get_FT_Amount @M_SEQ_ID_EXHS,@tagName_EXHS,1,3,@MAmount_EXHS_T1 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_EXHS,@tagName_EXHS_D,2,3,@MAmount_EXHS_T1A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_EXHS,@tagName_EXHS_COEF,5,3,@MAmount_EXHS_T1C OUTPUT;

        --DIWT
        EXEC sp_Get_FT_Amount @M_SEQ_ID_DIWT,@tagName_DIWT,1,0,@MAmount_DIWT_T1 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_DIWT,@tagName_DIWT_D,2,3,@MAmount_DIWT_T1A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_DIWT,@tagName_DIWT_COEF,5,3,@MAmount_DIWT_T1C OUTPUT;

        --計算
        --sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
        EXEC sp_GetAmountPi @MAmount_EXHS_T1,@MAmount_EXHS_T1A,@MAmount_EXHS_T1C,@M_WeightTransferPara_EXHS,0,@MAmount_EXHS OUTPUT;
        EXEC sp_GetAmountPi @MAmount_DIWT_T1,@MAmount_DIWT_T1A,@MAmount_DIWT_T1C,@M_WeightTransferPara_DIWT,@M_FillingQty_DIWT,@MAmount_DIWT OUTPUT;

        SET @MAmount=@MAmount_EXHS+@MAmount_DIWT;

        UPDATE [Material_Table] SET [M_Amount] =@MAmount_EXHS ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_EXHS;
        UPDATE [Material_Table] SET [M_Amount] =@MAmount_DIWT ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_DIWT;

END




