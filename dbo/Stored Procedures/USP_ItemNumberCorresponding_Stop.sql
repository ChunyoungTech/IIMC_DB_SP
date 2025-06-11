CREATE PROCEDURE [dbo].[USP_ItemNumberCorresponding_Stop]
	@intSerialNo AS int,		/*流水號*/
	@strUser as varchar(50)		/*使用者*/
AS
BEGIN TRY
	declare @intCount int;

	SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';

	update INC
		set INC_ActiveFlag='N'
			,INC_UpdateUser=@strUser,INC_UpdateTime=GETDATE()
		from ItemNumberCorresponding as INC
		where INC_SerialNo=@intSerialNo

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
