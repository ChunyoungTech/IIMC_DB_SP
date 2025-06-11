
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<寫入備註>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddRemark]
	@M_SEQ_ID int,
	@M_Remark varchar(255),
	@M_UPDATE_USER varchar(50),
	@strREMARK_TYPE NVARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Remark_Table(M_SEQ_ID,REMARK_TYPE,M_Remark,M_UPDATE_USER,M_UPDATE_TIME) VALUES (@M_SEQ_ID,@strREMARK_TYPE,@M_Remark,@M_UPDATE_USER,GETDATE())
END
