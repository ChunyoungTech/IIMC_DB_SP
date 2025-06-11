

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<PO量即將用盡>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_13_po_exhausted]
 AS

BEGIN

	DECLARE  @MappMSg NVARCHAR(255)='';

	SET @MappMSg='請注意!!'+char(10)+char(13)+ (
		SELECT DISTINCT '['+[IBD_SHOP]+[IBD_SYSTEM]+'] '+[IBD_MATERIAL]+'、'+char(10)+char(13)  FROM (

			SELECT DISTINCT [IBD_PLANT],[IBD_SHOP],[IBD_SYSTEM],[IBD_MATERIAL],[IBD_BOM_NO],[IBD_FEED_AMT],ISNULL([SUGGEST_CALLED_QTY],0) [SUGGEST_CALLED_QTY] FROM (
				SELECT [IBD_PLANT],[IBD_SHOP],[IBD_SYSTEM],[IBD_MATERIAL],[IBD_BOM_NO],[IBD_FEED_AMT] FROM [dbo].[Inventory_BaseData] WHERE IBD_PLANT='TT02' AND [IBD_AUTO_ORDER] ='Y'
			)S1 LEFT JOIN (
				SELECT [PLANT],[MATERIAL_NO],MAX([SUGGEST_CALLED_QTY]) [SUGGEST_CALLED_QTY] FROM  [SDP_PO_TABLE] WHERE [PLANT]='TT02'
				GROUP BY  [PLANT],[MATERIAL_NO]
			)S2 ON S1.[IBD_PLANT]=S2.PLANT AND S1.IBD_BOM_NO=S2.MATERIAL_NO

		)D WHERE ROUND([SUGGEST_CALLED_QTY]/[IBD_FEED_AMT],0)<=3
	FOR XML PATH(''),TYPE).value('.','NVARCHAR(MAX)')+'PO餘量不足3車，請盡速處理'-- AS CombinedString;

	SELECT @MappMSg

	IF(@MappMSg<>'') exec sp_mapp_insert 'FAC2_IIMC_GROUP',@MappMSg ;

END

