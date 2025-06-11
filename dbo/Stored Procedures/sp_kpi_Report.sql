

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<寫入備註>
-- =============================================
CREATE PROCEDURE [dbo].[sp_kpi_Report]
AS
BEGIN
	SET NOCOUNT ON;

	/* KPI 係數  每日由前一日資料延續產生*/
	IF(SELECT COUNT(1) FROM [kpi_coefficient] where [datetime]=CONVERT(CHAR(10),GETDATE(),120))=0
	BEGIN

		INSERT INTO [dbo].[kpi_coefficient]
				   ([material_base_data_id]
				   ,[datetime]
				   ,[name]
				   ,[base_value]
				   ,[exponent]
				   ,[r_value]
				   ,[correction]
				   ,[adjusted]
				   ,[water_volume]
				   ,[converted_area])
		SELECT [material_base_data_id]
			  ,CONVERT(CHAR(10),GETDATE(),120)
			  ,[name]
			  ,[base_value]
			  ,[exponent]
			  ,[r_value]
			  ,[correction]
			  ,[adjusted]
			  ,[water_volume]
			  ,[converted_area]
		  FROM [kpi_coefficient]
		  WHERE [datetime]=(SELECT MAX([datetime]) FROM [kpi_coefficient])

	END


	/* 各廠產能 由ifm抓取，目前使用舊資料產生 */
	/*
	IF(SELECT COUNT(1) FROM [kpi_yield] where [datetime]=CONVERT(CHAR(10),DATEADD(D,-1,GETDATE()),120))=0
	BEGIN

		INSERT INTO [dbo].[kpi_yield]
				   ([plant]
				   ,[datetime]
				   ,[array]
				   ,[cf]
				   ,[lcd]
				   ,[array_cf]
				   ,[array_cf_moved_pc]
				   ,[array_cf_moved_m2]
				   ,[array_cf_moved_rate])
			SELECT [plant]
			  ,CONVERT(CHAR(10),DATEADD(D,-1,GETDATE()),120)
			  ,[array]
			  ,[cf]
			  ,[lcd]
			  ,[array_cf]
			  ,[array_cf_moved_pc]
			  ,[array_cf_moved_m2]
			  ,[array_cf_moved_rate]
		  FROM [kpi_yield]
		  WHERE [datetime]=CONVERT(CHAR(10),DATEADD(D,-60,GETDATE()),120)

	END
	*/


	  		INSERT INTO [dbo].[kpi_yield]
				   ([plant]
				   ,[datetime]
				   ,[array]
				   ,[cf]
				   ,[lcd]
				   ,[array_cf]
				   ,[array_cf_moved_pc]
				   ,[array_cf_moved_m2]
				   ,[array_cf_moved_rate])
	  SELECT CASE WHEN M1.Factory ='FAC1' THEN 'fab1'
	  WHEN M1.Factory ='FAC1' THEN 'fab1'
	  WHEN M1.Factory ='FAC2' THEN 'fab2'
	  WHEN M1.Factory ='FAC3' THEN 'fab3'
	  WHEN M1.Factory ='FAC4' THEN 'fab4'
	  WHEN M1.Factory ='FAC5' THEN 'fab5'
	  WHEN M1.Factory ='FAC6' THEN 'fab6'
	  WHEN M1.Factory ='FAC7' THEN 'fab7'
	  WHEN M1.Factory ='FAC8-A' THEN 'fab8A'
	  WHEN M1.Factory ='FAC8-B' THEN 'fab8B'
	  WHEN M1.Factory ='FACL' THEN 'fabC'
	  WHEN M1.Factory ='FACT1' THEN 'fabT1'
	  WHEN M1.Factory ='FACT2' THEN 'fabT2'
	  WHEN M1.Factory ='FACT3' THEN 'fabT3'
	  WHEN M1.Factory ='FACT6' THEN 'fabT6'
	  ELSE ''
	  END [Factory],
	  M1.EDate [datetime],M1.Eval [array],M2.Eval [cf],M3.Eval [lcd],M4.Eval [array_cf],M5.Eval [array_cf_moved_pc],M6.Eval [array_cf_moved_m2],M7.Eval [array_cf_moved_rate] FROM 
	  (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='Array每日產出當量(PC)' and [EDate]=CONVERT(CHAR(10),DATEADD(D,-1,GETDATE()),120)) M1
	  LEFT JOIN (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='CF每日產出當量(PC)') M2 ON M1.Factory=M2.Factory AND M1.EDate=M2.EDate
	  LEFT JOIN (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='LCD每日產出當量(PC)') M3 ON M1.Factory=M3.Factory AND M1.EDate=M3.EDate
	  LEFT JOIN (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='Array+CF每日產出當量(PC)') M4 ON M1.Factory=M4.Factory AND M1.EDate=M4.EDate
	  LEFT JOIN (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='Array+CF每日推移月產出當量(PC)') M5 ON M1.Factory=M5.Factory AND M1.EDate=M5.EDate
	  LEFT JOIN (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='Array+CF每日推移月產出當量面積(m2)') M6 ON M1.Factory=M6.Factory AND M1.EDate=M6.EDate
	  LEFT JOIN (SELECT [Factory],[EDate],[Eval] FROM v_IFM_ENERGY_DAILY_REPORT_NEW where [Main_Name] ='Array+CF每日推移產出當量(與基準月比)') M7 ON M1.Factory=M7.Factory AND M1.EDate=M7.EDate
 


END
