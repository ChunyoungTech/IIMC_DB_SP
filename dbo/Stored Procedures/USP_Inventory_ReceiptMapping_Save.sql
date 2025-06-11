CREATE PROCEDURE USP_Inventory_ReceiptMapping_Save
	@SelSeqID AS int,			/*編碼*/
	@strMATNO AS varchar(max),	/*料號串接字串*/
	@strUser as varchar(50)		/*使用者*/
AS
BEGIN TRY
	declare @intCount int;
	declare @intType int=1;

	SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';

	/*2019/5/15 改為全部刪除再新增*/
	delete from Inventory_ReceiptMapping
		where IBD_SEQ_ID=@SelSeqID;

	MERGE dbo.Inventory_ReceiptMapping AS T  
		USING (
			select @SelSeqID as SeqID,Result as MATNO 
				from FUN_StringSplit(@strMATNO,'^')
		) AS S
		ON (T.IBD_SEQ_ID = S.SeqID and T.IRM_MTRL_NO = S.MATNO)  
		WHEN NOT MATCHED THEN  
			INSERT (IBD_SEQ_ID,IRM_TYPE
				,IRM_TAGNAME,IRM_MTRL_NO
				,UPDATE_TIME,UPDATE_USER) 
			VALUES (@SelSeqID,@intType
				,'', S.MATNO
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

	Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('USP_Inventory_ReceiptMapping_Save','Save',@strError
			,getdate())

END CATCH 
