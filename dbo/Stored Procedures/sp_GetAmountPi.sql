


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<帶入桶槽液位高度(CM)及直徑，計算桶槽使用量>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAmountPi]
	@H decimal(18, 4),--高
	@D decimal(18, 4),--直徑
	@C decimal(18, 4),--係數
	@SG decimal(18, 4),--比重
	@F decimal(18, 4), --充填
	@MAmountTotal decimal(18, 4) OUTPUT --輸出結果
AS
BEGIN
	SET NOCOUNT ON;

	SET @MAmountTotal=round((@H*@C)*((@D/2)*(@D/2)*3.14)*@SG,4)/1000+@F
END
