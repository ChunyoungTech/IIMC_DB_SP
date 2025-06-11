
CREATE Function [dbo].[FUN_RemarkTable_Q]
(
	 @strM_SEQ_ID int,				/*M_SEQ_ID*/
     @strREMARK_TYPE nvarchar(10)	/*REMARK_TYPE*/
)
RETURNS TABLE 
AS
RETURN 
(
	select A.*,B.U_USER_NAME
		from Remark_Table as A
		inner join Users as B on B.U_USER_ID=A.M_UPDATE_USER
		where M_SEQ_ID=@strM_SEQ_ID and REMARK_TYPE=(case when @strREMARK_TYPE<>'' then @strREMARK_TYPE else REMARK_TYPE end)
)