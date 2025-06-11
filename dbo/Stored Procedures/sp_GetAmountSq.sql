



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<帶入桶槽液位高度(CM)及面積，計算桶槽使用量>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAmountSq]
	@H decimal(18, 4),--高
	@S decimal(18, 4),--面積
	@C decimal(18, 4),--係數
	@SG decimal(18, 4),--比重
	@F decimal(18, 4), --充填
	@MAmountTotal decimal(18, 4) OUTPUT --輸出結果
AS
BEGIN
	SET NOCOUNT ON;

	SET @MAmountTotal=round((@H*@C)*@S*@SG,4)/1000+@F
END
