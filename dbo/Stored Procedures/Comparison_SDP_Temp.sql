﻿




-- =============================================
-- Author:		<Author,,Name>
-- Create DATE: <Create DATE,,>
-- Description:	<比對物管資料有無更新，如更新則更新本地資料並將舊資料寫入歷史table>
-- =============================================
CREATE PROCEDURE [dbo].[Comparison_SDP_Temp] 
AS
BEGIN
/*
	INSERT INTO SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE (CALLED_NO,ARRIVAL_DATE,CREATE_BY,CREATE_DATE,MATERIAL_NO,PLANT,REMARKS,SHIP_QTY,STATUS,UNIT,VENDOR_ARRIVAL_DATE,VENDOR_CONFIRM_DATE,UPDATE_DATE,SOURCE)
	SELECT CALLED_NO,ARRIVAL_DATE,CREATE_BY,CREATE_DATE,MATERIAL_NO,PLANT,REMARKS,SHIP_QTY,STATUS,UNIT,VENDOR_ARRIVAL_DATE,VENDOR_CONFIRM_DATE,UPDATE_DATE,SOURCE
	FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE
	WHERE NOT EXISTS (
		SELECT 1
		FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE
		WHERE SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.CALLED_NO = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.CALLED_NO
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.ARRIVAL_DATE = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.ARRIVAL_DATE
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.CREATE_BY = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.CREATE_BY
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.CREATE_DATE = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.CREATE_DATE
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.MATERIAL_NO = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.MATERIAL_NO
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.PLANT = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.PLANT
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.REMARKS = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.REMARKS
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.SHIP_QTY = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.SHIP_QTY
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.STATUS = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.STATUS
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.UNIT = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.UNIT
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.VENDOR_ARRIVAL_DATE = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.VENDOR_ARRIVAL_DATE
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.VENDOR_CONFIRM_DATE = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.VENDOR_CONFIRM_DATE
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.UPDATE_DATE = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.UPDATE_DATE
		  AND SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE.SOURCE = SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE.SOURCE
	);

*/
	DECLARE @Count as INT
	DECLARE @CALLED_NO VARCHAR(30)
	DECLARE @myCURSOR CURSOR
	DECLARE @Temp TABLE (
			  CALLED_NO VARCHAR(30)
			 ,STATUS VARCHAR(20)
			 ,REVISION VARCHAR(10)
			 ,SHIP_QTY FLOAT
			 ,VENDOR_ARRIVAL_DATE DATE
			 ,VENDOR_CONFIRM_DATE DATE
			 ,VENDOR_REMARK VARCHAR(500)
			 ,VENDOR_SHIP_DATE DATE
			 ,VENDOR_CODE VARCHAR(30)
			 ,VENDOR_NAME VARCHAR(240)
			 );
		 
	DECLARE @Temp2 TABLE (CALLED_NO VARCHAR(30));
		 
	--將相異資料寫入@temp
	/*
	INSERT INTO @temp 
	SELECT CALLED_NO, STATUS, REVISION,SHIP_QTY,VENDOR_ARRIVAL_DATE,VENDOR_CONFIRM_DATE,VENDOR_REMARK,VENDOR_SHIP_DATE, VENDOR_CODE, VENDOR_NAME From SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP  where STATUS <> 'Close' and STATUS <> 'Cancel' and CALLED_NO in (SELECT CALLED_NO From SDP_VW_SRM_CALLED_ORDERS_GCIC where STATUS <> 'Close' and STATUS <> 'Cancel')
	EXCEPT
	SELECT CALLED_NO, STATUS, REVISION,SHIP_QTY,VENDOR_ARRIVAL_DATE,VENDOR_CONFIRM_DATE,VENDOR_REMARK,VENDOR_SHIP_DATE, VENDOR_CODE, VENDOR_NAME From SDP_VW_SRM_CALLED_ORDERS_GCIC where STATUS <> 'Close' and STATUS <> 'Cancel'
	*/

	--將相異資料寫入@temp
	INSERT INTO @temp 
	SELECT CALLED_NO, STATUS, REVISION,SHIP_QTY,VENDOR_ARRIVAL_DATE,VENDOR_CONFIRM_DATE,VENDOR_REMARK,VENDOR_SHIP_DATE, VENDOR_CODE, VENDOR_NAME From SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP  where CALLED_NO in (SELECT CALLED_NO From SDP_VW_SRM_CALLED_ORDERS_GCIC)
	EXCEPT
	SELECT CALLED_NO, STATUS, REVISION,SHIP_QTY,VENDOR_ARRIVAL_DATE,VENDOR_CONFIRM_DATE,VENDOR_REMARK,VENDOR_SHIP_DATE, VENDOR_CODE, VENDOR_NAME From SDP_VW_SRM_CALLED_ORDERS_GCIC 


	--
	INSERT INTo @temp2 SELECT CALLED_NO From [dbo].[SDP_VW_SRM_CALLED_ORDERS_GCIC] where [CALLED_NO] not in (SELECT CALLED_NO From SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS)
	   

	INSERT INTo [dbo].[SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS] ([CALLED_NO]
      ,[ACTUAL_ARRIVAL_DATE]
      ,[ACTUAL_ARRIVAL_QTY]
      ,[ARRIVAL_DATE]
      ,[CALLED_DATE]
      ,[CANCEL_REASON]
      ,[CLOSE_ASN_QTY]
      ,[CLOSE_FLAG]
      ,[CLOSE_REASON]
      ,[CONTACT_TELNO]
      ,[CONTACT_WINDOW]
      ,[CREATE_BY]
      ,[CREATE_DATE]
      ,[DESCRIPTION]
      ,[ERROR_MSG]
      ,[GUID]
      ,[MATERIAL_NO]
      ,[MATGROUP]
      ,[MTD_ARRIVAL_QTY]
      ,[NO_ARRIVAL_QTY]
      ,[PLANT]
      ,[PO_LINE]
      ,[PO_NO]
      ,[REMARKS]
      ,[REVISION]
      ,[SHIP_QTY]
      ,[STATUS]
      ,[TRX_QTY]
      ,[UNIT]
      ,[UPL_GUID]
      ,[VENDOR_ARRIVAL_DATE]
      ,[VENDOR_CODE]
      ,[VENDOR_CONFIRM_DATE]
      ,[VENDOR_NAME]
      ,[VENDOR_REMARK]
      ,[VENDOR_SHIP_DATE]
      ,[UPDATE_DATE]
      ,[SOURCE])
	  SELECT  [CALLED_NO]
      ,[ACTUAL_ARRIVAL_DATE]
      ,[ACTUAL_ARRIVAL_QTY]
      ,[ARRIVAL_DATE]
      ,[CALLED_DATE]
      ,[CANCEL_REASON]
      ,[CLOSE_ASN_QTY]
      ,[CLOSE_FLAG]
      ,[CLOSE_REASON]
      ,[CONTACT_TELNO]
      ,[CONTACT_WINDOW]
      ,[CREATE_BY]
      ,[CREATE_DATE]
      ,[DESCRIPTION]
      ,[ERROR_MSG]
      ,[GUID]
      ,[MATERIAL_NO]
      ,[MATGROUP]
      ,[MTD_ARRIVAL_QTY]
      ,[NO_ARRIVAL_QTY]
      ,[PLANT]
      ,[PO_LINE]
      ,[PO_NO]
      ,[REMARKS]
      ,[REVISION]
      ,[SHIP_QTY]
      ,[STATUS]
      ,[TRX_QTY]
      ,[UNIT]
      ,[UPL_GUID]
      ,[VENDOR_ARRIVAL_DATE]
      ,[VENDOR_CODE]
      ,[VENDOR_CONFIRM_DATE]
      ,[VENDOR_NAME]
      ,[VENDOR_REMARK]
      ,[VENDOR_SHIP_DATE]
      ,[UPDATE_DATE]
      ,[SOURCE]
 	  from [SDP_VW_SRM_CALLED_ORDERS_GCIC]
	  where [CALLED_NO] in (SELECT CALLED_NO From @temp2)


	UPDATE [SDP_VW_SRM_CALLED_ORDERS_GCIC] SET STATUS = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].STATUS
	   ,REVISION = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].REVISION
	   ,SHIP_QTY = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].SHIP_QTY
	   ,VENDOR_ARRIVAL_DATE = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].VENDOR_ARRIVAL_DATE
	   ,VENDOR_CONFIRM_DATE = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].VENDOR_CONFIRM_DATE
	   ,VENDOR_REMARK = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].VENDOR_REMARK
	   ,VENDOR_SHIP_DATE = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].VENDOR_SHIP_DATE 
	   ,VENDOR_CODE = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].VENDOR_CODE
	   ,VENDOR_NAME = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].VENDOR_NAME 
	   ,ASN = SDP_VW_ASN_DATA_GCIC.ASN_NO
	  From SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp left join SDP_VW_ASN_DATA_GCIC on SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp.CALLED_NO = SDP_VW_ASN_DATA_GCIC.CALLED_NO where [SDP_VW_SRM_CALLED_ORDERS_GCIC].CALLED_NO = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].CALLED_NO and [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].CALLED_NO in (SELECT CALLED_NO From @Temp)



	   
       INSERT INTo [dbo].[SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS] ([CALLED_NO]
      ,[ACTUAL_ARRIVAL_DATE]
      ,[ACTUAL_ARRIVAL_QTY]
      ,[ARRIVAL_DATE]
      ,[CALLED_DATE]
      ,[CANCEL_REASON]
      ,[CLOSE_ASN_QTY]
      ,[CLOSE_FLAG]
      ,[CLOSE_REASON]
      ,[CONTACT_TELNO]
      ,[CONTACT_WINDOW]
      ,[CREATE_BY]
      ,[CREATE_DATE]
      ,[DESCRIPTION]
      ,[ERROR_MSG]
      ,[GUID]
      ,[MATERIAL_NO]
      ,[MATGROUP]
      ,[MTD_ARRIVAL_QTY]
      ,[NO_ARRIVAL_QTY]
      ,[PLANT]
      ,[PO_LINE]
      ,[PO_NO]
      ,[REMARKS]
      ,[REVISION]
      ,[SHIP_QTY]
      ,[STATUS]
      ,[TRX_QTY]
      ,[UNIT]
      ,[UPL_GUID]
      ,[VENDOR_ARRIVAL_DATE]
      ,[VENDOR_CODE]
      ,[VENDOR_CONFIRM_DATE]
      ,[VENDOR_NAME]
      ,[VENDOR_REMARK]
      ,[VENDOR_SHIP_DATE]
      ,[UPDATE_DATE]
      ,[SOURCE]
	  ,[ASN])
	  SELECT  [SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].[CALLED_NO]
      ,[ACTUAL_ARRIVAL_DATE]
      ,[ACTUAL_ARRIVAL_QTY]
      ,[ARRIVAL_DATE]
      ,[CALLED_DATE]
      ,[CANCEL_REASON]
      ,[CLOSE_ASN_QTY]
      ,[CLOSE_FLAG]
      ,[CLOSE_REASON]
      ,[CONTACT_TELNO]
      ,[CONTACT_WINDOW]
      ,[CREATE_BY]
      ,[CREATE_DATE]
      ,[DESCRIPTION]
      ,[ERROR_MSG]
      ,[GUID]
      ,[SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].[MATERIAL_NO]
      ,[MATGROUP]
      ,[MTD_ARRIVAL_QTY]
      ,[NO_ARRIVAL_QTY]
      ,[SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].[PLANT]
      ,[PO_LINE]
      ,[PO_NO]
      ,[REMARKS]
      ,[REVISION]
      ,[SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].[SHIP_QTY]
      ,[STATUS]
      ,[TRX_QTY]
      ,[UNIT]
      ,[UPL_GUID]
      ,[VENDOR_ARRIVAL_DATE]
      ,[SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].[VENDOR_CODE]
      ,[VENDOR_CONFIRM_DATE]
      ,[SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].[VENDOR_NAME]
      ,[VENDOR_REMARK]
      ,[VENDOR_SHIP_DATE]
      ,[UPDATE_DATE]
      ,[SOURCE]
	  ,[ASN_NO]
	  From [SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP] left join SDP_VW_ASN_DATA_GCIC on SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp.CALLED_NO = SDP_VW_ASN_DATA_GCIC.CALLED_NO where [SDP_VW_SRM_CALLED_ORDERS_GCIC_TEMP].CALLED_NO = [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].CALLED_NO and [SDP_VW_SRM_CALLED_ORDERS_GCIC_Temp].CALLED_NO in (SELECT CALLED_NO From @Temp)


END


