





-- Batch submitted through debugger: 2.sql|7|0|C:\Users\ww\Desktop\IDCM\2.sql
-- Batch submitted through debugger: SQLQuery33.sql|7|0|C:\Users\ww\AppData\Local\Temp\~vs6DB3.sql



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_recalculate]
	@M_SEQ_ID AS int --M_SEQ_ID
AS

BEGIN
	SET NOCOUNT ON;
	DECLARE @spName varchar(100)=''
	DECLARE @CalcDate AS DATE=''

	BEGIN TRY 

		SELECT @CalcDate=M.M_Date,@spName=MB.MB_spName FROM Material_Table M INNER JOIN Material_Base_Data MB ON M.MB_SEQ_ID=MB.MB_Seq_ID WHERE M.M_Seq_ID=@M_SEQ_ID
		EXEC @spName @CalcDate
		SELECT 1 AS status

	END TRY  
	BEGIN CATCH  

		SELECT 0 AS status

	END CATCH
END



