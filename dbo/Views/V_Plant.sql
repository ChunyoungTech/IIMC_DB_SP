
CREATE VIEW V_Plant
AS
	--select distinct (case when SBO_PLANT2='FAB8' then 'FAB8A' else SBO_PLANT2 end) as Plant_F,SBO_PLANT as Plant_T
	--	from SDP_Base_Org
	select SBO_PLANT2 as Plant_F,SBO_PLANT as Plant_T
		from SDP_Base_Org

