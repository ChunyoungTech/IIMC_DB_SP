
CREATE Function [dbo].[FUN_SplitRatioReportData_Q]
(
	 @strPlant varchar(50)
	 ,@strYearMonth varchar(6)
)
RETURNS TABLE 
AS
RETURN 
(/*
	select SPD_YearMonth,O1.ORG_PLANT as SourcePlant
		,(case O1.ORG_PLANT when 'TT08' then '5100' when 'TT10' then '5100' when 'T006' then '3100' else '' end) as SourceBinCode
		,O2.ORG_PLANT as DestinationPlant
		,(case O2.ORG_PLANT when 'TT08' then '5100' when 'TT10' then '5100' when 'T006' then '3100' else '' end) as DestinationWarehouseCode
		,SPD_ORG,SPD_BOM
		,SPD_MVT,convert(decimal(5,2),SPD_SplitRatio) as SPD_SplitRatio

		from SplitRatioReportData as SPD
		inner join ORG as O1 on O1.ORG_PLANT2=(case SPD_REPORT_PLANT when 'FAB8A' then 'FAB8' else SPD_REPORT_PLANT end)
		inner join ORG as O2 on O2.ORG_ID=SPD_ORG

		where SPD_REPORT_PLANT=(case @strPlant when 'FAB8' then 'FAB8A' else @strPlant end) and SPD_YearMonth=@strYearMonth
*/

	select SPD_YearMonth
		,(case SPD.SPD_REPORT_PLANT when 'FAB8A' then 'TT08' when 'FAB8B' then 'TT10' when 'FABT6' then 'T006' else '' end) as SourcePlant
		,(case SPD.SPD_REPORT_PLANT when 'FAB8A' then '5100' when 'FAB8B' then '5100' when 'FABT6' then '3100' else '' end) as SourceBinCode
		,O2.ORG_PLANT as DestinationPlant
		,(case O2.ORG_PLANT when 'TT08' then '5100' when 'TT10' then '5100' when 'T006' then '3100' else '' end) as DestinationWarehouseCode
		,SPD_ORG,SPD_BOM
		,SPD_MVT,convert(decimal(5,2),SPD_SplitRatio) as SPD_SplitRatio

		from SplitRatioReportData as SPD
		inner join ORG as O1 on O1.ORG_PLANT2=(case SPD_REPORT_PLANT when 'FAB8A' then 'FAB8' else SPD_REPORT_PLANT end)
		inner join ORG as O2 on O2.ORG_ID=SPD_ORG

		where SPD_REPORT_PLANT=(case @strPlant when 'FAB8' then 'FAB8A' else @strPlant end) and SPD_YearMonth=@strYearMonth

)