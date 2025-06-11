

CREATE Function [dbo].[FUN_ReasonCode_List]
(
	 @strReasonType char(2)				/*RC_ReasonType*/
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT RC_SeqID
		,(case RC_ReasonType when '01' then '作廢原因' when '02' then '手動結案原因'
			else '' end) as ReasonType
		,RC_ReasonName
		,RC_UpdateTime
		,RC_UpdateUser
		,ISNULL(U_USER_NAME,'')as RC_UpdateUserName
		FROM ReasonCode RC
		left join Users as U on U.U_USER_ID=RC.RC_UpdateUser
		where RC_ReasonType=@strReasonType
)

