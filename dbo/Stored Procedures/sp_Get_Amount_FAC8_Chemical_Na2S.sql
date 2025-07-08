-- FAC8 Na2S 化學品計算 - 僅空調課使用
-- 依據液位計 F8FRFK_EXHS_LT_201A 取得使用量
CREATE PROCEDURE [dbo].[sp_Get_Amount_FAC8_Chemical_Na2S]
    @CalcDate AS DATE -- 重新指定運算日期
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate            AS DATE;        -- 計算日期
    DECLARE @M_SEQ_ID_W          INT;            -- 用量主檔序號
    DECLARE @Plant               VARCHAR(50) = 'FAC8';  -- 廠別
    DECLARE @CName               VARCHAR(50) = 'Na2S';  -- 化學品名稱
    DECLARE @MB_Shop             VARCHAR(50) = '空調課'; -- 使用單位
    DECLARE @MB_Sysname          VARCHAR(50) = 'EXHS';  -- 系統名稱

    -- 液位計 TAG 名稱
    DECLARE @tagName      VARCHAR(50) = 'F8FRFK_EXHS_LT_201A';
    DECLARE @tagName_D    VARCHAR(50) = @tagName + '_D';
    DECLARE @tagName_COEF VARCHAR(50) = @tagName + '_COEF';

    DECLARE @MAmount             DECIMAL(18,4) = 0; -- 最終用量
    DECLARE @MAmount_T1          DECIMAL(18,4) = 0; -- 液位差值
    DECLARE @MAmount_T1A         DECIMAL(18,4) = 0; -- 滿桶液位
    DECLARE @MAmount_T1C         DECIMAL(18,4) = 0; -- 係數
    DECLARE @M_FillingQty        DECIMAL(18,2);     -- 充填高度
    DECLARE @M_WeightTransferPara DECIMAL(18,2);    -- 比重

    -- 指定運算日期，若未指定則取前一天
    IF (@CalcDate <> '')
        SET @StartDate = @CalcDate;
    ELSE
        SET @StartDate = CONVERT(VARCHAR(10), DATEADD(D, -1, GETDATE()), 111);

    -- 取得化學品設定
    SELECT @M_SEQ_ID_W = A.M_Seq_ID,
           @MAmount = A.M_Amount,
           @M_FillingQty = A.M_FillingQty,
           @M_WeightTransferPara = A.M_WeightTransferPara
      FROM dbo.Material_Table AS A
     WHERE A.MB_SEQ_ID = (
              SELECT B.MB_SEQ_ID
                FROM Material_Base_Data AS B
               WHERE B.MB_CName = @CName
                 AND B.MB_Plant = @Plant
                 AND B.MB_Shop = @MB_Shop
                 AND B.MB_Sysname = @MB_Sysname)
       AND A.M_Date = @StartDate;

    /* 如有備註則終止計算 */
    IF EXISTS (SELECT 1
                 FROM Material_Table
                WHERE M_Seq_ID = @M_SEQ_ID_W
                  AND M_MenuRemark <> '')
    BEGIN
        UPDATE Material_Table
           SET M_Amount = @MAmount,
               M_TotalQty = @MAmount,
               M_TotalPara = 1
         WHERE M_Seq_ID = @M_SEQ_ID_W;
        RETURN;
    END

    -- 取得液位計數值
    EXEC sp_Get_FT_Amount @M_SEQ_ID_W, @tagName,      1, 3, @MAmount_T1  OUTPUT;
    EXEC sp_Get_FT_Amount @M_SEQ_ID_W, @tagName_D,    2, 3, @MAmount_T1A OUTPUT;
    EXEC sp_Get_FT_Amount @M_SEQ_ID_W, @tagName_COEF, 5, 3, @MAmount_T1C OUTPUT;

    -- 依液位計數值與參數計算使用量
    EXEC sp_GetAmountPi @MAmount_T1,
                        @MAmount_T1A,
                        @MAmount_T1C,
                        @M_WeightTransferPara,
                        0,
                        @MAmount OUTPUT;

    UPDATE Material_Table
       SET M_Amount    = @MAmount,
           M_TotalQty  = @MAmount,
           M_TotalPara = 1
     WHERE M_Seq_ID = @M_SEQ_ID_W;
END
GO

