CREATE VIEW [dbo].[v_kpi_step1]
AS
SELECT 
mb.MB_plant,
mb.MB_CName,
mb.MB_Shop,
mb.MB_Sysname,
y.datetime,
FORMAT(y.datetime,'yyyyMM') AS year_month,
y.array_cf * c.converted_area AS [每日產能(m2/TFT+CF)],
y.array_cf_moved_rate AS [與基準月比],
m.M_Amount AS [每日化學品用量(kg)],
SUM(m.M_Amount) OVER (PARTITION BY mb.MB_Sysname,mb.MB_CName,FORMAT(y.datetime,'yyyyMM')ORDER BY y.datetime) AS [日累積用量(kg)],
SUM(y.array_cf * c.converted_area) OVER (PARTITION BY mb.MB_Sysname, mb.MB_CName, FORMAT(y.datetime,'yyyyMM') ORDER BY y.datetime) AS [日累積產能(m2)],
(c.base_value * POWER(array_cf_moved_rate,c.exponent) * c.correction + c.adjusted) AS [日理論推移累積量(kg) 未乘日累積產能]
FROM kpi_coefficient c JOIN
	kpi_yield y ON c.datetime = y.datetime JOIN
	Material_Base_Data mb ON mb.MB_Seq_ID = c.material_base_data_id JOIN
	Material_Table m ON m.M_Date = y.datetime AND m.MB_SEQ_ID = mb.MB_Seq_ID

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_kpi_step1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_kpi_step1';

