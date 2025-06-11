
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	結束減開始
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTotalAndComponent]
	@MB_Plant varchar(10),
	@CName varchar(100),
	@StartDate AS DATE
AS
BEGIN
	--SET NOCOUNT ON
	--DECLARE	@MB_Plant varchar(10)='fab2'
	--DECLARE @CName varchar(100)='h2so4'
	--DECLARE @StartDate AS DATE='2023-03-07'
	SELECT a.M_TotalQty,a.M_Seq_ID,a.MB_SEQ_ID,b.MB_Plant_T,''as MB_Shop,''as MB_Sysname,a.M_MenuRemark FROM [Material_Table] a inner join [dbo].[Material_Base_Data] b on a.MB_SEQ_ID=b.MB_Seq_ID
	where b.MB_IsMaster='Y' and b.MB_Plant=@MB_Plant and b.MB_CName=@CName and a.M_Date=@StartDate
	UNION ALL
	SELECT c.M_Amount,c.M_Seq_ID,c.MB_SEQ_ID,d.MB_Plant,d.MB_Shop,d.MB_Sysname,c.M_MenuRemark FROM [Material_Table] c inner join [dbo].[Material_Base_Data] d on c.MB_SEQ_ID=d.MB_Seq_ID
	where d.MB_Upper=(SELECT b.MB_Seq_ID FROM [Material_Table] a inner join [dbo].[Material_Base_Data] b on a.MB_SEQ_ID=b.MB_Seq_ID
	where b.MB_IsMaster='Y' and b.MB_Plant=@MB_Plant and b.MB_CName=@CName and a.M_Date=@StartDate) and c.M_Date=@StartDate ORDER BY MB_Plant_T,MB_Shop

END




