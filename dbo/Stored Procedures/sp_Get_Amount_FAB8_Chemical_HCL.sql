CREATE PROCEDURE [dbo].[sp_Get_Amount_FAB8_Chemical_HCL]
        @CalcDate AS DATE --重新指定運算日期
AS
BEGIN
        SET NOCOUNT ON;

        DECLARE @StartDate AS DATE;
        DECLARE @M_SEQ_ID_UPWS int;
        DECLARE @M_SEQ_ID_WWT int;
        DECLARE @M_SEQ_ID_RECL int;
        DECLARE @Plant varchar(50) ='FAB8';
        DECLARE @CName varchar(50) ='HCL';

        DECLARE @MAmount_UPWS decimal(18,4)=0;
        DECLARE @MAmount_WWT decimal(18,4)=0;
        DECLARE @MAmount_RECL decimal(18,4)=0;

        DECLARE @T1 decimal(18,4)=0;
        DECLARE @T1A decimal(18,4)=0;
        DECLARE @T1C decimal(18,4)=0;
        DECLARE @T2 decimal(18,4)=0;
        DECLARE @T2A decimal(18,4)=0;
        DECLARE @T2C decimal(18,4)=0;
        DECLARE @T3 decimal(18,4)=0;
        DECLARE @T3A decimal(18,4)=0;
        DECLARE @T3C decimal(18,4)=0;
        DECLARE @T4 decimal(18,4)=0;
        DECLARE @T4A decimal(18,4)=0;
        DECLARE @T4C decimal(18,4)=0;
        DECLARE @T5 decimal(18,4)=0;
        DECLARE @T5A decimal(18,4)=0;
        DECLARE @T5C decimal(18,4)=0;
        DECLARE @T6 decimal(18,4)=0;
        DECLARE @T6A decimal(18,4)=0;
        DECLARE @T6C decimal(18,4)=0;

        DECLARE @M_FillingQty_UPWS decimal(18,4);
        DECLARE @M_WeightTransferPara_UPWS decimal(18,4);
        DECLARE @M_FillingQty_WWT decimal(18,4);
        DECLARE @M_WeightTransferPara_WWT decimal(18,4);
        DECLARE @M_FillingQty_RECL decimal(18,4);
        DECLARE @M_WeightTransferPara_RECL decimal(18,4);

        IF (@CalcDate<>'')
                SET @StartDate =  @CalcDate ;
        ELSE
                SET @StartDate = CONVERT(VARCHAR(10),DATEADD(D,-1,GETDATE()),111);

        SELECT @M_SEQ_ID_UPWS = A.M_Seq_ID,@MAmount_UPWS=A.M_Amount,
               @M_FillingQty_UPWS=A.M_FillingQty,@M_WeightTransferPara_UPWS=A.M_WeightTransferPara
          FROM dbo.Material_Table A
         WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='UPWS')
           AND m_Date = @StartDate;

        SELECT @M_SEQ_ID_WWT = A.M_Seq_ID,@MAmount_WWT=A.M_Amount,
               @M_FillingQty_WWT=A.M_FillingQty,@M_WeightTransferPara_WWT=A.M_WeightTransferPara
          FROM dbo.Material_Table A
         WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='WWT')
           AND m_Date = @StartDate;

        SELECT @M_SEQ_ID_RECL = A.M_Seq_ID,@MAmount_RECL=A.M_Amount,
               @M_FillingQty_RECL=A.M_FillingQty,@M_WeightTransferPara_RECL=A.M_WeightTransferPara
          FROM dbo.Material_Table A
         WHERE a.MB_SEQ_ID=(select b.MB_SEQ_ID from Material_Base_Data b where b.MB_CName=@CName AND MB_Plant=@Plant AND MB_Shop='水務課' AND MB_Sysname='RECL')
           AND m_Date = @StartDate;

        IF EXISTS( SELECT M_Seq_ID FROM [Material_Table] WHERE [M_Seq_ID] IN(@M_SEQ_ID_UPWS,@M_SEQ_ID_WWT,@M_SEQ_ID_RECL) AND M_MenuRemark<>'')
        BEGIN
                UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount_WWT+@MAmount_RECL ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_UPWS;
                UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWT ,[M_TotalQty] =@MAmount_WWT+@MAmount_RECL ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_WWT;
                UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL ,[M_TotalQty] =@MAmount_WWT+@MAmount_RECL ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_RECL;
                RETURN;
        END

        -- UPWS 主槽
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8W10W_DIWT_LIA_2901B_HMI',1,0,@T1 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8W10W_DIWT_LIA_2901B_HMI_D',2,3,@T1A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8W10W_DIWT_LIA_2901B_HMI_COEF',5,3,@T1C OUTPUT;

        -- UPWS 分槽
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8C10A_DIWT_LIA_2931A_HMI',1,0,@T2 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8C10A_DIWT_LIA_2931A_HMI_D',2,3,@T2A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8C10A_DIWT_LIA_2931A_HMI_COEF',5,3,@T2C OUTPUT;

        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8C10A_DIWT_LIA_2431A_PV',1,0,@T3 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8C10A_DIWT_LIA_2431A_PV_D',2,3,@T3A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_UPWS,'F8C10A_DIWT_LIA_2431A_PV_COEF',5,3,@T3C OUTPUT;

        -- WWT 分槽
        EXEC sp_Get_FT_Amount @M_SEQ_ID_WWT,'F8CB1_TWW_LIA_5401_PV',1,0,@T4 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_WWT,'F8CB1_TWW_LIA_5401_PV_D',2,3,@T4A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_WWT,'F8CB1_TWW_LIA_5401_PV_COEF',5,3,@T4C OUTPUT;

        -- RECL 分槽
        EXEC sp_Get_FT_Amount @M_SEQ_ID_RECL,'F8C10A_LIA_T6810_IN',1,0,@T5 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_RECL,'F8C10A_LIA_T6810_IN_D',2,3,@T5A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_RECL,'F8C10A_LIA_T6810_IN_COEF',5,3,@T5C OUTPUT;

        EXEC sp_Get_FT_Amount @M_SEQ_ID_RECL,'F8CB1A_RECS_LIA_678_PV',1,0,@T6 OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_RECL,'F8CB1A_RECS_LIA_678_PV_D',2,3,@T6A OUTPUT;
        EXEC sp_Get_FT_Amount @M_SEQ_ID_RECL,'F8CB1A_RECS_LIA_678_PV_COEF',5,3,@T6C OUTPUT;

        DECLARE @Tmp decimal(18,4);
        SET @MAmount_UPWS=0;

        EXEC sp_GetAmountPi @T1,@T1A,@T1C,@M_WeightTransferPara_UPWS,@M_FillingQty_UPWS,@Tmp OUTPUT;
        SET @MAmount_UPWS=@MAmount_UPWS+@Tmp;
        EXEC sp_GetAmountPi @T2,@T2A,@T2C,@M_WeightTransferPara_UPWS,0,@Tmp OUTPUT;
        SET @MAmount_UPWS=@MAmount_UPWS+@Tmp;
        EXEC sp_GetAmountPi @T3,@T3A,@T3C,@M_WeightTransferPara_UPWS,0,@Tmp OUTPUT;
        SET @MAmount_UPWS=@MAmount_UPWS+@Tmp;

        EXEC sp_GetAmountPi @T4,@T4A,@T4C,@M_WeightTransferPara_WWT,@M_FillingQty_WWT,@MAmount_WWT OUTPUT;
        EXEC sp_GetAmountPi @T5,@T5A,@T5C,@M_WeightTransferPara_RECL,@M_FillingQty_RECL,@MAmount_RECL OUTPUT;
        EXEC sp_GetAmountPi @T6,@T6A,@T6C,@M_WeightTransferPara_RECL,0,@Tmp OUTPUT;
        SET @MAmount_RECL=@MAmount_RECL+@Tmp;

        IF @MAmount_UPWS<1 SET @MAmount_UPWS=0;
        IF @MAmount_WWT<1 SET @MAmount_WWT=0;
        IF @MAmount_RECL<1 SET @MAmount_RECL=0;

        UPDATE [Material_Table] SET [M_Amount] =@MAmount_UPWS ,[M_TotalQty] =@MAmount_WWT+@MAmount_RECL ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_UPWS;
        UPDATE [Material_Table] SET [M_Amount] =@MAmount_WWT ,[M_TotalQty] =@MAmount_WWT+@MAmount_RECL ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_WWT;
        UPDATE [Material_Table] SET [M_Amount] =@MAmount_RECL ,[M_TotalQty] =@MAmount_WWT+@MAmount_RECL ,[M_TotalPara] =1 WHERE  [M_Seq_ID]=@M_SEQ_ID_RECL;
END
GO
