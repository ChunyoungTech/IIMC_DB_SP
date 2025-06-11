

Create Function [dbo].[FUN_ReasonCode_Query]
(
	@strSeqID bigint				/*RC_SeqID*/
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT RC_SeqID
		,(case RC_ReasonType when '01' then '作廢原因' when '02' then '手動結案原因'
			else '' end) as ReasonType
		,RC_ReasonName
		FROM ReasonCode
		where RC_SeqID=@strSeqID
)
