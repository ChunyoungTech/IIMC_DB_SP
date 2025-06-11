CREATE PROCEDURE sp_DailyInventory_Book
	@intSEQ_ID as bigint,
	@strUser as varchar(50)		/*使用者*/
AS
BEGIN
	declare @strError nvarchar(max)='';
	BEGIN TRY
		update IDD
			set IDD_IS_BOOKING='1'
			,UPD_USER=@strUser,UPD_DATETIME=getdate()
			from Inventory_DailyData as IDD
			where IDD_SEQ_ID=@intSEQ_ID

		INSERT INTO Inventory_BookingLog
			(IBL_IDD_SEQ_ID,IBL_IBD_SEQ_ID
			,IBL_IDD_DailyDate,IBL_IDD_IS_BOOKING
			,IBL_UPD_DATETIME,IBL_UPD_USER)
		select IDD_SEQ_ID,IBD_SEQ_ID
			,IDD_DailyDate,'1'
			,getdate(),@strUser
			from Inventory_DailyData as IDD
			where IDD_SEQ_ID=@intSEQ_ID

		select IDD_SEQ_ID
			from Inventory_DailyData as IDD
			where IDD_SEQ_ID=@intSEQ_ID
	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(max))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_DailyInventory_Book','IDD_IS_BOOKING',@strError
				,getdate())

	END CATCH 
END