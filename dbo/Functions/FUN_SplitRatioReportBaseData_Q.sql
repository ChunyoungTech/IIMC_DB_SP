
Create Function FUN_SplitRatioReportBaseData_Q
(
	 @strPlant varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT SPR.SEQ_ID as SPR_SEQ_ID
		  ,SPR_REPORT_PLANT
		  ,SPR_ORG,ORG_PLANT
		  ,SPR_MVT
		  ,SPR_BOM
		  ,SPR_UPPER_BOM
		  ,SPR_UPERR_SPLIT_RATE
		  ,SPR_FIXED_RATIO
		  --,SPR.update_user
		  --,update_datetime
	  FROM SplitRatioReportBaseData as SPR
	  inner join ORG as O on O.ORG_ID=SPR.SPR_ORG
	  where SPR_REPORT_PLANT = @strPlant and SPR_FIXED_RATIO is not null
)