CREATE VIEW dbo.View_Material_Table
AS
SELECT     dbo.BOM_SETTING.BS_BOM_NO AS M_material_no, dbo.Material_Base_Data.MB_Plant AS M_fac, dbo.Material_Base_Data.MB_Shop AS M_fab, 
                      dbo.BOM_SETTING.BS_UNIT AS M_unit, 'B' AS M_type, dbo.BOM_USEAGE.BU_DATE AS M_date, dbo.BOM_SETTING.BS_TAG AS M_tagname, 
                      dbo.BOM_USEAGE.BU_USEAGE AS M_usage, dbo.Material_Base_Data.MB_CName AS M_material_name, dbo.BOM_USEAGE.BS_TRANSFER_PARA, 
                      dbo.BOM_USEAGE.BS_UNIT_TRANSFER_PARA, dbo.BOM_USEAGE.BS_LOSS_PARA, dbo.BOM_USEAGE.BS_SURVIVAL_PARA, dbo.BOM_USEAGE.BS_USE_PARA, 
                      dbo.BOM_SETTING.BS_MASTER_BOM_NO, dbo.Material_Table.M_Amount, dbo.BOM_USEAGE.BU_SEQ_ID, dbo.Material_Base_Data.MB_spName
FROM         dbo.BOM_SETTING INNER JOIN
                      dbo.BOM_USEAGE ON dbo.BOM_SETTING.BS_SEQ_ID = dbo.BOM_USEAGE.BS_SEQ_ID INNER JOIN
                      dbo.Material_Base_Data ON dbo.BOM_SETTING.MB_SEQ_ID = dbo.Material_Base_Data.MB_Seq_ID INNER JOIN
                      dbo.Material_Table ON dbo.Material_Base_Data.MB_Seq_ID = dbo.Material_Table.MB_SEQ_ID AND dbo.BOM_USEAGE.BU_DATE = dbo.Material_Table.M_Date

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[20] 2[18] 3) )"
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
         Left = -17
      End
      Begin Tables = 
         Begin Table = "BOM_SETTING"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 208
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BOM_USEAGE"
            Begin Extent = 
               Top = 19
               Left = 299
               Bottom = 214
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material_Base_Data"
            Begin Extent = 
               Top = 12
               Left = 568
               Bottom = 218
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material_Table"
            Begin Extent = 
               Top = 6
               Left = 806
               Bottom = 196
               Right = 1006
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
      Begin ColumnWidths = 19
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 675
         Width = 870
         Width = 705
         Width = 1500
         Width = 2970
         Width = 1500
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
         Column = 2370
         Alias = 2190
         Table ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_Material_Table';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 2025
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_Material_Table';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_Material_Table';

