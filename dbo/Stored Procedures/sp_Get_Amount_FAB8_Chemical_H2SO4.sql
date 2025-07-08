CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB8_Chemical_H2SO4]
        @CalcDate AS DATE --重新指定運算日期
AS
BEGIN

        SET NOCOUNT ON;
        --DECLARE @CalcDate AS DATE ='2024-01-01'
        DECLARE @StartDate AS DATE
        DECLARE @M_SEQ_ID_H int
        DECLARE @Plant varchar(50) ='FAB8';
        DECLARE @CName varchar(50) ='H2SO4';
        DECLARE @MB_Shop varchar(50) ='空調課';
        DECLARE @MB_Sysname varchar(50) ='EXHH';
        DECLARE @tagNameA varchar(50) ='F8EXHH_FL_FT401A';
        DECLARE @tagNameA_D varchar(50) = @tagNameA + '_D';
        DECLARE @tagNameA_COEF varchar(50) = @tagNameA + '_COEF';
        DECLARE @tagNameB varchar(50) ='F8EXHH_FL_FT401B';
        DECLARE @tagNameB_D varchar(50) = @tagNameB + '_D';
        DECLARE @tagNameB_COEF varchar(50) = @tagNameB + '_COEF';

        DECLARE @MAmount decimal(18, 4)=0
        DECLARE @MAmount_A decimal(18, 4)=0
        DECLARE @MAmount_AA decimal(18, 4)=0
        DECLARE @MAmount_AC decimal(18, 4)=0
        DECLARE @MAmount_B decimal(18, 4)=0
        DECLARE @MAmount_BA decimal(18, 4)=0
        DECLARE @MAmount_BC decimal(18, 4)=0
        DECLARE @MAmount_A_R decimal(18, 4)=0
        DECLARE @MAmount_B_R decimal(18, 4)=0
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
        SELECT @M_SEQ_ID_H = A.M_Seq_ID,@MAmount=A.M_Amount,@M_FillingQty=A.M_FillingQty,@M_WeightTransferPara=A.M_WeightTransferPara  FROM  dbo.Material_Table  A
        WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop=@MB_Shop AND MB_Sysname=@MB_Sysname) AND m_Date = @StartDate  ;

        /* 如有備註則終止計算 */
        IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_H) AND M_MenuRemark<>'')
        BEGIN
                UPDATE [Material_Table] SET [M_Amount] =@MAmount ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H;
        RETURN
        END

        --取得總用量
        EXEC sp_Get_FT_Amount @M_SEQ_ID_H,@tagNameA,1,0,@MAmount_A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_H,@tagNameA_D,2,3,@MAmount_AA OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_H,@tagNameA_COEF,5,3,@MAmount_AC OUTPUT;

        EXEC sp_Get_FT_Amount @M_SEQ_ID_H,@tagNameB,1,0,@MAmount_B OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_H,@tagNameB_D,2,3,@MAmount_BA OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_H,@tagNameB_COEF,5,3,@MAmount_BC OUTPUT;

        --計算
        --sp_GetAmountPi 高,直徑,係數,比重,充填,輸出
        EXEC sp_GetAmountPi @MAmount_A,@MAmount_AA,@MAmount_AC,@M_WeightTransferPara,@M_FillingQty,@MAmount_A_R OUTPUT;
        EXEC sp_GetAmountPi @MAmount_B,@MAmount_BA,@MAmount_BC,@M_WeightTransferPara,@M_FillingQty,@MAmount_B_R OUTPUT;

        SET @MAmount=@MAmount_A_R + @MAmount_B_R

        IF @MAmount <1 BEGIN SET @MAmount=0 END

        UPDATE [Material_Table] SET [M_Amount] =@MAmount ,[M_TotalQty] =@MAmount ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_H;

END

