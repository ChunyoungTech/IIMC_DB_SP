CREATE VIEW dbo.View_BOM_MONTH_USEAGE
AS
SELECT     YEAR(dbo.BOM_USEAGE.BU_DATE) * 100 + MONTH(dbo.BOM_USEAGE.BU_DATE) AS YYMM, dbo.Material_Base_Data.MB_Sysname, 
                      dbo.Material_Base_Data.MB_Plant, dbo.Material_Base_Data.MB_Shop, dbo.Material_Base_Data.MB_CName, dbo.BOM_SETTING.BS_TAG, 
                      dbo.BOM_SETTING.BS_BOM_NO, dbo.BOM_SETTING.BS_UNIT, 
                      SUM(dbo.Material_Table.M_Amount * dbo.BOM_USEAGE.BS_TRANSFER_PARA * dbo.BOM_USEAGE.BS_USE_PARA / 100) AS M_USEAGE, 
                      dbo.Material_Base_Data.MB_DECIMAL_BITS
FROM         dbo.BOM_USEAGE INNER JOIN
                      dbo.BOM_SETTING ON dbo.BOM_USEAGE.BS_SEQ_ID = dbo.BOM_SETTING.BS_SEQ_ID INNER JOIN
                      dbo.Material_Table ON dbo.BOM_SETTING.MB_SEQ_ID = dbo.Material_Table.MB_SEQ_ID AND 
                      dbo.BOM_USEAGE.BU_DATE = dbo.Material_Table.M_Date INNER JOIN
                      dbo.Material_Base_Data ON dbo.Material_Table.MB_SEQ_ID = dbo.Material_Base_Data.MB_Seq_ID
GROUP BY YEAR(dbo.BOM_USEAGE.BU_DATE) * 100 + MONTH(dbo.BOM_USEAGE.BU_DATE), dbo.Material_Base_Data.MB_Sysname, dbo.Material_Base_Data.MB_Plant, 
                      dbo.Material_Base_Data.MB_Shop, dbo.Material_Base_Data.MB_CName, dbo.Material_Base_Data.MB_IsVisable, dbo.BOM_SETTING.BS_TAG, 
                      dbo.BOM_SETTING.BS_BOM_NO, dbo.BOM_SETTING.BS_UNIT, dbo.Material_Base_Data.MB_DECIMAL_BITS
HAVING      (dbo.Material_Base_Data.MB_IsVisable = 'Y')

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[16] 2[23] 3) )"
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
         Begin Table = "BOM_USEAGE"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 180
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "BOM_SETTING"
            Begin Extent = 
               Top = 7
               Left = 408
               Bottom = 252
               Right = 720
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material_Table"
            Begin Extent = 
               Top = 7
               Left = 768
               Bottom = 180
               Right = 1044
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Material_Base_Data"
            Begin Extent = 
               Top = 181
               Left = 196
               Bottom = 368
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 19
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1695
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Colum', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_MONTH_USEAGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n = 11475
         Alias = 1740
         Table = 2865
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_MONTH_USEAGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_MONTH_USEAGE';

