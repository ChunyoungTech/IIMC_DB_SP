






CREATE VIEW [dbo].[v_kpi_water_step1]
AS
SELECT  mb.MB_plant, mb.MB_CName, mb.MB_Shop, mb.MB_Sysname, y.datetime, FORMAT(y.datetime, 'yyyyMM') AS year_month, 
                   (case when substring(mb.MB_Sysname,1,4)  = 'WWTS' and mb.MB_CName = 'CaCL2' then y.fbc_in_volume 
				    when substring(mb.MB_Sysname,1,4)  = 'WWTS' and mb.MB_CName = 'FeCL2' then y.ana_in_volume 
					when substring(mb.MB_Sysname,1,4)  = 'WWTS' then y.aer_in_volume 
				    else y.fab2_sum_volume end) AS [二廠純水用量(m3)], y.fab2_moved_m3 AS [每日推移水量(m3/m3)], 
                   m.M_Amount AS [每日化學品用量(kg)], SUM(m.M_Amount) OVER (PARTITION BY mb.MB_Sysname, mb.MB_CName, 
                   FORMAT(y.datetime, 'yyyyMM')
ORDER BY y.datetime) AS [日累積用量(kg)], SUM((case when substring(mb.MB_Sysname,1,4)  = 'WWTS' and mb.MB_CName = 'CaCL2' then y.fbc_in_volume 
				    when substring(mb.MB_Sysname,1,4)  = 'WWTS' and mb.MB_CName = 'FeCL2' then y.ana_in_volume 
					when substring(mb.MB_Sysname,1,4)  = 'WWTS' then y.aer_in_volume 
				    else y.fab2_sum_volume end)) OVER (PARTITION BY mb.MB_Sysname, 
mb.MB_CName, FORMAT(y.datetime, 'yyyyMM')
ORDER BY y.datetime) AS [日累積用水量(m3)], (c.base_value * POWER(y.fab2_moved_m3, c.exponent) * c.correction + c.adjusted) 
AS [日理論推移累積量(kg) 未乘日累積產能],y.fab2_sum_volume as [總純水用量],mb.MB_Seq_ID
FROM      kpi_coefficient_water c 
JOIN kpi_yield_water y ON c.datetime = y.datetime 
JOIN Material_Base_Data mb ON mb.MB_Plant = c.plant and mb.MB_CName = c.MB_CName and mb.MB_Sysname like c.MB_Sysname+'%'
JOIN Material_Table m ON m.M_Date = y.datetime AND m.MB_SEQ_ID = mb.MB_Seq_ID and m.M_FillingQty = 0
