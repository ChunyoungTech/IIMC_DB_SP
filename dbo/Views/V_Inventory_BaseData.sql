
CREATE VIEW [dbo].[V_Inventory_BaseData]
AS
SELECT DISTINCT 
                          IBD.IBD_SEQ_ID, IBD.IBD_PLANT, 
                          (CASE WHEN IBD_SYSTEM = 'POWER' THEN '2' ELSE '1' END) 
                          AS IBD_SYSTEMNO, IBD.IBD_SYSTEM, IBD.IBD_MATERIAL, 
                          IBD.IBD_MATERIAL2, dbo.Inventory_BOM.MTRL_NO AS IBD_BOM_NO, 
                          IBD.IBD_UNIT, IBD.IBD_FEED_AMT, IBD.IBD_TRANSFER_PARA, 
                          IBD.IBD_SHOP
FROM             dbo.Inventory_BaseData AS IBD INNER JOIN
                          dbo.V_Plant ON IBD.IBD_PLANT = dbo.V_Plant.Plant_T left JOIN
                          dbo.Inventory_BOM ON 
                          IBD.IBD_MATERIAL = dbo.Inventory_BOM.MTRL_NAME AND 
                          dbo.V_Plant.Plant_F = dbo.Inventory_BOM.PLANT

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
         Begin Table = "IBD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 282
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V_Plant"
            Begin Extent = 
               Top = 204
               Left = 19
               Bottom = 300
               Right = 184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inventory_BOM"
            Begin Extent = 
               Top = 182
               Left = 331
               Bottom = 312
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_Inventory_BaseData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_Inventory_BaseData';

