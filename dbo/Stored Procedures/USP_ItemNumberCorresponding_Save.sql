
CREATE PROCEDURE [dbo].[USP_ItemNumberCorresponding_Save]
	@SelSeqID AS int,			/*編碼*/
	@strMATNO AS varchar(max),	/*料號串接字串*/
	@strUser as varchar(50)		/*使用者*/
AS
BEGIN TRY
	declare @intCount int;

	SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';
	MERGE dbo.ItemNumberCorresponding AS T  
		USING (
			select @SelSeqID as SeqID,Result as MATNO 
				from FUN_StringSplit(@strMATNO,'^')
		) AS S
		ON (T.INC_SeqID = S.SeqID and T.INC_MATNO = S.MATNO)  
		WHEN NOT MATCHED THEN  
			INSERT (INC_SeqID, INC_MATNO
				, INC_ActiveFlag
				, INC_CreatUser, INC_CreatTime
				, INC_UpdateUser, INC_UpdateTime)  
			VALUES (@SelSeqID, S.MATNO
				,'Y'
				, @strUser, getdate()
				, @strUser, getdate())
		when MATCHED THEN
			UPDATE SET INC_ActiveFlag='Y'
			,INC_UpdateUser=@strUser,INC_UpdateTime= getdate();

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

	Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('USP_ItemNumberCorresponding_Save','ItemNumberCorresponding',@strError
			,getdate())

END CATCH 

