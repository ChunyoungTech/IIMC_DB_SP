
CREATE PROCEDURE [dbo].[USP_ReasonCodeMultiple_Save]
	@strReasonType AS char(2),			/*類型*/
	@strReasonName AS nvarchar(max),	/*料號串接字串*/
	@strUser as varchar(50)				/*使用者*/
AS
BEGIN TRY
	declare @intCount int;
	declare @intType int=1;

	SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';

	/*2019/5/15 改為全部刪除再新增*/
	--delete from Inventory_ReceiptMapping
	--	where IBD_SEQ_ID=@SelSeqID;

	MERGE dbo.ReasonCode AS T  
		USING (
			select @strReasonType as ReasonType,Result as ReasonName 
				from FUN_StringSplit(@strReasonName,'^')
		) AS S
		ON (T.RC_ReasonType = S.ReasonType and T.RC_ReasonName = S.ReasonName)  
		WHEN NOT MATCHED THEN  
			INSERT (RC_ReasonType,RC_ReasonName
				,RC_CreateTime,RC_CreateUser
				,RC_UpdateTime,RC_UpdateUser) 
			VALUES (@strReasonType,S.ReasonName
				, getdate(), @strUser
				, getdate(), @strUser)
	;

	set @intCount=@@ROWCOUNT;
	select @intCount as ItemCount;
END TRY

BEGIN CATCH
	set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
		+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
			+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
			+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
			+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
			+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

	Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('USP_ReasonCodeMultiple_Save','Multiple_Save',@strError
			,getdate())

END CATCH 

