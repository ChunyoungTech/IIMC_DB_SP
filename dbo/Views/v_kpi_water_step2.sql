








CREATE VIEW [dbo].[v_kpi_water_step2]
AS
SELECT  c.MB_plant, c.MB_CName, MB_Shop, MB_Sysname, c.datetime, year_month, [二廠純水用量(m3)] as [pura_volume(m3)], [每日推移水量(m3/m3)] as [day_moved_volume(m3/m3)], 
                   [每日化學品用量(kg)] as [day_chemical_volume(kg)], [日累積用量(kg)] as [day_sum_volume(kg)], [日累積用水量(m3)] as [day_water_volume(m3)], [日理論推移累積量(kg) 未乘日累積產能] as [theory_moved_no], 
                   [日理論推移累積量(kg) 未乘日累積產能] * [日累積用水量(m3)] AS [theory_moved], 
                   [日累積用量(kg)] / [日累積用水量(m3)] AS [act_moved_volume], 
                   [日理論推移累積量(kg) 未乘日累積產能] * [日累積用水量(m3)] / [日累積用水量(m3)] AS [theory_moved_volume], 
                   ([日累積用量(kg)] - [日理論推移累積量(kg) 未乘日累積產能] * [日累積用水量(m3)]) 
                   / ([日理論推移累積量(kg) 未乘日累積產能] * [日累積用水量(m3)]) AS [act VS theory],[總純水用量] as [old_pure_water],c.MB_Seq_ID  
FROM      dbo.v_kpi_water_step1 c 

