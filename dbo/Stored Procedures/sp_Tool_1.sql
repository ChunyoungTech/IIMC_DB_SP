
-- =============================================
-- Author:		<KEN>
-- Description:	<可搜尋sp中是否帶有某關鍵字>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Tool_1]
	@Plant varchar(10),
	@StartDate AS DATE,
	@EndDate AS DATE
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT DISTINCT O.NAME,C.* FROM SYSCOMMENTS C
	INNER JOIN SYSOBJECTS O ON C.id=O.id
	WHERE O.xtype='P'
	AND C.text LIKE '%MB_Mapp_1%'
								
								

END

