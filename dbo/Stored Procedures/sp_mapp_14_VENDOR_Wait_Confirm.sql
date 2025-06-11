

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<廠商沒有Confirm出貨>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mapp_14_VENDOR_Wait_Confirm]
 AS

BEGIN

	DECLARE  @MappMSg NVARCHAR(255)='';


	SET @MappMSg='請注意!!'+CHAR(10)+CHAR(13)+ (
		SELECT DISTINCT CONVERT(CHAR(10),[ARRIVAL_DATE],111) [ARRIVAL_DATE],[VENDOR_NAME]+CHAR(10)+CHAR(13)
		  FROM [SDP_VW_SRM_CALLED_ORDERS_GCIC] WHERE [STATUS]='Wait_Confirm'
		  AND DATEADD(D,1,[CREATE_DATE] )<GETDATE() AND CONVERT(CHAR(10),[ARRIVAL_DATE],111)>=CONVERT(CHAR(10),GETDATE(),111)
	FOR XML PATH(''),TYPE).value('.','NVARCHAR(MAX)')+'叫料需求廠商尚未確認'-- AS CombinedString;

	SELECT @MappMSg

	IF(@MappMSg<>'') exec sp_mapp_insert 'FAC2_IIMC_GROUP',@MappMSg ;

END

